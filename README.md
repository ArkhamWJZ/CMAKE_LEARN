# JZZ_CMKAE

## All we need to know

mkdir build

cd build

cmake .. // 提供cmakelist.txt路径，作为参数运行cmake

make -j4 // -j4 使用四个内核进行并行编译

./[项目名 代表可执行文件]

### 有趣的变量

```cmake
# 输出打印资源目录，/Users/arkham/Github/JZZ_CMAKE/test04
# 你问 STATUS 有啥用，没啥用，就是多两道杠，治好强迫症
message(STATUS "This is PROJECT_SOURCE_DIR " ${PROJECT_SOURCE_DIR})

message(STATUS "This is CMAKE_SOURCE_DIR " ${CMAKE_SOURCE_DIR})

message(STATUS ${CMAKE_CXX_COMPILER_ID}) # 打印当前编译器 如 AppleClang
```

> 把 SOURCE 改成 BINARY，则会输出构建目录 /Users/arkham/Github/JZZ_CMAKE/test04/build

### 生成执行文件

```cmake
 # 用 .h .cpp  生成可执行文件 jianzhou 

SET(SRC_LIST test.cpp)

ADD_EXECUTABLE(jianzhou ${SRC_LIST})

# 另一个长例摘自 CMU 框架 DrawSVG

add_executable( drawsvg
   ${CMU462_DRAWSVG_SOURCE}

   ${CMU462_DRAWSVG_HEADER}

)
```





### 生成动态链接库

有意思的来了，.h .cpp 生成动态链接库 .dylib (这里起名叫 math 实际上命名为 libmath.dylib)

跑的时候只要.h 和 dylib就行了

这里的例子创建了 include src lib 三个文件夹，分别装着 .h .cpp 和预备着输出的.dylib

```cmake
# 指定 cmake 最低编译版本
CMAKE_MINIMUM_REQUIRED(VERSION 3.14)
PROJECT (MATH)
# 把当前工程目录下的 src 目录的下的所有 .cpp 和 .c 文件赋值给 SRC_LIST
# AUX_SOURCE_DIRECTORY(${PROJECT_SOURCE_DIR}/src SRC_LIST)
FILE(GLOB SRC_LIST "${PROJECT_SOURCE_DIR}/src/*.cpp") # 这句也行，在这种情况下
# 指定头文件目录
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)
# 指定输出 .so 动态库的目录位置
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)
# 指定生成动态库
ADD_LIBRARY(math SHARED ${SRC_LIST})
```



使用的时候，复制 include 和 lib 目录

然后在 cmakelists 中添加头文件位置、链接库位置 并 添加共享库链接 

一共三步走即可

```cmake
# 指定cmake最低编译版本
CMAKE_MINIMUM_REQUIRED(VERSION 3.14)
# 指定工程的名称
PROJECT(HELLO)
#添加头文件目录位置
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)
#添加共享库搜索路径
LINK_DIRECTORIES(${PROJECT_SOURCE_DIR}/lib)
#生成可执行文件
ADD_EXECUTABLE(hello test.cpp)
#为hello添加共享库链接
TARGET_LINK_LIBRARIES(hello math)
```

