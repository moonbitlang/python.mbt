// Module
extern "C" fn __py_module_check(obj: PyObjectRef) -> Int = "py_module_check"
pub fn py_module_check(obj: PyObjectRef) -> Bool {
  __py_module_check(obj) != 0
}
pub extern "C" fn py_module_new_object(name: PyObjectRef) -> PyObjectRef = "PyModule_NewObject"
pub extern "C" fn py_module_new(name: CStr) -> PyObjectRef = "PyModule_New"
pub extern "C" fn py_module_get_dict(a: PyObjectRef) -> PyObjectRef = "PyModule_GetDict"
pub extern "C" fn py_module_get_name_object(a: PyObjectRef) -> PyObjectRef = "PyModule_GetNameObject"
pub extern "C" fn py_module_get_name(a: PyObjectRef) -> CStr = "PyModule_GetName"
pub extern "C" fn py_module_get_filename_object(a: PyObjectRef) -> PyObjectRef = "PyModule_GetFilenameObject"
