# Commit 
git rm --cached   keep file but rm from staging
git rm -f   remove file from hdd too



# Fugitive
[]c     scroll through commits
Gvdiff  see a diff for current file    
Git blame
czz     stash
czA     apply top stash
cza     apply top stash, preserve index
czP     pop
dv      vert diff

# Nav
git switch -c <newBranchName> #create new and switch
git switch - #switch back to last branch
git switch <branch>


# MISC
## Override local with the remote
git fetch main
git reset --hard origin/main
git clean -df #removes untracked files that are not necessary

## Override the remote with local
git fetch origin
git merge -s ours --no-commit <local-branch>
git push --force origin <remote-branch-name>

## good to clear the cache periodically
git rm -r -cached . 


# BRANCHES
## create branch
git branch <name>

## rename branch
git branch -m <newName>

## show local AND remote branches
git branch -a

## delete branch
git branch -d <name>
## -D for unmerged branches

## delete on remote too
git push origin :<branchName> 

# merge branch into the one you're in
git merge <name>
git mergetool # for conflicts OR use VScode


# REMOTE
## list all remote
git branch -r

## Add a local branch from a remote branch
git branch <local> <origin>/<branchname>
git merge <origin>/<branchname> ## merge in the remote

## Add remote branch from a local branch
git checkout <localbranch>
git push <origin> <localbranch>:<newremotebranch>

## Update a remote branch from local
git push <origin> <local>:<remote>

## Add remote repo to local repo. Can add multiple remotes.
git remote add <remotename(usually origin)> <URL>
git remote remove <name>
git remote rename <oldname> <newname>
git remote # list, -v verbose

## Push first time
git push -u <remote> <branch>
# -u = --set-upstream-to

## pushes all local branches
git push --all # initial setup will create these locals on remote and link them

## reconnect local and remote branch (set upstream)
git branch -u <remote/branch> <localbranch>
git branch --set-upstream-to <remote/branch> <localbranch>

## Clone a specfic branch
git clone -b <branch> <remote_repo>

## pull latest changes from remote
git pull <remote> <branch>
#or (if you have already used push -u origin master - the key is the -u flag)
git pull
## fetch grabs data from remote, pull grabs and merges

## see what remote branch local is tracking
git branch -v
git remote -v

## see all remote branches
git ls-remote

## see remote tracking details, url, etc.
git remote show <remotename>

## change from https to ssh 
git remote set-url origin git@HOST:USERNAME/REPOSITORY.git


# CONFLICTS
## If your local is just behind remote, than run a
## fast-forward merge: pulling down the most recent commit from remote
## Otherwise, with conflicts, you can:

## 1. pull down and merge both commits into a new commit
## 2. Or rebase: take out local commit temp, then add it back in after remote.

git pull --rebase
git rebase -abort #if you fuck something up
git rebase -skip #to skip the other commit

## Override the remote repo with local
## push your other branch to the end of the main branch (newest commits)
git rebase main 
## from your feature branch. this changes what commit it's anchored off of, but it's still seen as separate commits from main
## then switch to main and rebase again to merge the commits into main
git rebase <featurebranch>
#then
git push

# move a branch's base to a newer master commit (if you got left behind)
# never rebase commits that have been pushed to a remote!!
git rebase master # must be inside branch you want to rebase


# AMENDING
# amend
git commit --amend -m "new message" #change the message of last commit

# amend with files you forgot to add (same message)
git add .
git commit --amend --no-edit


# PULL REQUEST PROCESS
1. fork on github
2. clone your fork in CLI
3. create new branch inside clone “git checkout -b <branchfixname>”
4. make change and commit
5. push commit “git push origin <branchfixname>”
6. Click “compare and pull request” green button on github


# PULLING: IGNORE LOCAL
## overwite local changes
git reset --hard
git pull

If there are untracked local files you could use `git clean` to remove them.
- `git clean -f` to remove untracked files
- `df` to remove untracked files and directories
- `xdf` to remove untracked or ignored files or directories



# CONFIG

# System: all users
# Global: one user, all repos
# Local: one repo (default)

git config --global user.name "username"
git config --global user.email "email"

# global ignore file
git config --global core.excludesfile <file>
# common ignore: DS_Store, vsCode, etc.

# See your configurations
git config --list

# or look at your ~/.gitconfig file. The local configuration will be in your repository's .git/config file.
git config --list --show-origin
# to see where that setting is defined (global, user, repo, etc...)


# STASH
git stash # quick one-off save
git stash save <name> # name your stash to get it later
git stash list # see what's in your stash, get index
git stash apply <indexNumber> # applies your stash, leave stash mem alone
git stash pop <indexNumber> # applies your stash, deletes that stash from mem


# TAGS
git tag # see all
git tag <name>
git tag -a <name> -m <message> # annotated
git push <remote> <tagname>
git push --tags # all
git tag -d <name> # delete
git push --delete <remote> <tagname>


# RESTORE
# undo, remove from staging
git restore . # undo all from staging
git restore --staged <file> # undo a file
git restore -S <file>
git restore <file> # WARN discards local changes revert to last commit/stage
git reset HEAD <file> #alt remove staging
git checkout -- <file> # revert file back to staging version (WARNING: will delete your working dir version)


# CLEAN
git clean
git clean -n # dry run
git clean -d # also delete untracked directores, sub folders
git clean -f # force delete
git clean -dn
git clean -df

# REVERT & RESET

# REVERT creates a new commit that undoes changes from previous(does not modify history)
# RESET alters staging area or changes what commit branch head is pointing to (may alter history)
# revert undoes commit by creating a new one (copy of previous)
# (keeps old commit)

git revert HEAD #will get rid of current commit
git revert <commitToIgnore>

# https://christoph.ruegg.name/blog/git-howto-revert-a-commit-already-pushed-to-a-remote-reposit.html
# reset will actually delete the commit
# AVOID USING RESET AT ALL

git reset <fileName>
git reset HEAD
git reset # resets staging to match most recent commit (working dir unaffected)
git reset <commit> # resets staging back to that commit (working dir unaffected)
git reset --hard # will also delete working dir changes
git reset --hard <commit>


# BISECT: Diagnosing which commit is breaking
# starts a designated commit and walks you through each
# you label commits as good or bad as you test

git bisect start
git bisect bad
git bisect good <commitId>
