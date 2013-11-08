cmake_minimum_required(VERSION 2.8)
project(ore-infinium-deps NONE)

include(ExternalProject)

set_property(DIRECTORY PROPERTY EP_BASE "deps")
ExternalProject_Add(
    Chipmunk
    URL http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-6.2.1.tgz
    URL_HASH MD5=1cc6ff6a1f1cfcc6e167841fb24bf3c6
    CMAKE_ARGS -DBUILD_DEMOS=OFF -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
)
ExternalProject_Add(
    yaml-cpp
    URL https://yaml-cpp.googlecode.com/files/yaml-cpp-0.3.0.tar.gz
    URL_HASH SHA1=28766efa95f1b0f697c4b4a1580a9972be7c9c41
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
)
