pub extern "C" fn pylong_from_long(value: Int64) -> PyObjectRef = "PyLong_FromLong"

// As Long
pub extern "C" fn pylong_as_long(obj: PyObjectRef) -> Int64 = "PyLong_AsLong"

// As Double
pub extern "C" fn pylong_as_double(obj: PyObjectRef) -> Double = "PyLong_AsDouble"
