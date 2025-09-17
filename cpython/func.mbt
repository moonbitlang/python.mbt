// Func Object

///|
#owned(a, b)
pub extern "C" fn py_function_new(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyFunction_New"

///|
#owned(a, b, c)
pub extern "C" fn py_function_new_with_qual_name(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> PyObjectRef = "PyFunction_NewWithQualName"

///|
#owned(a)
pub extern "C" fn py_function_get_code(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetCode"

///|
#owned(a)
pub extern "C" fn py_function_get_globals(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetGlobals"

///|
#owned(a)
pub extern "C" fn py_function_get_module(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetModule"

///|
#owned(a)
pub extern "C" fn py_function_get_defaults(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetDefaults"

///|
#owned(a, b)
pub extern "C" fn py_function_set_defaults(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetDefaults"

///|
#owned(a)
pub extern "C" fn py_function_get_kw_defaults(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetKwDefaults"

///|
#owned(a, b)
pub extern "C" fn py_function_set_kw_defaults(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetKwDefaults"

///|
#owned(a)
pub extern "C" fn py_function_get_closure(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetClosure"

///|
#owned(a, b)
pub extern "C" fn py_function_set_closure(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetClosure"

///|
#owned(a)
pub extern "C" fn py_function_get_annotations(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetAnnotations"

///|
#owned(a, b)
pub extern "C" fn py_function_set_annotations(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetAnnotations"

///|
#owned(a)
pub extern "C" fn py_class_method_new(a : PyObjectRef) -> PyObjectRef = "PyClassMethod_New"

///|
#owned(a)
pub extern "C" fn py_static_method_new(a : PyObjectRef) -> PyObjectRef = "PyStaticMethod_New"
