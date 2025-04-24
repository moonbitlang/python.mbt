// context
///|
pub extern "C" fn py_context_new() -> PyObjectRef = "PyContext_New"

///|
pub extern "C" fn py_context_copy(a : PyObjectRef) -> PyObjectRef = "PyContext_Copy"

///|
pub extern "C" fn py_context_copy_current() -> PyObjectRef = "PyContext_CopyCurrent"

///|
pub extern "C" fn py_context_enter(a : PyObjectRef) -> Int = "PyContext_Enter"

///|
pub extern "C" fn py_context_exit(a : PyObjectRef) -> Int = "PyContext_Exit"

///|
pub extern "C" fn py_context_var_new(
  name : CStr,
  default_value : PyObjectRef
) -> PyObjectRef = "PyContextVar_New"

///|
pub extern "C" fn py_context_var_get(
  var : PyObjectRef,
  default_value : PyObjectRef,
  value : ArrayPyObjectRef
) -> Int = "PyContextVar_Get"

///|
pub extern "C" fn py_context_var_set(
  var : PyObjectRef,
  value : PyObjectRef
) -> PyObjectRef = "PyContextVar_Set"

///|
pub extern "C" fn py_context_var_reset(
  var : PyObjectRef,
  token : PyObjectRef
) -> Int = "PyContextVar_Reset"

///|
pub extern "C" fn _py_context_new_hamt_for_tests() -> PyObjectRef = "_PyContext_NewHamtForTests"

///|
pub extern "C" fn py_context_clear_free_list() -> Int = "PyContext_ClearFreeList"
