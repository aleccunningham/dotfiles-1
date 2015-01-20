alias -g N="1>/dev/null 2>/dev/null"
alias -g B="1>/dev/null 2>/dev/null &"
alias re="exec $SHELL"
alias hist="history"
alias rmrf="\rm -rf"

function gith() {
  cat <<EOF
[push branch] $ git push origin dev
[ck branch]   $ git checkout -b dev origin/dev
[del branch]  $ git push origin :dev
[sync branch] $ git fetch --prune
[pull force]  $ git fetch --all && git reset --hard origin/master
EOF
}

function empty() {
  sudo cp /dev/null $1
}

function alc() {
  if [ $ != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +37
  else
    w3m "http://www.alc.co.jp/"
  fi
}

function timeset() {
  sudo date -s "$(curl -s --head http://www.google.co.jp | grep ^Date | cut -b 7-)"
}

function up() {
  scp $1 jxck@jxck.io:src/files/tmp
}

function port() {
  PID=$(lsof -i:$1 | awk 'NR>=2 {print $2}' | sort | uniq)
  if [[ $2  = "-k" ]]; then
    kill -9 $PID
  else
    echo $PID
  fi
}

function cd() {
  p=$@                   # current arg
  if [[ $p = "" ]]; then # cd only
    p=$HOME              # path to home
  fi
  p=${p:a}               # expand to full path
  print -s cd $p         # add history
  builtin cd $p          # exec original cd
  return $?
}
