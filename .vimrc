" my stuff
filetype plugin indent on
" Highlighting the current line by \c
":hi CursorLine   cterm=NONE ctermbg=0.9 ctermfg=white guibg=darkred guifg=white
":nnoremap <Leader>c :set cursorline!<CR>

" Highligh that stays at the line by \l toggle
:nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>







set t_Co=256
"colorscheme leo
"colorscheme desert256

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set history=50    " keep 50 lines of command line history
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch    " do incremental searching
set ignorecase

set wildmode=longest,full

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  au BufNewFile,BufRead *.txx set filetype=cpp
  au BufNewFile,BufRead *.cu set filetype=cpp
  set hlsearch
endif

set mouse=a
set shiftwidth=2
set autowrite
compiler gcc

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

if has("gui_running")
  set guifont=Monospace\ 11
endif

set sw=2

filetype on
" set foldmethod=marker foldmarker=<<<,>>>
set foldmethod=syntax
set foldlevel=0
noremap , 5h
noremap . 5l
nnoremap s :syntax sync fromstart<CR>

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab 

set background=dark
set foldcolumn=8

set number
"set numberwidth=4

function! PrintSyntaxItem()
  let l:colorsyntax = synIDattr(synID(line("."), col("."), 0), "name")
  execute "highlight" l:colorsyntax
endfunction
nnoremap ; :call PrintSyntaxItem()<CR>
nnoremap t :TlistToggle<CR>


"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight LineNr term=bold cterm=NONE ctermfg=Gray ctermbg=NONE gui=NONE guifg=Cyan guibg=NONE
hi FoldColumn ctermfg=Yellow ctermbg=NONE 
hi Folded ctermfg=Yellow ctermbg=NONE 

hi PreProc ctermfg=DarkMagenta ctermbg=NONE 
hi PreCondit ctermfg=DarkMagenta ctermbg=NONE 
hi cSpecial ctermfg=DarkMagenta ctermbg=NONE 

hi cComment ctermfg=Cyan ctermbg=NONE 
hi cCommentL ctermfg=Cyan ctermbg=NONE 

hi cIncluded ctermfg=DarkRed ctermbg=NONE 
hi cppBoolean ctermfg=DarkRed ctermbg=NONE 
hi cCppString ctermfg=DarkRed ctermbg=NONE 
hi cConstant ctermfg=DarkRed ctermbg=NONE 
hi cString ctermfg=DarkRed ctermbg=NONE 
hi cNumber ctermfg=DarkRed ctermbg=NONE 
hi cFloat ctermfg=DarkRed ctermbg=NONE 

hi cppStatement ctermfg=brown ctermbg=NONE 
hi cConditional ctermfg=brown ctermbg=NONE 
hi cStatement ctermfg=brown ctermbg=NONE 
hi cUserLabel ctermfg=brown ctermbg=NONE 
hi cRepeat ctermfg=brown ctermbg=NONE 
hi cLabel ctermfg=brown ctermbg=NONE 

hi cType ctermfg=DarkGreen ctermbg=NONE 
hi cStructure ctermfg=DarkGreen ctermbg=NONE 
hi cStorageClass ctermfg=DarkGreen ctermbg=NONE 

highlight Search ctermfg=Black ctermbg=Yellow

set foldtext=MyFoldText2()
function MyFoldText2()
  let nucolwidth = &fdc + &number*&numberwidth
  let winwd = winwidth(0) - nucolwidth - 5
  let foldlinecount = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
  let prefix = " _______>>> "
  let fdnfo = prefix . string(v:foldlevel) . "," . string(foldlinecount)
  let line =  strpart(getline(v:foldstart), 0 , winwd - len(fdnfo)) 
        \ . " ... " . strpart(getline(v:foldend), 0 , winwd - len(fdnfo)) 
  let fillcharcount = winwd - len(line) - len(fdnfo)
  return line . repeat(" ",fillcharcount) . fdnfo
endfunction

"syn region cMyFold start="#if" end="#end" transparent fold contains=ALL
"syn region myFold start="\#if" end="\#end" transparent fold
"syn sync fromstart
"set foldmethod=syntax

let c_space_errors = 1
let c_no_comment_fold=1

set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"let g:SuperTabDefaultCompletionType = "context"

highlight Pmenu ctermbg=238 ctermfg=Red gui=bold
hi Pmenu      ctermfg=Cyan    ctermbg=DarkGray  cterm=None guifg=Cyan guibg=DarkBlue
hi PmenuSel   ctermfg=White   ctermbg=238 cterm=Bold guifg=White guibg=DarkBlue gui=Bold
hi PmenuSbar                  ctermbg=Cyan            guibg=Cyan
hi PmenuThumb ctermfg=White                           guifg=White


"inoremap <expr> <buffer> . MyFunction()
"set rtp+=~/.vam/vim-addon-manager
"call vam#ActivateAddons(["FuzzyFinder"])

"-------------------------------------------------------------------------------

" Color test: Save this file, then enter ':so %'
" " Then enter one of following commands:
" "   :VimColorTest    "(for console/terminal Vim)
" "   :GvimColorTest   "(for GUI gvim)
function! VimColorTest(outfile, fgend, bgend)
  let result = []
  for fg in range(a:fgend)
    for bg in range(a:bgend)
      let kw = printf('%-7s', printf('c_%d_%d', fg, bg))
      let h = printf('hi %s ctermfg=%d ctermbg=%d', kw, fg, bg)
      let s = printf('syn keyword %s %s', kw, kw)
      call add(result, printf('%-32s | %s', h, s))
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
command! VimColorTest call VimColorTest('vim-color-test.tmp', 12, 16)
function! GvimColorTest(outfile)
  let result = []
  for red in range(0, 255, 16)
    for green in range(0, 255, 16)
      for blue in range(0, 255, 16)
        let kw = printf('%-13s', printf('c_%d_%d_%d', red, green, blue))
        let fg = printf('#%02x%02x%02x', red, green, blue)
        let bg = '#fafafa'
        let h = printf('hi %s guifg=%s guibg=%s', kw, fg, bg)
        let s = printf('syn keyword %s %s', kw, kw)
        call add(result, printf('%s | %s', h, s))
      endfor
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
command! GvimColorTest call GvimColorTest('gvim-color-test.tmp')

hi CursorLine ctermbg=black cterm=none
au InsertEnter * set cursorline
au InsertLeave * set nocursorline

set viminfo='20,<1000
