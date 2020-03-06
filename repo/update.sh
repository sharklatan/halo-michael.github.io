#!/bin/bash

for file in `ls update`
do
	if [[ ${file} == PPSSPP*ipa ]];then
		mv update/${file} ../ipas
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/${file}" ../download/ppsspp_en_US.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(Need AppSync)" ../download/ppsspp_en_US.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/${file}" ../download/ppsspp_zh_CN.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(需要 AppSync)" ../download/ppsspp_zh_CN.plist
	fi
	if [[ ${file} == org.ppsspp.ppsspp*deb ]];then
		mv update/${file} debs
	fi
done

rm -rf Packages Packages.bz2 Packages.xz Packages.lzma
dpkg-scanpackages -m ./debs /dev/null >Packages
bzip2 -9fkv Packages > Packages.bz2
xz -9fkev Packages > Packages.xz
xz -9fkev --format=lzma Packages > Packages.lzma
