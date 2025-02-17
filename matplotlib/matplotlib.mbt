typealias PyModule = @python.PyModule
typealias PyString = @python.PyString
// typealias PyInteger = @python.PyInteger
typealias PyTuple = @python.PyTuple
typealias PyDict = @python.PyDict
typealias PyList = @python.PyList
typealias PyFunc = @python.PyFunc

type! MatplotlibError {
  LoadMatplotlibError
  LoadPyPlotError
  LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  // CallFuncError(String)
} derive(Show)

pub struct Matplotlib {
  // priv matplotlib: PyModule 
  priv pyplot: PyModule
  // priv color_map: PyModule
  priv pylab: PyModule
  priv funcs: Map[String, PyFunc]
}

pub fn new() -> Matplotlib!Error {
  let matplotlib = @python.pyimport("matplotlib")

  // @cpython.py_object_call_method(
  //   matplotlib.get_obj(), "use", "s"
  // )

  let pyplot = @python.pyimport("matplotlib.pyplot")
  let color_map = @python.pyimport("matplotlib.cm")
  let pylab = @python.pyimport("pylab")

  let _ = match matplotlib {
    Some(m) => m
    None => raise LoadMatplotlibError
  }

  let pyplot = match pyplot {
    Some(m) => m
    None => raise LoadPyPlotError
  }

  let _ = match color_map {
    Some(m) => m
    None => raise LoadColorMapError
  }

  let pylab = match pylab {
    Some(m) => m
    None => raise LoadPylabError
  }

  let funcs: Map[String, PyFunc] = Map::new()

  Matplotlib::{
    // matplotlib,
    pyplot,
    // color_map,
    pylab,
    funcs
  }
}

fn pyplot_get_func(fname: String) -> PyFunc!MatplotlibError {
  let lib = singleton()
  match lib.funcs.get(fname) {
    Some(f) => return f
    None =>()
  }
  let f = match lib.pyplot.get_func(fname) {
    Some(f) => f
    None => raise LoadFuncError("Didn't find function : \{fname} in matplotlib.pyplot")
  }
  lib.funcs.set(fname, f)
  f
}

fn pylab_get_func(fname: String) -> PyFunc!MatplotlibError {
  let lib = singleton()
  match lib.funcs.get(fname) {
    Some(f) => return f
    None =>()
  }
  let f = match lib.pylab.get_func(fname) {
    Some(f) => f
    None => raise LoadFuncError("Didn't find function : \{fname} in pylab")
  }
  lib.funcs.set(fname, f)
  f
}

let singleton : () -> Matplotlib = get_lib()

fn get_lib() -> () -> Matplotlib {
  @python.init_py()
 
  let mlib = match new?() {
    Ok(mlib) => mlib
    Err(e) => {
      println(e)
      panic()
    }
  }

  fn () {mlib}
}

fn unwrap_func(maybe_func: Result[PyFunc, MatplotlibError]) -> PyFunc {
  match maybe_func {
    Ok(f) => f
    Err(e) => {
      println(e)
      panic()
    }
  }
}

pub fn plot(xs: PyList, ys: PyList, format~: String = "r") -> Unit{
  let func = pyplot_get_func?("plot") |> unwrap_func
  let format = @python.PyString::from(format)

  let plot_args = PyTuple::from((xs, ys, format))
  let _ = func.invoke(plot_args)

  plot_args.drop()
}

pub fn xlim(left: Double, right: Double) -> Unit{
  let func = pyplot_get_func?("xlim") |> unwrap_func

  let list = PyList::from([left, right])
  let args = PyTuple::new(1) .. set(0, list)

  let _ = func.invoke(args)

  args.drop()
}

pub fn ylim(left: Double, right: Double) -> Unit {
  let func = pyplot_get_func?("ylim") |> unwrap_func

  let list = @python.PyList::from([left, right])
  let args = @python.PyTuple::new(1) .. set(0, list)

  let _ = func.invoke(args)

  args.drop()
}

pub fn title(
  title_str: String,
  // keywords~: Map[String, String] = Map::new()
) -> Unit {
  let func = pyplot_get_func?("title") |> unwrap_func
  let py_str = PyString::from(title_str)

  let args = PyTuple::new(1) .. set(0, py_str)

  let _ = func.invoke(args)

  args.drop()
}


pub fn show() -> Unit {
  let func = pyplot_get_func?("show") |> unwrap_func
  let _ = func.invoke(PyTuple::new(0))
}

pub fn save(
  filename: String,
  dpi~: Int = 0
) -> Unit {
  let func = pylab_get_func?("save") |> unwrap_func
  let py_str = PyString::from(filename)

  let args = PyTuple::new(1) .. set(0, py_str)
  let kwargs = PyDict::new()

  if dpi > 0 {
    kwargs.set("dpi", dpi)
  }

  let _ = func.invoke(args, kwargs = kwargs)

  args.drop()
  kwargs.drop()
}
