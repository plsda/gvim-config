source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

call plug#begin("$VIM/plugins")

Plug 'lervag/vimtex'
"Plug 'ycm-core/YouCompleteMe'

call plug#end()

set encoding=utf-8

colo desert 
set tabstop=3
set shiftwidth=3
set iskeyword+=:
set cursorline
set nowrap

set swapfile
"set dir=C:/windows/Temp
set dir=E:/Vim/Temp

set backup
"set backupdir=C:/windows/Temp
"set backupskip=C:/windows/Temp/*
"set directory=C:/windows/Temp
"Replace paths with $VIMRUNTIME etc. 
set backupdir=E:/Vim/Temp
set backupskip=E:/Vim/Temp/*
set directory=E:/Vim/Temp
set writebackup

set undofile
"set undodir=C:/windows/Temp
set undodir=E:/Vim/Temp

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
"set errorformat=%f(%l):\ %s\ %t%n:\ %m
"set errorformat=%f(%l):%m
set errorformat=%f(%l):\ error\ %t%n:\ %m,%f(%l):\ warning\ %t%n:\ %m,%f(%l):\ note\ %t%n:\ %m
set winminheight=0

nnoremap <F5> :call AsyncCompile()<cr>
nnoremap <F9> :call AsyncDebug()<cr>
nnoremap <F12> :call AsyncRun()<cr>

"https://vimhelp.org/channel.txt.html#channel.txt 
"https://vim.fandom.com/wiki/Execute_external_programs_asynchronously_under_Windows
"https://andrewvos.com/writing-async-jobs-in-vim-8/"
"https://devhints.io/vimscript"

function! CHandler(channel, msg)
	silent cgetfile compilerOutputTemp_ 
	let l:error_count = len(filter(getqflist(), 'v:val.type == "C"'))
	let l:warning_count = len(filter(getqflist(), 'v:val.type == "W"'))

	if(l:error_count > 0)
		caddexpr "\nCompilation failed with " . l:error_count . " errors and " . l:warning_count . " warnings."
	else
		caddexpr "\nCompilation successful. Warnings: " . l:warning_count
	endif

	copen 
	
	:setlocal syntax=compilerOutput
endfunction

function! LaunchVCEnv()
	"silent !call "E:\VisualStudio\VC\Auxiliary\Build\vcvars64.bat"
	"silent !call "E:\VisualStudio\Common7\Tools\VsDevCmd.bat""
	"TODO: parameterize these paths
	"let g:compiler_job = job_start('!call "E:\VisualStudio\VC\Auxiliary\Build\vcvars64.bat" && G: && cd G:\MyPrograms\Handmade\code', {"out_cb": "CHandler"})
	let g:compiler_job = job_start('cmd /k "E:\VisualStudio\VC\Auxiliary\Build\vcvars64.bat"', {"out_cb": "CHandler"})
	let g:compiler_channel = job_getchannel(g:compiler_job)
	
	let l:c_status = ch_status(g:compiler_job)
	if(l:c_status != "open")
		echoerr "Failed to start the compiler job"
	endif

endfunction

function! AsyncCompile()
	if v:version < 800
     echoerr 'Asynchronous compilation requires VIM 8.0 or higher'
     return
   endif

	if !exists('g:compiler_job')
		call LaunchVCEnv()
	endif
	
	let l:c_status = ch_status(g:compiler_job)
	if(l:c_status != "open")
		echoerr "The channel for compiler is not open"
	endif
	
	"NOTE: CHandler is triggered by irrelevant messages - use cResponse instead?
	let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "..\build.bat > compilerOutputTemp_"' . "\n")
	"call ch_sendraw(g:compiler_channel, '%comspec% /c "..\build.bat > compilerOutputTemp_"')
	"call ch_sendraw(g:compiler_channel, '%comspec% "G:\MyPrograms\Handmade\build.bat" > compilerOutputTemp_')
	"call ch_sendraw(g:compiler_channel, 'G:\MyPrograms\Handmade\build.bat > compilerOutputTemp_\n')
	
endfunction

function! AsyncDebug()
	if !exists('g:compiler_job')
		call LaunchVCEnv()
	endif
	let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "..\debug.bat' . "\n")
	"silent !start ..\debug.bat
	"call system('..\debug.bat')
endfunction

function! AsyncRun()
	if !exists('g:compiler_job')
		call LaunchVCEnv()
	endif
	let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "..\run.bat' . "\n")
	"silent !start ..\run.bat
	"call system('start /B ..\run.bat')
endfunction

function! MyCompile() 
	silent !..\build.bat > compilerOutputTemp_
	"silent !G:\MyPrograms\Handmade\build.bat > compilerOutputTemp_
	"silent cgetfile compilerOutputTemp_ 
	"silent cfile compilerOutputTemp_ 
	silent cgetfile compilerOutputTemp_ 
	let error_count = len(filter(getqflist(), 'v:val.valid != 0'))

	if(error_count > 0)
		caddexpr "\nCompilation failed with " . error_count . " errors."
	else
		caddexpr "\nCompilation successful."
	endif

	copen "9999
	
	:setlocal syntax=compilerOutput
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


