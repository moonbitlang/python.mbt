// ========================================
// Function
// ========================================
pub struct PyCallable {
  priv obj: PyObject
}

pub fn PyCallable::create(obj: PyObject) -> PyCallable!PyRuntimeError {
  guard obj.is_callable() else {
    raise TypeMisMatchError
  }

  PyCallable::{ obj }
}

fn PyCallable::create_unchecked(obj: PyObject) -> PyCallable {
  PyCallable::{ obj }
}

pub fn PyCallable::create_by_ref(obj: @cpython.PyObjectRef) -> PyCallable!PyRuntimeError {

  guard @cpython.py_callable_check(obj) else {
    raise TypeMisMatchError
  }

  PyCallable::{ obj: PyObject::create(obj) }
}

fn PyCallable::create_by_ref_unchecked(obj: @cpython.PyObjectRef) -> PyCallable {
  PyCallable::{ obj: PyObject::create(obj) }
}

pub fn PyCallable::obj(self: PyCallable) -> PyObject {
  self.obj
}

pub fn PyCallable::invoke(self: PyCallable, args: PyTuple, kwargs~: PyDict = PyDict::new()) -> PyObjectEnum? {
  let obj = if kwargs.len() > 0 {
    PyObject::create(@cpython.py_object_call(self.obj_ref(), args.obj_ref(), kwargs.obj_ref()))
  } else {
    PyObject::create(@cpython.py_object_call_object(self.obj_ref(), args.obj_ref()))
  }

  @option.unless(
    obj.is_null(),
    fn () { PyObjectEnum::create(obj) }
  )
}

pub impl IsPyObject for PyCallable with obj(self) -> PyObject {
  self.obj
}

pub impl Show for PyCallable with to_string(self) {
  self.obj.to_string()
}

pub impl Show for PyCallable with output(self, logger) {
  logger.write_string(self.to_string())
}
