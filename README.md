# kotz-bin-lib
My ~/bin and ~/lib directories, used for both MacOS and Linux.

More precisely,

* `scripts`, with its three subdirectories `cs`, `mac`, and `common`.
* `lib`, where I keep miscellaneous support (it also has `cs` and `mac` subdirectories)
* `dot`, where I keep the home 'dot' files

Each of these is symlinked from the home directory, i.e.,

```
cd
ln -s projects/kotz-bin-lib/scripts .
ln -s projects/kotz-bin-lib/lib .
ln -s projects/kotz-bin-lib/dot .
```

On MacOS, `PATH` should include `~/scripts/common:~/scripts/mac`

On CS Linux, `PATH` should include `~/scripts/common:~/scripts/cs`

The `~/bin` directory should be used only for compiled binaries.

All 'dot' files should be linked into the home directory, i.e., something like this:

```
cd ~/dot
for d in *
do
	ln -s dot/$d ~/.$d
done
```

## Migrated from svn 30 May 2020

`scripts` was copied from revision 313 of `svn+ssh://tahoe.cs.dartmouth.edu/u/dfk/repositories/svn/bin/trunk`

`lib` was copied from revision 531 of `svn+ssh://tahoe.cs.dartmouth.edu/u/dfk/repositories/svn/lib/trunk`

`dot` was copied from revision 531 of `svn+ssh://tahoe.cs.dartmouth.edu/u/dfk/repositories/svn/lib/trunk/dot`