///|
pub extern "C" fn py_err_occurred() -> PyObjectRef = "PyErr_Occurred"

///|
pub extern "C" fn py_err_clear() = "PyErr_Clear"

///|
pub extern "C" fn py_err_print() = "PyErr_Print"
