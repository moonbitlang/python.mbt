
type CStr
type PyObjectRef // PyObject*

extern "C" fn moonbit_str_to_c_str(
  s: String
) -> CStr = "moonbit_str_to_c_str"
extern "C" fn c_str_to_moonbit_str(
  s: CStr
) -> String = "c_str_to_moonbit_str"
extern "C" fn c_str_to_moonbit_str_with_length(
  s: CStr,
  len: UInt
) -> String = "c_str_to_moonbit_str_with_length"

fn CStr::from(s: String) -> CStr {
  moonbit_str_to_c_str(s)
}

fn CStr::to_string(self: CStr) -> String {
  c_str_to_moonbit_str(self)
}

fn CStr::to_string_with_length(self: CStr, len: UInt) -> String {
  c_str_to_moonbit_str_with_length(self, len)
}

pub extern "C" fn py_init() = "Py_Initialize"
pub extern "C" fn py_finalize() = "Py_Finalize"

extern "C" fn __py_is_initialized() -> Int = "Py_IsInitialized"

pub fn py_is_initialized() -> Bool {
    __py_is_initialized() != 0
}

pub extern "C" fn print_pyobject(obj: PyObjectRef) = "print_pyobject"

pub extern "C" fn py_incref(obj: PyObjectRef) = "py_incref"
pub extern "C" fn py_decref(obj: PyObjectRef) = "py_decref"
