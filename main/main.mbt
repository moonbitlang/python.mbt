///|
typealias @python.(PyInteger, PyList, PyTuple)

///|
fn main {
  // It's equivalent to `nums = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]`
  let nums = [1L, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
  let py_nums = nums.map(PyInteger::from) |> PyList::from
  println(py_nums) // Output: [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

  // It's equivalent to `import collections`
  guard @python.pyimport("collections") is Some(collections)

  // It's equivalent to `from collections import Counter`
  guard collections.get_attr("Counter") is Some(PyCallable(counter))
  let args = PyTuple::new(1)
  args..set(0, py_nums)

  // It's equivalent to `cnt = Counter(nums)`
  guard (try? counter.invoke(args~)) is Ok(Some(cnt))
  guard cnt is PyDict(cnt)

  // `print(cnt)`
  println(cnt) // Output: Counter({4: 4, 3: 3, 2: 2, 1: 2})
}
