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

// class

///|
#owned(a, b)
pub extern "C" fn py_method_new(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyMethod_New"

///|
#owned(a)
pub extern "C" fn py_method_function(a : PyObjectRef) -> PyObjectRef = "PyMethod_Function"

///|
#owned(a)
pub extern "C" fn py_method_self(a : PyObjectRef) -> PyObjectRef = "PyMethod_Self"

///|
pub extern "C" fn py_method_clear_free_list() -> Int = "PyMethod_ClearFreeList"

///|
#owned(a)
pub extern "C" fn py_instance_method_new(a : PyObjectRef) -> PyObjectRef = "PyInstanceMethod_New"

///|
#owned(a)
pub extern "C" fn py_instance_method_function(a : PyObjectRef) -> PyObjectRef = "PyInstanceMethod_Function"