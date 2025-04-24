//fn main {
//  let x = Array::makei(100, fn (i) { i.to_double() })
//  let y = x.map(@math.ln)
//
//  let x = PyList::from(x)
//  let y = PyList::from(y)
//
//  @plt.plot(x, y)
//  @plt.show()
//}

///|
fn main {
  let f = @python.PyFloat::from(3.5)
  println(f)
  println(f.type_name())
  println(f.to_double())
}
