// Module

///|
pub extern "C" fn py_module_new_object(name : PyObjectRef) -> PyObjectRef = "PyModule_NewObject"

///|
pub extern "C" fn py_module_new(name : CStr) -> PyObjectRef = "PyModule_New"

///|
pub extern "C" fn py_module_get_dict(a : PyObjectRef) -> PyObjectRef = "PyModule_GetDict"

///|
pub extern "C" fn py_module_get_name_object(a : PyObjectRef) -> PyObjectRef = "PyModule_GetNameObject"

///|
pub extern "C" fn py_module_get_name(a : PyObjectRef) -> CStr = "PyModule_GetName"

///|
pub extern "C" fn py_module_get_filename_object(a : PyObjectRef) -> PyObjectRef = "PyModule_GetFilenameObject"
