///|
pub trait IsPyObject {
  obj(Self) -> PyObject
  obj_ref(Self) -> @cpython.PyObjectRef = _
  type_name(Self) -> String = _
}

///|
impl IsPyObject with obj_ref(self) {
  self.obj().obj
}

///|
impl IsPyObject with type_name(self) {
  self.obj().type_name()
}
