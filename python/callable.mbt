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


pub impl IsPyObject for PyFunc with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

