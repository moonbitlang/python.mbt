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

///|
/// Represents common colors used for drawing.
/// Deriving Show provides a default to_string() which can be converted to lowercase for Python.
pub(all) enum Color {
  Red
  Green
  Blue
  Purple
  Orange
  Yellow
  Black
  Silver
  White // Added more colors
  Gray
  Brown
  Cyan
  Magenta
  Lime
  Pink
  Teal
  Indigo
  Violet
} derive(Show)

///|
/// Converts the Color enum to a lowercase string representation suitable for Python turtle.
/// - self: The Color enum value.
/// Returns: The color name as a PyString.
pub fn Color::to_pystr(self : Color) -> PyString {
  let s = self.to_string().to_lower()
  PyString::from(s)
}
