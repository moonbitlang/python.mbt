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

// cell

///|
#owned(a)
pub extern "C" fn py_cell_new(a : PyObjectRef) -> PyObjectRef = "PyCell_New"

///|
#owned(a)
pub extern "C" fn py_cell_get(a : PyObjectRef) -> PyObjectRef = "PyCell_Get"

///|
#owned(a, b)
pub extern "C" fn py_cell_set(a : PyObjectRef, b : PyObjectRef) -> Int = "PyCell_Set"

// Eval

///|
#owned(a, b, c)
pub extern "C" fn py_eval_eval_code(
  a : PyObjectRef,
  b : PyObjectRef,
  c : PyObjectRef,
) -> PyObjectRef = "PyEval_EvalCode"