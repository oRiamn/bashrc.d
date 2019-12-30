# bashrc.d

## Installation

Clone this repo in your home :

```
cd ~
git clone https://github.com/oRiamn/.bashrc.d.git
```

Add this code to your .bashrc file

```
for file in $HOME/.bashrc.d/*.sh
do
    source $file
done
```

And type `exit` in your terminal

## Requirements

APT packages needed :

* fonts-powerline
* screen