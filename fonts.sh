#!/usr/bin/env bash

# Description: Automatically patch Apple's SF Mono Fonts selectively with nerdfonts patcher
# Dependencies: 7z, aria2

# Dependencies
sudo apt update 
sudo apt install p7zip-full aria2 -y

# Variables
directory=$(pwd)

apple_fonts () {
	mkdir -p $directory/tmpdir
	mkdir -p $directory/tmpdir/AppleFontsNerdPatched
	mkdir -p $directory/tmpdir/AppleFonts
	cd $directory/tmpdir

	sf_pro () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg"
		7z x 'SF-Pro.dmg'
		cd SFProFonts
		7z x 'SF Pro Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFontsNerdPatched
		cd ..
	}
	sf_arabic () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Arabic.dmg"
		7z x 'SF-Arabic.dmg'
    	cd SFArabicFonts
    	7z x 'SF Arabic Fonts.pkg'
    	7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFontsNerdPatched
		cd ..
	}
	sf_compact () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg"
		7z x 'SF-Compact.dmg'
		cd SFCompactFonts
		7z x 'SF Compact Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFontsNerdPatched
		cd ..
	}
	ny () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/NY.dmg"
		7z x 'NY.dmg'
		cd NYFonts
		7z x 'NY Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFontsNerdPatched
		cd ..	
	}
	sf_mono () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg"
		7z x 'SF-Mono.dmg'
		cd SFMonoFonts
		7z x 'SF Mono Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFonts
		cd ..
	}

	sf_pro		# no nerd patches
	sf_arabic	# no nerd patches
	sf_compact	# no nerd patches
	ny			# no nerd patches
	sf_mono		# nerd patched
	
	set +e && docker run --rm -v $directory/tmpdir/AppleFonts:/in -v $directory/tmpdir/AppleFontsNerdPatched:/out nerdfonts/patcher --no-progressbars --quiet && set -e
	7z a $directory/AppleFontsNerdPatched.7z $directory/tmpdir/AppleFontsNerdPatched
}

apple_fonts
