"~/.bashrc" 39L, 1274C
  1 source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
  2 source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
  3 GIT_PS1_SHOWDIRTYSTATE=true
  4 export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '
  5
  6 # default:cyan / root:red
  7
  8
  9 # "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
 10 alias g='git'
 11 alias ls='ls -FG'
 12 alias ll='ls -alFG'
 13
 14 function parse_git_branch {
 15     git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
 16 }
 17
 18 # System-wide .bashrc file for interactive bash(1) shells.
 19 if [ -z "$PS1" ]; then
 20    return
 21 fi
 22
 23 # ターミナルプロンプト表示変更については、↓こちらの１行です。
 24 PS1='\n\[\033[030;047m\]\D{%m/%d} \t\[\033[0m\]\n\[\033[030;046m\]@~\w\[\033[0m\]$(parse_git_branch) $ '
 25
 26 # Make bash check its window size after a process completes
 27 shopt -s checkwinsize
 28
 29 [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"# System-wide .bashrc file for interactive bash(1) shells.
 30 if [ -z "$PS1" ]; then
 31    return
 32 fi
 33
 34 #PS1='\h:\W \u\$ '
 35 # Make bash check its window size after a process completes
 36 shopt -s checkwinsize
 37
 38 [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
 39 ~