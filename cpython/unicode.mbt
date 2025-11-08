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

// Unicode

///|
#owned(u)
pub extern "C" fn py_unicode_from_unicode(
  u : CWStr,
  size : UInt64,
) -> PyObjectRef = "PyUnicode_FromStringAndSize"

///|
#owned(u)
pub extern "C" fn py_unicode_from_string_and_size(
  u : CStr,
  size : UInt64,
) -> PyObjectRef = "PyUnicode_FromStringAndSize"

///|
#owned(u)
extern "C" fn __py_unicode_from_string(u : CStr) -> PyObjectRef = "PyUnicode_FromString"

///|
pub fn py_unicode_from_string(s : String) -> PyObjectRef {
  let u = CStr::from(s)
  __py_unicode_from_string(u)
}

// PyAPI_FUNC(const char *) PyUnicode_AsUTF8(PyObject *unicode);

///|
#owned(u)
extern "C" fn __py_unicode_as_utf8(u : PyObjectRef) -> CStr = "PyUnicode_AsUTF8"

///|
#owned(u)
pub extern "C" fn py_unicode_as_utf16_string(u : PyObjectRef) -> PyObjectRef = "PyUnicode_AsUTF16String"

///|
#owned(u)
pub extern "C" fn py_unicode_as_moonbit_string(u : PyObjectRef) -> String = "py_unicode_as_moonbit_string"

///|
pub fn py_unicode_as_utf8(u : PyObjectRef) -> String {
  let cstr = __py_unicode_as_utf8(u)
  cstr.to_string()
}

///|
#borrow(buffer)
extern "C" fn __py_unicode_from_kind_and_data(
  kind : Int,
  buffer : String,
  size : UInt64,
) -> PyObjectRef = "PyUnicode_FromKindAndData"

///|
pub fn py_unicode_from_moonbit_string(s : String) -> PyObjectRef {
  let kind = 2 // 2 = PyUnicode_2BYTE_KIND
  let size = s.length().to_uint64()
  __py_unicode_from_kind_and_data(kind, s, size)
}
