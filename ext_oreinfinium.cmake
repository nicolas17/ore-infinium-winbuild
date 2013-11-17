# Ore Infinium!
ExternalProject_Get_Property(Chipmunk INSTALL_DIR)
set(CHIPMUNK_PREFIX ${INSTALL_DIR})
ExternalProject_Get_Property(yaml-cpp INSTALL_DIR)
set(YAMLCPP_PREFIX ${INSTALL_DIR})
ExternalProject_Get_Property(enet INSTALL_DIR)
set(ENET_PREFIX ${INSTALL_DIR})
ExternalProject_Get_Property(Protobuf SOURCE_DIR)
set(PROTOBUF_SRC ${SOURCE_DIR})

ExternalProject_Add(
    ore-infinium
    GIT_REPOSITORY git://github.com/sreich/ore-infinium
    GIT_TAG winbuild
    CMAKE_CACHE_ARGS
        -DCMAKE_PREFIX_PATH:STRING=${CMAKE_PREFIX_PATH};${CHIPMUNK_PREFIX};${YAMLCPP_PREFIX};${ENET_PREFIX}
        -DPROTOBUF_SRC_ROOT_FOLDER:PATH=${PROTOBUF_SRC}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}

    DEPENDS Protobuf Chipmunk yaml-cpp enet
)
