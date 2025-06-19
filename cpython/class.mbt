// class

///|
pub extern "C" fn py_method_new(
  a : PyObjectRef,
  b : PyObjectRef
) -> PyObjectRef = "PyMethod_New"

///|
pub extern "C" fn py_method_function(a : PyObjectRef) -> PyObjectRef = "PyMethod_Function"

///|
pub extern "C" fn py_method_self(a : PyObjectRef) -> PyObjectRef = "PyMethod_Self"

///|
pub extern "C" fn py_method_clear_free_list() -> Int = "PyMethod_ClearFreeList"

///|
pub extern "C" fn py_instance_method_new(a : PyObjectRef) -> PyObjectRef = "PyInstanceMethod_New"

///|
pub extern "C" fn py_instance_method_function(a : PyObjectRef) -> PyObjectRef = "PyInstanceMethod_Function"
