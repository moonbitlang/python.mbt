///|
pub extern "C" fn py_object_repr(a : PyObjectRef) -> PyObjectRef = "PyObject_Repr"

///|
pub extern "C" fn py_object_str(a : PyObjectRef) -> PyObjectRef = "PyObject_Str"

///|
pub extern "C" fn py_object_ascii(a : PyObjectRef) -> PyObjectRef = "PyObject_ASCII"

///|
pub extern "C" fn py_object_bytes(a : PyObjectRef) -> PyObjectRef = "PyObject_Bytes"

///|
pub extern "C" fn py_object_rich_compare(
  a : PyObjectRef,
  b : PyObjectRef,
  c : Int,
) -> PyObjectRef = "PyObject_RichCompare"

///|
pub extern "C" fn py_object_rich_compare_bool(
  a : PyObjectRef,
  b : PyObjectRef,
  c : Int,
) -> Int = "PyObject_RichCompareBool"

///|
extern "C" fn __py_object_get_attr_string(
  a : PyObjectRef,
  b : Bytes,
) -> PyObjectRef = "PyObject_GetAttrString"

///|
pub fn py_object_get_attr_string(a : PyObjectRef, b : String) -> PyObjectRef {
  let b = ToCStr::to_cstr(b)
  __py_object_get_attr_string(a, b)
}

///|
extern "C" fn __py_object_set_attr_string(
  a : PyObjectRef,
  b : Bytes,
  c : PyObjectRef,
) -> Int = "PyObject_SetAttrString"

///|
pub fn py_object_set_attr_string(
  a : PyObjectRef,
  b : String,
  c : PyObjectRef,
) -> Int {
  let b = ToCStr::to_cstr(b)
  __py_object_set_attr_string(a, b, c)
}

///|
extern "C" fn __py_object_has_attr_string(a : PyObjectRef, b : Bytes) -> Int = "PyObject_HasAttrString"

///|
pub fn py_object_has_attr_string(a : PyObjectRef, b : String) -> Int {
  let b = ToCStr::to_cstr(b)
  __py_object_has_attr_string(a, b)
}

