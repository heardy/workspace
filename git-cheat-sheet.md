#### Reset local branch when origin has been force pushed

`git fetch && git reset origin/<branch_name> --hard`

#### Prune local tracking branches

`git remote prune origin`

#### Interactive rebase

```
git checkout <source_branch> && git pull origin <source_branch>`
git checkout <branch_name>
git rebase -i <source_branch>
```

#### Rebase local commits (ie. not pushed to remote)

Reference - http://balinterdi.com/2011/07/19/git-rebase-to-fix-your-local-commits.html  
<n> - represents the number of commits to rebase

`git rebase -i HEAD~<n>`
