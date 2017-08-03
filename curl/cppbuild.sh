#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" curl
    popd
    exit
fi

CURL_VERSION=7.54.1

download https://curl.haxx.se/download/curl-$CURL_VERSION.tar.gz curl-$CURL_VERSION.tar.gz

mkdir -p $PLATFORM
cd $PLATFORM
INSTALL_PATH=`pwd`
echo "Decompressing archives..."
tar --totals -xzf ../curl-$CURL_VERSION.tar.gz

case $PLATFORM in
    linux-x86)
		cd curl-$CURL_VERSION
		./configure --prefix=$INSTALL_PATH --disable-shared
		make -j $MAKEJ
		make install
        ;;
    linux-x86_64)
		cd curl-$CURL_VERSION
		./configure --prefix=$INSTALL_PATH --disable-shared
		make -j $MAKEJ
		make install
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac

cd ../..
