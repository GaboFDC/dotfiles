# ~/.bash_logout: executed by bash(1) when login shell exits.

# Gabo backup history
cp ~/.bash_history ~/.bash_history.bkp

# Gabo save directory on exit
if [[ ! "$(pwd)" == *"VS Code"*  ]];then
    echo "LOGOUT PWD $PWD"
    pwd | sed 's/ /\\ /g' > ~/.lastdirectory
fi

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
