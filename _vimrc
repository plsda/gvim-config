source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

call plug#begin("$VIM/plugins")

Plug 'lervag/vimtex'

call plug#end()

colo desert 
set tabstop=3
set shiftwidth=3
set iskeyword+=:
set cursorline
set nowrap

set swapfile
set dir=C:windows/Temp

set backup
set backupdir=C:/windows/Temp
set backupskip=C:/windows/Temp/*
set directory=C:/windows/Temp
set writebackup

set undofile
set undodir=C:/windows/Temp

set cinoptions+=(0,w1,W4,t0,g0

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guifont=Lucida_Console:h8
"set guifont=Monospace\ 10

unmap <C-v>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

inoremap <M-q>	<C-c>
inoremap <M-i>	<C-c>
"inoremap <CapsLock>	<esc>
inoremap jk <C-c>
inoremap kj <C-c>
nnoremap <space> =iB<C-o>
"nnoremap <CapsLock> =iB<C-o>
nnoremap gp `[v`]
nnoremap <M-q> "_dd

vnoremap c "ac
vnoremap y "ay
vnoremap p "ap

nnoremap p "ap
nnoremap cc "acc
nnoremap cw "acw
nnoremap cW "acW
nnoremap yy "ayy
nnoremap yw "ayw
nnoremap yW "ayW

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

nnoremap <M-d> yyp

"if !exists("autocommands_loaded")
"	let autocommands_loaded = 1
"	autocmd BufNewFile,BufRead *.cpp compiler devenv
"	autocmd BufNewFile,BufRead *.c compiler devenv
"	autocmd BufNewFile,BufRead *.h compiler devenv
"endif

"set errorformat=\ %#%f(%l\\\,%c):\ %
"set errorformat=\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %[A-Z\ ]%#%n:\ %m
"set errorformat=%.%#>\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %[A-Z\ ]%#%n:\ %m
"set errorformat=%*[0-9]%*[>]\ %#%f(%l):\ %m
set errorformat=%f(%l):\ %s\ %t%n:\ %m
set winminheight=0

nnoremap <F5> :call MyAsyncCall()<cr>
":call MyCompile()<cr>
nnoremap <F9> :call MyDebug()<cr>
nnoremap <F12> :call MyRun()<cr>

"TODO add support for unix
"TODO add errorformat for warnings (and notes?)
"TODO count errors and warnings separately
"TODO fix jumping to errors
"TODO add asynchronous support https://vimhelp.org/channel.txt.html#channel.txt 
"https://andrewvos.com/writing-async-jobs-in-vim-8/"
"https://devhints.io/vimscript"

function! MyCompile() 
	silent !..\build.bat > compilerOutputTemp_
	"call system('!..\build.bat > compilerOutputTemp_')
	"silent cgetfile compilerOutputTemp_ 
	"silent cfile compilerOutputTemp_ 
	silent cgetfile compilerOutputTemp_ 
	let error_count = len(filter(getqflist(), 'v:val.valid != 0'))

	if(error_count > 0)
		caddexpr "\nCompilation failed with " . error_count . " errors."
	else
		caddexpr "\nCompilation successful."
	endif

	copen 9999
	
	:setlocal syntax=compilerOutput
endfunction

function! MyDebug()
	"silent !..\debug.bat
	call system('..\debug.bat')
endfunction

function! MyRun()
	"silent !..\run.bat
	call system('start /B ..\run.bat')
endfunction

command! MyCompileCommand call s:MyCompile()
command! MyDebugCommand call s:MyDebug()
command! MyRunCommand call s:MyRun()

"TODO save job name in a global and terminate inside function call?
"Launch an asynchronous job(without a channel)
function! MyAsyncCall()
	let job = job_start('call MyCompile()', {"in_io": "null", "out_io": "null", "err_io": "null"})
endfunction

  
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


