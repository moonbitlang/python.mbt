
pub extern "C" fn py_object_repr(a: PyObjectRef) -> PyObjectRef = "PyObject_Repr"
pub extern "C" fn py_object_str(a: PyObjectRef) -> PyObjectRef = "PyObject_Str"
pub extern "C" fn py_object_ascii(a: PyObjectRef) -> PyObjectRef = "PyObject_ASCII"
pub extern "C" fn py_object_bytes(a: PyObjectRef) -> PyObjectRef = "PyObject_Bytes"
pub extern "C" fn py_object_rich_compare(a: PyObjectRef, b: PyObjectRef, c: Int) -> PyObjectRef = "PyObject_RichCompare"
pub extern "C" fn py_object_rich_compare_bool(a: PyObjectRef, b: PyObjectRef, c: Int) -> Int = "PyObject_RichCompareBool"
extern "C" fn __py_object_get_attr_string(a: PyObjectRef, b: CStr) -> PyObjectRef = "PyObject_GetAttrString"
pub fn py_object_get_attr_string(a: PyObjectRef, b: String) -> PyObjectRef {
  let b = CStr::from(b)
  __py_object_get_attr_string(a, b)
}

extern "C" fn __py_object_set_attr_string(a: PyObjectRef, b: CStr, c: PyObjectRef) -> Int = "PyObject_SetAttrString"
pub fn py_object_set_attr_string(a: PyObjectRef, b: String, c: PyObjectRef) -> Int {
  let b = CStr::from(b)
  __py_object_set_attr_string(a, b, c)
}

extern "C" fn __py_object_has_attr_string(a: PyObjectRef, b: CStr) -> Int = "PyObject_HasAttrString"
pub fn py_object_has_attr_string(a: PyObjectRef, b: String) -> Int {
  let b = CStr::from(b)
  __py_object_has_attr_string(a, b)
}

pub extern "C" fn py_object_get_attr(a: PyObjectRef, b: PyObjectRef) -> PyObjectRef = "PyObject_GetAttr"
pub extern "C" fn py_object_set_attr(a: PyObjectRef, b: PyObjectRef, c: PyObjectRef) -> Int = "PyObject_SetAttr"
pub extern "C" fn py_object_has_attr(a: PyObjectRef, b: PyObjectRef) -> Int = "PyObject_HasAttr"
pub extern "C" fn py_object_self_iter(a: PyObjectRef) -> PyObjectRef = "PyObject_SelfIter"
pub extern "C" fn py_object_generic_get_attr(a: PyObjectRef, b: PyObjectRef) -> PyObjectRef = "PyObject_GenericGetAttr"
pub extern "C" fn py_object_generic_set_attr(a: PyObjectRef, b: PyObjectRef, c: PyObjectRef) -> Int = "PyObject_GenericSetAttr"
// pub extern "C" fn py_object_hash(a: PyObjectRef) -> Py_hash_t = "PyObject_Hash"
// pub extern "C" fn py_object_hash_not_implemented(a: PyObjectRef) -> Py_hash_t = "PyObject_HashNotImplemented"
extern "C" fn __py_object_is_true(a: PyObjectRef) -> Int = "PyObject_IsTrue"
pub fn py_object_is_true(a: PyObjectRef) -> Bool {
  __py_object_is_true(a) != 0
}
pub extern "C" fn py_object_not(a: PyObjectRef) -> Int = "PyObject_Not"
pub extern "C" fn __py_callable_check(a: PyObjectRef) -> Int = "PyCallable_Check"
pub fn py_callable_check(a: PyObjectRef) -> Bool {
  __py_callable_check(a) != 0
}
pub extern "C" fn py_object_clear_weak_refs(a: PyObjectRef) = "PyObject_ClearWeakRefs"
pub extern "C" fn py_object_dir(a: PyObjectRef) -> PyObjectRef = "PyObject_Dir"
pub extern "C" fn py_repr_enter(a: PyObjectRef) -> Int = "Py_ReprEnter"
pub extern "C" fn py_repr_leave(a: PyObjectRef) = "Py_ReprLeave"


pub extern "C" fn py_type(obj: PyObjectRef) -> PyTypeObjectRef = "py_type"

extern "C" fn __py_type_name(t: PyTypeObjectRef) -> CStr = "_PyType_Name"
pub fn py_type_name(t: PyTypeObjectRef) -> String {
  let cstr = __py_type_name(t)
  cstr.to_string()
}

extern "C" fn __py_object_is_tuple(obj: PyObjectRef) -> Int = "py_tuple_check"
pub fn py_object_is_tuple(obj: PyObjectRef) -> Bool {
  __py_object_is_tuple(obj) != 0
}

extern "C" fn __py_object_is_list(obj: PyObjectRef) -> Int = "py_list_check"
pub fn py_object_is_list(obj: PyObjectRef) -> Bool {
  __py_object_is_list(obj) != 0
}

extern "C" fn __py_object_is_dict(obj: PyObjectRef) -> Int = "py_dict_check"
pub fn py_object_is_dict(obj: PyObjectRef) -> Bool {
  __py_object_is_dict(obj) != 0
}

extern "C" fn __py_object_is_set(obj: PyObjectRef) -> Int = "py_set_check"
pub fn py_object_is_set(obj: PyObjectRef) -> Bool {
  __py_object_is_set(obj) != 0
}

extern "C" fn __py_object_is_int(obj: PyObjectRef) -> Int = "py_int_check"
pub fn py_object_is_int(obj: PyObjectRef) -> Bool {
  __py_object_is_int(obj) != 0
}

extern "C" fn __py_object_is_float(obj: PyObjectRef) -> Int = "py_float_check"
pub fn py_object_is_float(obj: PyObjectRef) -> Bool {
  __py_object_is_float(obj) != 0
}

extern "C" fn __py_object_is_string(obj: PyObjectRef) -> Int = "py_string_check"
pub fn py_object_is_string(obj: PyObjectRef) -> Bool {
  __py_object_is_string(obj) != 0
}

extern "C" fn __py_object_is_bool(obj: PyObjectRef) -> Int = "py_bool_check"
pub fn py_object_is_bool(obj: PyObjectRef) -> Bool {
  __py_object_is_bool(obj) != 0
}
