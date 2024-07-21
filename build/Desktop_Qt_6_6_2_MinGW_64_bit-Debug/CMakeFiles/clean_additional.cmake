# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appLearnParticals2dQML_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appLearnParticals2dQML_autogen.dir\\ParseCache.txt"
  "appLearnParticals2dQML_autogen"
  )
endif()
