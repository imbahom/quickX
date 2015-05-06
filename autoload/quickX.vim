" vim:tabstop=2:shiftwidth=4:expandtab:foldmethod=marker:textwidth=79
" simple vim plugin for cocos2d-x lua developers
" repo url : github.com/imbahom/quickX
" Maintainer: imbahom <imbahom@gmail.com>

scriptencoding utf-8

if exists("g:loaded_quickX")
    finish
endif
let g:loaded_quickX = 1

let s:autocommands_done = 0

"init{{{
fu! quickX#init() abort
    s:CreateAutocmd()
endf
"}}}

" {{{
fu! s:CreateAutocmd() abort
    augroup quickX
        autocmd!

        " autocmd ShellCmdPost * redraw!
    augroup END
    let s:autocommands_done = 1
    return 1
endf
"}}}

"{{{
fu! quickX#RunPlayer()
    exe system("source ~/.zshrc")
    if !exists("$QUICK_V3_ROOT")
        echohl WarningMsg | echo "Please make sure launch vim from \
        terminal.\nDid you set QUICK_V3_ROOT in your .bashrc or .zshrc?\n" | echohl None
        return
    endif

    let s:workDir = getcwd()
    let s:file = "src/main.lua"
    let s:width = str2nr(system("sed -n '/CONFIG_SCREEN_WIDTH/p' src/config.lua | awk 'NR==1 {print $3}'"))
    let s:height = str2nr(system("sed -n '/CONFIG_SCREEN_HEIGHT/p' src/config.lua | awk 'NR==1 {print $3}'"))
    let s:orientation = str2nr(system("sed -n '/CONFIG_SCREEN_ORIENTATION/p' src/config.lua | awk 'NR==1 {print $3}'"))
    let s:scale = (system("sed -n '/\"scale\"/p' config.json | awk 'NR==1 {print $3}'"))
    let s:scale = string(0.75)
    let s:debuggerType = " -disable-debugger " 
    " let s:debuggerType = " -debugger-codeide " 
    " let s:debuggerType = " -debugger-ldt " 

    let s:args = " -workdir ".s:workDir." -file ".s:file." -".s:orientation." -size ".s:width."x".s:height." -scale ".s:scale.s:debuggerType
    let s:customed_player = s:workDir."/runtime/mac/Client'\ Mac.app/Contents/MacOS/Client'\ Mac"
    echo s:customed_player
    let s:quick_player_path =$QUICK_V3_ROOT."/player3.app/Contents/MacOS/player3"
    " echo s:quick_player_path
    let g:tips = ""
    if executable(s:customed_player)
        let g:tips = "Run with customed player."
        let s:cmd = join(["!",s:customed_player,s:args," &"],"")
        silent! execute s:cmd
    elseif executable(s:quick_player_path)
        let g:tips = "Run with default player."
        let s:cmd = join(["!",s:quick_player_path,s:args," &"],"")
        silent! execute s:cmd
    else
        echohl WarningMsg | echo "err : cant find any app of player\n" | echohl NONE
    endif
    echo g:tips
endf
"}}}

" fu! CompileScripts()
    " " let scriptPath = join(getcwd()
" endf
" command! CompileScripts call CompileScripts()

"loaaQuickXFrameWork{{{
fu! quickX#LoadQuickXFramework()
    let s:cmd = ""
    if has("gui_running")
        let s:cmd = "!cd $QUICK_V3_ROOT/quick/framework && find . -name '*.lua' | xargs mvim"
        silent! exe s:cmd
    else
        let s:cmd = "!cd $QUICK_V3_ROOT/quick/framework && find . -name '*.lua' | xargs vim"
        silent! exe s:cmd
    endif
endf
"}}}

"create class {{{
fu! quickX#Create_class(name)
    let s:template = "local ".a:name." = class(\"".a:name."\")\n\nfunction ".a:name.":ctor()\n\nend\n\nreturn ".a:name
    normal diw
    let @* = s:template
    silent! normal "*p
endf
"}}}

"create function by name {{{
fu! quickX#Create_function(funcName)
    let s:fileName = matchstr(expand("%:t"),"[^\.]*")
    let s:template = "function ".s:fileName.":".a:funcName."()\n\nend"
    normal diw
    let @* = s:template
    silent! normal "*p
endf
"}}}

"viewDebugLog {{{
fu! quickX#View_debugLog()
    let s:workDir = getcwd()
    let s:cmd1 = ":new"
    silent! exe s:cmd1
    let s:cmd2 = ":r!cat ".s:workDir."/debug.log"
    silent! exe s:cmd2
endf
"}}}

