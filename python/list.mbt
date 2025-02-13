trait IsPyObject {
  get_obj(Self) -> @cpython.PyObjectRef;
}

pub impl IsPyObject for PyInteger with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
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

trait PyAble {
  to_pyobject(Self) -> PyObject;
}

pub impl PyAble for Int with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_long_from_long(self.to_int64()))
}

pub impl PyAble for Double with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_float_from_double(self))
}

pub impl PyAble for String with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_unicode_from_string(self))
}

pub impl PyAble for PyObject with to_pyobject(self) -> PyObject {
  self
}

pub impl PyAble for PyInteger with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl PyAble for PyList with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl PyAble for PyTuple with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl PyAble for PyDict with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl PyAble for PyString with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

// --------
pub impl Show for PyObject with to_string(self) -> String {
  PyObject::to_string(self)
}

pub impl Show for PyObject with output(
  self:PyObject, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

pub impl Show for PyInteger with to_string(self) -> String {
  PyInteger::to_string(self)
}

pub impl Show for PyInteger with output(
  self:PyInteger, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

pub impl Show for PyList with to_string(self) -> String {
  PyList::to_string(self)
}

pub impl Show for PyList with output(
  self:PyList, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

pub impl Show for PyTuple with to_string(self) -> String {
  PyTuple::to_string(self)
}

pub impl Show for PyTuple with output(
  self:PyTuple, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

pub impl Show for PyDict with to_string(self) -> String {
  PyDict::to_string(self)
}

pub impl Show for PyDict with output(
  self:PyDict, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

pub impl Show for PyString with to_string(self) -> String {
  PyString::to_string(self)
}

pub impl Show for PyString with output(
  self:PyString, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
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

pub fn PyObject::is_null(self: PyObject) -> Bool {
  self.obj.is_null()
}

pub fn PyObject::to_string(self: PyObject) -> String {
  @cpython.py_object_moonbit_repr(self.obj)
}

pub fn PyObject::dump(self: PyObject) -> Unit {
  @cpython.print_pyobject(self.get_obj())
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

pub fn PyInteger::to_string(self: PyInteger) -> String {
  @cpython.py_object_moonbit_repr(self.get_obj())
}

pub fn PyInteger::dump(self: PyInteger) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyInteger::drop(self: PyInteger) -> Unit {
  self.obj.drop()
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

pub fn PyList::new(size~ : Int = 0) -> PyList {
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
pub fn PyList::append[T: PyAble](self: PyList, item: T) -> Unit {
  let _ = @cpython.py_list_append(self.get_obj(), item.to_pyobject().get_obj())
}


pub fn PyList::sort(self: PyList) -> Unit {
  let _ = @cpython.py_list_sort(self.get_obj())
}

pub fn PyList::reverse(self: PyList) -> Unit {
  let _ = @cpython.py_list_reverse(self.get_obj())
}

pub fn PyList::from[T: PyAble](items: Array[T]) -> PyList {
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

pub fn PyList::set[T: PyAble](self: PyList, idx: Int, item: T) -> Unit {
  let _ = @cpython.py_list_set_item(self.get_obj(), idx.to_uint64(), item.to_pyobject().get_obj())
}

pub fn PyList::op_set[T: PyAble](self: PyList, idx: Int, item: T) -> Unit {
  self.set(idx, item)
}

pub fn PyList::to_string(self: PyList) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyList::dump(self: PyList) -> Unit {
  PyObject::dump(self.obj)
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

pub fn PyTuple::set[T: PyAble](self: PyTuple, idx: Int, item: T) -> Unit {
  let _ = @cpython.pytuple_set_item(self.get_obj(), idx.to_uint64(), item.to_pyobject().get_obj())
}

pub fn PyTuple::op_set[T: PyAble](self: PyTuple, idx: Int, item: T) -> Unit {
  self.set(idx, item)
}

pub fn PyTuple::to_string(self: PyTuple) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyTuple::dump(self: PyTuple) -> Unit {
  PyObject::dump(self.obj)
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

pub fn PyDict::get[T: PyAble](self: PyDict, key: T) -> PyObject {
  let dict = self.get_obj()
  let key = key.to_pyobject().get_obj()
  let obj = @cpython.py_dict_get_item(dict, key)
  PyObject::create(obj)
}

pub fn PyDict::op_get[T: PyAble](self: PyDict, key: T) -> PyObject {
  self.get(key)
}

pub fn PyDict::set[K: PyAble, V: PyAble](self: PyDict, key: K, val: V) -> Unit {
  let dict = self.get_obj()
  let key = key.to_pyobject().get_obj()
  let val = val.to_pyobject().get_obj()
  let _ = @cpython.py_dict_set_item(dict, key, val)
}

pub fn PyDict::op_set[K: PyAble, V: PyAble](self: PyDict, key: K, val: V) -> Unit {
  self.set(key, val)
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

pub fn PyDict::to_string(self: PyDict) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyDict::dump(self: PyDict) -> Unit {
  PyObject::dump(self.obj)
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

pub fn PyString::to_string(self: PyString) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyString::dump(self: PyString) -> Unit {
  PyObject::dump(self.obj)
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

pub fn PyFunc::get_obj(self: PyFunc) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyFunc::invoke(self: PyFunc, args: PyTuple, kwargs~: PyDict = PyDict::new()) -> PyObject {
  if kwargs.len() > 0 {
    PyObject::create(@cpython.py_object_call(self.get_obj(), args.get_obj(), kwargs.get_obj()))
  } else {
    PyObject::create(@cpython.py_object_call_object(self.get_obj(), args.get_obj()))
  }
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

// -----------------------
fn init {
  @cpython.py_init()

  if (not(@cpython.py_is_initialized())) {
    println("Python initialization failed")
    return 
  }
}
