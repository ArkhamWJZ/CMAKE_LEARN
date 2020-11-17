set(MATH_INC_NAMES jian.h)
set(MATH_LIB_NAMES libjian.a)

# jian static library
find_library(Math_LIBRARIES 
    NAMES ${MATH_LIB_NAMES}
    PATHS ${PROJECT_SOURCE_DIR}/lib/)

# jian library dir CMakeLists 中添加静态链接库有用
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