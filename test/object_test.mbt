typealias PyInteger = @python.PyInteger;
typealias PyFloat = @python.PyFloat;
typealias PyString = @python.PyString;
typealias PyList = @python.PyList;
typealias PyTuple = @python.PyTuple;
typealias PyBool = @python.PyBool;
typealias PyDict = @python.PyDict;


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

test "PyBool Test" {
  let t = PyBool::from(true);
  let f = PyBool::from(false);
  let f2 = t.not();

  inspect!(t, content="True")
  inspect!(f, content="False")
  inspect!(t.type_name(), content="bool")

  assert_true!(t.is_true());
  assert_true!(f.is_false());
  assert_true!(f2.is_false());
}

test "PyString Test" {
  let s = PyString::from("hello");
  inspect!(s, content="\'hello\'")
  inspect!(s.type_name(), content="str")

  inspect!(PyString::from("one"), content="\'one\'")
  inspect!(PyString::from("two"), content="\'two\'")
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
  inspect!(list.get(0).unwrap(), content="PyInteger(1)")
  inspect!(list.get(1).unwrap(), content="PyFloat(2.0)")
  inspect!(list.get(2), content="Some(PyString(\'three\'))")
  inspect!(list.get(3), content="None")
  inspect!(list.get(-1), content="None")

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

test "PyTuple Test" {
  let tuple = PyTuple::new(3)
            ..set!(0, PyInteger::from(1))
            ..set!(1, PyFloat::from(2.0))
            ..set!(2, PyString::from("three"));

  inspect!(tuple.type_name(), content="tuple")
  assert_eq!(tuple.len(), 3);
  inspect!(tuple, content="(1, 2.0, \'three\')")

  inspect!(tuple.get(0).unwrap(), content="PyInteger(1)")
  inspect!(tuple.get(1).unwrap(), content="PyFloat(2.0)")
  inspect!(tuple.get(2).unwrap(), content="PyString(\'three\')")
  inspect!(tuple.get(3), content="None")

  tuple[0] = PyInteger::from(42);
  inspect!(tuple, content="(42, 2.0, \'three\')")
}

test "PyDict Test" {
  let dict = PyDict::new()
           ..set("one", PyInteger::from(1))
           ..set("two", PyFloat::from(2.0))
           ..set("three", PyBool::from(true));

  inspect!(dict.type_name(), content="dict")
  assert_eq!(dict.len(), 3);
  inspect!(dict, content="{\'one\': 1, \'two\': 2.0, \'three\': True}")

  inspect!(dict.get("one").unwrap(), content="PyInteger(1)")
  inspect!(dict.get("two"), content="Some(PyFloat(2.0))")
  inspect!(dict.get("four"), content="None")

  inspect!(dict["one"], content="PyInteger(1)")
  inspect!(dict["two"], content="PyFloat(2.0)")
  inspect!(dict["three"], content="PyBool(True)")

  inspect!(dict.keys(), content="[\'one\', \'two\', \'three\']")
  inspect!(dict.values(), content="[1, 2.0, True]")

  let dict = PyDict::new()
            ..setByObj!(PyInteger::from(1), PyInteger::from(1))
            ..setByObj!(PyInteger::from(2), PyInteger::from(4))
            ..setByObj!(PyInteger::from(3), PyInteger::from(9))

  inspect!(dict, content="{1: 1, 2: 4, 3: 9}")

  let list = PyList::new()
            ..append(PyInteger::from(3))
            ..append(PyInteger::from(2));

  let e = dict.setByObj?(list, PyInteger::from(42));
  inspect!(e, content="Err(KeyIsUnHashableError)")
}
