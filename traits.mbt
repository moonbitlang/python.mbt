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
/// Return the type name of the object.
///
/// ## Example
///
/// ```moonbit
/// let t = PyBool::from(true);
/// inspect(t.type_name(), content="bool")
///
/// let i = PyInteger::from(42);
/// inspect(i.type_name(), content="int")
///
/// let f = PyFloat::from(3.14);
/// inspect(f.type_name(), content="float")
///
/// let s = PyString::from("hello");
/// inspect(s.type_name(), content="str")
///
/// let tup = PyTuple::new(1)
/// inspect(tup.type_name(), content="tuple")
///
/// let lst = PyList::new()
/// inspect(lst.type_name(), content="list")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// t = True
/// print(type(t)) # Output: <class 'bool'>
///
/// i = 42
/// print(type(i)) # Output: <class 'int'>
///
/// f = 3.14
/// print(type(f)) # Output: <class 'float'>
///
/// s = "hello"
/// print(type(s)) # Output: <class 'str'>
///
/// tup = (1,)
/// print(type(tup)) # Output: <class 'tuple'>
///
/// lst = []
/// print(type(lst)) # Output: <class 'list'>
/// ```
impl IsPyObject with type_name(self) {
  self.obj().type_name()
}
