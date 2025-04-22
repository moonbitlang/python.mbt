test "PyInteger Test" {
  let i = @python.PyInteger::from(42);
  inspect!(i, content="42")
  inspect!(i.type_name(), content="int")
  assert_eq!(i.to_int64(), 42);
  assert_eq!(i.to_double(), 42.0);
}

test "PyFloat Test" {
  let f = @python.PyFloat::from(3.5);
  inspect!(f, content="3.5")
  inspect!(f.type_name(), content="float")
  assert_eq!(f.to_double(), 3.5);
}

test "PyString Test" {
  let s = @python.PyString::from("hello");
  inspect!(s, content="\'hello\'")
  inspect!(s.type_name(), content="str")
}
