// ========================================
// Tuple
// ========================================
pub struct PyTuple {
  priv obj: PyObject
}

fn PyTuple::obj(self: PyTuple) -> PyObject {
  self.obj
}

pub fn PyTuple::new(size : UInt64) -> PyTuple {
  PyTuple::{
    obj: @cpython.pytuple_new(size) |> PyObject::create
  }
}

pub fn PyTuple::create(obj: PyObject) -> PyTuple {
  PyTuple::{
    obj
  }
}

fn PyTuple::create_unchecked(obj: PyObject) -> PyTuple {
  PyTuple::{
    obj
  }
}

pub fn PyTuple::create_by_ref(obj_ref: @cpython.PyObjectRef) -> PyTuple {
  PyTuple::{
    obj: PyObject::create(obj_ref)
  }
}

fn PyTuple::create_by_ref_unchecked(obj_ref: @cpython.PyObjectRef) -> PyTuple {
  PyTuple::{
    obj: PyObject::create(obj_ref)
  }
}

pub fn PyTuple::len(self: PyTuple) -> Int {
  @cpython.pytuple_size(self.obj_ref()).to_int()
}

pub fn PyTuple::get(self: PyTuple, idx: Int) -> PyObject {
  PyObject::create(@cpython.pytuple_get_item(self.obj_ref(), idx.to_uint64()))
}

pub fn PyTuple::op_get(self: PyTuple, idx: Int) -> PyObject {
  self.get(idx)
}

pub fn PyTuple::set[T: PyAble](self: PyTuple, idx: Int, item: T) -> Unit {
  let _ = @cpython.pytuple_set_item(self.obj_ref(), idx.to_uint64(), item.to_pyobject().obj_ref())
}

pub fn PyTuple::op_set[T: PyAble](self: PyTuple, idx: Int, item: T) -> Unit {
  self.set(idx, item)
}

pub fn PyTuple::from[T: PyAble](self: T) -> PyTuple {
  self.to_pytuple()
}

pub fn PyTuple::to_string(self: PyTuple) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyTuple::dump(self: PyTuple) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyTuple::drop(self: PyTuple) -> Unit {
  self.obj.drop()
} 

pub fn PyTuple::type_name(self: PyTuple) -> String {
  self.obj.type_name()
}

pub impl IsPyObject for PyTuple with obj(self) -> PyObject {
  self.obj()
}

pub impl PyAble for PyTuple with to_pyobject(self) -> PyObject {
  PyObject::create(self.obj_ref())
}

pub impl Show for PyTuple with to_string(self) -> String {
  PyTuple::to_string(self)
}

pub impl Show for PyTuple with output(
  self:PyTuple, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
