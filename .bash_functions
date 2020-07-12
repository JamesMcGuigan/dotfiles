#!/bin/bash

###  Extra Commands ###

alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias ........='cd ../../../..'
alias path='echo -e ${PATH//:/\\n}'
alias which='type -all'
alias vimexec="perl -p -i -e 's/^(\S+):(\d+):.*$/\$1 +$2 /g' | xargs sh -c '</dev/tty vim \$*' "
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'

if [[ `uname -o 2> /dev/null || uname` == "Darwin" ]]; then
    alias showhiddenfiles='defaults write com.apple.finder AppleShowAllFiles TRUE;  killall Finder'
    alias hidehiddenfiles='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
fi
if [[ `uname -o 2> /dev/null || uname` == "Cygwin" ]]; then
    alias start='cygstart '
fi


### Anaconda Functions
function conda-activate () {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/usr/local/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/usr/local/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  if [[ $1 ]]; then
    conda activate $1
  fi;
  conda info --envs
}

### SSH Functions ###

function sshr () {
    echo ssh -R 12345:localhost:22 "$@"; echo;
    ssh -R 12345:localhost:22 "$@"
}

### Ping Functions ###

alias pinggoogle='time ping 8.8.8.8'
alias pingrouter='time ping 192.168.1.254'
alias pingisp='time ping 90.155.53.6'



### Helper Functions ###

function isNumeric(){ [ "$(echo $*|grep -v "[^0-9]")" ]; }
function argc () {
    count=0;
    for arg in "$@"; do
        if [[ ! "$arg" =~ ^- ]]; then count=$(($count+1)); fi;
    done;
    echo $count;
}

show    () { for i in $*; do eval echo "\ \ \#\#  $i=\(\$$i\)";  done; }
field   () { awk "/.*/ {print \$$1} "; }
fields  () { fields=`echo $@ \
                   | sed 's/\(\w\)\s*/\$\1, /g' \
                   | sed 's/,\s*$//'`;
			awk "/.*/ {print $fields} ";
		  }



### Filesystem Functions ###

alias findf='find ./ -type f -name '
alias findd='find ./ -type d -name '

catwhich () {
    _ARG3=`type "$@" | head -n 1 | awk '{ print $3 }'`;
    _ARG4=`type "$@" | head -n 1 | awk '{ print $4 }'`;
    if [ "$_ARG3" == "" ]; then
        echo "catwhich: $@ not defined"
    elif [ "$_ARG4" == "function" ]; then
        type -a "$@"
    elif [ "$_ARG3" == "aliased" ]; then
        type -a "$@"
    else
        echo "+$_ARG3"
        cat $_ARG3
    fi
}
locateall() {
    /usr/bin/locate "$@"
}
locatepwd() {
    /usr/bin/locate "$@" | greplocate --color=auto "`pwd`/"
}
greplocate() {
    grep --color=never "$@" | grep -v '\.svn\|\.crxde\|\.tmp\|\.vlt\|.swp\|.bak\|.backup\|/RECYCLER/' | perl -p -e 's!^C:!/c!; s!/cygdrive!!; s!/c/code!/code!; s!/code/premierleague.com/branch/cms/cq/jcr_root/!/jcr_root/!'
}



### Grep / Awk Functions ###

alias gitawkmodified=" git st | awk '/modified:/  { print \$2 }'"
alias gitawkdeleted="  git st | awk '/deleted:/   { print \$2 }'"
alias gitawkadded="    git st | awk '/added:/     { print \$2 }'"
alias gitawkuntracted="git clean --dry-run | awk '{ print \$3 }'"

function awkf() {
    ($(isNumeric $1) && /usr/bin/awk "//    { print \$$1 }" $2 $3 $4 $5 $6 $7 $8 $9) ||
    ($(isNumeric $2) && /usr/bin/awk "/^$1/ { print \$$2 }"    $3 $4 $5 $6 $7 $8 $9) ||
                        /usr/bin/cat
}

