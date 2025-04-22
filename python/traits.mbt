pub trait IsPyObject {
  obj(Self) -> PyObject;
  obj_ref(Self) -> @cpython.PyObjectRef;
  type_name(Self) -> String;
}

impl IsPyObject with obj_ref(self) {
  self.obj().obj
}

impl IsPyObject with type_name(self) {
  self.obj().type_name()
}
