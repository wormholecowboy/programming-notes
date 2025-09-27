## START SSH AGENT
`eval $(ssh-agent)`
OR
`eval `ssh-agent -s`

## CLEAR CURRENT KEYS
`ssh-add -D`

## LIST CURRENT ADDED
`ssh-add -ld`

## GENERATE
ssh-keygen -t ed25519 -C "your.email@blah.com"
    -b 1040  (min bits, optional)

- ADD PUB KEY TO YOUR ONLINE ACCOUNT


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





