// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ========================================
// py_list
// ========================================

///|
pub struct PyList {
  priv obj : PyObject
}

///| Create an empty python list.
///
/// ## Example
///
/// ```moonbit
/// let list = @python.PyList::new();
/// inspect(list, content="[]")
/// assert_eq(list.len(), 0);
/// ```
pub fn PyList::new() -> PyList {
  PyList::{ obj: @cpython.py_list_new(0) |> PyObject::create }
}

///| Create a python list object from a pyobject.
/// If the pyobject is not a list, it will raise a TypeMisMatchError.
pub fn PyList::create(obj : PyObject) -> PyList raise PyRuntimeError {
  guard obj.is_list() else { raise TypeMismatchError }
  PyList::{ obj, }
}

///|
fn PyList::create_unchecked(obj : PyObject) -> PyList {
  PyList::{ obj, }
}

///| Create a python list object from a pyobject reference.
/// If the pyobject is not a list, it will raise a TypeMisMatchError.
pub fn PyList::create_by_ref(
  obj : @cpython.PyObjectRef,
) -> PyList raise PyRuntimeError {
  guard @cpython.py_list_check(obj) else { raise TypeMismatchError }
  PyList::{ obj: PyObject::create(obj) }
}

///|
fn PyList::create_by_ref_unchecked(obj : @cpython.PyObjectRef) -> PyList {
  PyList::{ obj: PyObject::create(obj) }
}

///| Returns the length of the list.
///
/// ## Example
///
/// ```moonbit
/// let list = @python.PyList::new();
/// list.append(@python.PyInteger::from(1));
/// list.append(@python.PyFloat::from(2.0));
/// list.append(@python.PyString::from("hello"));
///
/// assert_eq(list.len(), 3);
/// ```
///
/// The above code is equivalent to the following Python code:
///
/// ```python
/// list = []
/// list.append(1)
/// list.append(2.0)
/// list.append("hello")
///
/// print(len(list))  # Output: 3
/// ```
pub fn PyList::len(self : PyList) -> Int {
  @cpython.py_list_size(self.obj_ref()).to_int()
}

///| Append an item to the end of the list.
///
/// ## Example
///
/// ```moonbit
/// let list = @python.PyList::new();
/// list.append(@python.PyInteger::from(1));
/// list.append(@python.PyFloat::from(2.0));
/// list.append(@python.PyString::from("hello"));
/// inspect(list, content="[1, 2.0, \'hello\']")
/// ```
///
/// The above code is equivalent to the following Python code:
///
/// ```python
/// list = []
/// list.append(1)
/// list.append(2.0)
/// list.append("hello")
///
/// print(list)  # Output: [1, 2.0, 'hello']
/// ```
pub fn[T : IsPyObject] PyList::append(self : PyList, item : T) -> Unit {
  let _ = @cpython.py_list_append(self.obj_ref(), item.obj_ref())

}

// Review: The following code is available, but I don't think it is necessary.

///| Sort the elements inside the list, using python's built-in sort.
//pub fn PyList::sort(self: PyList) -> Unit {
//  let _ = @cpython.py_list_sort(self.obj_ref())
//}

// Review: The following code is available, but I don't think it is necessary.
//pub fn PyList::reverse(self: PyList) -> Unit {
//  let _ = @cpython.py_list_reverse(self.obj_ref())
//}

///| Create a new python list from a python object array
///
/// ## Example
///
/// ```moonbit
/// let arr: Array[&IsPyObject] = Array::new()
/// let one = PyInteger::from(1);
/// let two = PyFloat::from(2.0);
/// let three = PyString::from("three");
///
/// arr.push(one)
/// arr.push(two)
/// arr.push(three)
///
/// let list = PyList::from(arr);
/// inspect(list, content="[1, 2.0, \'three\']")
/// ```
pub fn[T : IsPyObject] PyList::from(items : Array[T]) -> PyList {
  let pylist = PyList::new()
  items.each(fn(item) { pylist.append(item) })
  pylist
}

