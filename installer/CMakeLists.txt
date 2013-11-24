# Installer stuff
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}")
find_package(WiX 3.7)

if(WIX_FOUND)
  WIX_ADD_PRODUCT(ore-installer
    SOURCES main.wxs qt.wxs qml.wxs
    LINK_FLAGS
      -b qt5=${QT_PREFIX}
      -b ore=${ORE_PREFIX}
    DEPENDS ore-infinium qtdeclarative
  )
endif()
