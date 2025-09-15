
# TARBALL 
# create
tar -czvf tarballFilename.tar.gz fileORdir
# see inside tarball
tar -tzvf file
# extract
tar -xzvf file.tar.gz

-c : Creates Archive
-x : Extract the archive
-f : creates archive with given filename
-t : displays or lists files in archived file
-u : archives and adds to an existing archive file

-v : Displays Verbose Information
-A : Concatenates the archive files
-z : tells tar to use gzip
    For .tar.xz archives use J instead of z, and for .tar.bz2 use j.
    -j : use tbzip  *.tar.bz2
    -J : use for *.tar.xz
-W : Verify a archive file
-r : update or add file or directory in already existed .tar file
-C : change install dir

example
tar -C /opt -xzf example.tar.gz 
unzip file.zip -d destination_folder

