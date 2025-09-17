// dict

///|
pub extern "C" fn py_dict_new() -> PyObjectRef = "PyDict_New"

///|
#owned(dict, key)
pub extern "C" fn py_dict_get_item(
  dict : PyObjectRef,
  key : PyObjectRef,
) -> PyObjectRef = "PyDict_GetItem"

///|
#owned(dict, key, item)
pub extern "C" fn py_dict_set_item(
  dict : PyObjectRef,
  key : PyObjectRef,
  item : PyObjectRef,
) -> Int = "PyDict_SetItem"

///|
#owned(dict, key)
pub extern "C" fn py_dict_del_item(
  dict : PyObjectRef,
  key : PyObjectRef,
) -> Int = "PyDict_DelItem"

///|
#owned(dict)
pub extern "C" fn py_dict_clear(dict : PyObjectRef) = "PyDict_Clear"

// PyAPI_FUNC(int) py_dict_Next(
//     PyObject *mp, Py_ssize_t *pos, PyObject **key, PyObject **value);

///|
#owned(dict)
pub extern "C" fn py_dict_keys(dict : PyObjectRef) -> PyObjectRef = "PyDict_Keys"

///|
#owned(dict)
pub extern "C" fn py_dict_values(dict : PyObjectRef) -> PyObjectRef = "PyDict_Values"

///|
#owned(dict)
pub extern "C" fn py_dict_items(dict : PyObjectRef) -> PyObjectRef = "PyDict_Items"

///|
#owned(dict)
pub extern "C" fn py_dict_size(dict : PyObjectRef) -> UInt64 = "PyDict_Size"

///|
#owned(dict)
pub extern "C" fn py_dict_copy(dict : PyObjectRef) -> PyObjectRef = "PyDict_Copy"

///|
#owned(dict, key)
pub extern "C" fn __py_dict_contains(
  dict : PyObjectRef,
  key : PyObjectRef,
) -> Int = "PyDict_Contains"

///|
pub fn py_dict_contains(dict : PyObjectRef, key : PyObjectRef) -> Bool {
  __py_dict_contains(dict, key) != 0
}

///|
#owned(dict, other)
pub extern "C" fn py_dict_update(
  dict : PyObjectRef,
  other : PyObjectRef,
) -> Int = "PyDict_Update"

///|
#owned(dict, other)
pub extern "C" fn py_dict_merge(
  dict : PyObjectRef,
  other : PyObjectRef,
  _override : Int,
) -> Int = "PyDict_Merge"

///|
#owned(dict, seq2)
pub extern "C" fn py_dict_merge_from_seq2(
  dict : PyObjectRef,
  seq2 : PyObjectRef,
  override_ : Int,
) -> Int = "PyDict_MergeFromSeq2"

///|
#owned(dict, key)
extern "C" fn __py_dict_get_item_string(
  dict : PyObjectRef,
  key : CStr,
) -> PyObjectRef = "PyDict_GetItemString"

///|
pub fn py_dict_get_item_string(dict : PyObjectRef, key : String) -> PyObjectRef {
  let key = CStr::from(key)
  __py_dict_get_item_string(dict, key)
}

///|
#owned(dict, key, item)
extern "C" fn __py_dict_set_item_string(
  dict : PyObjectRef,
  key : CStr,
  item : PyObjectRef,
) -> Int = "PyDict_SetItemString"

///|
pub fn py_dict_set_item_string(
  dict : PyObjectRef,
  key : String,
  item : PyObjectRef,
) -> Int {
  let key = CStr::from(key)
  __py_dict_set_item_string(dict, key, item)
}

///|
#owned(dict, key)
extern "C" fn __py_dict_del_item_string(dict : PyObjectRef, key : CStr) -> Int = "PyDict_DelItemString"

///|
pub fn py_dict_del_item_string(dict : PyObjectRef, key : String) -> Int {
  let key = CStr::from(key)
  __py_dict_del_item_string(dict, key)
}
