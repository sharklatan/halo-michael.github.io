#!/bin/bash

for file in `ls update`
do
	if [[ ${file} == PPSSPP*ipa ]];then
		cd update
		unzip ${file}
		mv ${file} ../../ipas
		ldid -Sglobal.xml -M -Ksigncert.p12 Payload/PPSSPP.app/PPSSPP
		zip -r9 u0_${file} Payload/PPSSPP.app
		rm -rf Payload
		mv u0_${file} ../../ipas
		cd ..
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/${file}" ../download/ppsspp_en_US.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(Need AppSync)" ../download/ppsspp_en_US.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/${file}" ../download/ppsspp_zh_CN.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(需要 AppSync)" ../download/ppsspp_zh_CN.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/u0_${file}" ../download/u0_ppsspp_en_US.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(Only for Unc0ver, need AppSync)" ../download/u0_ppsspp_en_US.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/u0_${file}" ../download/u0_ppsspp_zh_CN.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(仅限Unc0ver, 需要AppSync)" ../download/u0_ppsspp_zh_CN.plist
	fi
	if [[ ${file} == iSH*ipa ]];then
		cd update
		unzip ${file}
		mv ${file} ../../ipas
		ldid -Sglobal.xml -M -Ksigncert.p12 Payload/iSH.app/iSH
		zip -r9 u0_${file} Payload/iSH.app
		rm -rf Payload
		mv u0_${file} ../../ipas
		cd ..
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/${file}" ../download/ish_en_US.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(Need AppSync)" ../download/ish_en_US.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/${file}" ../download/ish_zh_CN.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(需要 AppSync)" ../download/ish_zh_CN.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/u0_${file}" ../download/u0_ish_en_US.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(Only for Unc0ver, need AppSync)" ../download/u0_ish_en_US.plist
		plutil -key items -key 0 -key assets -key 0 -key url -string "https://halo-michael.github.io/ipas/u0_${file}" ../download/u0_ish_zh_CN.plist
		plutil -key items -key 0 -key metadata -key title -string "$(echo ${file} | sed -e 's/.ipa//g')(仅限Unc0ver, 需要AppSync)" ../download/u0_ish_zh_CN.plist
	fi
	if [[ ${file} == org.ppsspp.ppsspp*deb ]];then
		mv update/${file} debs
	fi
	if [[ ${file} != 'global.xml' && ${file} != 'signcert.p12' ]];then
		rm -rf update/${file}
	fi
done

rm -rf Packages Packages.bz2 Packages.xz Packages.lzma
dpkg-scanpackages -m ./debs /dev/null >Packages
bzip2 -9fkv Packages > Packages.bz2
xz -9fkev Packages > Packages.xz
xz -9fkev --format=lzma Packages > Packages.lzma
