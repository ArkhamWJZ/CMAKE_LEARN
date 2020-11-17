# 遍历当前路径下的所有源文件，并将其添加到变量DIR_SRCS中
# 使用c++11标准
set_cxx_norm(${CXX_NORM_CXX11})
aux_source_directory(. DIR_SRCS)
 
# 添加名为cmake_test3的可执行文件，该文件会由变量DIR_SRCS中的源文件构建生成
add_executable(cmake_test3 ${DIR_SRCS})