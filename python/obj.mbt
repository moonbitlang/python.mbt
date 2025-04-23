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

pub fn PyObject::is_bool(self: PyObject) -> Bool {
  @cpython.py_object_is_bool(self.obj_ref())
}

pub fn PyObject::is_int(self: PyObject) -> Bool {
  @cpython.py_object_is_int(self.obj_ref())
}

pub fn PyObject::is_float(self: PyObject) -> Bool {
  @cpython.py_object_is_float(self.obj_ref())
}

pub fn PyObject::is_string(self: PyObject) -> Bool {
  @cpython.py_object_is_string(self.obj_ref())
}

pub fn PyObject::is_list(self: PyObject) -> Bool {
  @cpython.py_object_is_list(self.obj_ref())
}

pub fn PyObject::is_tuple(self: PyObject) -> Bool {
  @cpython.py_object_is_tuple(self.obj_ref())
}

pub fn PyObject::is_dict(self: PyObject) -> Bool {
  @cpython.py_object_is_dict(self.obj_ref())
}

pub fn PyObject::dump(self: PyObject) -> Unit {
  @cpython.print_pyobject(self.obj_ref())
}

pub fn PyObject::drop(self: PyObject) -> Unit {
  @cpython.py_decref(self.obj_ref())
}

pub fn PyObject::type_name(self: PyObject) -> String {
  let ty = @cpython.py_type(self.obj_ref())
  let tyname = @cpython.py_type_name(ty)
  tyname
}

//// TODO: what if the attribute doesn't exist?
//pub fn PyObject::get_attr(self: PyObject, attr_name: String) -> PyObject? {
//  let obj_ref = @cpython.py_object_get_attr_string(self.obj_ref(), attr_name)
//  @option.unless(
//    obj_ref.is_null(),
//    fn () { PyObject::create(obj_ref)}
//  )
//}
//
//pub fn PyObject::get_method(self: PyObject, method_name: String) -> PyCallable? {
//  println("getting method \{method_name}")
//  let obj_ref = @cpython.py_object_get_attr_string(self.obj_ref(), method_name)
//
//  if obj_ref.is_null() {
//    println("\{method_name} not found")
//    return None
//  } else {
//    println("\{method_name} found")
//  }
//
//  if @cpython.py_callable_check(obj_ref) {
//    Some(PyCallable::create_by_ref(obj_ref))
//  } else {
//    println("\{method_name} is not callable")
//    None
//  }
//}

pub fn PyObject::get_attr(self: PyObject, attr: String, print_err~ : Bool = false) -> PyAttrEnum? {
  let f = @cpython.py_object_get_attr_string(self.obj_ref(), attr)

  if f.is_null() {
    if print_err {
      @cpython.py_err_print()
    }
    @cpython.py_err_clear()
    return None
  }

  let c = PyAttrEnum::create_by_ref(f)

  Some(c)
}

pub impl Show for PyObject with to_string(self: PyObject) -> String {
  @cpython.py_object_moonbit_repr(self.obj)
}


pub impl Show for PyObject with output(
  self:PyObject, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
