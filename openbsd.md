# --- Copy public key to server (if needed) ---
ssh-copy-id -i ~/.ssh/your_key.pub username@your.server.ip

# If ssh-copy-id not available:
cat ~/.ssh/your_key.pub | ssh username@your.server.ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh"

# --- Permissions on the server ---
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# --- Local SSH config (~/.ssh/config) example ---
# (edit with your editor; IdentityFile must be private key)
cat >> ~/.ssh/config <<'EOF'
Host vultr
    HostName 149.28.56.37
    User wormholecowboy
    IdentityFile ~/.ssh/your_key
    IdentitiesOnly yes
    ServerAliveInterval 60
EOF

# --- Debugging connection (verbose) ---
ssh -vvv wormholecowboy@149.28.56.37

# --- Check key fingerprints locally and on server ---
ssh-keygen -lf ~/.ssh/your_key
ssh-keygen -lf /home/username/.ssh/authorized_keys   # run on the server to compare

# --- Read users / check users exist (OpenBSD) ---
cat /etc/passwd
cut -d: -f1 /etc/passwd

# --- Add a new user (interactive) ---
adduser

# --- doas setup (edit /etc/doas.conf) ---
# Example: require password once per session
# echo 'permit persist brian as root' >> /etc/doas.conf
# or (less secure) nopass:
# echo 'permit nopass brian' >> /etc/doas.conf

# --- Copy root's authorized_keys to a user (as root) ---
mkdir -p /home/brian/.ssh
cp /root/.ssh/authorized_keys /home/brian/.ssh/
chown -R brian:brian /home/brian/.ssh
chmod 700 /home/brian/.ssh
chmod 600 /home/brian/.ssh/authorized_keys

# --- Append a public key to a user's authorized_keys (server-side) ---
echo "ssh-ed25519 AAAA... your_comment" >> /home/brian/.ssh/authorized_keys
chown brian:brian /home/brian/.ssh/authorized_keys
chmod 600 /home/brian/.ssh/authorized_keys

# --- Test login and escalation ---
ssh brian@your.server.ip
doas ls /root
doas su -

# --- Disable root SSH login and passwords (edit /etc/ssh/sshd_config) ---
# Set these lines in /etc/ssh/sshd_config:
# PermitRootLogin no
# PasswordAuthentication no
# Then restart SSH:
rcctl restart sshd

# --- OpenBSD system patching ---
syspatch

# --- Check mounted filesystems (is /mnt used?) ---
mount

# --- View a user's .ssh directory and authorized_keys (example) ---
ls -la /home/wormholecowboy/.ssh
cat /home/wormholecowboy/.ssh/authorized_keys

# --- Remove keys from root (if you're ready) ---
> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# --- Helpful quick checks ---
# Show which key the client offers (from -vvv output)
# Look for lines: "Offering public key: /path/to/key"
# If not offering the correct key, check ~/.ssh/config and IdentityFile path.

# --- Misc: edit files with editor examples ---
vi /etc/doas.conf
vi /etc/ssh/sshd_config
vi /home/brian/.ssh/authorized_keys
