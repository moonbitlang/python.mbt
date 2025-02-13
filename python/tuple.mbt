// ========================================
// Tuple
// ========================================
pub struct PyTuple {
  priv obj: PyObject
}

fn PyTuple::obj_ref(self: PyTuple) -> @cpython.PyObjectRef {
  self.obj.obj_ref()
}

pub fn PyTuple::new(size : Int) -> PyTuple {
  let size = if size < 0 {
    0
  } else {
    size
  }

  PyTuple::{
    obj: @cpython.pytuple_new(size.to_uint64()) |> PyObject::create
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

pub fn PyTuple::to_string(self: PyTuple) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyTuple::dump(self: PyTuple) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyTuple::drop(self: PyTuple) -> Unit {
  self.obj.drop()
} 

pub impl IsPyObject for PyTuple with obj_ref(self) -> @cpython.PyObjectRef {
  self.obj_ref()
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

