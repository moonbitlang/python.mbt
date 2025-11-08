// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// PyObjectRef  PyBool_FromLong(long);

///|
pub extern "C" fn py_long_from_long(value : Int64) -> PyObjectRef = "PyLong_FromLong"

// As Long

///|
#owned(obj)
pub extern "C" fn py_long_as_long(obj : PyObjectRef) -> Int64 = "PyLong_AsLong"

// As Double

///|
#owned(obj)
pub extern "C" fn py_long_as_double(obj : PyObjectRef) -> Double = "PyLong_AsDouble"

// Float

///|
pub extern "C" fn py_float_from_double(value : Double) -> PyObjectRef = "PyFloat_FromDouble"

///|
#owned(obj)
pub extern "C" fn py_float_as_double(obj : PyObjectRef) -> Double = "PyFloat_AsDouble"

///|
pub extern "C" fn py_float_get_max() -> Double = "PyFloat_GetMax"

///|
pub extern "C" fn py_float_get_min() -> Double = "PyFloat_GetMin"

///|
pub extern "C" fn py_float_get_info() -> PyObjectRef = "PyFloat_GetInfo"

///|
#owned(obj)
pub extern "C" fn py_float_from_string(obj : PyObjectRef) -> PyObjectRef = "PyFloat_FromString"

// Complex

///|
pub extern "C" fn py_complex_from_doubles(
  real : Double,
  imag : Double,
) -> PyObjectRef = "PyComplex_FromDoubles"

///|
#owned(op)
pub extern "C" fn py_complex_real_as_double(op : PyObjectRef) -> Double = "PyComplex_RealAsDouble"

///|
#owned(op)
pub extern "C" fn py_complex_imag_as_double(op : PyObjectRef) -> Double = "PyComplex_ImagAsDouble"

// Bool

///|
pub extern "C" fn py_bool_from_long(value : Int64) -> PyObjectRef = "PyBool_FromLong"
