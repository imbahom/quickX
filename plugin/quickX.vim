" vim:tabstop=2:shiftwidth=4:expandtab:foldmethod=marker:textwidth=79
" simple vim plugin for cocos2d-x lua developers
" repo url : github.com/imbahom/quickX
" Maintainer: imbahom <imbahom@gmail.com>

scriptencoding utf-8

if exists("quickX") || &cp
    finish
endif
let quickX = 1
let s:old_cpo = $cpo
set cpo&vim

normal exe call quickX#init()

noremap  <Leader>ll  :args **src/*.lua<CR>
vnoremap <Leader>gg  YGPifunction <ESC>wwr:wdwdwyeiget<ESC>l~wc$()<CR><ESC>iend<ESC>O<ESC>"0pIreturn <ESC>A_<ESC>biself.<ESC>

command! RunPlayer call quickX#RunPlayer()
command! LoadFrameWork call quickX#LoadQuickXFramework()
command! ViewDebugLog call quickX#View_debugLog()
command! CreateClassWithName call quickX#Create_class(expand("<cword>"))
command! CreateClassWithFileName call quickX#Create_class(expand("%:t:r"))
command! CreateFunctionWithName call quickX#Create_function(expand("<cword>"))

" MAPPING {{{
if !hasmapto('<Plug>RunPlayer')
    nmap  <silent><unique> <F3> <Plug>RunPlayer
endif
nnoremap <unique><script> <Plug>RunPlayer :RunPlayer<CR>

if !hasmapto('<Plug>LoadFrameWork')
    nmap  <silent><unique> <Leader>lf <Plug>LoadFrameWork
endif
nnoremap <unique><script> <Plug>LoadFrameWork :LoadFrameWork<CR>

if !hasmapto('<Plug>ViewDebugLog')
    nmap  <silent><unique> <Leader>vdl <Plug>ViewDebugLog
endif
nnoremap <unique><script> <Plug>ViewDebugLog :ViewDebugLog<CR>
"}}}


let &cpo = s:old_cpo
