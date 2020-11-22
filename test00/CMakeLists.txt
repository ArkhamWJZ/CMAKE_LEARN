cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project (JZZ_Test VERSION 1.2.3.4)

# message 和 变量
message("")
set(A_A wanjianzhou)
set(var A)
message(STATUS "${A_${var}}")
message(jianzhou ${A_A})
message(STATUS "A_A")
message("")

# 打印变量和值
function(PrintVar var)
	message(STATUS "${var}: ${${var}}")
endfunction()

function(PrintValue value)
	message(STATUS "${value}")
endfunction()

PrintVar(PROJECT_SOURCE_DIR)
PrintVar(CMAKE_PROJECT_NAME)
PrintVar(PROJECT_VERSION)
PrintVar(PROJECT_VERSION_MAJOR)
PrintVar(PROJECT_VERSION_MINOR)
PrintVar(PROJECT_VERSION_PATCH)
PrintVar(PROJECT_VERSION_TWEAK)
message("")

# set  CACHE
# CACHE 存入缓存文件 CMakeCache.txt 中
# 后面跟着缓存值的类型 缓存变量上面的注释
# 当再次运行cmake时，这些变量会直接使用缓存值，可以利用ccmake或者cmake-gui等工具来重新赋值。缓存变量在整个cmake运行过程中都可以起作用。
set(Ubpa_bool TRUE CACHE BOOL "Ubpa bool")
set(Ubpa_string "a string" CACHE STRING "Ubpa string")
set(Ubpa_path ${PROJECT_SOURCE_DIR} CACHE PATH  "Ubpa path")
set(Ubpa_filepath "${PROJECT_SOURCE_DIR}/CMakeLists.txt" CACHE FILEPATH "JZZ  filepath 是上面的注释描述吗？")
message("")

# 函数的参数解析
function(Parse)
  cmake_parse_arguments("ARG" # prefix 解析出的参数都会按照 prefix_参数名 的形式形成新的变量
                        "TEST;INSTALL;JZZ" # 可选值 传入/不传入 TRUE/FALSE
                        "MODE" # 单值关键词
                        "NUMS" # 多值关键词列表
                        ${ARGN})
  # Options
  PrintVar(ARG_TEST)
  PrintVar(ARG_INSTALL)
  PrintVar(ARG_JZZ)
  # Keywords
  PrintVar(ARG_MODE)
  PrintVar(ARG_NUMS)
endfunction()

Parse(TEST JZZ
  MODE BREAKDOWN
  NUMS 1 2 3 4 5 6)
message("")

# while LESS 的条件编写
# i的自增
set(i 0)
set(n 5)
while(i LESS n)
  PrintVar(i)
  math(EXPR i "${i} + 1")
endwhile()
message("")

# 类似于迭代器的语法
set(nums 1 2 3 4 5)
foreach(num ${nums})
  PrintValue(${num})
endforeach()
message("")

# 通过 list 进行列表操作 长度、下标访问等
set(list0 1 2 3 4 5) # list0: 1;2;3;4;5
set(list1 a b c d e) # list1: a;b;c;d;e
list(LENGTH list0 n)
set(i 0)
while(i LESS n)
  list(GET list0 ${i} v0)
  list(GET list1 ${i} v1)
  message(STATUS "${v0}, ${v1}")
  math(EXPR i "${i} + 1") # i++
endwhile()
message("")

# list 进行分割操作，很有趣
set(numletters 1 a 2 b 3 c)
list(LENGTH numletters n)
set(i 0)
while(i LESS n)
  list(SUBLIST numletters ${i} 2 numletter) #sublist : input begin length output
  list(GET numletter 0 num)
  list(GET numletter 1 letter)

  message(STATUS "num : ${num}, letter : ${letter}")

  math(EXPR i "${i} + 2")
endwhile()
message("")

# string 正则表达式的搜素 MATCH
string(REGEX
	MATCH
	"/(([^/]*)\\.(.*))$"
	out
	"xxx/ddd/aa.eee")
PrintVar(out)
PrintVar(CMAKE_MATCH_COUNT)

set(i 0)
while(i LESS_EQUAL CMAKE_MATCH_COUNT)
  PrintVar(CMAKE_MATCH_${i})
  math(EXPR i "${i} + 1")
endwhile()
message("")

# string 正则表达式的搜索 MATCHALL
string(REGEX
	MATCHALL
	"[_a-zA-Z][_a-zA-Z0-9]*"
	out
	"xxx/ddd/aa.eee")
PrintVar(out)
PrintVar(CMAKE_MATCH_COUNT)

set(i 0)
while(i LESS_EQUAL CMAKE_MATCH_COUNT)
  PrintVar(CMAKE_MATCH_${i})
  math(EXPR i "${i} + 1")
endwhile()
message("")

# INCLUDE 提取出匹配
set(data 1 2 3 4 5 a 6 b 7)
list(FILTER data
  INCLUDE
  REGEX "[0-9]")
PrintVar(data)
# EXCLUDE 排除匹配
set(data 1 2 3 4 5 a 6 b 7)
list(FILTER data
  EXCLUDE
  REGEX "[0-9]")
PrintVar(data)
message("")

# 变量的解析 ${} 与 "${}" 是不同的
set(specialStr "aaa;bbb")
# example 1
message(STATUS ${specialStr}) # aaabbb
message(STATUS "${specialStr}") # aaa;bbb
# example 2
function(PrintVar var)
    message(STATUS "${var}")
endfunction()
PrintVar(${specialStr})
PrintVar("${specialStr}")
message("")

# file() 和 set 1/0
file(READ "${CMAKE_SOURCE_DIR}/CMakeLists.txt" filestr)
# PrintValue("${filestr}")  # 会把 CMakeLists 文件的内容全部打印出来

set(flag 1)
if(flag)
  message(STATUS "flag")
endif()

PrintValue("Everything have been done")

