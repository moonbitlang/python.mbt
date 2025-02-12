// fn main {
//   @cpython.py_init()
//
//   if (not(@cpython.py_is_initialized())) {
//     println("Python initialization failed")
//     return 
//   }
//
//   let plist = @cpython.py_list_new(0)
//
//   let a = @cpython.py_long_from_long(42)
//   let b = @cpython.py_long_from_long(33)
//
//   let _ = @cpython.py_list_append(plist, a)
//   let _ = @cpython.py_list_append(plist, b)
//
//   @cpython.print_pyobject(plist)
//
//   println("")
//
//   @cpython.py_decref(plist)
//   @cpython.py_finalize()
// }

fn main {
  let plt = match @matplotlib.new?() {
    Ok(plt) => plt
    Err(e) => {
      println("Error Happened!")
      println(e)
      panic()
    }
  }

  let x = [1.0, 2.0, 3.0, 4.0, 5.0]
  let y = x.map(fn { x => x *2.0 })
  plt.plot(x, y)
  plt.show()
}
