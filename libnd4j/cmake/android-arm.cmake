# CMake toolchain to build for Android 5.0 or newer. Sample usage:
#
# ANDROID_BIN="/path/to/android-ndk/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/" \
# ANDROID_CPP="/path/to/android-ndk/sources/cxx-stl/llvm-libc++/" \
# ANDROID_CC="/path/to/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/clang" \
# ANDROID_ROOT="/path/to/android-ndk/platforms/android-21/arch-arm/" \
# cmake -DCMAKE_TOOLCHAIN_FILE=android-arm.cmake -DCMAKE_INSTALL_PREFIX=..
#
# If you really need to use libnd4j on a CPU with no FPU, replace "libs/armeabi-v7a" by "libs/armeabi" and
# "-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" with "-march=armv5te -mtune=xscale -msoft-float"

set(CMAKE_SYSTEM_NAME UnixPaths)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(ANDROID TRUE)

set(CMAKE_C_COMPILER   "$ENV{ANDROID_CC}")
set(CMAKE_CXX_COMPILER "$ENV{ANDROID_CC}++")

set(CMAKE_C_LINK_EXECUTABLE    "<CMAKE_C_COMPILER>   <FLAGS> <CMAKE_C_LINK_FLAGS>   <LINK_FLAGS> <OBJECTS> -target armv7-none-linux-androideabi -Wl,--fix-cortex-a8 -Wl,--no-undefined -z text -o <TARGET> <LINK_LIBRARIES> -gcc-toolchain $ENV{ANDROID_BIN} --sysroot=$ENV{ANDROID_ROOT} -lm -lc")
set(CMAKE_CXX_LINK_EXECUTABLE  "<CMAKE_CXX_COMPILER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -target armv7-none-linux-androideabi -Wl,--fix-cortex-a8 -Wl,--no-undefined -z text -o <TARGET> <LINK_LIBRARIES> -gcc-toolchain $ENV{ANDROID_BIN} --sysroot=$ENV{ANDROID_ROOT} -L$ENV{ANDROID_CPP}/libs/armeabi-v7a/ -nostdlib++ -lc++_static -lc++abi -landroid_support -lm -lc")

set(CMAKE_C_CREATE_SHARED_LIBRARY    "<CMAKE_C_COMPILER> <CMAKE_SHARED_LIBRARY_C_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS> <CMAKE_SHARED_LIBRARY_SONAME_C_FLAG><TARGET_SONAME> -target armv7-none-linux-androideabi -Wl,--fix-cortex-a8 -Wl,--no-undefined -z text -o <TARGET> <OBJECTS> <LINK_LIBRARIES> -gcc-toolchain $ENV{ANDROID_BIN} --sysroot=$ENV{ANDROID_ROOT} -lm -lc")
set(CMAKE_CXX_CREATE_SHARED_LIBRARY  "<CMAKE_CXX_COMPILER> <CMAKE_SHARED_LIBRARY_CXX_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS> <CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG><TARGET_SONAME> -target armv7-none-linux-androideabi -Wl,--fix-cortex-a8 -Wl,--no-undefined -z text -o <TARGET> <OBJECTS> <LINK_LIBRARIES> -gcc-toolchain $ENV{ANDROID_BIN} --sysroot=$ENV{ANDROID_ROOT} -L$ENV{ANDROID_CPP}/libs/armeabi-v7a/ -nostdlib++ -lc++_static -lc++abi -landroid_support -lm -lc")

add_definitions(-D__ANDROID_API__=21 -DANDROID -fPIC -ffunction-sections -funwind-tables -fstack-protector-strong -target armv7-none-linux-androideabi -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16)

include_directories("$ENV{ANDROID_CPP}/include/" "$ENV{ANDROID_CPP}/../llvm-libc++abi/include/" "$ENV{ANDROID_NDK}/sources/android/support/include/" "$ENV{ANDROID_CPP}/libs/armeabi-v7a/include/" "$ENV{ANDROID_NDK}/sysroot/usr/include/" "$ENV{ANDROID_NDK}/sysroot/usr/include/arm-linux-androideabi/" "$ENV{ANDROID_ROOT}/usr/include/")
