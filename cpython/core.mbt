///|
type CStr // const char*

///|
type CWStr // const wchar_t*

///|
type PyObjectRef // PyObject*

///|
type PyThreadStateRef // PyThreadState*

///|
type PyCodeObjectRef // PyCodeObject*

///|
type ArrayPyObjectRef // PyObject*[]

///|
type PyTypeObjectRef

///|
#borrow(s)
extern "C" fn moonbit_str_to_c_str(s : String) -> CStr = "moonbit_str_to_c_str"

///|
#owned(s)
extern "C" fn c_str_to_moonbit_str(s : CStr) -> String = "c_str_to_moonbit_str"

///|
#owned(s)
extern "C" fn c_str_to_moonbit_str_with_length(s : CStr, len : UInt) -> String = "c_str_to_moonbit_str_with_length"

///|
//extern "C" fn moonbit_str_to_cw_str(s : String) -> CWStr = "moonbit_str_to_cw_str"

///|
//extern "C" fn cw_str_to_moonbit_str(s : CWStr) -> String = "cw_str_to_moonbit_str"

///|
//extern "C" fn cw_str_to_moonbit_str_with_length(
//  s : CWStr,
//  len : UInt
//) -> String = "cw_str_to_moonbit_str_with_length"

///|
fn CStr::from(s : String) -> CStr {
  moonbit_str_to_c_str(s)
}

///|
fn CStr::to_string(self : CStr) -> String {
  c_str_to_moonbit_str(self)
}

///|
fn CStr::to_string_with_length(self : CStr, len : UInt) -> String {
  c_str_to_moonbit_str_with_length(self, len)
}

///|
test {
  ignore(CStr::to_string_with_length)
  //ignore(CWStr::from)
}

///|
//fn CWStr::from(s : String) -> CWStr {
//  moonbit_str_to_cw_str(s)
//}

///|
//fn CWStr::to_string(self : CWStr) -> String {
//  cw_str_to_moonbit_str(self)
//}
//
/////|
//fn CWStr::to_string_with_length(self : CWStr, len : UInt) -> String {
//  cw_str_to_moonbit_str_with_length(self, len)
//}

///|
//test {
//  ignore(CWStr::to_string_with_length)
//  ignore(CWStr::to_string)
//}

///|
#owned(obj)
extern "C" fn py_object_is_null(obj : PyObjectRef) -> Int = "Moonbit_PyObjectRef_is_null"

///|
pub fn PyObjectRef::is_null(self : PyObjectRef) -> Bool {
  py_object_is_null(self) != 0
}

///|
#owned(obj)
pub extern "C" fn print_pyobject(obj : PyObjectRef) = "print_pyobject"

///|
pub fn PyObjectRef::dump(self : PyObjectRef) -> Unit {
  print_pyobject(self)
}

///|
#owned(obj)
pub extern "C" fn py_incref(obj : PyObjectRef) = "py_incref"

///|
#owned(obj)
pub extern "C" fn py_decref(obj : PyObjectRef) = "py_decref"
