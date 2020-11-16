cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project (JZZ_Test VERSION 1.2.3.4)

function(PrintVar var)
	message(STATUS "${var}: ${${var}}")
endfunction()

set(data 1 2 3 4 5 a 6 b 7)
list(FILTER data
  INCLUDE
  REGEX "[0-9]")
PrintVar(data)

set(data 1 2 3 4 5 a 6 b 7)
list(FILTER data
  EXCLUDE
  REGEX "[0-9]")
PrintVar(data)