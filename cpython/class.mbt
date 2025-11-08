// class

///|
#owned(a, b)
pub extern "C" fn py_method_new(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyMethod_New"

///|
#owned(a)
pub extern "C" fn py_method_function(a : PyObjectRef) -> PyObjectRef = "PyMethod_Function"

///|
#owned(a)
pub extern "C" fn py_method_self(a : PyObjectRef) -> PyObjectRef = "PyMethod_Self"

///|
pub extern "C" fn py_method_clear_free_list() -> Int = "PyMethod_ClearFreeList"

///|
#owned(a)
pub extern "C" fn py_instance_method_new(a : PyObjectRef) -> PyObjectRef = "PyInstanceMethod_New"

///|
#owned(a)
pub extern "C" fn py_instance_method_function(a : PyObjectRef) -> PyObjectRef = "PyInstanceMethod_Function"
