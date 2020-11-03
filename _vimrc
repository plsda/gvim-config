source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

call plug#begin("$VIM/plugins")

Plug 'lervag/vimtex'
Plug 'jiangmiao/auto-pairs'
"Plug 'LucHermitte/lh-vim-lib' 
"Plug 'LucHermitte/lh-brackets' 
Plug 'tpope/vim-surround'
"Plug 'tmsvg/pear-tree'
"Plug 'ycm-core/YouCompleteMe'

call plug#end()

"let g:pear_tree_map_special_keys = 0
"let g:pear_tree_smart_openers = 1
"let g:pear_tree_smart_backspace = 1
"let g:pear_tree_repeatable_expand = 0
"imap <BS> <Plug>(PearTreeBackspace)
"imap <CR> <Plug>(PearTreeExpand)


    
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''


let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'



set encoding=utf-8

colo desert 
set tabstop=3
set shiftwidth=3
set iskeyword+=:
set cursorline
set nowrap

set swapfile
"set dir=C:/windows/Temp
set dir=$VIM/Temp

set backup
"set backupdir=C:/windows/Temp
"set backupskip=C:/windows/Temp/*
"set directory=C:/windows/Temp
set backupdir=$VIM/Temp
set backupskip=$VIM/Temp/*
set directory=$VIM/Temp
set writebackup

set undofile
"set undodir=C:/windows/Temp
set undodir=$VIM/Temp

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

"Change mode
inoremap <M-q>	<C-c>
inoremap <M-i>	<C-c>

inoremap ö <ESC>
inoremap ä <ESC>
nnoremap ö i
inoremap <C-ö> ö
inoremap <C-ä> ä

"autocmd FileType tex iunmap ö
"autocmd FileType tex iunmap ä

"inoremap <CapsLock>	<esc>
"Change mode
"inoremap jk <C-c>
"inoremap kj <C-c>

nnoremap £ {

"Format
nnoremap <space> =iB<C-o>
"nnoremap <CapsLock> =iB<C-o>
nnoremap gp `[v`]
"Delete line
nnoremap <M-q> "_dd

"Using a named register(a) for yanking, cutting and pasting
"A better alternative below 
"vnoremap c "ac
"vnoremap y "ay
"vnoremap p "ap
"nnoremap p "ap
"nnoremap cc "acc
"nnoremap cw "acw
"nnoremap cW "acW
"nnoremap yy "ayy
"nnoremap yw "ayw
"nnoremap yW "ayW

"Use the unnamed(") register for yank and cut but paste from register 0(holds
"the latest yank) since " is trashed by deletes etc.
vnoremap p "0p
nnoremap p "0p
"Cut is problematic, since seems like it isn't considered a yank but a delete
vnoremap c "0c
nnoremap cc "0cc
nnoremap cw "0cw
nnoremap cW "0cW

"Move line/selection up or down
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

"For quick, small movements in insert mode 
inoremap <M-h> <left>
inoremap <M-l> <right>
inoremap <M-j> <down>
inoremap <M-k> <up>

"Duplicate line
nnoremap <M-d> yyp
"Cycle tabs
nnoremap <M-n> gt
nnoremap <M-p> gT

"Macro playback(always use register 'd')
nnoremap <C-Space> @d

"Quickfix commands
nnoremap <C-CR> :cclose<CR>
nnoremap <C-Right> :cnext<CR>
nnoremap <C-Left> :cNext<CR>

"Delete buffer without closing the window
command! BW :bn|:bd#

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

"By default, look for build.bat, debug.bat and run.bat to compile, run the debugger and run the program respectively
nnoremap <F5> :call AsyncCompile()<cr>
nnoremap <F9> :call AsyncDebug()<cr>
nnoremap <F12> :call AsyncRun()<cr>
autocmd FileType tex nnoremap <F5> :VimtexCompile<cr>
autocmd FileType tex nnoremap <F9> :VimtexCompileSS<cr>
autocmd FileType tex nnoremap <F12> :VimtexView<cr>
autocmd FileType tex nnoremap j gj
autocmd FileType tex nnoremap k gk
"autocmd FileType tex :set nowrap linebreak wrapmargin=2
autocmd FileType tex :set wrap linebreak
autocmd Filetype tex let b:autopairs_enabled = 0

"https://vimhelp.org/channel.txt.html#channel.txt 
"https://vim.fandom.com/wiki/Execute_external_programs_asynchronously_under_Windows
"https://andrewvos.com/writing-async-jobs-in-vim-8/"
"https://devhints.io/vimscript"


" A) Direct the compiler output to a file, read file to the quickfix window after done
" B) Direct the compiler output directly to a buffer, update the quickfix live from the output via the buffer
" C) Direct the compiler output to a file, add a buffer for the file(and display results live), apply quickfix stuff after all is done(pros: easy to detect when compiler is done)
"Currently using B

function! CHandler(channel, msg)
	"silent cgetfile compilerOutputTemp_ "For option A
	let l:errorbuffernr = bufnr('dummybuffer') 
	silent exe "cgetbuffer" l:errorbuffernr

	let l:error_count = len(filter(getqflist(), 'v:val.type == "C"'))
	let l:warning_count = len(filter(getqflist(), 'v:val.type == "W"'))

	if(l:error_count > 0)
		caddexpr "\nCompilation failed with " . l:error_count . " errors and " . l:warning_count . " warnings."
	else
		caddexpr "\nCompilation successful. Warnings: " . l:warning_count
	endif

	copen 
	:setlocal syntax=compilerOutput
	normal G
	exe "normal \<c-w>\<c-p>"
	
endfunction

"function! IndicatorJob(channel, msg)
"	echo '/'
"	sleep 300
"	echo '—''
"	sleep 300
"	echo '\'
"	sleep 300
"endfunction

function! LaunchVCEnv()
	"silent !call "E:\VisualStudio\VC\Auxiliary\Build\vcvars64.bat"
	"silent !call "E:\VisualStudio\Common7\Tools\VsDevCmd.bat""
	"TODO: parameterize these paths
	"let g:compiler_job = job_start('!call "E:\VisualStudio\VC\Auxiliary\Build\vcvars64.bat" && G: && cd G:\MyPrograms\Handmade\code', {"out_cb": "CHandler"})	"For option A
	
	let g:compiler_job = job_start('cmd /k "E:\VisualStudio\VC\Auxiliary\Build\vcvars64.bat"', {"out_io": "buffer", "out_name": "dummybuffer", "out_cb": "CHandler"})
	let l:dummybuffernr = bufnr('dummybuffer') 				 "used
	call setbufvar(l:dummybuffernr, "&buftype", "nofile") "these
	
	"call setbufvar(l:dummybuffernr, "&bufhidden", "hide")
	"call setbufvar(l:dummybuffernr, "noswapfile")

	let g:compiler_channel = job_getchannel(g:compiler_job)
	
	let l:c_status = ch_status(g:compiler_job)
	if(l:c_status != "open")
		echoerr "Failed to start the compiler job"
	endif

endfunction

function! AsyncCompile()
	"These are not needed for option A
	
	"exe "bwipeout!" bufnr('dummybuffer')
	":setlocal syntax=compilerOutput
	":q
	if(bufexists('dummybuffer'))
		"NOTE: Potentially a very dangerous hack to reset the dummybuffer used by compiler output
		:sb! dummybuffer | %d 
		:hide
	endif


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
	
	"let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "2>NUL ..\build.bat > compilerOutputTemp_"' . "\n")	"For option A
	let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "2>NUL ..\build.bat"' . "\n")
	
endfunction

function! AsyncDebug()
	if !exists('g:compiler_job')
		call LaunchVCEnv()
	endif
	let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "..\debug.bat"' . "\n")
	"silent !start ..\debug.bat
	"call system('..\debug.bat')
endfunction

function! AsyncRun()
	if !exists('g:compiler_job')
		call LaunchVCEnv()
	endif
	let l:cResponse = ch_evalraw(g:compiler_channel, '%comspec% /c "..\run.bat"' . "\n")
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



"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      if empty(&shellxquote)
"        let l:shxq_sav = ''
"        set shellxquote&
"      endif
"      let cmd = '"' . $VIMRUNTIME . '\diff"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"  if exists('l:shxq_sav')
"    let &shellxquote=l:shxq_sav
"  endif
"endfunction

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
