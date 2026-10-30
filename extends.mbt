// Copyright 2026 International Digital Economy Academy
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

///|
pub extend PyBool with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyBool with Show::{to_string, output}

///|
pub extend PyCallable with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyCallable with Show::{to_string, output}

///|
pub extend PyDict with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyDict with Show::{to_string, output}

///|
pub extend PyFloat with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyFloat with Show::{to_string, output}

///|
pub extend PyInteger with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyInteger with Show::{to_string, output}

///|
pub extend PyList with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyList with Show::{to_string, output}

///|
pub extend PyModule with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyModule with Show::{to_string, output}

///|
pub extend PyObject with IsPyObject::{obj}

///|
pub extend PyObject with Show::{to_string, output}

///|
pub extend PyObjectEnum with Show::{to_string, output}

///|
pub extend PyRuntimeError with Show::{to_string, output}

///|
pub extend PyString with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyString with Show::{to_string, output}

///|
pub extend PyTuple with IsPyObject::{type_name, obj, obj_ref}

///|
pub extend PyTuple with Show::{to_string, output}
