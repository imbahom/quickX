" vim:tabstop=2:shiftwidth=4:expandtab:foldmethod=marker:textwidth=79
" simple vim plugin for cocos2d-x lua developers
" repo url : github.com/imbahom/quickX
" Maintainer: imbahom <imbahom@gmail.com>

scriptencoding utf-8

if exists("g:Loaded_quickX")
    finish
endif
let g:Loaded_quickX = 1

"  player_type
"  default      ==  0
"  custom       ==  1
"  none         ==  -1
" let g:player_type = 0

let s:autocommands_done = 0

"init{{{
fu! quickX#init() abort
    call quickX#CreateAutocmd()
    call quickX#initVal()

    let &tags=$QUICK_V3_ROOT."/cocos/tags"
    set tags+=./tags;
endf
"}}}

"{{{
fu! quickX#CreateAutocmd() abort
    augroup quickX
        autocmd!

        " autocmd ShellCmdPost * redraw!
    augroup END
    let s:autocommands_done = 1
    return 1
endf
"}}}

"setPlayerType{{{
fu! quickX#initVal()
    exe system("source ~/.zshrc")
    if !exists("$QUICK_V3_ROOT")
        let g:player_type = -1
        return
    endif
    let s:workDir = getcwd()
    let g:customed_player = s:workDir."/runtime/mac/Client\ Mac.app/Contents/MacOS/Client\ Mac"
    let g:quick_player_path =$QUICK_V3_ROOT."/player3.app/Contents/MacOS/player3"
    if executable(g:customed_player)
        let g:customed_player = s:workDir."/runtime/mac/Client\\ Mac.app/Contents/MacOS/Client\\ Mac"
        " fuck quick 这个runtime 代码有问题吧，一定是我不理解，暂时不用custom
        " player
        let g:player_type = 0
        " let g:player_type = 1
    elseif executable(g:quick_player_path)
        let g:player_type = 0
    else
        let g:player_type = -1
    endif
endf
"}}}

"RunPlayer{{{
fu! quickX#RunPlayer()
    if g:player_type == -1
        echohl WarningMsg | echo "Please make sure launch vim from \
        terminal.\nDid you set QUICK_V3_ROOT in your .bashrc or .zshrc?\n" | echohl None
        echohl WarningMsg | echo "err : cant find any app of player\n" | echohl NONE
        return
    endif

    let s:file = "src/main.lua"
    let s:width = str2nr(system("sed -n '/CONFIG_SCREEN_WIDTH/p' src/config.lua | awk 'NR==1 {print $3}'"))
    let s:height = str2nr(system("sed -n '/CONFIG_SCREEN_HEIGHT/p' src/config.lua | awk 'NR==1 {print $3}'"))
    let s:orientation = str2nr(system("sed -n '/CONFIG_SCREEN_ORIENTATION/p' src/config.lua | awk 'NR==1 {print $3}'"))
    let s:scale = (system("sed -n '/\"scale\"/p' config.json | awk 'NR==1 {print $3}'"))
    let s:scale = string(0.75)
    let s:debuggerType = " -disable-debugger "
    " let s:debuggerType = " -debugger-codeide "
    " let s:debuggerType = " -debugger-ldt "

    let s:args = " -workdir ".getcwd()." -file ".s:file." -".s:orientation." -size ".s:width."x".s:height." -scale ".s:scale.s:debuggerType
    let g:tips = ""
    if g:player_type == 1
        let g:tips = "Run with customed player."
        let s:cmd = join(["!",g:customed_player,s:args," &"],"")
        silent! execute s:cmd
    elseif g:player_type == 0
        let g:tips = "Run with default player."
        let s:cmd = join(["!",g:quick_player_path,s:args," &"],"")
        silent! execute s:cmd
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
    if g:player_type == 0
        let s:frameworkPath = "$QUICK_V3_ROOT/quick/framework"
    elseif g:player_type == 1
        let s:frameworkPath = getcwd()."/src/framework"
    endif

    if has("gui_running")
        let s:cmd = "!cd ".s:frameworkPath." && find . -name '*.lua' | xargs mvim"
        silent! exe s:cmd
    else
        let s:cmd = "!cd ".s:frameworkPath." && find . -name '*.lua' | xargs vim"
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
    let s:cmd1 = ":new"
    silent! exe s:cmd1
    let s:cmd2 = ":r!cat ".getcwd()."/debug.log"
    silent! exe s:cmd2
endf
"}}}

"generate tags file using excuberant-ctags{{{
fu! quickX#generateTags()
    if exists("$QUICK_V3_ROOT")
        "Todo:pass more precise params
        exe system("ctags -f $QUICK_V3_ROOT/cocos/tags -R $QUICK_V3_ROOT/cocos")
    endif
endf
"}}}

