# GIT COMMANDS

## LOG & SEARCH
grep for string that changed in commits
`git log -S <string>`
print out objects of a commit, tree, object
`git cat-file -p <hash>`

see commit history for a file
`git log -- filename`
see commit changes for a file
`git log -p -- filename`
see only the commit messages for a file
`git log --stat -- filename`
see parents
`git log --parents`


## GIT SHOW
`git show`              # Shows the latest commit (HEAD)
`git show <commitish>`       # Shows specific commit
`git show abc123:path/to/file.txt`    # File contents at that commit

Compare specific commits  
`git show abc123..def456`    # Changes between two commits
Useful combos  
`git show HEAD:path/file > old.txt`    # Extract old version to a new file
Files + status (A/M/D)  
`git show --stat`


## GITHUB CLI  
`github auth login`  

`gh repo create`  
`gh repo list <user>`  
`gh repo view <user/repo>`  
`gh repo delete <repo>`  
`gh repo edit`  

`gh gist list`  
`gh gist create --public <file.py>`  
`gh gist view <gist>`  


## DIFF   
 compare staging and working  
`git diff`  
compare staging and last commit  
`git diff --staged`  
compare staging and working with last commit  
`git diff HEAD`  
help  
`git diff --tool-help`  

`git diff hash1 hash2`  
`git diff branch1 branch2`  
`git diff feature..master`  

config for difftool and mergetool  
```bash
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
```  

## SYNC
force local to match remote
`git fetch origin`
`git reset --hard origin/main`
`git clean -df`

force remote to match local
`git push --force origin <branch>`
`git push --force-with-lease`  safer: only pushes if remote hasn't changed since last fetch


## REMOTE  

Create local branch from a remote branch  
`git checkout -t origin/remotebranch`  
OR  
`git checkout -b <newlocalbranch> origin/remotebranch`  

Add remote branch from a local branch  
Also works to set a local to a current remote  
`git checkout <localbranch>`  
`git push <origin> <localbranch>:<newremotebranch>`  

Add a local branch to remote repo  
`git push -u <origin> <local-branch-name>`  

Update a remote branch from local  
`git push <origin> <local>:<remote>`  

Add remote repo to local repo. Can add multiple remotes.  
`git remote add <remotename(usually origin)> <URL>`  
`git remote remove <name>`  
`git remote rename <oldname> <newname>`  

Push first time  
`git push -u <remote> <branch>`  

pushes all local branches  
git push --all # initial setup will create these locals on remote and link them  

reconnect local and remote branch (set upstream)  
`git branch -u <remote/branch> <localbranch>`  

Clone a specfic branch  
`git clone -b <branch> <remote_repo>`  

Or merge in a new remote branch by creating the local  
`git checkout -b serverfix origin/serverfix`  

Rename a remote  
`git remote rename old new`  

delete remote   
`git push origin --delete <remotename>`  

see what remote branch local is tracking  
`git branch -v`  

see all remote branches  
`git ls-remote`  
`git branch -r`  

see remote tracking details, url, etc.  
`git remote show <remotename>`  

change from https to ssh   
`git remote set-url origin git@HOST:USERNAME/REPOSITORY.git`  


## REBASING   
make sure to git add your files after fixing conflict before continuing  
`git rebase main`  // from feature  
`git rebase --abort`  // if you fuck something up  
`git rebase --skip`   // to skip the commit  
`git rebase --continue`  // keep going after fixing conflict, conflicts will stop replaying feature branch on the commit that is problematic.  
`git rebase -i main`  // from feature  
or   
`git rebase -r HEAD~n`  if you want to squash down commits in current branch  

### ALT USING MERGE SQUASH  
`git merge --squash feature-branch`  from main  
creates an unstaged change on main  
`git commit -m "Your single commit message"`  

### Rebase Conflict  
Note: When conflict during rebase, theirs and ours will be swapped, b/c rebase switches to the target base branch under the hood.   
fix conflict can use these commands instead of editing  
`git checkout --ours filename`  // main  
`git checkout --theirs filename`  // features  
`git add filename`  
`git rebase --continue`  
if you want to ff merge  
`git merge feature`  
if you need to push up feature  
`git push --force`  WARNING: will overwrite remote branch history  

diffs  
`git diff`  
`git diff --ours --theirs file.txt`  


## CONFIG  

System: all users  
Global: one user, all repos  
Local: one repo (default)  

`git config --global user.name "username"`  
`git config --global user.email "email"`  
`git config --add -global <any k/v pair>`  
`   section.key "value"`  

global ignore file  
`git config --global core.excludesfile <file>`  
common ignore: DS_Store, vsCode, etc.  
only visible to you, not others who pull repo  

See your configurations  
`git config --list`  

