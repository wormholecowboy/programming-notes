

# HANDY 
 ## remove all files from staging, keep working changes
git reset
 ## keep file but rm from staging
git rm --cached  
 ##  remove file from hdd too
git rm -f

## Finding Things
 ## grep for string that changed in commits
git log -S <string>
 ## print out objects of a commit, tree, object
git cat-file -p <hash>

### unstage a file
git restore --staged <file>
### unmodify a file
git retore <file>
### amend last commit
git commit --amend
git commit --amend -m "updated message"

## see commit changes for a file
git log -p -- filename
## see only the commit messages for a file
git log --stat -- filename
## see parrents
 --parents

# GITHUB CLI
github auth login

gh repo create
gh repo list <user>
gh repo view <user/repo>
gh repo delete <repo>
gh repo edit

gh gist list
gh gist create --public <file.py>
gh gist view <gist>


# GIT SIGNS
td      to see old changes hunk
tb      inline blame


# FUGITIVE
[]c     scroll through commits
Gvdiff  see a diff for current file    
Gvdiff main   see a diff for another branch or commit
Git blame
czz     stash
czA     apply top stash
cza     apply top stash, preserve index
czP     pop
dv      vert diff
dq      quit the vert diff
Shift x to delete a change in unstaged

Gvdiffsplit        compare working to last commit
Gvdiffsplit main   to compare changes to main branch
Gvdiffsplit!       keep focus on current window
G difftool -y      see changes for each file in a tab
tabo               get rid of tabs?

Gedit main:file.js      open a file in certain branch
Gread                   same but replaces your current buffer

G log
O   to see changes in tab
o   to see changes in split
coo checkout that commit

merge conflicts (Gvdiffsplit!)
]c      next hunk
d2o     select right side solution
d3o     select left


# WORKTREES
### new branch
git worktree add -b <branch name> <path/worktree name> [ref-branch]

git worktree list
git worktree remove <path> 


# DIFF 
 ##  compare staging and working
git diff
 ## compare staging and last commit
git diff --staged
## compare staging and working with last commit
git diff HEAD
## help
git diff --tool-help

git diff hash1 hash2
git diff branch1 branch2
git diff feature..master

## config for difftool and mergetool
[difftool]
    prompt = true
[diff]
    tool = nvimdiff
[difftool "nvimdiff"]
    cmd = "nvim -d \"$LOCAL\" \"$REMOTE\""
[merge]
	tool = "nvim"

[mergetool]
	keepBackup = false
	prompt = false

[mergetool "nvim"]
	cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\""

# PULL REQUEST PROCESS
1. fork on github
2. clone your fork in CLI
3. create new branch inside clone “git checkout -b <branchfixname>”
4. make change and commit
5. push commit “git push origin -u <branchfixname>”
6. Click “compare and pull request” green button on github
opt. add the orig repo as a remote so you can stay in sync with and pull from orig
    git remote add upstream <URL>




# MISC

If there are untracked local files you could use `git clean` to remove them.
- `git clean -f` to remove untracked files
- `df` to remove untracked files and directories
- `xdf` to remove untracked or ignored files or directories

## Override local with the remote
git fetch main
git reset --hard origin/main
git clean -df #removes untracked files that are not necessary
git pull

## Override the remote with local
git fetch origin
git merge -s ours --no-commit <local-branch>
git push --force origin <remote-branch-name>
git push --force-with-lease   ### only pushes if repo hasn't changed since your last fetch

## good to clear the cache periodically
git rm -r -cached . 


# REMOTE

## Create local branch from a remote branch
git checkout -t origin/remotebranch
## OR
git checkout -b <newlocalbranch> origin/remotebranch

## Add remote branch from a local branch
## Also works to set a local to a current remote
git checkout <localbranch>
git push <origin> <localbranch>:<newremotebranch>

## Add a local branch to remote repo
git push -u <origin> <local-branch-name>

## Update a remote branch from local
git push <origin> <local>:<remote>

## Add remote repo to local repo. Can add multiple remotes.
git remote add <remotename(usually origin)> <URL>
git remote remove <name>
git remote rename <oldname> <newname>

## Push first time
git push -u <remote> <branch>

## pushes all local branches
git push --all # initial setup will create these locals on remote and link them

## reconnect local and remote branch (set upstream)
git branch -u <remote/branch> <localbranch>

## Clone a specfic branch
git clone -b <branch> <remote_repo>

## Or merge in a new remote branch by creating the local
git checkout -b serverfix origin/serverfix

