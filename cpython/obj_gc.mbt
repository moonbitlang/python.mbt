pub struct PyObject {
  obj_ref : PyObjectRef
}

pub extern "C" fn PyObject::new(obj_ref: PyObjectRef) -> PyObject = "newPyObject"