alias awkM='   awk "/^M/       { print \$2 }" '
alias awkA='   awk "/^A/       { print \$2 }" '
alias awkD='   awk "/^D/       { print \$2 }" '
alias awkMA='  awk "/^A|^M/    { print \$2 }" '
alias awkAM='  awk "/^A|^M/    { print \$2 }" '
alias awkAMD=' awk "/^A|^M|^D/ { print \$2 }" '
alias awkADM=' awk "/^A|^M|^D/ { print \$2 }" '
alias awkMAD=' awk "/^A|^M|^D/ { print \$2 }" '
alias awkMDA=' awk "/^A|^M|^D/ { print \$2 }" '
alias awkDMA=' awk "/^A|^M|^D/ { print \$2 }" '
alias awkDAM=' awk "/^A|^M|^D/ { print \$2 }" '
alias awkC='   awk "/^C/       { print \$2 }" '
alias awkW='   awk "/^\w/      { print \$2 }" '
alias awk?='   awk "/^?/ { print \$2 }" '
alias awk!='   awk "/^!/ { print \$2 }" '
alias awk1='   awk "//   { print \$1 }" '
alias awk2='   awk "//   { print \$2 }" '
alias awk3='   awk "//   { print \$3 }" '
alias awk4='   awk "//   { print \$4 }" '
alias awk5='   awk "//   { print \$5 }" '
alias awk6='   awk "//   { print \$6 }" '
alias awk7='   awk "//   { print \$7 }" '
alias awk8='   awk "//   { print \$8 }" '
alias awk9='   awk "//   { print \$9 }" '
alias awktmp=' awk "/\.(tmp|swp|swo)$/ { print \$2 }"'
#alias awkf='   grep : | sed s/:.*// '

alias awkdir1="awk2 | perl -p -e 's!(^([^/]*/?){1}).*!\$1!' | sort | uniq "
alias awkdir2="awk2 | perl -p -e 's!(^([^/]*/?){2}).*!\$1!' | sort | uniq "
alias awkdir3="awk2 | perl -p -e 's!(^([^/]*/?){3}).*!\$1!' | sort | uniq "
alias awkdir4="awk2 | perl -p -e 's!(^([^/]*/?){4}).*!\$1!' | sort | uniq "
alias awkdir5="awk2 | perl -p -e 's!(^([^/]*/?){5}).*!\$1!' | sort | uniq "
alias awkdir6="awk2 | perl -p -e 's!(^([^/]*/?){6}).*!\$1!' | sort | uniq "

alias rgrepcss='    rgrep --include="*.css" '
alias rgrepscss='   rgrep --include="*.scss" '
alias rgrephtml='   rgrep --include="*.html" '
alias rgrepjava='   rgrep --include="*.java" '
alias rgrepjs='     rgrep --include="*.js" '
alias rgrepjsp='    rgrep --include="*.jsp" '
alias rgreppm='     rgrep --include="*.pm" '
alias rgrepxml='    rgrep --include="*.xml" '
alias rgreppom='    rgrep --include="pom.xml" '
alias rgrepjspjs='  rgrep --include="*.jsp" --include="*.js" '
alias rgrepjsjsp='  rgrep --include="*.jsp" --include="*.js" '
alias rgrepjspcss=' rgrep --include="*.jsp" --include="*.css" '
alias rgrepcssjsp=' rgrep --include="*.jsp" --include="*.css" '
alias rgrepjspm='   rgrep --include="*.js"  --include="*.pm" '
alias rgreppmjs='   rgrep --include="*.js"  --include="*.pm" '
alias rgrepjscss='  rgrep --include="*.js"  --include="*.css" '
alias rgrepcssjs='  rgrep --include="*.js"  --include="*.css" '
alias rgrepjavajsp='rgrep --include="*.jsp" --include="*.java" '
alias rgrepjspjava='rgrep --include="*.jsp" --include="*.java" '

alias fgrepcss='    fgrep --include="*.css" '
alias fgrephtml='   fgrep --include="*.html" '
alias fgrepjava='   fgrep --include="*.java" '
alias fgrepjs='     fgrep --include="*.js" '
alias fgrepjsp='    fgrep --include="*.jsp" '
alias fgreppm='     fgrep --include="*.pm" '
alias fgrepxml='    fgrep --include="*.xml" '
alias fgreppom='    fgrep --include="pom.xml" '
alias fgrepjspjs='  fgrep --include="*.jsp" --include="*.js" '
alias fgrepjsjsp='  fgrep --include="*.jsp" --include="*.js" '
alias fgrepjspcss=' fgrep --include="*.jsp" --include="*.css" '
alias fgrepcssjsp=' fgrep --include="*.jsp" --include="*.css" '
alias fgrepjspm='   fgrep --include="*.js"  --include="*.pm" '
alias fgreppmjs='   fgrep --include="*.js"  --include="*.pm" '
alias fgrepjscss='  fgrep --include="*.js"  --include="*.css" '
alias fgrepcssjs='  fgrep --include="*.js"  --include="*.css" '
alias fgrepjavajsp='fgrep --include="*.jsp" --include="*.java" '
alias fgrepjspjava='fgrep --include="*.jsp" --include="*.java" '

