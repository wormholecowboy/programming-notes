Permission Types:
r (Read): Allows viewing the content of a file or listing the contents of a directory.
w (Write): Allows modifying the content of a file or creating/deleting files within a directory.
x (Execute): Allows running an executable file or entering a directory.

User Classes:
u (User/Owner): The individual who owns the file or directory.
g (Group): Members of the group associated with the file or directory.
o (Others): All other users on the system.
a (All): Represents user, group, and others.

Methods for Changing Permissions:
Symbolic Mode:
Syntax: chmod [who][operator][permissions] file/directory

Operators:
+: Add permission.
-: Remove permission.
=: Set exact permissions (overwrites existing).

Examples:
chmod u+rw file.txt: Gives the owner read and write permissions.
chmod g-x file.txt: Removes execute permissions for the group.
chmod a=rx file.txt: Sets read and execute permissions for all users, removing write.

Octal (Numeric) Mode:
Each permission (read, write, execute) is assigned a numeric value: 
Read (r): 4
Write (w): 2
Execute (x): 1

The permissions for user, group, and others are represented by a three-digit number, where each digit is the sum of the corresponding permission values.
Examples:
chmod 755 file.txt:
User: 7 (4+2+1 = rwx)
Group: 5 (4+0+1 = r-x)
Others: 5 (4+0+1 = r-x)
chmod 644 file.txt:
User: 6 (4+2+0 = rw-)
Group: 4 (4+0+0 = r--)
Others: 4 (4+0+0 = r--)
chmod 700 file.txt: Owner has full permissions, group and others have none.

Common chmod Commands:
chmod +x script.sh: Makes a script executable for the owner.
chmod 600 private_key: Sets read/write for owner only (common for SSH keys).
chmod 755 directory: Sets full permissions for owner, read/execute for group and others (common for directories).
chmod -R 777 folder: Recursively sets full permissions for all users within a folder (use with caution).
