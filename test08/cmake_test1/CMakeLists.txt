# 遍历当前路径下的所有源文件，并将其添加到变量DIR_SRCS中
aux_source_directory(. DIR_SRCS)

# 添加名为cmake_test1的可执行文件，该文件会由变量DIR_SRCS中的源文件构建生成
add_executable(jian ${DIR_SRCS})

# 设置依赖的共享库
target_link_libraries(jian fileA)