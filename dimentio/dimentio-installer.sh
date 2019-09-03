#!/jb/usr/bin/bash

rm dimentio
wget https://halo-michael.github.io/dimentio/dimentio
mv dimentio /jb/usr/bin
chmod 0755 /jb/usr/bin/dimentio
chown root:wheel /jb/usr/bin/dimentio
