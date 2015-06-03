# base-files version 4.0-4
# ~/.bashrc: executed by bash(1) for interactive shells.

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export PATH="/usr/local/bin:$PATH:~/bin:~/github/command-line-scripts"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"      # gnu coreutils
export PATH="$PATH:/Applications/BB10 WebWorks SDK 2.1.0.13/cordova-blackberry/bin/dependencies/bb-tools/bin"
export PATH="$PATH:~/.git-scripts"               
export PATH="$PATH:./node_modules/.bin"               
export PATH="$PATH:/usr/local/share/python"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PYTHONSTARTUP="/Users/jamie/.pythonstartup"
export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
export HOMEBREW_GITHUB_API_TOKEN='c0a4b23af01f71531bd166e81e9713f865762de0'

export   SHELL=bash
export  EDITOR=vim
export   PAGER=less
export    LESS=-R
unset  GREP_OPTIONS

export HISTCONTROL=ignoredups      # don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth      # ... and ignore same sucessive entries.
export COMP_CVS_REMOTE=1           # Define to access remotely checked-out files over passwordless ssh for CVS
export COMP_CONFIGURE_HINTS=1      # Define to avoid stripping description in --option=description of './configure --help'
export COMP_TAR_INTERNAL_PATHS=1   # Define to avoid flattening internal contents of tar files

# Remove dyld: DYLD_ environment variables being ignored because main executable (/usr/bin/sudo) is setuid or setgid
unset LD_LIBRARY_PATH
unset DYLD_LIBRARY_PATH

#export JAVA_REBEL="-Drebel.spring_plugin=false -noverify -javaagent:C:/JRebel/jrebel.jar"
#export JAVA_DEBUG="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=4000,server=y,suspend=n"
#export JAVA_MEM="  -Xms512M -Xmx2048M -XX:MaxPermSize=512M"
#export MAVEN_OPTS="$JAVA_MEM $JAVA_DEBUG $JAVA_REBEL"

# see http://www.caliban.org/bash/index.shtml
#shopt -s cdspell
#shopt -s checkwinsize
#shopt -s cmdhist
#shopt -s dotglob
#shopt -s extglob      # regexps for pattern matching
#shopt -s nocaseglob
#set   -o ignoreeof      # Don't use ^D to exit
shopt  -s histappend    # Make Bash append rather than overwrite the history on disk
shopt  -s checkwinsize  # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
set    -o notify          # Don't wait for job termination notification
set       visible-stats on   # ls -F for bash-completion
unset     USERNAME

bind 'C-u:kill-whole-line'              # Ctrl-U kills whole line
#bind 'set bell-style visible'           # No beeping
#bind 'set horizontal-scroll-mode on'    # Don't wrap
bind 'set show-all-if-ambiguous on'     # Tab once for complete
bind 'set visible-stats on'             # Show file info in complete

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# If not running interactively, don't do anything more
[ -z "$PS1" ] && return

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*) PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"' ;;
    dumb*)        PS1=$PROMPT_COMMAND'\u@\h:\w\$ ' ;;
    *)            ;; 
esac

# welcome message
if [ "$TERM" != "dumb" ]; then
    for FILE in \
        ~/.bash_prompt \
        ~/.bash_alias  \
        ~/.bash_functions;
    do
        if [ -f $FILE ]; then . $FILE; fi;
    done;

    for FILE in \
        /etc/bash_completion \
        ~/.bash_completion \
        ~/.bash_completion_grails \
        /etc/bash_completion.d/git-completion.bash \
        /usr/local/etc/bash_completion.d/git-completion.bash \
	~/.git-prompt.sh
    do
        if [[ -f $FILE ]]; then . $FILE; fi;
    done;
      
    #if [[ `which bower`   ]]; then bower completion;           fi;  # slow
    #if [[ `which npm`     ]]; then eval "$(npm completion -)"; fi;  # slow

    if [[ `which fortune` ]]; then echo; fortune; echo; fi; 
    if [[ `which ddate`   ]]; then       ddate;   echo; fi
    #if [ "$TERM" != "screen" ]; then
    #    #updatedb > /dev/null &
    #    /usr/bin/screen development
    #fi
fi
