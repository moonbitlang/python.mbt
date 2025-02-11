pub extern "C" fn pylong_from_long(value: Int64) -> PyObjectRef = "PyLong_FromLong"

// As Long
pub extern "C" fn pylong_as_long(obj: PyObjectRef) -> Int64 = "PyLong_AsLong"

// As Double
pub extern "C" fn pylong_as_double(obj: PyObjectRef) -> Double = "PyLong_AsDouble"

// Float

pub extern "C" fn pyfloat_from_double(value: Double) -> PyObjectRef = "PyFloat_FromDouble"

pub extern "C" fn pyfloat_as_double(obj: PyObjectRef) -> Double = "PyFloat_AsDouble"

pub extern "C" fn pyfloat_get_max() -> Double = "PyFloat_GetMax"

pub extern "C" fn pyfloat_get_min() -> Double = "PyFloat_GetMin"

pub extern "C" fn pyfloat_get_info() -> PyObjectRef = "PyFloat_GetInfo"

pub extern "C" fn pyfloat_from_string(obj: PyObjectRef) -> PyObjectRef = "PyFloat_FromString"


