// cell

///|
#owned(a)
pub extern "C" fn py_cell_new(a : PyObjectRef) -> PyObjectRef = "PyCell_New"

///|
#owned(a)
pub extern "C" fn py_cell_get(a : PyObjectRef) -> PyObjectRef = "PyCell_Get"

///|
#owned(a, b)
pub extern "C" fn py_cell_set(a : PyObjectRef, b : PyObjectRef) -> Int = "PyCell_Set"

// Eval

///|
#owned(a, b, c)
pub extern "C" fn py_eval_eval_code(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> PyObjectRef = "PyEval_EvalCode"