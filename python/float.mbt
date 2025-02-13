pub struct PyFloat {
  priv obj: PyObject
}

fn PyFloat::obj_ref(self: PyFloat) -> @cpython.PyObjectRef {
  self.obj.obj_ref()
}

pub fn PyFloat::new(value: Double) -> PyFloat {
  PyFloat::{
    obj: @cpython.py_float_from_double(value) |> PyObject::create
  }
}

pub fn PyFloat::to_double(self: PyFloat) -> Double {
  @cpython.py_float_as_double(self.obj_ref())
}

pub fn PyFloat::to_string(self: PyFloat) -> String {
  @cpython.py_object_moonbit_repr(self.obj_ref())
}

pub fn PyFloat::dump(self: PyFloat) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyFloat::drop(self: PyFloat) -> Unit {
  self.obj.drop()
}
