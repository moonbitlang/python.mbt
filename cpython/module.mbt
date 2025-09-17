// Module

///|
#owned(name)
pub extern "C" fn py_module_new_object(name : PyObjectRef) -> PyObjectRef = "PyModule_NewObject"

///|
#owned(name)
pub extern "C" fn py_module_new(name : CStr) -> PyObjectRef = "PyModule_New"

///|
#owned(a)
pub extern "C" fn py_module_get_dict(a : PyObjectRef) -> PyObjectRef = "PyModule_GetDict"

///|
#owned(a)
pub extern "C" fn py_module_get_name_object(a : PyObjectRef) -> PyObjectRef = "PyModule_GetNameObject"

///|
#owned(a)
pub extern "C" fn py_module_get_name(a : PyObjectRef) -> CStr = "PyModule_GetName"

///|
#owned(a)
pub extern "C" fn py_module_get_filename_object(a : PyObjectRef) -> PyObjectRef = "PyModule_GetFilenameObject"
