# JZZ_CMKAE

## All we need to know

[cmake 官方文档检索](https://cmake.org/cmake/help/latest/search.html?)

```shell
mkdir build

cd build

cmake .. // 提供cmakelist.txt路径，作为参数运行cmake

make -j4 // -j4 使用四个内核进行并行编译

./[项目名 代表可执行文件]
```

### 基础语法

看看就懂了？

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





### 生成动态/静态链接库

有意思的来了，.h .cpp 生成动态链接库 .dylib (这里起名叫 math 实际上命名为 libmath.dylib)

跑的时候只要.h 和 dylib就行了

这里的例子创建了 include src lib 三个文件夹，分别装着 .h .cpp 和预备着输出的.dylib

>  生成[静态库](https://blog.csdn.net/ox0080/article/details/96453985) .a 只需要去掉 SHARED 行了，ADD_LIBRARY(math ${SRC_LIST})
>
>  OSX 下 MODULE 参数就是生成 .so 后缀的动态链接库了
>
>  有个问题得码一下，就是在OS X上，最后一步链接库的时候，.so 一直找不到。。。。。
>
>  不知道为毛。。。。。。

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
# 暴力链接 target_link_libraries(abc ${PROJECT_SOURCE_DIR}/lib/libmath.a)
# 但这样写可移植性很差，不优雅
```

### cmake 模块

也很有趣，可以规范你的 CMakeLists 文件，更显整洁。

在 CMakeLists 中找包的时候，我们一般这么写 `` find_package(Math REQUIRED)`` 。如果要链接到自己的库，一般会到相应的 .cmake 模块文件中找（cmake  文件的命名是有规范的，比如你在lists 文件中这样写 find_package(Jian REQUIRED)  则对应的 cmake 文件要求命名为 FindJian.cmake / JianConfig.cmake / jian-config.cmake）。

```cmake
cmake_minimum_required(VERSION 2.8)
project(Project1)

# 添加路径
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/modules/")

# 对 cmake 文件的命名是有规范的
find_package(Math REQUIRED)

# 下面三个变量都是在 cmake 文件中查找出来的
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
```



对应的 cmake 查找模块编写

没啥要注意的，看下面示例即可。注意这些提供的功能函数的参数，非常丰富，可定制化非常强

建议用的时候对应文档

```cmake
set(MATH_INC_NAMES jian.h)
set(MATH_LIB_NAMES libjian.a)

# jian static library
find_library(Math_LIBRARIES 
    NAMES ${MATH_LIB_NAMES}
    PATHS ${PROJECT_SOURCE_DIR}/lib/)

# jian library dir 在 CMakeLists 中添加静态链接库有用
# 这样写比较规范
find_path(Math_LIBRARY_DIRS
    NAMES ${MATH_LIB_NAMES}
    PATHS ${PROJECT_SOURCE_DIR}/lib/
)

# jian include dir
find_path(Math_INCLUDE_PATH 
    NAMES ${MATH_INC_NAMES}
    PATHS ${PROJECT_SOURCE_DIR}/include/)

# Version
set(MATH_VERSION 1.0)

# Set package standard args
# 检查这几个变量都找到没有
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Math
    REQUIRED_VARS Math_LIBRARIES Math_INCLUDE_PATH Math_LIBRARY_DIRS
    VERSION_VAR MATH_VERSION)
```

### 编译器参数设置

建议通过 set  命令修改`CMAKE_CXX_FLAGS`或`CMAKE_C_FLAGS`。

set 命令设置`CMAKE_C_FLAGS`或`CMAKE_CXX_FLAGS`变量分别只针对c和c++编译器的。

Clang [参数汇总](https://clang.llvm.org/docs/ClangCommandLineReference.html)

GCC [参数汇总](https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html)

```cmake
# Check compiler
# clang 编译参数设置
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")

  set(CLANG_CXX_FLAGS "-std=c++17 -m64 -O3 -funroll-loops")
  set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -Wno-narrowing")
  set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -Wno-deprecated-register")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CLANG_CXX_FLAGS}")

elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  
  # UNIX
  if(UNIX)

    set(GCC_CXX_FLAGS "-std=gnu++11 -m64 -O3 -funroll-loops")
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -fopenmp")
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXi")
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXxf86vm")
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXinerama") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXcursor") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXfixes") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXrandr") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXext")
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXrender") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lX11")
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lpthread") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lxcb") 
    set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXau")  
  endif(UNIX)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GCC_CXX_FLAGS}")

endif()
```

### 模块化

在 test08 中，提供的是一个非常有趣的例子。

使用 include 指令用来载入并运行来自于文件或模块的CMake代码 ；（这样就可以把一些函数和宏的编写过程扔到外面去了）

通过 ADD_SUBDIRECTORY( )  添加子目录，接着跑每个子目录自己的 CMakeLists.txt 文件

```cmake
# CMake版本要求
cmake_minimum_required(VERSION 2.8)
project(Test)

# 生成的可执行文件及共享库的存放位置 
# PROJECT_SOURCE_DIR表示项目的顶级目录
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/obj)
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/obj)

# 头文件路径
include_directories(${PROJECT_SOURCE_DIR}/include)
# 共享库位置
LINK_DIRECTORIES(${PROJECT_SOURCE_DIR}/lib)


list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(set_cxx_norm)
include(macroTest)
include(functionTest)

message(${CMAKE_MODULE_PATH})
set(var "ABC")
Moo(${var})
Woo()


# 添加构建子目录
ADD_SUBDIRECTORY(cmake_test1)
ADD_SUBDIRECTORY(cmake_test2)
ADD_SUBDIRECTORY(cmake_test3)
```



### 函数与宏

宏和函数的用法非常非常相似，都是创建一段有名字的代码稍后可以调用，还可以传参数。

不同的地方在于，宏的ARGN、ARGV等内部变量不能直接在 if 和 foreach(..IN LISTS..) 中使用。

需要使用变量赋值后使用变量进行逻辑分支操作。

**在 test09 中有很详细的测试代码。**

