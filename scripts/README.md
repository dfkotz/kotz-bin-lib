This directory is part of a [git repository](https://github.com/dfkotz/kotz-bin-lib).
A typical installation would check out that repo as `projects/kotz-bin-lib`:

```
cd ~/projects
git clone git@github.com:dfkotz/kotz-bin-lib.git
```

Then, this directory must be reachable as `~/scripts` because several of the scripts depend on that path to find other scripts.

```
cd; ln -s projects/kotz-bin-lib/scripts scripts
```