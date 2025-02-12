fn main {
  @cpython.py_init()

  if (not(@cpython.py_is_initialized())) {
    println("Python initialization failed")
    return 
  }

  let plist = @cpython.py_list_new(0)

  let a = @cpython.py_long_from_long(42)
  let b = @cpython.py_long_from_long(33)

  let _ = @cpython.py_list_append(plist, a)
  let _ = @cpython.py_list_append(plist, b)

  @cpython.print_pyobject(plist)

  println("")

  @cpython.py_decref(plist)
  @cpython.py_finalize()
}
