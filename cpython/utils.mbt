///|
priv trait ToCStr {
  to_cstr(Self) -> Bytes
}

///|
impl ToCStr for String with to_cstr(self) {
  let s = self.to_bytes().to_array().filter(fn(c) { c != 0 })
  s.push(0)
  s |> @bytes.from_array
}
