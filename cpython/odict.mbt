// ODict

///|
pub extern "C" fn py_odict_new() -> PyObjectRef = "PyODict_New"

///|
#owned(od, key, item)
pub extern "C" fn py_odict_set_item(
  od : PyObjectRef,
  key : PyObjectRef,
  item : PyObjectRef,
) -> Int = "PyODict_SetItem"

///|
#owned(od, key)
pub extern "C" fn py_odict_del_item(od : PyObjectRef, key : PyObjectRef) -> Int = "PyODict_DelItem"
