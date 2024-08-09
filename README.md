# LearnParticles2dQML

<img src="docs/Screenshot1.gif" width="640" height="360">
<img src="docs/Screenshot2_edit.gif" width="640" height="360">

This is a work in progress (just started!) application purely for learning the Qt particle system
and a few other things that I have been wanting to practice, like Shapes and user
interaction with the UI controls.

## Goals
- **Learn** all aspects of **QML Particles** - https://doc.qt.io/qt-6/qtquick-particles-qmlmodule.html
- Provide an  interactive **Particle Editor** for being creative for your next project.
- Add the tool as a WASM application for anyone to immediately experiment with. 

## FEATURES (In Progress)
- Create any number of emitters and edit there shape (ShapePath) and position on the screen
- Create any number of attractors, only the position can be changed.
- Hide the editor function and shapes to see the final effect.
- Save and Load INI format works now for the standard folder temp path. File destination is not configurable.

## TODOS and IDEAS
- Add an editor pane (like QmlDesigner does?) for each particle element (fun part !) - Except I dont want to hard code the setting panes like Qt design studio does, but make it generic.
- Creation of all types of Particle elements (Effectors, Particle Painter, Particle Groups)
- Creation of all types of emitter shapes (Particle Extruder)
- Add configurable styling (dark mode etc)
- Drag & drop your image files (storage with WASM? Store to file system??) - how about using the Camera !
- Image based (MaskShape) emitter
- Save and restore of setup (Preferably JSON?) - this would be a custom QSettings writer as Qt doesnt support JSON in QSettings.
- (nice to have) - Export the creation to QML files for use in other applications.
  I am thinking along the line to do this like the Qt effects editor does it or Qt Creator QML designer.
- ...
- any other idea that comes to mind while do this (-;

