#!/bin/zsh

NAME=name

# zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

sudo chsh -s /bin/zsh $NAME
rm -f /home/$NAME/.zprezto/runcoms/zshrc
cp zshrc /home/$NAME/.zprezto/runcoms/zshrc

# pg
sudo pacman -S --noconfirm lua python3

# yaourt
cd /tmp
sudo pacman -S --noconfirm yajl
git clone https://aur.archlinux.org/package-query.git/
cd package-query
makepkg
sudo pacman -U --noconfirm *pkg.tar.xz
cd ..
git clone https://aur.archlinux.org/yaourt.git/
cd yaourt
makepkg
sudo pacman -U --noconfirm *pkg.tar.xz

# vim
yaourt -S --noconfirm ctags par
bash <(curl -sL https://git.io/haskell-vim-now) --basic
rm -f /home/$NAME/.config/haskell-vim-now/.vimrc
cp ./vimrc /home/$NAME/.config/haskell-vim-now/.vimrc

# chrome
yaourt -S --noconfirm google-chrome-beta

# other software
sudo pacman -S --noconfirm mpv clementine qemu ntfs-3g the_silver_searcher \
                           tmux python python-pip vim-workspace vim-vcscommand \
                           vim-jad vim-align jdk8-openjdk gvfs mate-terminal \
                           imagemagick gdb clang lua wget yajl
