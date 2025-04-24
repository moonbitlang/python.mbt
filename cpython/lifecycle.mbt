///|
pub extern "C" fn py_init() = "Py_Initialize"

///|
pub extern "C" fn py_finalize() = "Py_Finalize"

///|
extern "C" fn __py_is_initialized() -> Int = "Py_IsInitialized"

///|
pub fn py_is_initialized() -> Bool {
  __py_is_initialized() != 0
}
