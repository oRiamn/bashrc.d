# bashrc.d

Add this code to your .bashrc file
```
for file in $HOME/.bashrc.d/*.sh
do
    source $file
done
```
