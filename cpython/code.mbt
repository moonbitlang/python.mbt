// code
///|
pub extern "C" fn py_code_new(
  a : Int,
  b : Int,
  c : Int,
  d : Int,
  e : Int,
  f : PyObjectRef,
  g : PyObjectRef,
  h : PyObjectRef,
  i : PyObjectRef,
  j : PyObjectRef,
  k : PyObjectRef,
  l : PyObjectRef,
  m : PyObjectRef,
  n : Int,
  o : PyObjectRef
) -> PyCodeObjectRef = "PyCode_New"

///|
pub extern "C" fn py_code_new_with_pos_only_args(
  a : Int,
  b : Int,
  c : Int,
  d : Int,
  e : Int,
  f : Int,
  g : PyObjectRef,
  h : PyObjectRef,
  i : PyObjectRef,
  j : PyObjectRef,
  k : PyObjectRef,
  l : PyObjectRef,
  m : PyObjectRef,
  n : PyObjectRef,
  o : Int,
  p : PyObjectRef
) -> PyCodeObjectRef = "PyCode_NewWithPosOnlyArgs"

///|
pub extern "C" fn py_code_new_empty(
  filename : CStr,
  funcname : CStr,
  firstlineno : Int
) -> PyCodeObjectRef = "PyCode_NewEmpty"

///|
pub extern "C" fn py_code_addr2_line(a : PyCodeObjectRef, b : Int) -> Int = "PyCode_Addr2Line"
