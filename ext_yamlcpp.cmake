# yaml-cpp library

ExternalProject_Add(
    yaml-cpp
    URL https://yaml-cpp.googlecode.com/files/yaml-cpp-0.3.0.tar.gz
    URL_HASH SHA1=28766efa95f1b0f697c4b4a1580a9972be7c9c41
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)
