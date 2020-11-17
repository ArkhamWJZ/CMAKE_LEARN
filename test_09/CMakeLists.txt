cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(Test)

macro(_bar)
  message(STATUS "this is in macro bar " ${ARGN})
  message(STATUS "this is in macro bar " ${ARGC})
  message(STATUS "this is in macro bar " ${ARGV})
  
  set(aa ${ARGV0})
  if(ARGV0)
     message(STATUS "this is in a 1")
  endif()

  if(aa)
  message(STATUS "this is in a 2 " ${aa})
  endif()
  
  set(list_var ${ARGN})

  foreach(arg IN LISTS ARGN)
    message(STATUS "this is in macro 2 ${arg}")
  endforeach()

  foreach(arg ${ARGN})
    message(STATUS "this is in macro 3 ${arg}")
  endforeach()

  foreach(arg IN LISTS list_var)
    message(STATUS "this is in macro 4 ${arg}")
  endforeach()
endmacro(_bar)



message(STATUS "\n")
_bar(a b c)



function(_func)
  message(STATUS "this is in func __func " ${ARGN})
  
  set(aa ${ARGV0})
  if(ARGV0)
    message(STATUS "this is in a 1 " ${ARGV0})
  endif()
  if(aa)
    message(STATUS "this is in a 2 " ${aa})
  endif()
  
  set(list_var ${ARGN})

  foreach(arg IN LISTS ARGN)
    message(STATUS "this is in __func 2 ${arg}")
  endforeach()

  foreach(arg ${ARGN})
    message(STATUS "this is in __func 3 ${arg}")
  endforeach()

  foreach(arg IN LISTS list_var)
    message(STATUS "this is in __func 4 ${arg}")
  endforeach()
endfunction(_func)

message(STATUS "\n")
_func(d e f)