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

### Git tagging

##### Annotated

`git tag -a 1.4 -m "my version 1.4"`

##### with folders

`git tag -a ctm-approve/1.5.1 -m "ctm-approve-1.5.1"`

##### Push tags (single)

`git push origin <tag_name>`

##### Push tags (all)

`git push --follow-tags`
