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

// File

///|
#owned(name, mode, encoding, errors, newline)
pub extern "C" fn py_file_from_fd(
  fd : Int,
  name : CStr,
  mode : CStr,
  closefd : Int,
  encoding : CStr,
  errors : CStr,
  newline : CStr,
  line_buffering : Int,
) -> PyObjectRef = "PyFile_FromFd"

///|
#owned(a)
pub extern "C" fn py_file_get_line(a : PyObjectRef, b : Int) -> PyObjectRef = "PyFile_GetLine"

///|
#owned(a, b)
pub extern "C" fn py_file_write_object(
  a : PyObjectRef,
  b : PyObjectRef,
  c : Int,
) -> Int = "PyFile_WriteObject"

///|
#owned(s, a)
pub extern "C" fn py_file_write_string(s : CStr, a : PyObjectRef) -> Int = "PyFile_WriteString"

///|
#owned(a)
pub extern "C" fn py_object_as_file_descriptor(a : PyObjectRef) -> Int = "PyObject_AsFileDescriptor"

///|
pub extern "C" fn py_file_new_std_printer(a : Int) -> PyObjectRef = "PyFile_NewStdPrinter"

///|
#owned(utf8path)
pub extern "C" fn py_file_open_code(utf8path : CStr) -> PyObjectRef = "PyFile_OpenCode"

///|
#owned(path)
pub extern "C" fn py_file_open_code_object(path : PyObjectRef) -> PyObjectRef = "PyFile_OpenCodeObject"
