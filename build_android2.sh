#!/bin/bash  
NDK=$NDK_HOME
PLATFORM=$NDK/platforms/android-19/arch-arm/  
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

export PATH=$PATH:$PREBUILT/bin:$PLATFORM/usr/include

export LDFLAGS="-L$PLATFORM/usr/lib -L$PREBUILT/arm-linux-androideabi/lib -march=armv7-a"
export CFLAGS="-I$PLATFORM/usr/include -march=armv7-a -mfloat-abi=softfp -mfpu=vfp -ffast-math -O2"

export CPPFLAGS="$CFALGS"
export CFLAGS="$CFLAGS"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="$LDFLAGS"

export AS=$PREBUILT/bin/arm-linux-androideabi-as
export LD=$PREBUILT/bin/arm-linux-androideabi-ld
export CXX="$PREBUILT/bin/arm-linux-androideabi-g++ --sysroot=${PLATFORM}"
export CC="$PREBUILT/bin/arm-linux-androideabi-gcc --sysroot=${PLATFORM} -march=armv7-a "
export NM=$PREBUILT/bin/arm-linux-androideabi-nm
export STRIP=$PREBUILT/bin/arm-linux-androideabi-strip
export RANLIB=$PREBUILT/bin/arm-linux-androideabi-ranlib
export AR=$PREBUILT/bin/arm-linux-androideabi-ar

export PKG_CONFIG_PATH=`pwd`/fdk_aac/lib/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=`pwd`/x264/lib/pkgconfig/:$PKG_CONFIG_PATH
echo $PKG_CONFIG_PATH

CPU=arm
INSTALL_DIR=$(pwd)/out/android/$CPU

CURR_DIR=`pwd`

function build_one
{  
    ./configure \
    --prefix=$INSTALL_DIR \
    --disable-shared \
    --enable-static \
    --disable-stripping \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-devices \
    --disable-indevs \
    --disable-outdevs \
    --disable-debug \
    --disable-asm \
    --disable-x86asm \
    --disable-doc \
    --enable-small \
    --enable-dct \
    --enable-dwt \
    --enable-lsp \
    --enable-gpl \
    --enable-mdct \
    --enable-rdft \
    --enable-fft \
    --enable-version3 \
    --enable-nonfree \
    --disable-filters \
    --disable-postproc \
    --disable-bsfs \
    --enable-bsf=aac_adtstoasc \
    --enable-bsf=h264_mp4toannexb \
    --disable-encoders \
    --enable-encoder=pcm_s16le \
    --enable-encoder=aac \
    --enable-encoder=libvo_aacenc \
    --disable-decoders \
    --enable-decoder=aac \
    --enable-decoder=mp3 \
    --enable-decoder=pcm_sl16le \
    --disable-parsers \
    --enable-parser=aac \
    --disable-muxers \
    --enable-muxer=flv \
    --enable-muxer=wav \
    --enable-muxer=adts \
    --disable-demuxers \
    --enable-demuxer=flv \
    --enable-demuxer=wav \
    --enable-demuxer=aac \
    --disable-protocols \
    --enable-protocol=rtmp \
    --enable-protocol=file \
    --enable-libfdk_aac \
    --enable-libx264 \
    --enable-cross-compile \
    --target-os=android \
    --host-os=arm-linux \
    --arch=arm \
    --cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
    --enable-cross-compile \
    --sysroot=$PLATFORM \
    --extra-cflags="-marm -march=armv7-a -I$PLATFORM/usr/include -I$CURR_DIR/fdk_aac/include/ -I$CURR_DIR/x264/include/" \
    --extra-ldflags="-marm -march=armv7-a -L$CURR_DIR/fdk_aac/lib/ -L$CURR_DIR/x264/lib/" \

#    make clean
#    make
#    make install
}  

build_one
