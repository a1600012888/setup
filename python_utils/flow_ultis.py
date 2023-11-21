import cv2
import numpy as np


def single_chn_flow_to_rgb(flow_frames: np.ndarray):
    """
    Quantize a single channel of optical flow in float 32 to 3-channel RGB in uint8.
    Args:
        flow_frames: np.ndarray of shape [*batch, H, W] in float32
    Outs:
        ret: np.ndarray of shape [*batch, H, W, 3] in uint8
    """
    # flow_frames: [nf, H, W]
    sign_bit = (np.sign(flow_frames) + 1).astype(np.uint8)

    normalize_chn = 255.0 // (1e-5 + np.abs(flow_frames))
    normalize_chn = np.clip(normalize_chn, 0, 255).astype(np.uint8)

    mag_chn = (np.abs(flow_frames) * normalize_chn).astype(np.uint8)

    ret = np.stack([mag_chn, normalize_chn, sign_bit], axis=-1)  # [nf, H, W, 3]

    return ret


def convert_flow_to_video(flow_frames: np.ndarray):
    """
    Args:
        flow_frames: [nf, H, W, 2], np.flaot32
    Outs:
        flow_video: [nf, 2 * H, W, 3], np.uint8
    """
    # flow_frames: [nf, H, W, 2]
    flow_video_x = single_chn_flow_to_rgb(flow_frames[..., 0])
    flow_video_y = single_chn_flow_to_rgb(flow_frames[..., 1])

    flow_video = np.concatenate([flow_video_x, flow_video_y], axis=1)  # [nf, 2H, W, 3]

    return flow_video


def save_video_cv2(video_path: str, img_list, fps: int):
    """
    Lossy video saving using opencv.
    Args:
        img_list: List[np.ndarray of shape [H, W, 3]]
    """
    if len(img_list) == 0:
        return
    h, w, _ = img_list[0].shape
    fourcc = cv2.VideoWriter_fourcc(
        *"mp4v"
    )  # cv2.VideoWriter_fourcc('m', 'p', '4', 'v')
    writer = cv2.VideoWriter(video_path, fourcc, fps, (w, h))

    for frame in img_list:
        writer.write(frame)
    writer.release()


def decode_optical_flow_video(video_frames: np.ndarray):
    # video_frames [nf, 2H, W, 3]

    # [nf, 2H, W, 1]
    mag_chn, normalize_chn, sign_chn = np.split(video_frames, 3, axis=-1)

    mag_chn = mag_chn * 1.0 / normalize_chn

    sign_chn = 1.0 * sign_chn - 1.0

    flow_chn = mag_chn * sign_chn

    # [nf, H, W, 1]
    flow_x, flow_y = np.split(flow_chn, 2, axis=1)

    ret_flow = np.concatenate([flow_x, flow_y], axis=-1).astype(
        np.float32
    )  # [nf, H, W, 2]
    return ret_flow


def _code_test():
    # randomly generate a sequence of optical flow in -10~10 of shape [150, 256, 256, 2]
    flow = np.random.randn(150, 256, 256, 2).astype(np.float32) * 10

    # convert to video
    flow_video = convert_flow_to_video(flow)

    # decode video
    flow_decoded = decode_optical_flow_video(flow_video)

    # measure compression error
    error = np.abs(flow - flow_decoded).mean()
    print("Compression error: {}".format(error))


if __name__ == "__main__":
    _code_test()
