

test "Module Test" {
  let m = @python.pyimport("os", print_err = true)

  assert_true!(m is Some(_))
  //assert_true!(matplotlib is Some(_))

  //let collections = collections.unwrap()
  //guard m.unwrap().get("__version__") is Some(PyConstantString(_))

  //println("numpy version: \{s}")

  //collections.unwrap().dump()
}
