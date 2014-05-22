fu! RunPlayer()

    let s:workDir = getcwd()
    let s:file = "scripts/main.lua"
    let s:width = system("sed -n '/CONFIG_SCREEN_WIDTH/p' config.lua | awk 'NR==1 {print $3}'")
    let s:height = system("sed -n '/CONFIG_SCREEN_HEIGHT/p' config.lua | awk 'NR==1 {print $3}'")

    if !exists($QUICK_COCOS2DX_ROOT)
        let $QUICK_COCOS2DX_ROOT = g:QUICK_COCOS2DX_ROOT
    endif
    let s:quick_root = $QUICK_COCOS2DX_ROOT
    let s:args = join(["-workdir ",s:workDir,"/../"," -file ",s:file," -size ",s:width,"x",s:height],"")
    let s:customed_player = join([s:workDir,"/..","/proj.player/quick-x-player.app/Contents/MacOS/quick-x-player"],"")
    let s:quick_player_path =join([s:quick_root,"/player/bin/mac/quick-x-player.app/Contents/MacOS/quick-x-player"],"")
    let g:tips = ""
    if executable(s:customed_player)
        let g:tips = "Run with customed player."
        silent! execute join(["!","nohup ",s:customed_player,s:args," >/dev/null &"]," ")
    elseif executable(s:quick_player_path)
        let g:tips = "Run with default player."
        silent! execute join(["!","nohup ",s:quick_player_path,s:args," >/dev/null &"]," ")
    else
        echo "err : cant find any app of player\n"
        if !exists(s:quick_player_path)
            echo "If you started your vim by dragging a file , then please set QUICK_COCOS2DX_ROOT or g:QUICK_COCOS2DX_ROOT\n"
        elseif !exists(s:customed_player)
            echo "If you started your vim by dragging a file , then please set QUICK_COCOS2DX_ROOT\n"
        else
            echo "please set QUICK_COCOS2DX_ROOT\n"
        endif
    endif
    echo g:tips
endf
command! RunPlayer call RunPlayer()

fu! CompileScripts()
    " let scriptPath = join(getcwd()
endf
command! CompileScripts call CompileScripts()

fu LoadLuafiles()
    let s:workDir = getcwd()
    let s:quick_scripts_pathName = "scripts"
    let s:pathLen = strlen(s:workDir)
    let s:partLen = strlen(s:quick_scripts_pathName)
    if  s:pathLen > s:partLen
        if strpart(s:workDir,s:pathLen-s:partLen,s:partLen) == s:quick_scripts_pathName
            :args**/*.lua
            return
        endif
    endif

    echo printf("load lua files failed ,please make sure your current working dir is **/**/**/%s",s:quick_scripts_pathName)
endf
command! LoadLuafiles call LoadLuafiles()

" todo
fu LoadQuickXFrameworkInNewWindow()

endf

command! LoadGetterReg call LoadGetterReg()

noremap <D-F2> :RunPlayer<CR>
noremap <Leader>ll :LoadLuafiles<CR>
vnoremap <Leader>gg YGPifunction <ESC>wwr:wdwdwyeiget<ESC>l~wc$()<CR><ESC>iend<ESC>O<ESC>"0pIreturn <ESC>A_<ESC>biself.<ESC>
