fn main {
  @cpython.py_init()

  if (not(@cpython.py_is_initialized())) {
    println("Python initialization failed")
    return 
  }

  let plist = @cpython.pylist_new(0)

  let a = @cpython.pylong_from_long(42)
  let b = @cpython.pylong_from_long(33)

  let _ = @cpython.pylist_append(plist, a)
  let _ = @cpython.pylist_append(plist, b)

  @cpython.print_pyobject(plist)

  println("")

  @cpython.py_decref(plist)
  @cpython.py_finalize()
}
