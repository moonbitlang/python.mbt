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

// Module

///|
#owned(name)
pub extern "C" fn py_module_new_object(name : PyObjectRef) -> PyObjectRef = "PyModule_NewObject"

///|
#owned(name)
pub extern "C" fn py_module_new(name : CStr) -> PyObjectRef = "PyModule_New"

///|
#owned(a)
pub extern "C" fn py_module_get_dict(a : PyObjectRef) -> PyObjectRef = "PyModule_GetDict"

///|
#owned(a)
pub extern "C" fn py_module_get_name_object(a : PyObjectRef) -> PyObjectRef = "PyModule_GetNameObject"

///|
#owned(a)
pub extern "C" fn py_module_get_name(a : PyObjectRef) -> CStr = "PyModule_GetName"

///|
#owned(a)
pub extern "C" fn py_module_get_filename_object(a : PyObjectRef) -> PyObjectRef = "PyModule_GetFilenameObject"