alias svngrepcss='    svngrep --include="*.css" '
alias svngrephtml='   svngrep --include="*.html" '
alias svngrepjava='   svngrep --include="*.java" '
alias svngrepjs='     svngrep --include="*.js" '
alias svngrepjsp='    svngrep --include="*.jsp" '
alias svngreppm='     svngrep --include="*.pm" '
alias svngrepxml='    svngrep --include="*.xml" '
alias svngreppom='    svngrep --include="pom.xml" '
alias svngrepjspjs='  svngrep --include="*.jsp" --include="*.js" '
alias svngrepjsjsp='  svngrep --include="*.jsp" --include="*.js" '
alias svngrepjspcss=' svngrep --include="*.jsp" --include="*.css" '
alias svngrepcssjsp=' svngrep --include="*.jsp" --include="*.css" '
alias svngrepjspm='   svngrep --include="*.js"  --include="*.pm" '
alias svngreppmjs='   svngrep --include="*.js"  --include="*.pm" '
alias svngrepjscss='  svngrep --include="*.js"  --include="*.css" '
alias svngrepcssjs='  svngrep --include="*.js"  --include="*.css" '
alias svngrepjavajsp='svngrep --include="*.jsp" --include="*.java" '
alias svngrepjspjava='svngrep --include="*.jsp" --include="*.java" '

alias vimgrepcss='    vimgrep --include="*.css" '
alias vimgrephtml='   vimgrep --include="*.html" '
alias vimgrepjava='   vimgrep --include="*.java" '
alias vimgrepjs='     vimgrep --include="*.js" '
alias vimgrepjsp='    vimgrep --include="*.jsp" '
alias vimgreppm='     vimgrep --include="*.pm" '
alias vimgrepxml='    vimgrep --include="*.xml" '
alias vimgreppom='    vimgrep --include="pom.xml" '
alias vimgrepjspjs='  vimgrep --include="*.jsp" --include="*.js" '
alias vimgrepjsjsp='  vimgrep --include="*.jsp" --include="*.js" '
alias vimgrepjspcss=' vimgrep --include="*.jsp" --include="*.css" '
alias vimgrepcssjsp=' vimgrep --include="*.jsp" --include="*.css" '
alias vimgrepjspm='   vimgrep --include="*.js"  --include="*.pm" '
alias vimgreppmjs='   vimgrep --include="*.js"  --include="*.pm" '
alias vimgrepjscss='  vimgrep --include="*.js"  --include="*.css" '
alias vimgrepcssjs='  vimgrep --include="*.js"  --include="*.css" '
alias vimgrepjavajsp='vimgrep --include="*.jsp" --include="*.java" '
alias vimgrepjspjava='vimgrep --include="*.jsp" --include="*.java" '

#function rgrep () {
#    # TODO change into a find $dir -exec grep {}\; style command
#    if [[ `argc "$@"` < 2 ]]; then dir='./'; else dir=''; fi; # default to cwd if dir not supplied
#    GREP_COLOR='35;1' nice grep -rHIin --no-messages --color=always --exclude=".vimbackup" --exclude="*~" --exclude="*.sql" --exclude="*.tmp" --exclude="*.svn-base" --exclude="entries" --exclude="ctags" --exclude="functions" --exclude="debug.log" --exclude="sql.log" --exclude="Entries" --exclude="minified.*" --exclude=".#*" --exclude="*.bak" --exclude="jquery.js" "$@" $dir | grep -vP '^.{240}' | grep -v '/CVS/' | grep -v 'demo/' | grep -v '.vimbackup/'
#}

function rgrep () {
    if [[ `argc "$@"` < 2 ]]; then dir='./'; else dir=''; fi; # default to cwd if dir not supplied
    GREP_COLOR='35;1' nice grep -rHIin --no-messages --color=always "$@" $dir \
        --exclude-dir='*.vimbackup' --exclude-dir='.svn' --exclude-dir='target' --exclude-dir='.git' --exclude-dir='platforms' --exclude-dir='node_modules' \
        --exclude='*.tmp' --exclude='*~' --exclude='*.min.*' --exclude='.vlt' --exclude='*.swp' \
        | grep -v '^.{1000}'
}
function fgrep () {
    rgrep --color=never -l "$@"
}

