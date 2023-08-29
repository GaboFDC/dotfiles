# ~/.bash_logout: executed by bash(1) when login shell exits.

# Gabo backup history
cp ~/.bash_history ~/.bash_history.bkp
if [[ "$(stat -c%s ~/.bash_history.bkp)" -gt "$(stat -c%s ~/.bash_history.bkp.safe)" ]]; then
    cp  ~/.bash_history.bkp ~/.bash_history.bkp.safe;
fi

# Gabo save directory on exit
if [[ ! "$(pwd)" == *"VS Code"*  ]];then
    echo "LOGOUT PWD $PWD"
    pwd | sed 's/ /\\ /g' > ~/.lastdirectory
fi

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
