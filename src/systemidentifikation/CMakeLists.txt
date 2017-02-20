
##Declare Nodelet
add_executable(systemidentifikation
  src/systemidentifikation/systemidentifikation.cpp
  src/systemidentifikation/systemidentifikation_node.cpp
)

##Declare Nodelet
add_library(systemidentifikation_nodelet
  src/systemidentifikation/systemidentifikation.cpp
  src/systemidentifikation/systemidentifikation_node.cpp
)
## set compiler definitions for nodelet
set_target_properties(systemidentifikation_nodelet PROPERTIES COMPILE_DEFINITIONS "BUILD_NODELET")

add_dependencies(systemidentifikation ${PROJECT_NAME}_gencfg ${catkin_EXPORTED_TARGETS})
add_dependencies(systemidentifikation_nodelet ${PROJECT_NAME}_gencfg ${catkin_EXPORTED_TARGETS})

target_link_libraries(systemidentifikation
  ${catkin_LIBRARIES}
  ${common_LIBRARIES}
)
target_link_libraries(systemidentifikation_nodelet
  ${catkin_LIBRARIES}
  ${common_LIBRARIES}
)

catkin_add_gtest(systemidentifikation_test
  test/test_systemidentifikation.cpp
  src/systemidentifikation/systemidentifikation.cpp
)

