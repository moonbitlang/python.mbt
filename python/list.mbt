trait IsPyObject {
  get_obj(Self) -> @cpython.PyObjectRef;
}

impl IsPyObject for PyInteger with get_obj(self) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

impl IsPyObject for PyList with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
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
    obj: PyObject::create(@cpython.pylong_from_long(value))
  }
}

pub fn PyInteger::to_int64(self: PyInteger) -> Int64 {
  @cpython.pylong_as_long(self.get_obj())
}

pub fn PyInteger::to_double(self: PyInteger) -> Double {
  @cpython.pylong_as_double(self.get_obj())
}

// ========================================
// PyList
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
    obj: @cpython.pylist_new(size.to_uint64()) |> PyObject::create
  }
}

pub fn PyList::create(obj: @cpython.PyObjectRef) -> PyList {
  // TODO: Need to check if it is really list object firstly.
  PyList::{
    obj: PyObject::create(obj)
  }
}

pub fn PyList::len(self: PyList) -> Int {
  @cpython.pylist_size(self.get_obj()).to_int()
}

// REVIEW: the return value may have special meaning.
pub fn PyList::append[T: IsPyObject](self: PyList, item: T) -> Unit {
  let _ = @cpython.pylist_append(self.get_obj(), item.get_obj())
}

pub fn PyList::sort(self: PyList) -> Unit {
  let _ = @cpython.pylist_sort(self.get_obj())
}

pub fn PyList::reverse(self: PyList) -> Unit {
  let _ = @cpython.pylist_reverse(self.get_obj())
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

pub fn PyTuple::new(size~:Int = 0) -> PyTuple {
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

fn PyTuple::get_item(self: PyTuple, idx: Int) -> PyObject {
  PyObject::create(@cpython.pytuple_get_item(self.get_obj(), idx.to_uint64()))
}

pub fn PyTuple::op_get(self: PyTuple, idx: Int) -> PyObject {
  self.get_item(idx)
}

// ========================================
// Dict
// ========================================
pub struct PyDict {
  priv obj:@cpython.PyObjectRef
}

fn PyDict::get_obj(self: PyDict) -> @cpython.PyObjectRef {
  self.obj
}

pub fn PyDict::new() -> PyDict {
  PyDict::{
    obj: @cpython.pydict_new()
  }
}

pub fn PyDict::len(self: PyDict) -> Int {
  @cpython.pydict_size(self.obj).to_int()
}

// TODO: Seems that it is incorrect.
pub fn PyDict::keys(self: PyDict) -> PyList {
  PyList::create(@cpython.pydict_keys(self.obj))
}

pub fn PyDict::values(self: PyDict) -> PyList {
  PyList::create(@cpython.pydict_values(self.obj))
}

pub fn PyDict::items(self: PyDict) -> PyList {
  PyList::create(@cpython.pydict_items(self.obj))
}
