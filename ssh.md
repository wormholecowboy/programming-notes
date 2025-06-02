START SSH AGENT
`eval $(ssh-agent)`
OR
`eval `ssh-agent -s`

CLEAR CURRENT KEYS
`ssh-add -D`

LIST CURRENT ADDED
`ssh-add -ld`


GENERATE
ssh-keygen -t ed25519 -C "your.email@blah.com"
    -b 1040  (min bits, optional)

ADD PUB KEY TO YOUR ONLINE ACCOUNT


CREATE "CONFIG" IN ~/.SSH
ex.
#WORK Bitbucket
    Host bb
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_rsa_bb
Note: On Mac OS Sierra onwards you have to add this to the top of the config file OR in each one:
Host *
  UseKeychain yes
  AddKeysToAgent yes




CHECK IF REMOTE CAN CONNECT
`ssh -T bb`
`ssh -T gh`
`ssh -T username@remote-repo-url`


CHANGE HTTPS TO SSH
`git remote set-url origin git@HOST:USERNAME/REPOSITORY.git`








