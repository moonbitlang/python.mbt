///|
pub(all) enum Color {
  Red
  Green
  Blue
  Purple
  Orange
  Yellow
  Black
  Silver
} derive(Show)

///|
pub fn Color::to_pystr(self : Color) -> PyString {
  let s = self.to_string().to_lower()
  PyString::from(s)
}



