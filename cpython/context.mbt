// context

///|
pub extern "C" fn py_context_new() -> PyObjectRef = "PyContext_New"

///|
#owned(a)
pub extern "C" fn py_context_copy(a : PyObjectRef) -> PyObjectRef = "PyContext_Copy"

///|
pub extern "C" fn py_context_copy_current() -> PyObjectRef = "PyContext_CopyCurrent"

///|
#owned(a)
pub extern "C" fn py_context_enter(a : PyObjectRef) -> Int = "PyContext_Enter"

///|
#owned(a)
pub extern "C" fn py_context_exit(a : PyObjectRef) -> Int = "PyContext_Exit"

///|
#owned(name, default_value)
pub extern "C" fn py_context_var_new(
  name : CStr,
  default_value : PyObjectRef,
) -> PyObjectRef = "PyContextVar_New"

///|
#owned(pyvar, default_value, value)
pub extern "C" fn py_context_var_get(
  pyvar : PyObjectRef,
  default_value : PyObjectRef,
  value : ArrayPyObjectRef,
) -> Int = "PyContextVar_Get"

///|
#owned(pyvar, value)
pub extern "C" fn py_context_var_set(
  pyvar : PyObjectRef,
  value : PyObjectRef,
) -> PyObjectRef = "PyContextVar_Set"

///|
#owned(pyvar, token)
pub extern "C" fn py_context_var_reset(
  pyvar : PyObjectRef,
  token : PyObjectRef,
) -> Int = "PyContextVar_Reset"

///|
pub extern "C" fn _py_context_new_hamt_for_tests() -> PyObjectRef = "_PyContext_NewHamtForTests"

///|
pub extern "C" fn py_context_clear_free_list() -> Int = "PyContext_ClearFreeList"
