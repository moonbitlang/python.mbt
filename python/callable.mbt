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

pub fn PyFunc::obj_ref(self: PyFunc) -> @cpython.PyObjectRef {
  self.obj.obj_ref()
}

pub fn PyFunc::invoke(self: PyFunc, args: PyTuple, kwargs~: PyDict = PyDict::new()) -> PyObject {
  if kwargs.len() > 0 {
    PyObject::create(@cpython.py_object_call(self.obj_ref(), args.obj_ref(), kwargs.obj_ref()))
  } else {
    PyObject::create(@cpython.py_object_call_object(self.obj_ref(), args.obj_ref()))
  }
}


pub impl IsPyObject for PyFunc with obj_ref(self) -> @cpython.PyObjectRef {
  self.obj_ref()
}

