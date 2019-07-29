
##
## This adds a nice Git info to prompt.
## Intended to be sourced from ~/.bash_profile .
##

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}


## Original:
#export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "


#export PS1="\[\e[01;33m\]\A\[\e[m\] \[\e[01;32m\]\w\[\e[m\] \`nonzero_return\`\[\e[01;35m\]\\$\[\e[m\] "

# Get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ] ; then STAT=`parse_git_dirty`; echo "[${BRANCH}${STAT}]"; else echo ""; fi
}

# Get current status of git repo
function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then bits=">${bits}"; fi
  if [ "${ahead}" == "0" ]; then bits="*${bits}"; fi
  if [ "${newfile}" == "0" ]; then bits="+${bits}"; fi
  if [ "${untracked}" == "0" ]; then bits="?${bits}"; fi
  if [ "${deleted}" == "0" ]; then bits="x${bits}"; fi
  if [ "${dirty}" == "0" ]; then bits="!${bits}"; fi
  if [ ! "${bits}" == "" ]; then echo " ${bits} "; else echo ""; fi
}



export PS1="\[$(tput bold)\]\[\033[38;5;11m\]\t\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \`nonzero_return\`\[$(tput bold)\]\[$(tput sgr0)\]\`parse_git_branch\`\[\033[38;5;13m\]\\$\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

