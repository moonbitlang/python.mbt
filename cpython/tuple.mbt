// Tuple

///|
pub extern "C" fn pytuple_new(sz : UInt64) -> PyObjectRef = "PyTuple_New"

///|
pub extern "C" fn pytuple_size(tuple : PyObjectRef) -> UInt64 = "PyTuple_Size"

///|
pub extern "C" fn pytuple_get_item(
  tuple : PyObjectRef,
  idx : UInt64,
) -> PyObjectRef = "PyTuple_GetItem"

///|
pub extern "C" fn pytuple_set_item(
  tuple : PyObjectRef,
  idx : UInt64,
  item : PyObjectRef,
) -> Int = "PyTuple_SetItem"

///|
pub extern "C" fn pytuple_get_slice(
  tuple : PyObjectRef,
  start : UInt64,
  end : UInt64,
) -> PyObjectRef = "PyTuple_GetSlice"

// PyAPI_FUNC(PyObject *) PyTuple_Pack(Py_ssize_t, ...);
