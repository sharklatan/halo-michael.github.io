#!/bin/bash

for file in `ls update`
do
	if [[ $file == PPSSPP*ipa ]];then
		cd update
		unzip $file
		rm -rf $file
		ldid -Sglobal.xml -M -Ksigncert.p12 Payload/PPSSPP.app/PPSSPP
		zip -r9 $file Payload/PPSSPP.app
rm -rf Payload
		mv $file ../../ipas
		cd ..
	fi
	if [[ $file == org.ppsspp.ppsspp*deb ]];then
		mv update/$file debs
	fi
	if [[ $file != 'global.xml' && $file != 'signcert.p12' ]];then
		rm -rf update/$file
	fi
done

rm -rf Packages Packages.bz2 Packages.xz Packages.lzma
dpkg-scanpackages -m ./debs /dev/null >Packages
bzip2 -9fkv Packages > Packages.bz2
xz -9fkev Packages > Packages.xz
xz -9fkev --format=lzma Packages > Packages.lzma
