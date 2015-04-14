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
