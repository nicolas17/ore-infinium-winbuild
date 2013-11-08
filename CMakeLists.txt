cmake_minimum_required(VERSION 2.8)
project(ore-infinium-deps NONE)

include(ExternalProject)

set_property(DIRECTORY PROPERTY EP_BASE "deps")
ExternalProject_Add(
    Chipmunk
    URL http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-6.2.1.tgz
    CMAKE_ARGS -DBUILD_DEMOS=OFF -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
)
