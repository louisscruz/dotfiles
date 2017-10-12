# Louis Cruz's Dotfiles

## Installation

### If You Don't Yet Have Git

#### If You Want to Use the Remove Script

```
sh -c "`curl -fsSL https://raw.github.com/louisscruz/dotfiles/master/remote_setup.sh`"
```

#### If You Want to Manually Install

```
curl -Lk https://github.com/louisscruz/dotfiles/archive/master.zip -o ~/dotfiles.zip
unzip -d ~/ ~/dotfiles.zip
mv dotfiles-master dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

### If You Already Have Git

```
git clone https://github.com/louisscruz/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```
