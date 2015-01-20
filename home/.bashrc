# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
        . /etc/bash.bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# mint-fortune
/usr/bin/mint-fortune
export SOAP_UI_HOME=/home/erik/soap-ui/soapui-4.6.0
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_67
export GRADLE_HOME=/home/erik/tools/gradle-2.2/
export PATH=$PATH:$JAVA_HOME/bin:/usr/bin/nodejs:$SOAP_UI_HOME/bin:$GRADLE_HOME/bin
CLASSPATH=$CLASSPATH:/usr/local/commons-logging-1.1.3:/home/erik/spring-framework-4.0.0.M1
#Add lucene stuff to CLASSPATH
export LUCENE_HOME=/home/erik/java/lucene/lucene-4.10.1/
export CLASSPATH=$CLASSPATH:$LUCENE_HOME/core/lucene-core-4.10.1.jar:/$LUCENE_HOME/queryparser/lucene-queryparser-4.10.1.jar:$LUCENE_HOME/analysis/common/lucene-analyzers-common-4.10.1.jar:$LUCENE_HOME/demo/lucene-demo-4.10.1.jar
export NO_AT_BRIDGE
MAVEN_OPTS="-Xms256m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=256m"
export MAVEN_OPTS
export QTDIR=/usr/share/qt3
export NO_AT_BRIDGE=1

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
