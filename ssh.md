## ssh-copy-id vs ssh-add (what's the difference?)
**ssh-copy-id** → Tells the *remote server* to trust your key
- Copies public key to remote's ~/.ssh/authorized_keys
- One-time setup per server

**ssh-add** → Unlocks your key *locally* so you don't retype the passphrase
- Only needed if your private key has a passphrase
- Loads decrypted key into SSH agent (in memory)
- Lasts until logout/reboot

If your key has no passphrase, you don't need ssh-add at all.

Check if your key has a passphrase:
`ssh-keygen -y -f ~/.ssh/id_ed25519`
Prompts for passphrase = has one. Prints public key = doesn't.


## START SSH AGENT
only needed if you use a passphrase
holds private keys passphrase in mem
runs natively on macos (launchd)
`eval $(ssh-agent)`
OR
`eval "ssh-agent -s"`

## CLEAR CURRENT KEYS
`ssh-add -D`

## LIST CURRENT ADDED
`ssh-add -ld`

## GENERATE
ssh-keygen -t ed25519 -C "comment"
    -b 1040  (min bits, optional)
- Pick any file name under .ssh/
- ADD PUB KEY TO YOUR ONLINE ACCOUNT

# ADD KEY TO SSH AGENT'
ssh-add --apple-use-keychain ~/.ssh/id_ed25519


## CREATE "CONFIG" IN ~/.SSH
Creates an easy ref  

```
Host myec2
    HostName your-instance-public-ip
    User ec2-user
    IdentityFile ~/.ssh/your-key.pem
    ServerAliveInterval 60
```

Then you can use:
```
ssh myec2
scp file.txt myec2:/remote/path/
rsync -avz ./local/ myec2:/remote/
```


## PASSWORDLESS SSH (copy key to remote)
`ssh-copy-id hostname`

Copies your public key (~/.ssh/id_ed25519.pub) to the remote's ~/.ssh/authorized_keys.
Asks for password once, then future connections use key auth instead.
The hostname can be an alias from your config (e.g., `ssh-copy-id mm`).


## CHECK IF REMOTE CAN CONNECT
`ssh -T bb`
`ssh -T gh`
`ssh -T username@remote-repo-url`


## CHANGE HTTPS TO SSH
`git remote set-url origin git@HOST:USERNAME/REPOSITORY.git`



# CONNECTING and UPLOADING
`ssh -i /path/to/keyfile user@hostIP`

Upload single file  
`scp -i your-key.pem /local/path/file.txt ec2-user@your-instance-ip:/remote/path/`
Upload folder  
`scp -i your-key.pem -r /local/directory/ ec2-user@your-instance-ip:/remote/path/`
Download file  
`scp -i your-key.pem ec2-user@your-instance-ip:/remote/file.txt /local/path/`
Download folder
`scp -i your-key.pem -r ec2-user@your-instance-ip:/remote/directory/ /local/path/`





