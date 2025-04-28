///|
typealias Pen = @turtle.Pen

///|
fn main {
  let color = [
    @turtle.Red,
    @turtle.Purple,
    @turtle.Blue,
    @turtle.Green,
    @turtle.Orange,
    @turtle.Yellow,
  ]
  let p = Pen::new()
  @turtle.bgcolor(@turtle.Black)
  for i in 0..<360 {
    p.pencolor(color[i % 6])
    p.width(i.to_double() / 100 + 1)
    p.forward(i.to_double())
    p.left(59)
  }
}
