#!/usr/bin/bash
cd $QUICK_COCOS2DX_ROOT/framework
find . -name "*.lua" | xargs mvim
# mvim **/*.lua
