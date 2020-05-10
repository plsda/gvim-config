syntax case ignore

syntax match errPath /\<\S*\.\(cpp\|h\)\>/
syntax match errError /\<error\(s*\)/
syntax match errWarning /\<warning\(s*\)/
syntax keyword errSuccessful successful
syntax keyword errFailed failed

highlight errPath guifg=lightblue gui=underline
highlight errError guifg=red
highlight errWarning guifg=yellow
highlight errSuccessful guifg=green gui=bold
highlight errFailed guifg=red gui=bold
