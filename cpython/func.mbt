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
