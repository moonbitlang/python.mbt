// List

///|
pub extern "C" fn py_list_new(sz : Int64) -> PyObjectRef = "PyList_New"

///|
#owned(list)
pub extern "C" fn py_list_size(list : PyObjectRef) -> Int64 = "PyList_Size"

///|
#owned(list)
pub extern "C" fn py_list_get_item(
  list : PyObjectRef,
  idx : Int64,
) -> PyObjectRef = "PyList_GetItem"

///|
#owned(list, item)
pub extern "C" fn py_list_set_item(
  list : PyObjectRef,
  idx : Int64,
  item : PyObjectRef,
) -> Int = "PyList_SetItem"

///|
#owned(list, item)
pub extern "C" fn py_list_insert(
  list : PyObjectRef,
  idx : Int64,
  item : PyObjectRef,
) -> Int = "PyList_Insert"

///|
#owned(list, item)
pub extern "C" fn py_list_append(list : PyObjectRef, item : PyObjectRef) -> Int = "PyList_Append"

///|
#owned(list)
pub extern "C" fn py_list_get_slice(
  list : PyObjectRef,
  start : Int64,
  end : Int64,
) -> PyObjectRef = "PyList_GetSlice"

///|
#owned(list, new_list)
pub extern "C" fn py_list_set_slice(
  list : PyObjectRef,
  start : Int64,
  end : Int64,
  new_list : PyObjectRef,
) -> Int = "PyList_SetSlice"

///|
#owned(list)
pub extern "C" fn py_list_sort(list : PyObjectRef) -> Int = "PyList_Sort"

///|
#owned(list)
pub extern "C" fn py_list_reverse(list : PyObjectRef) -> Int = "PyList_Reverse"

///|
#owned(list)
pub extern "C" fn py_list_as_tuple(list : PyObjectRef) -> PyObjectRef = "PyList_AsTuple"
