
typealias PyTuple = @python.PyTuple
typealias PyList = @python.PyList
typealias PyFloat = @python.PyFloat

fnalias @math.(sin, cos)

///|
fn main {
  guard @python.pyimport("matplotlib.pyplot") is Some(pyplot) else {
    println("Failed to import matplotlib.pyplot")
    return
  }

  guard pyplot.get_attr("subplots") is Some(PyCallable(subplots)) else {
    println("Failed to get subplots")
    return
  }

  let args0 = PyTuple::new(0)

  guard subplots.invoke(args0) is Some(PyTuple(fig_ax))

  let fig = fig_ax[0]
  guard fig_ax[1] is PyClass(ax) 

  guard ax.get_attr("plot") is Some(PyCallable(plot)) else {
    println("Failed to get plot")
    return
  }

  guard pyplot.get_attr("show") is Some(PyCallable(show)) else {
    println("Failed to get show")
    return
  }

  let n = 5000 // number of data points
  let t : Array[Double] = Array::makei(n, fn(i) {
    2.0 * @math.PI * i.to_double() / n.to_double()
  })
  let xs = t.map(fn(t) { 16.0 * sin(t) * sin(t) * sin(t) })
  let ys = t.map(fn(t) {
    13.0 * cos(t) -
    5.0 * cos(2.0 * t) -
    2.0 * cos(3.0 * t) -
    cos(4.0 * t)
  })

  let xs = xs.map(@python.PyFloat::from) |> PyList::from
  let ys = ys.map(@python.PyFloat::from) |> PyList::from

  let args = PyTuple::new(2)
  args.set?(0, xs).unwrap()
  args.set?(1, ys).unwrap()

  let _ = plot.invoke(args)
  let _ = show.invoke(args0)

  println(fig)
  println(ax)
}
