// Unicode
pub extern "C" fn pyunicode_from_unicode(u: CWStr, size: UInt64) -> PyObjectRef = "PyUnicode_FromStringAndSize"
pub extern "C" fn pyunicode_from_string_and_size(u: CStr, size: UInt64) -> PyObjectRef = "PyUnicode_FromStringAndSize"
pub extern "C" fn pyunicode_from_string(u: CStr) -> PyObjectRef = "PyUnicode_FromString"

