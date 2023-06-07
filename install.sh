#!/bin/bash

# Variables telling us where to get things
HERE="$(dirname "$0")"
VERSION="ffmpeg-5.1.3"
SOURCE="https://ffmpeg.org/releases/${VERSION}.tar.xz"
WIN32SHARED="http://ffmpeg.zeranoe.com/builds/win32/shared/${VERSION}-win32-shared.zip"
WIN32SHAREDDEV="http://ffmpeg.zeranoe.com/builds/win32/dev/${VERSION}-win32-dev.zip"
WIN64SHARED="http://ffmpeg.zeranoe.com/builds/win64/shared/${VERSION}-win64-shared.zip"
WIN64SHAREDDEV="http://ffmpeg.zeranoe.com/builds/win64/dev/${VERSION}-win64-dev.zip"
YASM="http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz"

# fail if we can't do anything
set -e

# remove ffmpeg things in vendor dir
rm -rf ${HERE}/vendor/ffmpeg*
rm -rf ${HERE}/vendor/yasm*

# Now get the the zip files
for z in $SOURCE $YASM; do
	wget -P "${HERE}/vendor" $z
done

# untar the source
echo "Untarring source..."
tar Jxvf "${HERE}/vendor/$(basename $SOURCE)" -C "${HERE}/vendor"

# untar yasm
echo "Untarring yasm..."
tar xzf "${HERE}/vendor/$(basename $YASM)" -C "${HERE}/vendor"

# remove the archives
for z in $SOURCE $YASM; do
	rm "${HERE}/vendor/$(basename $z)"
done

# move the untarred archives to the correct names
mv "${HERE}/vendor/${VERSION}" "${HERE}/vendor/ffmpeg"
mv ${HERE}/vendor/yasm* "${HERE}/vendor/yasm"

echo "You can now type make to build this module"
