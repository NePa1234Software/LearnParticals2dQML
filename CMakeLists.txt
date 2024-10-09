cmake_minimum_required(VERSION 3.16)

project(LearnParticles2dQML VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appLearnParticles2dQML
    main.cpp
)

if (DEBUG)
target_compile_definitions(appLearnParticles2dQML PRIVATE QT_QML_DEBUG)
endif()

set_source_files_properties(Globals.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appLearnParticles2dQML
    URI LearnParticles2dQML
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
        SOURCES propertyintrospection.h
        QML_FILES SettingHelper.qml
        QML_FILES MainToolBar.qml
        QML_FILES Globals.qml
        QML_FILES ShapeConfigurator.qml
        QML_FILES CustomButton.qml
        QML_FILES CustomAttractor.qml
        QML_FILES ConfigSlider.qml
        QML_FILES ConfigListModelEmitter.qml
        QML_FILES ConfigListModelAttractor.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appLearnParticles2dQML PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLearnParticles2dQML
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLearnParticles2dQML
    PRIVATE Qt6::Quick Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS appLearnParticles2dQML
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
