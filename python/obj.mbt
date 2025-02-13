pub struct PyObject {
  priv obj: @cpython.PyObjectRef
}

fn PyObject::obj_ref(self: PyObject) -> @cpython.PyObjectRef {
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
  @cpython.print_pyobject(self.obj_ref())
}

pub fn PyObject::drop(self: PyObject) -> Unit {
  @cpython.py_decref(self.obj_ref())
}


pub impl PyAble for PyObject with to_pyobject(self) -> PyObject {
  self
}

pub impl Show for PyObject with to_string(self) -> String {
  PyObject::to_string(self)
}

pub impl Show for PyObject with output(
  self:PyObject, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}



