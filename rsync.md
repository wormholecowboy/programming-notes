
# RSYNC
rsync -aHAX wholedir dest/
rsync -aHAX contentsOfDir/ dest/

-a: archive mode (recursive + preserve permissions, timestamps, symlinks, etc.)
-v: verbose
-h: human-readable file sizes
-z: enable compression during transfer
--include='*.jpg'
--exclude='node_modules/'
--delete --del  delete files in target not found in source    


-a Archive mode: recursive + preserves symbolic links, permissions, timestamps, owner, group. Essentially -rlptgoD.
-v Verbose: shows detailed output of what rsync is doing.
-h Human-readable: makes file sizes easier to read (e.g., 1K, 234M).
-z Compress: compress file data during the transfer (good for slow links).
-r Recursive: copy directories recursively (included in -a).
-l Copy symlinks as symlinks (included in -a).
-p Preserve permissions (included in -a).
-t Preserve modification times (included in -a).
-g Preserve group (included in -a).
-o Preserve owner (requires sudo if not root) (included in -a).
-D Preserve device and special files (included in -a).
-H Preserve hard links.
-A Preserve ACLs (Access Control Lists).
-X Preserve extended attributes.

--delete
Delete files in the destination that are not in the source. Great for mirroring.
--dry-run
Show what would happen without actually copying/deleting anything. Useful for testing.
--progress
Show progress during transfer.
--exclude='PATTERN'
Skip files matching a pattern. Example: --exclude='node_modules/'.
--include='PATTERN'
Include only files matching a pattern. Often used with --exclude='*'.

# mirror - delete files in dest
rsync -avh --delete /src/ /dest/

# dry run
rsync -avh --dry-run /src/ /dst/
