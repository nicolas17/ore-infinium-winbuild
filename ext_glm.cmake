# GLM library

ExternalProject_Add(
    glm
    URL http://sourceforge.net/projects/ogl-math/files/glm-0.9.5.4/glm-0.9.5.4.zip
    URL_HASH SHA1=d9666b5b013d374c7d1a498c9495f7142f6fe9d3
    CMAKE_CACHE_ARGS
        -DCMAKE_PREFIX_PATH:STRING=${CMAKE_PREFIX_PATH}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
)

ExternalProject_Get_Property(glm INSTALL_DIR)
set(GLM_PREFIX ${INSTALL_DIR})
