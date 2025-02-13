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

pub fn PyString::obj_ref(self: PyString) -> @cpython.PyObjectRef {
  self.obj.obj_ref()
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

pub impl IsPyObject for PyString with obj_ref(self) -> @cpython.PyObjectRef {
  self.obj_ref()
}

pub impl PyAble for PyString with to_pyobject(self) -> PyObject {
  PyObject::create(self.obj_ref())
}

pub impl Show for PyString with to_string(self) -> String {
  PyString::to_string(self)
}

pub impl Show for PyString with output(
  self:PyString, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

