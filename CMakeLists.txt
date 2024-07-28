cmake_minimum_required(VERSION 3.16)

project(LearnParticals2dQML VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appLearnParticals2dQML
    main.cpp
)

if (DEBUG)
target_compile_definitions(appLearnParticals2dQML PRIVATE QT_QML_DEBUG)
endif()

qt_add_qml_module(appLearnParticals2dQML
    URI LearnParticals2dQML
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES EditableShape.qml
        QML_FILES DragPoint.qml
        QML_FILES EditableShapePath.qml
        QML_FILES CustomParticleSystem.qml
        QML_FILES ShapeEditor.qml
        QML_FILES EditableShapeSpot.qml
        QML_FILES CustomEmitterPath.qml
        QML_FILES CustomEmitterShape.qml
        QML_FILES CustomEmitter.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appLearnParticals2dQML PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLearnParticals2dQML
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLearnParticals2dQML
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appLearnParticals2dQML
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
