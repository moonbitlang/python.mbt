
// File
pub extern "C" fn py_file_from_fd(fd: Int, name: CStr, mode: CStr, closefd: Int, encoding: CStr, errors: CStr, newline: CStr, line_buffering: Int) -> PyObjectRef = "PyFile_FromFd"
pub extern "C" fn py_file_get_line(a: PyObjectRef, b: Int) -> PyObjectRef = "PyFile_GetLine"
pub extern "C" fn py_file_write_object(a: PyObjectRef, b: PyObjectRef, c: Int) -> Int = "PyFile_WriteObject"
pub extern "C" fn py_file_write_string(s: CStr, a: PyObjectRef) -> Int = "PyFile_WriteString"
pub extern "C" fn py_object_as_file_descriptor(a: PyObjectRef) -> Int = "PyObject_AsFileDescriptor"
pub extern "C" fn py_file_new_std_printer(a: Int) -> PyObjectRef = "PyFile_NewStdPrinter"
pub extern "C" fn py_file_open_code(utf8path: CStr) -> PyObjectRef = "PyFile_OpenCode"
pub extern "C" fn py_file_open_code_object(path: PyObjectRef) -> PyObjectRef = "PyFile_OpenCodeObject"
