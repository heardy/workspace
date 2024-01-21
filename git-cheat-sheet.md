### Caching git password
https://help.github.com/articles/caching-your-github-password-in-git/

##### Windows
`git config --global credential.helper wincred`

##### Mac
`git config --global credential.helper osxkeychain`

##### Linux
```
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
```

### Checkout previous branch

`git checkout -`

### Reset local branch when origin has been force pushed

`git fetch && git reset origin/<branch_name> --hard`

### Prune local tracking branches

`git remote prune origin`

### Interactive rebase

```
git checkout <base_branch> && git pull origin <base_branch>
git checkout <branch_name>
git rebase -i <base_branch>
```

### Rebase local commits (ie. not pushed to remote)

Reference - http://balinterdi.com/2011/07/19/git-rebase-to-fix-your-local-commits.html  
&lt;n&gt; - represents the number of commits to rebase

`git rebase -i HEAD~<n>`

### Rename branch

If you want to rename a branch while pointed to any branch, do:

`git branch -m <oldname> <newname>`

If you want to rename the current branch, you can do:

`git branch -m <newname>`

### Remove file(s) from previous commit

`git reset --soft HEAD^`

or

`git reset --soft HEAD~1`

Then reset the unwanted files in order to leave them out from the commit (the old way):

`git reset HEAD path/to/unwanted_file`

Note, that since Git 2.23.0 one can (the new way):

`git restore --staged path/to/unwanted_file`

May need to discard the changes to the file (or delete it)

`git restore path/to/unwanted_file`

Now commit again, you can even re-use the same commit message:

`git commit -c ORIG_HEAD`

### Total branches

Local branches only

`git branch | wc -l `

Remote branches only

`git branch -r | wc -l`

All branches

`git branch -a | wc -l`

### Show summary diff

Shows a summary diff of file changes, including indicating files that have been renamed/moved and showing a percentage to indicate how much they have changed from the original file.

`git diff --summary -M master <branch-name>`

### Show log with file names

`git log --name-only`

### Show files only for a commit

`git show --name-only <commit>`

### Automatic conflict resolution

https://hackernoon.com/fix-conflicts-only-once-with-git-rerere-7d116b2cec67

`git config --global rerere.enabled true`

### Git merge

Non fast forward with custom merge message

`git merge --no-ff -m 'release 3.48.0' release/3.48.0`

### Git tagging

##### Annotated

`git tag -a 1.4 -m "my version 1.4"`

##### with folders

`git tag -a ctm-approve/1.5.1 -m "ctm-approve-1.5.1"`

##### Push tags (single)

`git push origin <tag_name>`

##### Push tags (all)

`git push --follow-tags`

##### List all remote tags

`git ls-remote --tags`

##### Deleting tags locally

`git tag -d $(git tag -l "tag_prefix*")`

##### Deleting tags from remote

`git tag | grep <pattern> | xargs -n 1 -i% git push origin :refs/tags/%`

-or-

`git push origin --delete $(git ls-remote --tags | grep "tag_prefix.*[^}]$" | cut -f 2)`

`git ls-remote --tags` - will output all remote tags.  
`grep "*tag_prefix.*[^}]$"` - will ignore tags with annotated dereference operator "^{}" since including them errored out.  
`cut -f 2` - keeps the tag name column only  
