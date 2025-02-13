// ========================================
// py_list
// ========================================
pub struct PyList {
  priv obj: PyObject
}

fn PyList::get_obj(self: PyList) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyList::new(size~ : Int = 0) -> PyList {
  let size = if size < 0 {
    0
  } else {
    size
  }

  PyList::{
    obj: @cpython.py_list_new(size.to_int64()) |> PyObject::create
  }
}

pub fn PyList::create(obj: @cpython.PyObjectRef) -> PyList {
  // TODO: Need to check if it is really list object firstly.
  PyList::{
    obj: PyObject::create(obj)
  }
}

pub fn PyList::len(self: PyList) -> Int {
  @cpython.py_list_size(self.get_obj()).to_int()
}

// REVIEW: the return value may have special meaning.
pub fn PyList::append[T: PyAble](self: PyList, item: T) -> Unit {
  let _ = @cpython.py_list_append(self.get_obj(), item.to_pyobject().get_obj())
}

// pub fn PyList::pop(self: PyList) -> PyObject {
//   PyObject::create(@cpython.py_list_pop(self.get_obj()))
// }

pub fn PyList::sort(self: PyList) -> Unit {
  let _ = @cpython.py_list_sort(self.get_obj())
}

pub fn PyList::reverse(self: PyList) -> Unit {
  let _ = @cpython.py_list_reverse(self.get_obj())
}

pub fn PyList::from[T: PyAble](items: Array[T]) -> PyList {
  let pylist = PyList::new()
  items.each(fn (item) { pylist.append(item) })
  pylist
}

pub fn PyList::get(self: PyList, idx: Int) -> PyObject {
  PyObject::create(@cpython.py_list_get_item(self.get_obj(), idx.to_int64()))
}

pub fn PyList::op_get(self: PyList, idx: Int) -> PyObject {
  self.get(idx)
}

pub fn PyList::set[T: PyAble](self: PyList, idx: Int, item: T) -> Unit {
  let _ = @cpython.py_list_set_item(self.get_obj(), idx.to_int64(), item.to_pyobject().get_obj())
}

pub fn PyList::op_set[T: PyAble](self: PyList, idx: Int, item: T) -> Unit {
  self.set(idx, item)
}

pub fn PyList::to_string(self: PyList) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyList::dump(self: PyList) -> Unit {
  self.obj.dump()
}

pub fn PyList::drop(self: PyList) -> Unit {
  self.obj.drop()
}

pub impl IsPyObject for PyList with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl PyAble for PyList with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl Show for PyList with to_string(self) -> String {
  PyList::to_string(self)
}

pub impl Show for PyList with output(
  self:PyList, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