See config files location  
`git config --list --show-origin`  
to see where that setting is defined (global, user, repo, etc...)  

See ignore file  
`git config --get core.excludesfile`  
`git config core.excludesfile`  

Set path for ignore  
`git config --global core.excludesfile <path>`  

ALIASES  
`git config --global alias.myalias "log --oneline"`  
`git config --global alias.myalias "!sh -c 'echo Hello, this is a custom alias'"`  
`git config --global --unset alias.myalias`  


## STASH  
 quick one-off save  
`git stash`  
name your stash to get it later  
`git stash save <name> `  
 see what's in your stash, get index  
`git stash list`  
`git stash list -p`  show changes  
 applies your stash, leave stash mem alone  
`git stash apply <indexNumber>`  
 applies your stash, deletes that stash from mem  
`git stash pop <indexNumber>`  
clear it  
`git stash clear`  


## TAGS
 see all  
`git tag`  
`git tag <name>`  
 annotated  
`git tag -a <name> -m <message>`  
`git push <remote> <tagname>`  
 all  
`git push --tags`  
 delete  
`git tag -d <name>`  
`git push --delete <remote> <tagname>`  


## RESTORE   file-level: unstage, undo working
for working dir and staging changes only (file-level)
does NOT modify commit history
use this for: discarding local edits, unstaging files

Undo working, keep staging; restore to last commit or stage  
`git restore .`  
`git restore <file>`  
 remove from staging  
`git restore --staged or -S <file>`  
 restore back to a previous commit  
`git restore --source HEAD~3 file`  


## CLEAN
permanently deletes untracked files from filesystem (not recoverable)
only affects files not in git index; does NOT touch staged or committed files
always run `-n` first to preview what will be deleted
`git clean`  
 dry run  
`git clean -n`  
 also delete untracked directores, sub folders  
`git clean -d`  
 force delete  
`git clean -f`  
`git clean -dn`
`git clean -df`

clear git cache (forces re-evaluation of .gitignore)
`git rm -r --cached .`


## PRUNE
remove stale local refs to remote branches that no longer exist
`git remote prune origin`
`git fetch --prune`  or `-p`
set fetch to always prune
`git config --global fetch.prune true`


## REVERT
safe way to undo commits - creates NEW commit that reverses changes
preserves history (good for shared branches)
use this for: undoing commits already pushed to remote
compare to reset: revert adds history, reset rewrites it
`git revert <commitHash>`  


## RESET
moves HEAD pointer - rewrites commit history (commit-level)
destructive but recoverable via reflog
use this for: uncommitting local changes, cleaning up before push
compare to revert: reset rewrites history, revert preserves it
compare to restore: reset moves HEAD, restore only affects files  
--soft is good if you mess up revert, cherry pick, rebase  
--soft puts last commit into staging  
--reset defaults to --mixed  

removes from staging and preserves working changes  
`git reset <fileName>`  
 resets staging to match most recent commit (working dir unaffected)  
`git reset`  
 delete all commits after given commit, keeps working changes  
`git reset <commit>`  

 will also delete working dir changes  
`git reset --hard`  
`git reset --hard <commit>`  
`git checkout HEAD file   // discard for one file only`  
`git checkout -- file    // same`  

Command	Effect  
`git reset --soft HEAD^`	Moves HEAD back, keeps changes staged (git add remains intact).  
`git reset --mixed HEAD^` (default)	Moves HEAD back, unstages changes, but keeps them in the working directory.  
`git reset --hard HEAD^`	Moves HEAD back and discards all changes.  


## BISECT  

`git bisect start`  
give bisect a range to work in (not including commit uses the current HEAD position)  
`git bisect bad HEAD `  
`git bisect good <first commit>`  
bisect will start selecting commits for you. Label them.  
`git bisect good <or> bad`  
reset state  
`git bisect reset`  



## REFLOG
tracks everything HEAD does (local only, not pushed)
your safety net for recovering from mistakes
entries expire after 90 days by default

`git reflog`
`git reflog show <branch>`  reflog for specific branch
recover a lost commit or undo a bad reset
`git reset --hard HEAD@{2}`  go back 2 moves
`git checkout HEAD@{n}`  view previous state (detached HEAD)
`git branch recover-branch HEAD@{n}`  create branch from old state


## RERERE  
remember how conflicts where resolved  
`git config rerere.enabled true`  


## CHERRY-PICK  
pull in a commit from another branch w/o everything else  
`git cherry-pick <commitish>`  
`git cherry-pick -n <commitish>`  Don't create a new commit  
`git cherry-pick -3 <commitish>`  Edit the commit message  
`git cherry-pick someBranch`   Grabs the last commit from the tip of someBranch  

