# Dotfiles

James McGuigan's personal dotfiles and CLI scripts 

```bash
git clone git@github.com:JamesMcGuigan/dotfiles.git
cd dotfiles

find `pwd`/.* | xargs dos2unix  # if windows

find `pwd`/.* -maxdepth 0 -type f | 
    grep -v '\.(md|yml|ipynb)$' | 
    grep -v $(echo '@\(Darwin\|Linux\|CYGWIN_NT-10.0\)$' | sed "s/`uname`/^$/") |
    parallel "ln -svf {} ~/{= s:^.*/::; s:\@`uname`:: =}"

find `pwd`/.* -maxdepth 0 -type d | 
    grep -v '.idea\|/.git\|\.$' | 
    parallel "ln -svf {} ~/"
```