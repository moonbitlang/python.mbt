///|
/// Represents common shapes for the turtle cursor.
/// Deriving Show provides a default to_string() which can be converted to lowercase for Python.
pub(all) enum Shape {
  Arrow
  Turtle
  Circle
  Square
  Triangle
  Classic
} derive(Show)
