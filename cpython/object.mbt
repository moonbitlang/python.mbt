// PyObjectRef  PyObject_Repr(PyObjectRef );
// PyObjectRef  PyObject_Str(PyObjectRef );
// PyObjectRef  PyObject_ASCII(PyObjectRef );
// PyObjectRef  PyObject_Bytes(PyObjectRef );
// PyObjectRef  PyObject_RichCompare(PyObjectRef , PyObjectRef , int);
// int PyObject_RichCompareBool(PyObjectRef , PyObjectRef , int);
// PyObjectRef  PyObject_GetAttrString(PyObjectRef , CStr );
// int PyObject_SetAttrString(PyObjectRef , CStr , PyObjectRef );
// int PyObject_HasAttrString(PyObjectRef , CStr );
// PyObjectRef  PyObject_GetAttr(PyObjectRef , PyObjectRef );
// int PyObject_SetAttr(PyObjectRef , PyObjectRef , PyObjectRef );
// int PyObject_HasAttr(PyObjectRef , PyObjectRef );
// PyObjectRef  PyObject_SelfIter(PyObjectRef );
// PyObjectRef  PyObject_GenericGetAttr(PyObjectRef , PyObjectRef );
// int PyObject_GenericSetAttr(PyObjectRef ,
//                                               PyObjectRef , PyObjectRef );
//
// Py_hash_t PyObject_Hash(PyObjectRef );
// Py_hash_t PyObject_HashNotImplemented(PyObjectRef );
// int PyObject_IsTrue(PyObjectRef );
// int PyObject_Not(PyObjectRef );
// int PyCallable_Check(PyObjectRef );
// void PyObject_ClearWeakRefs(PyObjectRef );
//
// PyObjectRef  PyObject_Dir(PyObjectRef );
//
//
//
// int Py_ReprEnter(PyObjectRef );
// void Py_ReprLeave(PyObjectRef );

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
pub extern "C" fn py_object_is_true(a: PyObjectRef) -> Int = "PyObject_IsTrue"
pub extern "C" fn py_object_not(a: PyObjectRef) -> Int = "PyObject_Not"
pub extern "C" fn py_callable_check(a: PyObjectRef) -> Int = "PyCallable_Check"
pub extern "C" fn py_object_clear_weak_refs(a: PyObjectRef) = "PyObject_ClearWeakRefs"
pub extern "C" fn py_object_dir(a: PyObjectRef) -> PyObjectRef = "PyObject_Dir"
pub extern "C" fn py_repr_enter(a: PyObjectRef) -> Int = "Py_ReprEnter"
pub extern "C" fn py_repr_leave(a: PyObjectRef) = "Py_ReprLeave"
