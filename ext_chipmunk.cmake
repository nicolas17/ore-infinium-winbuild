# Chipmunk library

ExternalProject_Add(
    Chipmunk
    URL http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-6.2.1.tgz
    URL_HASH MD5=1cc6ff6a1f1cfcc6e167841fb24bf3c6
    CMAKE_ARGS
        -DBUILD_DEMOS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)
