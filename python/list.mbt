trait IsPyObject {
  get_obj(Self) -> @cpython.PyObjectRef;
}

pub impl IsPyObject for PyInteger with get_obj(self) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub impl IsPyObject for PyList with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl IsPyObject for PyTuple with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl IsPyObject for PyDict with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl IsPyObject for PyString with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl IsPyObject for PyFunc with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl IsPyObject for PyModule with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
} 

trait CanBePyObject {
  to_pyobject(Self) -> PyObject;
}

pub impl CanBePyObject for Int with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_long_from_long(self.to_int64()))
}

pub impl CanBePyObject for Double with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_float_from_double(self))
}

pub impl CanBePyObject for String with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_unicode_from_string(self))
}

pub impl CanBePyObject for PyObject with to_pyobject(self) -> PyObject {
  self
}

pub impl CanBePyObject for PyInteger with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl CanBePyObject for PyList with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl CanBePyObject for PyTuple with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl CanBePyObject for PyDict with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl CanBePyObject for PyString with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

// --------
pub struct PyObject {
  priv obj: @cpython.PyObjectRef
}

fn PyObject::get_obj(self: PyObject) -> @cpython.PyObjectRef {
  self.obj
}

pub fn PyObject::create(obj: @cpython.PyObjectRef) -> PyObject {
  PyObject::{
    obj: obj
  }
}

pub fn PyObject::drop(self: PyObject) -> Unit {
  @cpython.py_decref(self.get_obj())
}

// ========================================
// PyInteger
// ========================================

pub struct PyInteger {
  priv obj: PyObject
}

fn PyInteger::get_obj(self: PyInteger) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}


pub fn PyInteger::new(value: Int64) -> PyInteger {
  PyInteger::{
    obj: PyObject::create(@cpython.py_long_from_long(value))
  }
}

pub fn PyInteger::to_int64(self: PyInteger) -> Int64 {
  @cpython.py_long_as_long(self.get_obj())
}

pub fn PyInteger::to_double(self: PyInteger) -> Double {
  @cpython.py_long_as_double(self.get_obj())
}

// ========================================
// py_list
// ========================================
pub struct PyList {
  priv obj: PyObject
}

fn PyList::get_obj(self: PyList) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyList::new(size~:Int = 0) -> PyList {
  let size = if size < 0 {
    0
  } else {
    size
  }

  PyList::{
    obj: @cpython.py_list_new(size.to_uint64()) |> PyObject::create
  }
}

pub fn PyList::create(obj: @cpython.PyObjectRef) -> PyList {
  // TODO: Need to check if it is really list object firstly.
  PyList::{
    obj: PyObject::create(obj)
  }
}

pub fn PyList::len(self: PyList) -> Int {
  @cpython.py_list_size(self.get_obj()).to_int()
}

// REVIEW: the return value may have special meaning.
pub fn PyList::append[T: CanBePyObject](self: PyList, item: T) -> Unit {
  let _ = @cpython.py_list_append(self.get_obj(), item.to_pyobject().get_obj())
}


pub fn PyList::sort(self: PyList) -> Unit {
  let _ = @cpython.py_list_sort(self.get_obj())
}

pub fn PyList::reverse(self: PyList) -> Unit {
  let _ = @cpython.py_list_reverse(self.get_obj())
}

pub fn PyList::from[T: CanBePyObject](items: Array[T]) -> PyList {
  let pylist = PyList::new()
  items.each(fn (item) { pylist.append(item) })
  pylist
}

// pub fn PyList::get(self: PyList, idx: Int) -> PyObject {
//   PyObject::create(@cpython.py_list_get_item(self.get_obj(), idx.to_uint64()))
// }
//
// pub fn PyList::op_get(self: PyList, idx: Int) -> PyObject {
//   self.get(idx)
// }

pub fn PyList::set[T: CanBePyObject](self: PyList, idx: Int, item: T) -> Unit {
  let _ = @cpython.py_list_set_item(self.get_obj(), idx.to_uint64(), item.to_pyobject().get_obj())
}

pub fn PyList::op_set[T: CanBePyObject](self: PyList, idx: Int, item: T) -> Unit {
  self.set(idx, item)
}


