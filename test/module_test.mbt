///|
test "Module Test" {
  let os = @python.pyimport("os", print_err=true)
  assert_true!(os is Some(_))
  let os = os.unwrap()
  inspect!(os.get_name(), content="os")
  guard os.get_attr("name").unwrap() is PyString(s)
  assert_true!(["posix", "nt", "java"].contains(s.to_string()))
  assert_true!(os.get_attr("listdir") is Some(PyCallable(_)))

  /// ```python
  /// import collections
  /// ```
  let collections = @python.pyimport("collections", print_err=true)
  assert_true!(collections is Some(_))
  let collections = collections.unwrap()

  /// ```python
  /// from collections import Counter
  /// ```
  guard collections.get_attr("Counter").unwrap() is PyCallable(counter)

  // ```python
  // elements = [1, 2, 2, 3, 3, 3]
  // counter = Counter(elements)
  // print(counter) # Output: Counter({3: 3, 2: 2, 1: 1})
  // ```
  let list = [1L, 2, 2, 3, 3, 3].map(PyInteger::from) |> PyList::from
  let args = PyTuple::new(1)..set(0, list)
  guard counter.invoke(args~) is Some(PyDict(cnt))
  inspect!(cnt, content="Counter({3: 3, 2: 2, 1: 1})")

  // ```python
  // print(cnt.total()) # Output: 6
  // ```
  guard cnt.obj().get_attr("total") is Some(PyCallable(total))
  let args = PyTuple::new(0)
  inspect!(total.invoke(args~).unwrap(), content="PyInteger(6)")
}
