///|
fn[T] unless(cond : Bool, value : () -> T) -> T? {
  if !cond {
    Some(value())
  } else {
    None
  }
}

///|
fn[T] when(cond : Bool, value : () -> T) -> T? {
  if cond {
    Some(value())
  } else {
    None
  }
}

///|
pub fn init_py() -> Unit {
  if not(@cpython.py_is_initialized()) {
    @cpython.py_init()
    if not(@cpython.py_is_initialized()) {
      println("Python initialization failed")
      return
    }
  }
}

///|
fn init {
  init_py()
}

///|
/// elimnate the quotes from a string
///
/// ## Example
///
/// ```moonbit
/// let s = "\'os\'"
/// inspect(@python.strip_quot(s), content="os")
/// ```
pub fn strip_quot(s : String) -> String {
  if s.has_prefix("\'") && s.has_suffix("\'") {
    return s.view(start_offset=1, end_offset=s.length() - 1).to_string()
  }
  s
}
