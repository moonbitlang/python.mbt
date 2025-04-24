// Set
///|
pub extern "C" fn py_set_new(a : PyObjectRef) -> PyObjectRef = "PySet_New"

///|
pub extern "C" fn py_frozen_set_new(a : PyObjectRef) -> PyObjectRef = "PyFrozenSet_New"

///|
pub extern "C" fn py_set_add(set : PyObjectRef, key : PyObjectRef) -> Int = "PySet_Add"

///|
pub extern "C" fn py_set_clear(set : PyObjectRef) -> Int = "PySet_Clear"

///|
pub extern "C" fn py_set_contains(
  anyset : PyObjectRef,
  key : PyObjectRef
) -> Int = "PySet_Contains"

///|
pub extern "C" fn py_set_discard(set : PyObjectRef, key : PyObjectRef) -> Int = "PySet_Discard"

///|
pub extern "C" fn py_set_pop(set : PyObjectRef) -> PyObjectRef = "PySet_Pop"

///|
pub extern "C" fn py_set_size(anyset : PyObjectRef) -> Int64 = "PySet_Size"
