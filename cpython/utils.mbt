///|
priv trait ToCStr {
  to_cstr(Self) -> Bytes
}

///|
impl ToCStr for String with to_cstr(self) {
  self.to_bytes().to_array().filter(fn(c) { c != 0 })..push(0)
  |> @bytes.from_array
}
