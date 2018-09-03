An idea for managing multiple git repostories.

```
gits add <url> <branch/sha>
```

TODO: might pull in source code for the "gits" tool itself from multiple repositories, meaning I can use gits itself to manage those repositories.

## Some Use Cases

Say you Have your own repo, but it depends on some other repos.  You would add a file "gitsconfig" into the root of your git repository.  This file would then contain the the dependent repositories along with branch names or shas for each repository (similar to git submodules).

After gitsconfig has been loaded and processed, you should have one sub-directory for every repository the you depend on.  This subdirectory could be a local link to another directory somewhere else, or it could be a complete copy of the repository.

So what if our dependency has it's own gitsconfig file with it's own dependencies?  In that case, gitsconfig will check each repository it downloaded for other gitsconfig files.  If it finds them, it will resolve those dependencies as well.  If it has some of the same dependencies as another repository, then it will only download the dependency once, and create symbolic links to it.

# Ideas

We could separate groups of repositories that depend on each other into distict groups. For now let's call them "units".

So we want to start using gits, first we need to make a directory for our unit:
```
mkdir $HOME/my_gits_unit
```

To start using it, we can clone a repository in our "unit directory":
```
cd $HOME/my_gits_unit
gits clone https://github.com/foo/gui_app
```

So once `gits` clones the repo, it will check the root directory of the repository for a file called `gitsconfig`.  If it finds it, it will resolve any dependencies. 

`gui_app/gitconfig`:
```
[dependency "gui_lib"]
    owner = "bar"
[dependency "gitlab.com/gnu/utils"]
    protocols = "git,http,https"
```

In this case it looks like we have a couple dependencies.  The first one is just a name.  `gits` will assume this means the repo lives in the same location, so it will turn the original url https://github.com/foo/gui_app into https://github.com/foo/gui_lib, however, because we've specified it has a different owner, it's smart enough to know the actual url will be https://github.com/bar/gui_lib

The second dependency is actually a URL to a specific server. It also lists the supported protocols with the order they should be attempted in.

Also note that after these repositories get resolved, `gits` will check these new repositories for their own dependencies and resolve those as well.
