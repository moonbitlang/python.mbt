
// typealias PyInteger = @python.PyInteger
// typealias PyList = @python.PyList

test "PyInteger" {
  let x = PyInteger::new(42)

  inspect!(x, content = "42")
}
