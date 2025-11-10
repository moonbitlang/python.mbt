// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///|
#owned(a)
pub extern "C" fn py_object_repr(a : PyObjectRef) -> PyObjectRef = "PyObject_Repr"

///|
#owned(a)
pub extern "C" fn py_object_str(a : PyObjectRef) -> PyObjectRef = "PyObject_Str"

///|
#owned(a)
pub extern "C" fn py_object_ascii(a : PyObjectRef) -> PyObjectRef = "PyObject_ASCII"

///|
#owned(a)
pub extern "C" fn py_object_bytes(a : PyObjectRef) -> PyObjectRef = "PyObject_Bytes"

///|
#owned(a, b)
pub extern "C" fn py_object_rich_compare(
  a : PyObjectRef,
  b : PyObjectRef,
  c : Int,
) -> PyObjectRef = "PyObject_RichCompare"

///|
#owned(a, b)
pub extern "C" fn py_object_rich_compare_bool(
  a : PyObjectRef,
  b : PyObjectRef,
  c : Int,
) -> Int = "PyObject_RichCompareBool"

///|
#owned(a)
#borrow(b)
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
#owned(a, c)
#borrow(b)
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
#owned(a)
#borrow(b)
extern "C" fn __py_object_has_attr_string(a : PyObjectRef, b : Bytes) -> Int = "PyObject_HasAttrString"

///|
pub fn py_object_has_attr_string(a : PyObjectRef, b : String) -> Int {
  let b = ToCStr::to_cstr(b)
  __py_object_has_attr_string(a, b)
}

///|
#owned(a, b)
pub extern "C" fn py_object_get_attr(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyObject_GetAttr"

///|
#owned(a, b, c)
pub extern "C" fn py_object_set_attr(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> Int = "PyObject_SetAttr"

///|
#owned(a, b)
pub extern "C" fn py_object_has_attr(a : PyObjectRef, b : PyObjectRef) -> Int = "PyObject_HasAttr"

///|
#owned(a)
pub extern "C" fn py_object_self_iter(a : PyObjectRef) -> PyObjectRef = "PyObject_SelfIter"

///|
#owned(a, b)
pub extern "C" fn py_object_generic_get_attr(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyObject_GenericGetAttr"

///|
#owned(a, b, c)
pub extern "C" fn py_object_generic_set_attr(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> Int = "PyObject_GenericSetAttr"

// pub extern "C" fn py_object_hash(a: PyObjectRef) -> Py_hash_t = "PyObject_Hash"
// pub extern "C" fn py_object_hash_not_implemented(a: PyObjectRef) -> Py_hash_t = "PyObject_HashNotImplemented"

///|
#owned(a)
extern "C" fn __py_object_is_true(a : PyObjectRef) -> Int = "PyObject_IsTrue"

///|
pub fn py_object_is_true(a : PyObjectRef) -> Bool {
  __py_object_is_true(a) != 0
}

///|
#owned(a)
pub extern "C" fn py_object_not(a : PyObjectRef) -> Int = "PyObject_Not"

///|
#owned(a)
pub extern "C" fn py_object_clear_weak_refs(a : PyObjectRef) = "PyObject_ClearWeakRefs"

///|
#owned(a)
pub extern "C" fn py_object_dir(a : PyObjectRef) -> PyObjectRef = "PyObject_Dir"

///|
#owned(a)
pub extern "C" fn py_repr_enter(a : PyObjectRef) -> Int = "Py_ReprEnter"

///|
#owned(a)
pub extern "C" fn py_repr_leave(a : PyObjectRef) = "Py_ReprLeave"

///|
#owned(obj)
pub extern "C" fn py_type(obj : PyObjectRef) -> PyTypeObjectRef = "py_type"

///|
#owned(t)
extern "C" fn __py_type_name(t : PyTypeObjectRef) -> CStr = "_PyType_Name"

///|
pub fn py_type_name(t : PyTypeObjectRef) -> String {
  let cstr = __py_type_name(t)
  cstr.to_string()
}

///|
#owned(obj)
extern "C" fn __py_tuple_check(obj : PyObjectRef) -> Int = "py_tuple_check"

///|
pub fn py_tuple_check(obj : PyObjectRef) -> Bool {
  __py_tuple_check(obj) != 0
}

///|
#owned(obj)
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
#owned(obj)
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
#owned(obj)
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
#owned(obj)
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
#owned(obj)
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
#owned(obj)
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
#owned(obj)
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
#owned(obj)
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
#owned(f)
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
#owned(a)
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
#owned(obj)
extern "C" fn __py_none_check(obj : PyObjectRef) -> Int = "py_none_check"

///|
pub fn py_none_check(obj : PyObjectRef) -> Bool {
  __py_none_check(obj) != 0
}
