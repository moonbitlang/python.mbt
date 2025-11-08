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

// code

///|
#owned(f, g, h, i, j, k, l, m, o)
pub extern "C" fn py_code_new(
  a : Int,
  b : Int,
  c : Int,
  d : Int,
  e : Int,
  f : PyObjectRef,
  g : PyObjectRef,
  h : PyObjectRef,
  i : PyObjectRef,
  j : PyObjectRef,
  k : PyObjectRef,
  l : PyObjectRef,
  m : PyObjectRef,
  n : Int,
  o : PyObjectRef,
) -> PyCodeObjectRef = "PyCode_New"

///|
#owned(g, h, i, j, k, l, m, n, p)
pub extern "C" fn py_code_new_with_pos_only_args(
  a : Int,
  b : Int,
  c : Int,
  d : Int,
  e : Int,
  f : Int,
  g : PyObjectRef,
  h : PyObjectRef,
  i : PyObjectRef,
  j : PyObjectRef,
  k : PyObjectRef,
  l : PyObjectRef,
  m : PyObjectRef,
  n : PyObjectRef,
  o : Int,
  p : PyObjectRef,
) -> PyCodeObjectRef = "PyCode_NewWithPosOnlyArgs"

///|
#owned(filename, funcname)
pub extern "C" fn py_code_new_empty(
  filename : CStr,
  funcname : CStr,
  firstlineno : Int,
) -> PyCodeObjectRef = "PyCode_NewEmpty"

///|
#owned(a)
pub extern "C" fn py_code_addr2_line(a : PyCodeObjectRef, b : Int) -> Int = "PyCode_Addr2Line"