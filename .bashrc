alias rebash='source ~/.bashrc'
alias rb=rebash
alias eb='subl ~/.bashrc'

alias nrd='npm run dev'

alias grpo='git remote prune origin'
alias gpoh='git push origin HEAD'
alias gs='git status'
alias gc='git checkout'
alias gpr='git pull --rebase'
alias gba='git branch -a'
alias grd='git rebase develop'
alias gsu='git stash -u'
alias gsp='git stash pop'
alias glol='git log --oneline'
alias gpfwl='git push --force-with-lease origin HEAD'

# alias gcm='git checkout master'
alias gcd='git checkout develop'

function gcm() {
    if [ `git branch --list main` ]
    then
        git checkout main
    else
        git checkout master
    fi
}
