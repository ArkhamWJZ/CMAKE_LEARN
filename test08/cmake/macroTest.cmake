
macro(Moo arg)
  message("=== Call macro ===")
  message("arg = ${arg}")
  set(arg "abc")
  message("# After change the value of arg.")
  message("arg = ${arg}")
endmacro()
