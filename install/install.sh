echo "==================="
read -p "passwd has done ??(y/n): " DONE

if test $DONE != "y"; then
  echo "set passwd first"
  exit 0
fi
echo "continue"

###################
# common
###################
echo "alias ls='ls -la --col'" >> ~/.bashrc

export DOTFILES=`dirname $0`/..
echo DOTFILES=$DOTFILES

###################
# distoribute
###################
if [ `uname` = "Linux" ]; then
  if uname -a | grep ubuntu -i >/dev/null; then
    #########
    # ubuntu
    #########
    sudo apt-get update
    sudo apt-get install -y \
      build-essential \
      libssl-dev \
      libreadline6-dev \
      libncurses5-dev \
      libxml2-dev \
      libxslt1-dev \
      libpcre3 \
      libpcre3-dev \
      libev4 \
      libev-dev \
      libevent-dev \
      tree \
      xsel \
      vim-gnome \
      git-core \
      zsh \
      jq \
      w3m \
      curl \
      unzip \
      apcalc \
      source-highlight

  else
    #########
    # cent
    #########

    # JST time
    sudo cp /usr/share/zoneinfo/Japan /etc/localtime
    # package for build
    sudo yum install -y git gcc-c++ openssl-devel make
  fi
elif [ `uname` = "Darwin" ]; then
  brew install \
    tree \
    zsh \
    rmtrash \
    wget \
    nkf \
    reattach-to-user-namespace \
    jq \
    w3m \
    calc \
    source-highlight \
    ctags

  # Change default PATH order in mac for homebrew
  if ! diff /etc/paths $DOTFILES/misc/mac.paths >/dev/null ; then
    sudo mv /etc/paths /etc/paths.orig
    sudo cp $DOTFILES/misc/mac.paths /etc/paths
  fi
fi

# install tmux v2
$DOTFILES/install/install-tmux2.sh

# link dotfiles to home
$DOTFILES/install/slink.sh

# chsh to zsh
$DOTFILES/install/chsh.sh
