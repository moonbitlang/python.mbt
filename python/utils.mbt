pub fn init_py() -> Unit {
  if (not(@cpython.py_is_initialized())) {
    @cpython.py_init()

    if (not(@cpython.py_is_initialized())) {
      println("Python initialization failed")
      return 
    }
  }
}

fn init {
  init_py()
}
