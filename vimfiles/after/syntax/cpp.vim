syntax keyword mySUPERNOTE SUPERNOTE containedin=cComment, cCommentL contained
syntax keyword myNOTE NOTE, NOTE: containedin=cComment, cCommentL contained
syntax keyword myTODO TODO, TODO: containedin=cComment, cCommentL contained

highlight mySUPERNOTE guifg=red gui=bold
highlight myNOTE guifg=green
highlight myTODO guifg=red
