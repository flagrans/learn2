cmake_minimum_required(VERSION 3.16)

project(1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Charts REQUIRED)

qt_add_executable(app1
    main.cpp
    graphics.h
    graphics.cpp
)

qt_add_qml_module(app1
    URI 1
    VERSION 1.0
    QML_FILES main.qml 
)

set_target_properties(app1 PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(app1
    PRIVATE Qt6::Quick Qt6::Charts)

install(TARGETS app1
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
