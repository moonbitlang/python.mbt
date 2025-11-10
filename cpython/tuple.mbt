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

// Tuple

///|
pub extern "C" fn pytuple_new(sz : UInt64) -> PyObjectRef = "PyTuple_New"

///|
#owned(tuple)
pub extern "C" fn pytuple_size(tuple : PyObjectRef) -> UInt64 = "PyTuple_Size"

///|
#owned(tuple)
pub extern "C" fn pytuple_get_item(
  tuple : PyObjectRef,
  idx : UInt64,
) -> PyObjectRef = "PyTuple_GetItem"

///|
#owned(tuple, item)
pub extern "C" fn pytuple_set_item(
  tuple : PyObjectRef,
  idx : UInt64,
  item : PyObjectRef,
) -> Int = "PyTuple_SetItem"

///|
#owned(tuple)
pub extern "C" fn pytuple_get_slice(
  tuple : PyObjectRef,
  start : UInt64,
  end : UInt64,
) -> PyObjectRef = "PyTuple_GetSlice"

// PyAPI_FUNC(PyObject *) PyTuple_Pack(Py_ssize_t, ...);
