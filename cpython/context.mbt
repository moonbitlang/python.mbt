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

// context

///|
pub extern "C" fn py_context_new() -> PyObjectRef = "PyContext_New"

///|
#owned(a)
pub extern "C" fn py_context_copy(a : PyObjectRef) -> PyObjectRef = "PyContext_Copy"

///|
pub extern "C" fn py_context_copy_current() -> PyObjectRef = "PyContext_CopyCurrent"

///|
#owned(a)
pub extern "C" fn py_context_enter(a : PyObjectRef) -> Int = "PyContext_Enter"

///|
#owned(a)
pub extern "C" fn py_context_exit(a : PyObjectRef) -> Int = "PyContext_Exit"

///|
#owned(name, default_value)
pub extern "C" fn py_context_var_new(
  name : CStr,
  default_value : PyObjectRef,
) -> PyObjectRef = "PyContextVar_New"

///|
#owned(pyvar, default_value, value)
pub extern "C" fn py_context_var_get(
  pyvar : PyObjectRef,
  default_value : PyObjectRef,
  value : ArrayPyObjectRef,
) -> Int = "PyContextVar_Get"

///|
#owned(pyvar, value)
pub extern "C" fn py_context_var_set(
  pyvar : PyObjectRef,
  value : PyObjectRef,
) -> PyObjectRef = "PyContextVar_Set"

///|
#owned(pyvar, token)
pub extern "C" fn py_context_var_reset(
  pyvar : PyObjectRef,
  token : PyObjectRef,
) -> Int = "PyContextVar_Reset"

///|
pub extern "C" fn _py_context_new_hamt_for_tests() -> PyObjectRef = "_PyContext_NewHamtForTests"

///|
pub extern "C" fn py_context_clear_free_list() -> Int = "PyContext_ClearFreeList"
