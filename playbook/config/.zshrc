ZSH_THEME="frisk"

export EDITOR=nano
export VISUAL="$EDITOR"
export ZSH="$HOME/.oh-my-zsh"

export ANDROID_HOME=/home/divya/Android/Sdk
export ANDROID_SDK_ROOT=/home/divya/Android/Sdk  
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

alias cat=batcat

plugins=(git)

source $ZSH/oh-my-zsh.sh
