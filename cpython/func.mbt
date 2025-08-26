// Func Object

///|
pub extern "C" fn py_function_new(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyFunction_New"

///|
pub extern "C" fn py_function_new_with_qual_name(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> PyObjectRef = "PyFunction_NewWithQualName"

///|
pub extern "C" fn py_function_get_code(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetCode"

///|
pub extern "C" fn py_function_get_globals(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetGlobals"

///|
pub extern "C" fn py_function_get_module(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetModule"

///|
pub extern "C" fn py_function_get_defaults(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetDefaults"

///|
pub extern "C" fn py_function_set_defaults(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetDefaults"

///|
pub extern "C" fn py_function_get_kw_defaults(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetKwDefaults"

///|
pub extern "C" fn py_function_set_kw_defaults(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetKwDefaults"

///|
pub extern "C" fn py_function_get_closure(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetClosure"

///|
pub extern "C" fn py_function_set_closure(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetClosure"

///|
pub extern "C" fn py_function_get_annotations(a : PyObjectRef) -> PyObjectRef = "PyFunction_GetAnnotations"

///|
pub extern "C" fn py_function_set_annotations(
  a : PyObjectRef,
  b : PyObjectRef,
) -> Int = "PyFunction_SetAnnotations"

///|
pub extern "C" fn py_class_method_new(a : PyObjectRef) -> PyObjectRef = "PyClassMethod_New"

///|
pub extern "C" fn py_static_method_new(a : PyObjectRef) -> PyObjectRef = "PyStaticMethod_New"
