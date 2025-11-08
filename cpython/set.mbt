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

// Set

///|
#owned(a)
pub extern "C" fn py_set_new(a : PyObjectRef) -> PyObjectRef = "PySet_New"

///|
#owned(a)
pub extern "C" fn py_frozen_set_new(a : PyObjectRef) -> PyObjectRef = "PyFrozenSet_New"

///|
#owned(set, key)
pub extern "C" fn py_set_add(set : PyObjectRef, key : PyObjectRef) -> Int = "PySet_Add"

///|
#owned(set)
pub extern "C" fn py_set_clear(set : PyObjectRef) -> Int = "PySet_Clear"

///|
#owned(anyset, key)
pub extern "C" fn py_set_contains(
  anyset : PyObjectRef,
  key : PyObjectRef,
) -> Int = "PySet_Contains"

///|
#owned(set, key)
pub extern "C" fn py_set_discard(set : PyObjectRef, key : PyObjectRef) -> Int = "PySet_Discard"

///|
#owned(set)
pub extern "C" fn py_set_pop(set : PyObjectRef) -> PyObjectRef = "PySet_Pop"

///|
#owned(anyset)
pub extern "C" fn py_set_size(anyset : PyObjectRef) -> Int64 = "PySet_Size"