pub fn PyList::drop(self: PyList) -> Unit {
  self.obj.drop()
}


// ========================================
// Tuple
// ========================================
pub struct PyTuple {
  priv obj: PyObject
}

fn PyTuple::get_obj(self: PyTuple) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyTuple::new(size : Int) -> PyTuple {
  let size = if size < 0 {
    0
  } else {
    size
  }

  PyTuple::{
    obj: @cpython.pytuple_new(size.to_uint64()) |> PyObject::create
  }
}

pub fn PyTuple::len(self: PyTuple) -> Int {
  @cpython.pytuple_size(self.get_obj()).to_int()
}

pub fn PyTuple::get(self: PyTuple, idx: Int) -> PyObject {
  PyObject::create(@cpython.pytuple_get_item(self.get_obj(), idx.to_uint64()))
}

pub fn PyTuple::op_get(self: PyTuple, idx: Int) -> PyObject {
  self.get(idx)
}

pub fn PyTuple::set[T: CanBePyObject](self: PyTuple, idx: Int, item: T) -> Unit {
  let _ = @cpython.pytuple_set_item(self.get_obj(), idx.to_uint64(), item.to_pyobject().get_obj())
}

pub fn PyTuple::op_set[T: CanBePyObject](self: PyTuple, idx: Int, item: T) -> Unit {
  self.set(idx, item)
}

pub fn PyTuple::drop(self: PyTuple) -> Unit {
  self.obj.drop()
} 

// ========================================
// Dict
// ========================================
pub struct PyDict {
  priv obj: PyObject
}

fn PyDict::get_obj(self: PyDict) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyDict::new() -> PyDict {
  PyDict::{
    obj: PyObject::create(@cpython.py_dict_new())
  }
}

pub fn PyDict::len(self: PyDict) -> Int {
  @cpython.py_dict_size(self.get_obj()).to_int()
}

// TODO: Seems that it is incorrect.
pub fn PyDict::keys(self: PyDict) -> PyList {
  PyList::create(@cpython.py_dict_keys(self.get_obj()))
}

pub fn PyDict::values(self: PyDict) -> PyList {
  PyList::create(@cpython.py_dict_values(self.get_obj()))
}

pub fn PyDict::items(self: PyDict) -> PyList {
  PyList::create(@cpython.py_dict_items(self.get_obj()))
}

pub fn PyDict::drop(self: PyDict) -> Unit {
  self.obj.drop()
}

// ========================================
// PyString
// ========================================
pub struct PyString {
  priv obj: PyObject
}

pub fn PyString::from(s: String) -> PyString {
  PyString::{
    obj: PyObject::create(@cpython.py_unicode_from_string(s))
  }
}

pub fn PyString::get_obj(self: PyString) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyString::drop(self: PyString) -> Unit {
  self.obj.drop()
}

// ========================================
// Function
// ========================================
pub struct PyFunc {
  priv obj: PyObject
}

pub fn PyFunc::create(obj: @cpython.PyObjectRef) -> PyFunc {
  PyFunc::{
    obj: PyObject::create(obj)
  }
}

pub fn PyFunc::call(self: PyFunc, args: PyTuple) -> PyObject {
  PyObject::create(@cpython.py_object_call_object(self.get_obj(), args.get_obj()))
}

// ========================================
// Import
// ========================================
pub struct PyModule {
  name: String
  priv obj: PyObject
}

pub fn PyModule::get_obj(self: PyModule) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyModule::get_name(self: PyModule) -> String {
  self.name
}

pub fn pyimport(name: String) -> PyModule? {
  let py_str = PyString::from(name);

  let obj = @cpython.py_import_import(py_str.get_obj());

  let r = if obj.is_null() {
    None
  } else {
    let m = PyModule::{
      name,
      obj: PyObject::create(obj)
    }
    Some(m)
  }

  py_str.drop()
  r
}

pub fn PyModule::get_func(self: PyModule, fname: String) -> PyFunc? {
  let f = @cpython.py_object_get_attr_string(self.get_obj(), fname)

  if f.is_null() {
    return None
  }

  if @cpython.py_function_check(f) {
    Some(PyFunc::create(f))
  } else {
    None
  }
}
