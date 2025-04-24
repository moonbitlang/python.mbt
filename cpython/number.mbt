// PyObjectRef  PyBool_FromLong(long);

///|
pub extern "C" fn py_long_from_long(value : Int64) -> PyObjectRef = "PyLong_FromLong"

// As Long
///|
pub extern "C" fn py_long_as_long(obj : PyObjectRef) -> Int64 = "PyLong_AsLong"

// As Double
///|
pub extern "C" fn py_long_as_double(obj : PyObjectRef) -> Double = "PyLong_AsDouble"

// Float

///|
pub extern "C" fn py_float_from_double(value : Double) -> PyObjectRef = "PyFloat_FromDouble"

///|
pub extern "C" fn py_float_as_double(obj : PyObjectRef) -> Double = "PyFloat_AsDouble"

///|
pub extern "C" fn py_float_get_max() -> Double = "PyFloat_GetMax"

///|
pub extern "C" fn py_float_get_min() -> Double = "PyFloat_GetMin"

///|
pub extern "C" fn py_float_get_info() -> PyObjectRef = "PyFloat_GetInfo"

///|
pub extern "C" fn py_float_from_string(obj : PyObjectRef) -> PyObjectRef = "PyFloat_FromString"

// Complex
///|
pub extern "C" fn py_complex_from_doubles(
  real : Double,
  imag : Double
) -> PyObjectRef = "PyComplex_FromDoubles"

///|
pub extern "C" fn py_complex_real_as_double(op : PyObjectRef) -> Double = "PyComplex_RealAsDouble"

///|
pub extern "C" fn py_complex_imag_as_double(op : PyObjectRef) -> Double = "PyComplex_ImagAsDouble"

// Bool
///|
pub extern "C" fn py_bool_from_long(value : Int64) -> PyObjectRef = "PyBool_FromLong"
