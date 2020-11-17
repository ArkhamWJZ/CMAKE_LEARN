
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
 
#项目信息
PROJECT(demo)

set(CLANG_CXX_FLAGS "-std=c++17 -m64 -O3 -funroll-loops")
set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -Wno-narrowing")
set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -Wno-deprecated-register")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CLANG_CXX_FLAGS}")

message(STATUS ${CLANG_CXX_FLAGS})
message(jianzhou)
message(STATUS ${CMAKE_CXX_FLAGS})

