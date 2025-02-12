// List
pub extern "C" fn py_list_new(sz: UInt64) -> PyObjectRef = "PyList_New"

pub extern "C" fn py_list_size(list: PyObjectRef) -> UInt64 = "PyList_Size"

pub extern "C" fn py_list_set_item(list: PyObjectRef, idx: UInt64, item: PyObjectRef) -> Int = "PyList_SetItem"

pub extern "C" fn py_list_insert(list: PyObjectRef, idx: UInt64, item: PyObjectRef) -> Int = "PyList_Insert"

pub extern "C" fn py_list_append(list: PyObjectRef, item: PyObjectRef) -> Int = "PyList_Append"

pub extern "C" fn py_list_get_slice(list: PyObjectRef, start: UInt64, end: UInt64) -> PyObjectRef = "PyList_GetSlice"

pub extern "C" fn py_list_set_slice(list: PyObjectRef, start: UInt64, end: UInt64, new_list: PyObjectRef) -> Int = "PyList_SetSlice"

pub extern "C" fn py_list_sort(list: PyObjectRef) -> Int = "PyList_Sort"

pub extern "C" fn py_list_reverse(list: PyObjectRef) -> Int = "PyList_Reverse"

pub extern "C" fn py_list_as_tuple(list: PyObjectRef) -> PyObjectRef = "PyList_AsTuple"

