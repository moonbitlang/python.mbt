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
}

///|
pub impl Show for Color with fn output(self, logger) {
  match self {
    Red => logger.write_string("Red")
    Green => logger.write_string("Green")
    Blue => logger.write_string("Blue")
    Purple => logger.write_string("Purple")
    Orange => logger.write_string("Orange")
    Yellow => logger.write_string("Yellow")
    Black => logger.write_string("Black")
    Silver => logger.write_string("Silver")
    White => logger.write_string("White")
    Gray => logger.write_string("Gray")
    Brown => logger.write_string("Brown")
    Cyan => logger.write_string("Cyan")
    Magenta => logger.write_string("Magenta")
    Lime => logger.write_string("Lime")
    Pink => logger.write_string("Pink")
    Teal => logger.write_string("Teal")
    Indigo => logger.write_string("Indigo")
    Violet => logger.write_string("Violet")
  }
}

///|
/// Converts the Color enum to a lowercase string representation suitable for Python turtle.
/// - self: The Color enum value.
/// Returns: The color name as a PyString.
pub fn Color::to_pystr(self : Color) -> PyString {
  let s = self.to_string().to_lower()
  PyString::from(s)
}
