typealias PyString = @python.PyString
// typealias PyInteger = @python.PyInteger
typealias PyTuple = @python.PyTuple
typealias PyDict = @python.PyDict

type! MatplotlibError {
  LoadMatplotlibError
  LoadPyPlotError
  LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  CallFuncError(String)
} derive(Show)

pub struct Matplotlib {
  // priv matplotlib: @python.PyModule 
  // priv pyplot: @python.PyModule
  // priv color_map: @python.PyModule
  // priv pylab: @python.PyModule
  priv funcs: Map[String, @python.PyFunc]
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

  let funcs: Map[String, @python.PyFunc] = Map::new()

  fn unwrap_pyfunc(f: @python.PyFunc?, fname: String) -> Unit!Error {
    match f {
      Some(f) => funcs.set(fname, f)
      None => raise LoadFuncError("Didn't find function : \{fname}")
    }
  }

  pyplot.get_func("arrow") |> unwrap_pyfunc!("arrow")
  pyplot.get_func("show") |> unwrap_pyfunc!("show")
  pyplot.get_func("close") |> unwrap_pyfunc!("close")
  pyplot.get_func("draw") |> unwrap_pyfunc!("draw") 
  pyplot.get_func("pause") |> unwrap_pyfunc!("pause") 
  pyplot.get_func("figure") |> unwrap_pyfunc!("figure") 
  pyplot.get_func("fignum_exists") |> unwrap_pyfunc!("fignum_exists") 
  pyplot.get_func("plot") |> unwrap_pyfunc!("plot") 
  pyplot.get_func("quiver") |> unwrap_pyfunc!("quiver") 
  pyplot.get_func("contour") |> unwrap_pyfunc!("contour") 
  pyplot.get_func("semilogx") |> unwrap_pyfunc!("semilogx") 
  pyplot.get_func("semilogy") |> unwrap_pyfunc!("semilogy") 
  pyplot.get_func("loglog") |> unwrap_pyfunc!("loglog") 
  pyplot.get_func("fill") |> unwrap_pyfunc!("fill") 
  pyplot.get_func("fill_between") |> unwrap_pyfunc!("fill_between") 
  pyplot.get_func("hist") |> unwrap_pyfunc!("hist") 
  pyplot.get_func("imshow") |> unwrap_pyfunc!("imshow") 
  pyplot.get_func("scatter") |> unwrap_pyfunc!("scatter") 
  pyplot.get_func("boxplot") |> unwrap_pyfunc!("boxplot") 
  pyplot.get_func("subplot") |> unwrap_pyfunc!("subplot") 
  pyplot.get_func("subplot2grid") |> unwrap_pyfunc!("subplot2grid") 
  pyplot.get_func("legend") |> unwrap_pyfunc!("legend") 
  pyplot.get_func("xlim") |> unwrap_pyfunc!("xlim") 
  pyplot.get_func("ion") |> unwrap_pyfunc!("ion") 
  pyplot.get_func("ginput") |> unwrap_pyfunc!("ginput") 
  pyplot.get_func("ylim") |> unwrap_pyfunc!("ylim") 
  pyplot.get_func("title") |> unwrap_pyfunc!("title") 
  pyplot.get_func("axis") |> unwrap_pyfunc!("axis") 
  pyplot.get_func("axhline") |> unwrap_pyfunc!("axhline") 
  pyplot.get_func("axvline") |> unwrap_pyfunc!("axvline") 
  pyplot.get_func("axvspan") |> unwrap_pyfunc!("axvspan") 
  pyplot.get_func("xlabel") |> unwrap_pyfunc!("xlabel") 
  pyplot.get_func("ylabel") |> unwrap_pyfunc!("ylabel") 
  pyplot.get_func("gca") |> unwrap_pyfunc!("gca") 
  pyplot.get_func("xticks") |> unwrap_pyfunc!("xticks") 
  pyplot.get_func("yticks") |> unwrap_pyfunc!("yticks") 
  pyplot.get_func("margins") |> unwrap_pyfunc!("margins") 
  pyplot.get_func("tick_params") |> unwrap_pyfunc!("tick_params") 
  pyplot.get_func("grid") |> unwrap_pyfunc!("grid") 
  pyplot.get_func("cla") |> unwrap_pyfunc!("cla") 
  pyplot.get_func("clf") |> unwrap_pyfunc!("clf") 
  pyplot.get_func("errorbar") |> unwrap_pyfunc!("errorbar") 
  pyplot.get_func("annotate") |> unwrap_pyfunc!("annotate") 
  pyplot.get_func("tight_layout") |> unwrap_pyfunc!("tight_layout") 
  pyplot.get_func("stem") |> unwrap_pyfunc!("stem") 
  pyplot.get_func("xkcd") |> unwrap_pyfunc!("xkcd") 
  pyplot.get_func("text") |> unwrap_pyfunc!("text") 
  pyplot.get_func("suptitle") |> unwrap_pyfunc!("suptitle") 
  pyplot.get_func("bar") |> unwrap_pyfunc!("bar") 
  pyplot.get_func("barh") |> unwrap_pyfunc!("barh") 
  pyplot.get_func("colorbar") |> unwrap_pyfunc!("colorbar") 
  pyplot.get_func("subplots_adjust") |> unwrap_pyfunc!("subplots_adjust") 
  pyplot.get_func("spy") |> unwrap_pyfunc!("spy") 

  pylab.get_func("save") |> unwrap_pyfunc!("save") 

  Matplotlib::{
    // matplotlib,
    // pyplot,
    // color_map,
    // pylab,
    funcs
  }
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

pub fn plot(
  xs: @python.PyList,
  ys: @python.PyList,
  format~: String = "r"
) -> Unit {
  let lib = singleton()
  let func = lib.funcs["plot"].unwrap()
  let format = @python.PyString::from(format)

  let plot_args = @python.PyTuple::new(3)
  plot_args[0] = xs
  plot_args[1] = ys
  plot_args[2] = format

  let _ = func.invoke(plot_args)

  // TODO: Eliminate this when we can do gc
  plot_args.drop()
}

pub fn show() -> Unit {
  let lib = singleton()
  let func = lib.funcs["show"].unwrap()
  let _ = func.invoke(PyTuple::new(0))
}

pub fn save(
  filename: String,
  dpi~: Int = 0
) -> Unit!Error {
  let lib = singleton()
  let py_str = PyString::from(filename)

  let args = PyTuple::new(1)
  args[0] = py_str

  let kwargs = PyDict::new()

  if dpi > 0 {
    kwargs.set("dpi", dpi)
  }

  let func = lib.funcs["save"].unwrap()
  let res = func.invoke(args, kwargs = kwargs)

  if res.is_null() {
    raise CallFuncError("Call to save() failed")
  }

  args.drop()
  kwargs.drop()
  res.drop()
}

