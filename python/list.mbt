// ========================================
// py_list
// ========================================
pub struct PyList {
  priv obj: PyObject
}

fn PyList::obj(self: PyList) -> PyObject {
  self.obj
}

pub fn PyList::new() -> PyList {
  PyList::{
    obj: @cpython.py_list_new(0) |> PyObject::create
  }
}

pub fn PyList::create(obj: PyObject) -> PyList {
  PyList::{
    obj
  }
}

pub fn PyList::create_by_ref(obj: @cpython.PyObjectRef) -> PyList {
  // TODO: Need to check if it is really list object firstly.
  PyList::{
    obj: PyObject::create(obj)
  }
}

pub fn PyList::len(self: PyList) -> Int {
  @cpython.py_list_size(self.obj_ref()).to_int()
}

// REVIEW: the return value may have special meaning.
pub fn PyList::append[T: IsPyObject](self: PyList, item: T) -> Unit {
  let _ = @cpython.py_list_append(self.obj_ref(), item.obj_ref())
}

 //pub fn PyList::pop(self: PyList) -> PyObject {
 //  PyObject::create(@cpython.py_list_pop(self.obj_ref()))
 //}

pub fn PyList::sort(self: PyList) -> Unit {
  let _ = @cpython.py_list_sort(self.obj_ref())
}

pub fn PyList::reverse(self: PyList) -> Unit {
  let _ = @cpython.py_list_reverse(self.obj_ref())
}

pub fn PyList::from[T: IsPyObject](items: Array[T]) -> PyList {
  let pylist = PyList::new()
  items.each(fn (item) { pylist.append(item) })
  pylist
}

pub fn PyList::get(self: PyList, idx: Int) -> PyObject {
  PyObject::create(@cpython.py_list_get_item(self.obj_ref(), idx.to_int64()))
}

pub fn PyList::op_get(self: PyList, idx: Int) -> PyObject {
  self.get(idx)
}

pub fn PyList::set[T: IsPyObject](self: PyList, idx: Int, item: T) -> Unit {
  let _ = @cpython.py_list_set_item(self.obj_ref(), idx.to_int64(), item.obj_ref())
}

pub fn PyList::op_set[T: IsPyObject](self: PyList, idx: Int, item: T) -> Unit {
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

pub impl IsPyObject for PyList with type_name(self: PyList) -> String {
  self.obj.type_name()
}

pub impl IsPyObject for PyList with obj(self) {
  self.obj()
}

pub impl PyAble for PyList with to_pyobject(self) -> PyObject {
  PyObject::create(self.obj_ref())
}

pub impl Show for PyList with to_string(self) -> String {
  PyList::to_string(self)
}

pub impl Show for PyList with output(
  self:PyList, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