///|
pub extern "C" fn py_object_get_attr(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyObject_GetAttr"

///|
pub extern "C" fn py_object_set_attr(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> Int = "PyObject_SetAttr"

///|
pub extern "C" fn py_object_has_attr(a : PyObjectRef, b : PyObjectRef) -> Int = "PyObject_HasAttr"

///|
pub extern "C" fn py_object_self_iter(a : PyObjectRef) -> PyObjectRef = "PyObject_SelfIter"

///|
pub extern "C" fn py_object_generic_get_attr(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyObject_GenericGetAttr"

///|
pub extern "C" fn py_object_generic_set_attr(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> Int = "PyObject_GenericSetAttr"

// pub extern "C" fn py_object_hash(a: PyObjectRef) -> Py_hash_t = "PyObject_Hash"
// pub extern "C" fn py_object_hash_not_implemented(a: PyObjectRef) -> Py_hash_t = "PyObject_HashNotImplemented"

///|
extern "C" fn __py_object_is_true(a : PyObjectRef) -> Int = "PyObject_IsTrue"

///|
pub fn py_object_is_true(a : PyObjectRef) -> Bool {
  __py_object_is_true(a) != 0
}

///|
pub extern "C" fn py_object_not(a : PyObjectRef) -> Int = "PyObject_Not"

///|
pub extern "C" fn py_object_clear_weak_refs(a : PyObjectRef) = "PyObject_ClearWeakRefs"

///|
pub extern "C" fn py_object_dir(a : PyObjectRef) -> PyObjectRef = "PyObject_Dir"

///|
pub extern "C" fn py_repr_enter(a : PyObjectRef) -> Int = "Py_ReprEnter"

///|
pub extern "C" fn py_repr_leave(a : PyObjectRef) = "Py_ReprLeave"

///|
pub extern "C" fn py_type(obj : PyObjectRef) -> PyTypeObjectRef = "py_type"

///|
extern "C" fn __py_type_name(t : PyTypeObjectRef) -> CStr = "_PyType_Name"

///|
pub fn py_type_name(t : PyTypeObjectRef) -> String {
  let cstr = __py_type_name(t)
  cstr.to_string()
}

///|
extern "C" fn __py_tuple_check(obj : PyObjectRef) -> Int = "py_tuple_check"

///|
pub fn py_tuple_check(obj : PyObjectRef) -> Bool {
  __py_tuple_check(obj) != 0
}

///|
extern "C" fn __py_list_check(obj : PyObjectRef) -> Int = "py_list_check"

///|
pub fn py_list_check(obj : PyObjectRef) -> Bool {
  __py_list_check(obj) != 0
}

///|
pub fn PyObjectRef::is_list(self : PyObjectRef) -> Bool {
  __py_list_check(self) != 0
}

///|
extern "C" fn __py_dict_check(obj : PyObjectRef) -> Int = "py_dict_check"

///|
pub fn py_dict_check(obj : PyObjectRef) -> Bool {
  __py_dict_check(obj) != 0
}

///|
pub fn PyObjectRef::is_dict(self : PyObjectRef) -> Bool {
  __py_dict_check(self) != 0
}

///|
extern "C" fn __py_set_check(obj : PyObjectRef) -> Int = "py_set_check"

///|
pub fn py_set_check(obj : PyObjectRef) -> Bool {
  __py_set_check(obj) != 0
}

///|
pub fn PyObjectRef::is_set(self : PyObjectRef) -> Bool {
  __py_set_check(self) != 0
}

///|
extern "C" fn __py_int_check(obj : PyObjectRef) -> Int = "py_int_check"

///|
pub fn py_int_check(obj : PyObjectRef) -> Bool {
  __py_int_check(obj) != 0
}

///|
pub fn PyObjectRef::is_int(self : PyObjectRef) -> Bool {
  __py_int_check(self) != 0
}

///|
extern "C" fn __py_float_check(obj : PyObjectRef) -> Int = "py_float_check"

///|
pub fn py_float_check(obj : PyObjectRef) -> Bool {
  __py_float_check(obj) != 0
}

///|
pub fn PyObjectRef::is_float(self : PyObjectRef) -> Bool {
  __py_float_check(self) != 0
}

///|
extern "C" fn __py_string_check(obj : PyObjectRef) -> Int = "py_string_check"

///|
pub fn py_string_check(obj : PyObjectRef) -> Bool {
  __py_string_check(obj) != 0
}

///|
pub fn PyObjectRef::is_string(self : PyObjectRef) -> Bool {
  __py_string_check(self) != 0
}

///|
extern "C" fn __py_bool_check(obj : PyObjectRef) -> Int = "py_bool_check"

///|
pub fn py_bool_check(obj : PyObjectRef) -> Bool {
  __py_bool_check(obj) != 0
}

///|
pub fn PyObjectRef::is_bool(self : PyObjectRef) -> Bool {
  __py_bool_check(self) != 0
}

///|
extern "C" fn __py_module_check(obj : PyObjectRef) -> Int = "py_module_check"

///|
pub fn py_module_check(obj : PyObjectRef) -> Bool {
  __py_module_check(obj) != 0
}

///|
pub fn PyObjectRef::is_module(self : PyObjectRef) -> Bool {
  __py_module_check(self) != 0
}

///|
extern "C" fn __py_function_check(f : PyObjectRef) -> Int = "py_function_check"

///|
pub fn py_function_check(f : PyObjectRef) -> Bool {
  __py_function_check(f) != 0
}

///|
pub fn PyObjectRef::is_function(self : PyObjectRef) -> Bool {
  __py_function_check(self) != 0
}

///|
pub extern "C" fn __py_callable_check(a : PyObjectRef) -> Int = "PyCallable_Check"

///|
pub fn py_callable_check(a : PyObjectRef) -> Bool {
  __py_callable_check(a) != 0
}

///|
pub fn PyObjectRef::is_callable(self : PyObjectRef) -> Bool {
  __py_callable_check(self) != 0
}

///|
extern "C" fn __py_none_check(obj : PyObjectRef) -> Int = "py_none_check"

///|
pub fn py_none_check(obj : PyObjectRef) -> Bool {
  __py_none_check(obj) != 0
}
