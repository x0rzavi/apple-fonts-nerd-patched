#!/usr/bin/env bash

# Description: Install my favourite fonts
# Dependencies: fontforge, aria2

# Dependencies
sudo apt update 
sudo apt install p7zip-full aria2 -y

# Variables
directory=$(pwd)

mkdir -p $directory/tmpdir
mkdir -p $directory/tmpdir/out
cd $directory/tmpdir

apple_fonts () {
	mkdir -p $directory/tmpdir/AppleFonts

	sf_pro () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg"
		7z x "SF-Pro.dmg"
		cd SFProFonts
		7z x 'SF Pro Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFonts
		cd ..
	}
	sf_compact () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg"
		7z x "SF-Compact.dmg"
		cd SFCompactFonts
		7z x 'SF Compact Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFonts
		cd ..
	}	
	sf_mono () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg"
		7z x "SF-Mono.dmg"
		cd SFMonoFonts
		7z x 'SF Mono Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFonts
		cd ..
	}
	ny () {
		aria2c -x16 "https://devimages-cdn.apple.com/design/resources/download/NY.dmg"
		7z x "NY.dmg"
		cd NYFonts
		7z x 'NY Fonts.pkg'
		7z x 'Payload~'
		mv Library/Fonts/* $directory/tmpdir/AppleFonts
		cd ..	
	}

	#sf_pro
	#sf_compact
	sf_mono
	#ny

  rm $directory/tmpdir/AppleFonts/*Semibold*
  rm $directory/tmpdir/AppleFonts/*Bold*
  rm $directory/tmpdir/AppleFonts/*Light*
  rm $directory/tmpdir/AppleFonts/*Heavy*
  rm $directory/tmpdir/AppleFonts/*Medium*
  rm $directory/tmpdir/AppleFonts/SF-Mono-RegularItalic.otf
  docker run -v $directory/tmpdir/AppleFonts:/in -v $directory/tmpdir/out:/out nerdfonts/patcher -c --careful --no-progressbars --quiet
  7z a $directory/AppleFontsNerdPatched.7z $directory/tmpdir/out
  rm -rf *.dmg NYFonts SFCompactFonts SFProFonts SFMonoFonts
  ls $directory
  
}

apple_fonts
