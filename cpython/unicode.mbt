// Unicode
///|
pub extern "C" fn py_unicode_from_unicode(
  u : CWStr,
  size : UInt64
) -> PyObjectRef = "PyUnicode_FromStringAndSize"

///|
pub extern "C" fn py_unicode_from_string_and_size(
  u : CStr,
  size : UInt64
) -> PyObjectRef = "PyUnicode_FromStringAndSize"

///|
extern "C" fn __py_unicode_from_string(u : CStr) -> PyObjectRef = "PyUnicode_FromString"

///|
pub fn py_unicode_from_string(s : String) -> PyObjectRef {
  let u = CStr::from(s)
  __py_unicode_from_string(u)
}

// PyAPI_FUNC(const char *) PyUnicode_AsUTF8(PyObject *unicode);
///|
extern "C" fn __py_unicode_as_utf8(u : PyObjectRef) -> CStr = "PyUnicode_AsUTF8"

///|
pub fn py_unicode_as_utf8(u : PyObjectRef) -> String {
  let cstr = __py_unicode_as_utf8(u)
  cstr.to_string()
}
