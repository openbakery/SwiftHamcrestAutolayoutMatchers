#!/bin/sh

ARCHIVE_DIRECTORY=build/archive

if [ $# -ne 1 ]
then
	echo "Version is missing"
	exit
fi

VERSION=$1

xcodebuild archive \
    -project HamcrestAutolayoutMatchers.xcodeproj \
    -scheme HamcrestAutolayoutMatchers \
    -destination "generic/platform=iOS" \
    -archivePath "$ARCHIVE_DIRECTORY/HamcrestAutolayoutMatchers-iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -project HamcrestAutolayoutMatchers.xcodeproj \
    -scheme HamcrestAutolayoutMatchers \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$ARCHIVE_DIRECTORY/HamcrestAutolayoutMatchers-iOS_Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
    -archive $ARCHIVE_DIRECTORY/HamcrestAutolayoutMatchers-iOS.xcarchive -framework HamcrestAutolayoutMatchers.framework \
    -archive $ARCHIVE_DIRECTORY/HamcrestAutolayoutMatchers-iOS_Simulator.xcarchive -framework HamcrestAutolayoutMatchers.framework \
    -output build/archive/HamcrestAutolayoutMatchers.xcframework

cp LICENSE build/archive
cd build/archive

zip -r HamcrestAutolayoutMatchers-$VERSION.zip HamcrestAutolayoutMatchers.xcframework LICENSE
