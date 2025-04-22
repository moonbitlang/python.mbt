typealias PyObject = @python.PyObject;
typealias PyInteger = @python.PyInteger;
typealias PyFloat = @python.PyFloat;
typealias PyString = @python.PyString;
typealias PyList = @python.PyList;



test "PyInteger Test" {
  let i = PyInteger::from(42);
  inspect!(i, content="42")
  inspect!(i.type_name(), content="int")
  assert_eq!(i.to_int64(), 42);
  assert_eq!(i.to_double(), 42.0);
}

test "PyFloat Test" {
  let f = PyFloat::from(3.5);
  inspect!(f, content="3.5")
  inspect!(f.type_name(), content="float")
  assert_eq!(f.to_double(), 3.5);
}

test "PyString Test" {
  let s = PyString::from("hello");
  inspect!(s, content="\'hello\'")
  inspect!(s.type_name(), content="str")
}

test "PyList Test" {
  let list = PyList::new();
  inspect!(list, content="[]")
  assert_eq!(list.len(), 0);
  inspect!(list.type_name(), content="list")

  let one = PyInteger::from(1);
  let two = PyFloat::from(2.0);
  let three = PyString::from("three");

  list.append(one);
  list.append(two);
  list.append(three);

  assert_eq!(list.len(), 3);
  inspect!(list, content="[1, 2.0, \'three\']")
  inspect!(list.get!(0), content="PyInteger(1)")
  inspect!(list.get!(1), content="PyFloat(2.0)")
  inspect!(list.get?(2), content="Ok(PyString(\'three\'))")
  inspect!(list.get?(3), content="Err(IndexOutOfBoundsError)")
  inspect!(list.get?(-1), content="Err(IndexOutOfBoundsError)")

  inspect!(list[0], content="PyInteger(1)")
  inspect!(list[1], content="PyFloat(2.0)")
  inspect!(list[2], content="PyString(\'three\')")

  let forty_two = PyInteger::from(42);
  list.set!(0, forty_two);
  inspect!(list, content="[42, 2.0, \'three\']")

  list[1] = forty_two;
  inspect!(list, content="[42, 42, \'three\']")

  let arr = [3, 5, 1, 7, 4, -2]
  let pyobj_arr : Array[PyInteger] = arr.map(fn (e) {PyInteger::from(e.to_int64())});
  let list = PyList::from(pyobj_arr);
  list.sort();
  inspect!(list, content="[-2, 1, 3, 4, 5, 7]")
}
