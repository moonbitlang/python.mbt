// ========================================
// Dict
// ========================================
pub struct PyDict {
  priv obj: PyObject
}

fn PyDict::obj(self: PyDict) -> PyObject {
  self.obj
}

pub fn PyDict::new() -> PyDict {
  PyDict::{
    obj: PyObject::create(@cpython.py_dict_new())
  }
}

pub fn PyDict::len(self: PyDict) -> Int {
  @cpython.py_dict_size(self.obj_ref()).to_int()
}

pub fn PyDict::get[T: PyAble](self: PyDict, key: T) -> PyObject {
  let dict = self.obj_ref()
  let key = key.to_pyobject().obj_ref()
  let obj = @cpython.py_dict_get_item(dict, key)
  PyObject::create(obj)
}

pub fn PyDict::op_get[T: PyAble](self: PyDict, key: T) -> PyObject {
  self.get(key)
}

pub fn PyDict::set[K: PyAble, V: PyAble](self: PyDict, key: K, val: V) -> Unit {
  let dict = self.obj_ref()
  let key = key.to_pyobject().obj_ref()
  let val = val.to_pyobject().obj_ref()
  let _ = @cpython.py_dict_set_item(dict, key, val)
}

pub fn PyDict::op_set[K: PyAble, V: PyAble](self: PyDict, key: K, val: V) -> Unit {
  self.set(key, val)
}

// TODO: Seems that it is incorrect.
pub fn PyDict::keys(self: PyDict) -> PyList {
  PyList::create_by_ref(@cpython.py_dict_keys(self.obj_ref()))
}

pub fn PyDict::values(self: PyDict) -> PyList {
  PyList::create_by_ref(@cpython.py_dict_values(self.obj_ref()))
}

pub fn PyDict::items(self: PyDict) -> PyList {
  PyList::create_by_ref(@cpython.py_dict_items(self.obj_ref()))
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

pub fn PyDict::type_name(self: PyDict) -> String {
  self.obj.type_name()
}

pub impl IsPyObject for PyDict with obj(self) {
  self.obj()
}

pub impl PyAble for PyDict with to_pyobject(self) -> PyObject {
  PyObject::create(self.obj_ref())
}

pub impl Show for PyDict with to_string(self) -> String {
  PyDict::to_string(self)
}

pub impl Show for PyDict with output(
  self:PyDict, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

