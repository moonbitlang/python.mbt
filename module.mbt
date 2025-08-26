// ========================================
// Import
// ========================================

///|
pub struct PyModule {
  priv obj : PyObject
  priv mut name : String?
  priv attrs : Map[String, PyObjectEnum]
}

///|
pub fn PyModule::create(obj : PyObject) -> PyModule raise PyRuntimeError {
  guard obj.is_module() else { raise TypeMisMatchError }
  PyModule::{ obj, name: None, attrs: Map::new() }
}

///|
fn PyModule::create_unchecked(obj : PyObject) -> PyModule {
  PyModule::{ obj, name: None, attrs: Map::new() }
}

///|
pub fn PyModule::create_by_ref(
  obj_ref : @cpython.PyObjectRef,
) -> PyModule raise PyRuntimeError {
  guard @cpython.py_module_check(obj_ref) else { raise TypeMisMatchError }
  PyModule::{ obj: PyObject::create(obj_ref), name: None, attrs: Map::new() }
}

///|
fn PyModule::create_by_ref_unchecked(
  obj_ref : @cpython.PyObjectRef,
) -> PyModule {
  PyModule::{ obj: PyObject::create(obj_ref), name: None, attrs: Map::new() }
}

///|
test {
  ignore(PyModule::create_by_ref_unchecked)
}
// REVIEW: what if user call pyimport twice or more?

///| Import a python module
///
/// ## Example
///
/// ```moonbit
/// let os = @python.pyimport("os")
///
/// assert_true(os is Some(_))
/// ```
pub fn pyimport(name : String, print_err~ : Bool = false) -> PyModule? {
  let obj = @cpython.py_import_import_module(name)
  if obj.is_null() {
    if print_err {
      println("module \{name} not found")
      @cpython.py_err_print()
    }
    @cpython.py_err_clear()
    return None
  }
  PyModule::{ obj: PyObject::create(obj), name: None, attrs: Map::new() }
  |> Some
}

///| Get the name of the module.
///
/// ## Example
///
/// ```moonbit
/// let os = @python.pyimport("os").unwrap()
///
/// inspect(os.get_name(), content="os")
/// ```
pub fn PyModule::get_name(self : PyModule) -> String {
  if self.name is Some(n) {
    return n
  }
  let attr = self.get_attr("__name__")
  if attr is None {
    println("module has no attribute __name__")
    panic()
  }
  let attr = attr.unwrap()
  guard attr is PyString(s) else {
    println("module __name__ is not a string")
    panic()
  }
  let n = s.to_string() |> strip_quot
  self.name = Some(n)
  n
}

///|
pub fn PyModule::dump(self : PyModule) -> Unit {
  self.obj.dump()
}

///| Get attribute by name.
///
/// ## Example
///
/// ```moonbit
/// let collections = pyimport("collections").unwrap()
/// guard collections.get_attr("Counter").unwrap() is PyCallable(counter)
///
/// let list = [1L, 2L, 2L, 3L, 3L, 3L].map(PyInteger::from) |> PyList::from
/// let args = PyTuple::new(1)
/// args .. set(0, list)
/// guard counter.invoke(args~) is Some(PyDict(cnt))
/// inspect(cnt, content="Counter({3: 3, 2: 2, 1: 1})")
///
/// guard cnt.obj().get_attr("total") is Some(PyCallable(total))
/// inspect(total.invoke().unwrap(), content="PyInteger(6)")
/// ```
/// 
/// // The above code is equivalent to the following python code:
///
/// ```python
/// import collections
/// from collections import Counter
/// 
/// list = [1, 2, 2, 3, 3, 3]
/// cnt = Counter(list)
/// print(cnt) # Counter({3: 3, 2: 2, 1: 1})
///
/// total = cnt.total()
/// print(total) # 6
/// ```
pub fn PyModule::get_attr(
  self : PyModule,
  attr : String,
  print_err~ : Bool = false,
) -> PyObjectEnum? {
  if self.attrs.contains(attr) {
    return self.attrs.get(attr)
  }
  let f = @cpython.py_object_get_attr_string(self.obj_ref(), attr)
  if f.is_null() {
    if print_err {
      println("module \{self.get_name()} has no attribute \{attr}")
      @cpython.py_err_print()
    }
    @cpython.py_err_clear()
    return None
  }
  let c = PyObjectEnum::create_by_ref(f)
  self.attrs.set(attr, c)
  Some(c)
}

///|
pub impl IsPyObject for PyModule with obj(self) {
  self.obj
}

///|
pub impl Show for PyModule with to_string(self) {
  self.obj.to_string()
}

///|
pub impl Show for PyModule with output(self, logger) {
  logger.write_string(self.to_string())
}
