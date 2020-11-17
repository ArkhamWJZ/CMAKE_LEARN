cmake_minimum_required(VERSION 2.8)
project(Project1)


list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/modules/")

find_package(Math REQUIRED)

# Set include directories
include_directories(
    ${Math_INCLUDE_PATH}
)
# Set link directories
link_directories(
    ${Math_LIBRARY_DIRS}
)

add_executable(abc test.cpp)
target_link_libraries(abc ${Math_LIBRARIES})