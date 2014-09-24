# Ore Infinium!

# The *_PREFIX variables are set in each ext_*.cmake file.

ExternalProject_Add(
    ore-infinium
    GIT_REPOSITORY git://github.com/sreich/ore-infinium
    GIT_TAG qtquick-attempt
    CMAKE_CACHE_ARGS
        -DCMAKE_PREFIX_PATH:STRING=${CMAKE_PREFIX_PATH};${CHIPMUNK_PREFIX};${ENET_PREFIX};${QT_PREFIX}
        -DPROTOBUF_SRC_ROOT_FOLDER:PATH=${PROTOBUF_SRC}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}

    DEPENDS Protobuf Chipmunk enet qtdeclarative
)
