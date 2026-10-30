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
fn[T] unless(cond : Bool, value : () -> T) -> T? {
  if !cond {
    Some(value())
  } else {
    None
  }
}

///|
fn[T] when(cond : Bool, value : () -> T) -> T? {
  if cond {
    Some(value())
  } else {
    None
  }
}

///|
pub fn init_py() -> Unit {
  if !@cpython.py_is_initialized() {
    @cpython.py_init()
    if !@cpython.py_is_initialized() {
      println("Python initialization failed")
      return
    }
  }
}

///|
fn init {
  init_py()
}

///|
/// elimnate the quotes from a string
///
/// ## Example
///
/// ```moonbit nocheck
/// let s = "\'os\'"
/// inspect(@python.strip_quot(s), content="os")
/// ```
pub fn strip_quot(s : String) -> String {
  if s.has_prefix("\'") && s.has_suffix("\'") {
    return s.exact_view(start=1, end=s.length() - 1).to_owned()
  }
  s
}
