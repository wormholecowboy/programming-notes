
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

# mirror - delete files in dest
rsync -avh --delete /src/ /dest/

# dry run
rsync -avh --dry-run /src/ /dst/
