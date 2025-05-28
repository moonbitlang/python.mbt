///|
pub(all) enum Speed {
  Fastest
  Fast
  Normal
  Slow
  Slowest
}

///|
fn Speed::to_pynum(self : Speed) -> PyInteger {
  let i = match self {
    Speed::Fastest => 0L
    Speed::Fast => 10
    Speed::Normal => 6
    Speed::Slow => 3
    Speed::Slowest => 1
  }
  PyInteger::from(i)
}
