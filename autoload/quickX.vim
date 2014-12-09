scriptencoding utf-8

let s:autocommands_done = 0

fu! quickX#init() abort
    s:CreateAutocmd()
endf

fu! s:CreateAutocmd() abort
    augroup quickX
        autocmd!

        " autocmd ShellCmdPost * redraw!
    augroup END
    let s:autocommands_done = 1
    return 1
endf

fu! quickX#RunPlayer()
    exe system("source ~/.zshrc")

    let s:workDir = getcwd()
    let s:file = "scripts/main.lua"
    let s:width = str2nr(system("sed -n '/CONFIG_SCREEN_WIDTH/p' config.lua | awk 'NR==1 {print $3}'"))
    let s:height = str2nr(system("sed -n '/CONFIG_SCREEN_HEIGHT/p' config.lua | awk 'NR==1 {print $3}'"))

    if !exists("$QUICK_COCOS2DX_ROOT")
        echohl WarningMsg | echo "Please make sure launch vim from \
        terminal.\nDid you set QUICK_COCOS2DX_ROOT in your .bashrc or .zshrc?\n" | echohl None

        return
    endif
    let s:args = " -workdir ".s:workDir."/../"." -file ".s:file." -size ".s:width."x".s:height
    let s:customed_player = s:workDir."/.."."/proj.player/quick-x-player.app/Contents/MacOS/quick-x-player"
    let s:quick_player_path =$QUICK_COCOS2DX_ROOT."/player/bin/mac/quick-x-player.app/Contents/MacOS/quick-x-player"
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

" fu! CompileScripts()
    " " let scriptPath = join(getcwd()
" endf
" command! CompileScripts call CompileScripts()

fu! quickX#LoadQuickXFramework()
    let s:cmd = ""
    if has("gui_running")
        let s:cmd = "!cd $QUICK_COCOS2DX_ROOT/framework && find . -name '*.lua' | xargs mvim"
        silent! exe s:cmd
    else
        let s:cmd = "!cd $QUICK_COCOS2DX_ROOT/framework && find . -name '*.lua' | xargs vim"
        silent! exe s:cmd
    endif
endf

fu! quickX#Create_class(name)
    let s:template = "local ".a:name." = class(\"".a:name."\")\n\nfunction ".a:name.":ctor()\n\nend\n\nreturn ".a:name
    normal diw
    let @* = s:template
    silent! normal "*p
endf

fu! quickX#Create_function(funcName)
    let s:fileName = matchstr(expand("%:t"),"[^\.]*")
    let s:template = "function ".s:fileName.":".a:funcName."()\n\nend"
    normal diw
    let @* = s:template
    silent! normal "*p
endf

fu! quickX#View_debugLog()
    let s:workDir = getcwd()
    let s:cmd1 = ":new"
    silent! exe s:cmd1
    let s:cmd2 = ":r!cat ".s:workDir."/.."."/debug.log"
    silent! exe s:cmd2
endf

