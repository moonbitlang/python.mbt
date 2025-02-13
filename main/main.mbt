typealias PyList = @python.PyList

fn main {

  let x : Array[Double] = [] 
  for i in 0..<100 {
    x.push(i.to_double())
  }
  let y = x.map(@math.ln)

  let x = PyList::from(x)
  let y = PyList::from(y)

  @plt.plot(x, y)
  @plt.show()
}