///| Get the item at the specified index.
///
/// **Notes**: Although python support negative index, the moonbit api does not
/// support it. Code like `list.get(-1)` will return `None`.
///
/// ## Example
///
/// ```moonbit
/// let list = @python.PyList::new();
/// list.append(@python.PyInteger::from(1));
/// list.append(@python.PyFloat::from(2.0));
/// list.append(@python.PyString::from("hello"));
///
/// inspect(list.get(0).unwrap(), content="PyInteger(1)")
/// inspect(list.get(1), content="Some(PyFloat(2.0))")
/// inspect(list.get(3), content="None")
/// inspect(list.get(-1), content="None")
/// ```
pub fn PyList::get(self : PyList, idx : Int) -> PyObjectEnum? {
  when(idx >= 0 && idx < self.len(), fn() {
    @cpython.py_list_get_item(self.obj_ref(), idx.to_int64())
    |> PyObject::create
    |> PyObjectEnum::create
  })
}

///| Get the item at the specified index.
///
/// **Notes**: Although python support negative index, the moonbit api does not
/// support it. which means code like `list[-1]` will be panic.
///
/// ## Example
///
/// ```moonbit
/// let list = @python.PyList::new();
/// list.append(@python.PyInteger::from(1));
/// list.append(@python.PyFloat::from(2.0));
/// list.append(@python.PyString::from("hello"));
///
/// inspect(list[0], content="PyInteger(1)")
/// inspect(list[1], content="PyFloat(2.0)")
/// inspect(list[2], content="PyString(hello)")
/// ```
pub fn PyList::op_get(self : PyList, idx : Int) -> PyObjectEnum {
  self.get(idx).unwrap()
}

///| Set the item at the specified index.
///
/// **Notes**: Although python support negative index, the moonbit api does not
/// support it. which means code like `list.set(-1) = ...` will raise IndexOutOfBoundsError.
///
/// ## Example
/// 
/// ```moonbit
/// let list = @python.PyList::new();
/// list.append(@python.PyInteger::from(1));
/// list.append(@python.PyFloat::from(2.0));
/// list.append(@python.PyString::from("hello"));
/// inspect(list, content="[1, 2.0, \'hello\']")
///
/// list.set(0, @python.PyInteger::from(42));
/// inspect(list, content="[42, 2.0, \'hello\']")
/// ```
pub fn[T : IsPyObject] PyList::set(
  self : PyList,
  idx : Int,
  item : T,
) -> Unit raise PyRuntimeError {
  guard idx >= 0 && idx < self.len() else { raise IndexOutOfBoundsError }
  let _ = @cpython.py_list_set_item(
    self.obj_ref(),
    idx.to_int64(),
    item.obj_ref(),
  )

}

///| Set the item at the specified index.
///
/// **Notes**: Although python support negative index, the moonbit api does not
/// support it. which means code like `list[-1] = ...` will be panic.
///
/// ## Example
///
/// ```moonbit
/// let list = @python.PyList::new();
/// list.append(@python.PyInteger::from(1));
/// list.append(@python.PyFloat::from(2.0));
/// list.append(@python.PyString::from("hello"));
/// inspect(list, content="[1, 2.0, \'hello\']")
///
/// list[0] = @python.PyInteger::from(42);
/// inspect(list, content="[42, 2.0, \'hello\']")
/// ```
pub fn[T : IsPyObject] PyList::op_set(
  self : PyList,
  idx : Int,
  item : T,
) -> Unit {
  self.set(idx, item) catch {
    _ => panic()
  }
}

///| Let python interpreter print the list directly.
///
/// **Note**: It is different from `println(list)` and `list.dump()`
/// although they always print the same content.
pub fn PyList::dump(self : PyList) -> Unit {
  self.obj.dump()
}

///|
pub fn PyList::drop(self : PyList) -> Unit {
  self.obj.drop()
}

///|
pub impl IsPyObject for PyList with obj(self) {
  self.obj
}

///|
pub impl Show for PyList with to_string(self) -> String {
  self.obj.to_string()
}

///|
pub impl Show for PyList with output(self : PyList, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
