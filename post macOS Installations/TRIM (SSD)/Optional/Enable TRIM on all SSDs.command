#!/bin/bash

# Run this script if you are using an SSD not manufactured by Apple. By default, Mac OS X disables TRIM on all non-Apple SSD's, decreasing performance.

if (( $(echo "${OSTYPE:6} > 13" | bc -l) ))
then
	sudo trimforce enable
else
	sudo cp /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage.bak
	if [[ $(sw_vers -productVersion) =~ 10\.9\.[45] ]]
	then
		sudo perl -pi -e 's|(^\x00{1,20})[^\x00]{9}(\x00{1,20}\x54)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage
	elif [[ $(sw_vers -productVersion) =~ 10\.((8\.[345])|(9\.[0123])) ]]
	then
		sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00{1,20})[^\x00]{9}(\x00{1,20}\x54)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage
	elif [[ $(sw_vers -productVersion) =~ 10\.((7\.5)|(8\.[12])) ]]
	then
		sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00{1,20})[^\x00]{9}(\x00{1,20}\x4D)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage
	elif [[ $(sw_vers -productVersion) =~ 10\.((7\.[01234])|(8\.0)) ]]
	then
		sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00{1,20})[^\x00]{9}(\x00{1,20}\x51)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage
	elif [[ $(sw_vers -productVersion) =~ 10\.6\.8 ]]
	then
		sudo perl -pi -e 's|\x41\x50\x50\x4c\x45\x20\x53\x53\x44|\x00\x00\x00\x00\x00\x00\x00\x00\x00|g' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage
	else
		echo "Error: This script is incompatible with your version of Mac OS. No changes have been made."
		sleep 10
		exit
	fi
	echo "Your computer will restart momentarily. If you update OS X in the future, please re-run this script."
	sudo kextcache -system-prelinked-kernel
	sudo kextcache -system-caches
	sudo touch /System/Library/Extensions/
	sudo reboot
fi