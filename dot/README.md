# dot files

## installation

Most of these files are simply symlinked to the appropriate dot file in HOME.
The following commands move any existing file out of the way, and install the symlink.

```
cd
ln -s dot/bash_environset .bash_environset
ln -s dot/bash_login .bash_login
ln -s dot/bash_logout .bash_logout
ln -s dot/bash_profile .bash_profile
ln -s dot/bashrc .bashrc
ln -s dot/cshrc .cshrc
ln -s dot/emacs .emacs
ln -s dot/gitconfig .gitconfig
ln -s dot/gitconfig-fancy .gitconfig-fancy
ln -s dot/gitignore_global .gitignore_global
ln -s dot/login .login
ln -s dot/plan .plan
ln -s dot/signature .signature
ln -s dot/subversion .subversion
```

## plaform-dependent files

pick *one* of these:
```
cd
ln -s dot/forward-dartmouth .forward
ln -s dot/forward-icloud .forward
```

pick *one* of these:
```
cd
ln -s dot/muttrc-icloud .muttrc
ln -s dot/muttrc-smtp2go .muttrc
```