## Rename a remote
git remote rename old new

## delete remote 
git push origin --delete <remotename>

## see what remote branch local is tracking
git branch -v

## see all remote branches
git ls-remote
git branch -r

## see remote tracking details, url, etc.
git remote show <remotename>

## change from https to ssh 
git remote set-url origin git@HOST:USERNAME/REPOSITORY.git


# CONFLICTS

## merge branch into the one you're in
git merge <name>
git merge --no-ff    // create a merge commit even if using ff
Make sure to fast forward the one thats behind it after rebasing


## rebasing 
### make sure to git add your files after fixing conflict before continuing
git rebase --abort  // if you fuck something up
git rebase --skip   // to skip the other commit
git rebase --continue  // keep going after fixing conflict

## Override the remote repo with local
### push your other branch to the end of the main branch (newest commits)
git rebase main 
### then switch to main and rebase again to merge the commits into main
git rebase <featurebranch>
git push origin main -F

## Rebase can also be used to clean up history
## interactive rebase
git rebase -i main  # from feature

pick <commit>       use this
fixup <commit>      meld into prev commit and discard message
squash <commit>     meld into prev commit and keep message
reword <commit>     use commit but reword message
drop <commit>       discard commit completely
edit <commit>       use commit but pause for amending


## SQUASHING
run from feature
git rebase main --interactive
    pick    // show this in history
    squash  // use commit, but meld into previous
    fixup   // ignore commit msg

## ALT USING MERGE
git merge --squash feature-branch  # from main
## creates an unstaged change on main
git commit -m "Your single commit message"


# CONFIG

### System: all users
### Global: one user, all repos
### Local: one repo (default)

git config --global user.name "username"
git config --global user.email "email"
git config --add -global <any k/v pair>
   section.key "value"

### global ignore file
git config --global core.excludesfile <file>
### common ignore: DS_Store, vsCode, etc.

### See your configurations
git config --list

### See config files location
git config --list --show-origin
### to see where that setting is defined (global, user, repo, etc...)

### See ignore file
git config --get core.excludesfile
git config core.excludesfile

## Set path for ignore
git config --global core.excludesfile <path>

## ALIASES
git config --global alias.myalias "log --oneline"
git config --global alias.myalias "!sh -c 'echo Hello, this is a custom alias'"
git config --global --unset alias.myalias


# STASH
 ### quick one-off save
git stash
### name your stash to get it later
git stash save <name> 
 ### see what's in your stash, get index
git stash list
 ### applies your stash, leave stash mem alone
git stash apply <indexNumber>
 ### applies your stash, deletes that stash from mem
git stash pop <indexNumber>
### clear it
git stash clear


# TAGS
 ### see all
git tag
git tag <name>
 ### annotated
git tag -a <name> -m <message>
git push <remote> <tagname>
 ### all
git push --tags
 ### delete
git tag -d <name>
git push --delete <remote> <tagname>


# RESTORE   unstage , undo working

 ### undo working back to staging state
git restore .
 ### remove from staging
git restore --staged <file>
git restore -S <file>
 ### WARN discards local changes revert to last commit or stage
git restore <file>
 ### restore file back to staging version (WARNING: will delete your working dir version)
git checkout -- <file>
 ### restore back to a previous commit
git restore --source HEAD~3 file


# CLEAN
git clean
 ### dry run
git clean -n
 ### also delete untracked directores, sub folders
git clean -d
 ### force delete
git clean -f
git clean -dn
git clean -df


# REVERT 

## REVERT creates a new commit that undoes changes from previous(does not modify history)
## revert undoes commit by creating a new one (copy of previous)

 ### will get rid of current commit
git revert HEAD
git revert <commitToIgnore>


# RESET
Can be used to undo last commit or changes in stage or worktree
--soft is good if you mess up revert, cherry pick, rebase
--soft puts last commit into staging

### removes from staging and preserves working changes
git reset <fileName>
 ### resets staging to match most recent commit (working dir unaffected)
git reset
 ### delete all commits after given commit, keeps working changes
git reset <commit>
OR
git reset --soft HEAD~1
 ### will also delete working dir changes
git reset --hard
git reset --hard <commit>
git checkout HEAD file   // discard for one file only
git checkout -- file    // same



# BISECT

git bisect start
## give bisect a range to work in (not including commit uses the current HEAD position)
git bisect bad HEAD 
git bisect good <first commit>
## bisect will start selecting commits for you. Label them.
git bisect good <or> bad
## reset state
git bisect reset