function vimgrep () {
    fgrep --no-messages "$@" | xargs -p vim
    #vim -o `rgrep as-section-title | perl -p -i -e 's/^([^:]*):(\d+):.*/+$2 $1 /g' | uniq -f1 | awk '// { print $2" "$1 }'`
}



### CVS Functions ###

function cvsmod () {
    cvs -n update $* 2> /dev/null | grep -P '^(M|C) '
}
function cvsfmod () {
    cvsmod $* | sed s/^..//
}
function cvswithtag () {
    if [[ `argc "$@"` == 0 ]]; then
        echo "Usage: cvswithtag <tag_regexp>";
    else
        cvs stat | awk '
            BEGIN {
                RS="Repository revision";
                "pwd" |& getline pwd; close("pwd");
                sub(/^.*\/www[^/]*\//, "", pwd);
            }
            /'$@'/ {
                file = $3;
                gsub(/\/cvs\/|,v/, "", file);
                sub(pwd, "", file);
                print file;
            }
        ';
    fi
}
function cvswithtagnotupdated () {
    if [[ `argc "$@"` == 0 ]]; then
        echo "Usage: cvswithtag <tag_regexp>";
    else
        cvs stat | awk '
            BEGIN {
                RS="Repository revision";
                "pwd" | getline pwd; close("pwd");
                sub(/^.*\/www[^/]*\//, "", pwd);
            }
            /'$@'/ {
                cur_ver  = $2;
                file     = $3; gsub(/\/cvs\/|,v/, "", file); sub(pwd, "", file);
                print $0;
                if( $0 ) {
                    command = "awk \"/'$@'/ { print; }\""
                    print command;
                    print | command | getline cur_line;
                    print cur_line;
                }
                print file, cur_ver, cur_line;
#                tag_line = $0; sub( /.*'$@'/, "$1", tag_line );
#
#                #tag_name = ( /'$@'[[:alnum:]_]*/, "XXX", tag_name );
#                #tag_name = $0; gsub(/^.*([a-z_]*'$@'[a-z_]*).*/is, "$1", tag_name);
#                #tag_ver  = $0; gsub(/^.*'$@'[^0-9]*([0-9.]+).*/i, "$1", tag_ver);
#
#                #tag_name_command = "echo $0 | awk \"/'$@'/ \" {                      print $1; exit } }";
#                #tag_ver_command  = "echo $0 | awk \"/'$@'/ \" { sub( /)/, \"\", $3); print $3; exit } }";
#                #tag_name_command |& readline tag_name; close(tag_name_command);
#                #tag_ver_command  |& readline tag_ver;  close(tag_ver_command);
#
#                #if( cur_ver > tag_ver ) {
#                    print "xxx ", file, cur_ver, " ||| ", tag_line
#                #}
            }
        ';
    fi
}


# Unused Functions
#
#function headers () {
#    server=$1; port=${2:-80}
#    exec 5<> /dev/tcp/$server/$port
#    echo -e "HEAD / HTTP/1.0\nHost: ${server}\n\n" >&5
#    cat <&5
#    exec 5<&-
#}
#
## hangs when pointed to a closed port
#testPort() {
#    server=$1; port=$2; proto=${3:-tcp}
#    exec 5<>/dev/$proto/$server/$port
#    (( $? == 0 )) && exec 5<&-
#}
#function setdsm() {
#    # add the current directory and the parent directory to PYTHONPATH
#    # sets DJANGO_SETTINGS_MODULE
#    export PYTHONPATH=$PYTHONPATH:$PWD/..
#    export PYTHONPATH=$PYTHONPATH:$PWD
#    if [ -z "$1" ]; then
#        x=${PWD/\/[^\/]*\/}
#        export DJANGO_SETTINGS_MODULE=$x.settings
#    else
#        export DJANGO_SETTINGS_MODULE=$1
#    fi
#
#    echo "DJANGO_SETTINGS_MODULE set to $DJANGO_SETTINGS_MODULE"
#}
#function ctags_build () {
#    cd ~/
#    find /ft-cms/ -name "*.js" | xargs ctags -a
#    #| grep -vP 'jquery|demo|fcke|ext|tinymce|servers|yui-'
#}
