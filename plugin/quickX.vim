scriptencoding utf-8

normal exe call quickX#init()

noremap  <Leader>ll  :args**/*.lua<CR>

command! RunPlayer call quickX#RunPlayer()
norema  <F3>      :RunPlayer<CR>

command! LoadFrameWork call quickX#LoadQuickXFramework()
noremap  <Leader>lf  :LoadFrameWork<CR>

command! ViewDebugLog call quickX#View_debugLog()
nnoremap <Leader>vdl :ViewDebugLog<CR>

vnoremap <Leader>gg  YGPifunction <ESC>wwr:wdwdwyeiget<ESC>l~wc$()<CR><ESC>iend<ESC>O<ESC>"0pIreturn <ESC>A_<ESC>biself.<ESC>

command! CreateClassWithName call quickX#Create_class(expand("<cword>"))
command! CreateFunctionWithName call quickX#Create_function(expand("<cword>"))
