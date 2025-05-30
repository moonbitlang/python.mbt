///| Represents common colors used for drawing.
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

///| Converts the Color enum to a lowercase string representation suitable for Python turtle.
/// - self: The Color enum value.
/// Returns: The color name as a PyString.
pub fn Color::to_pystr(self : Color) -> PyString {
  let s = self.to_string().to_lower()
  PyString::from(s)
}
