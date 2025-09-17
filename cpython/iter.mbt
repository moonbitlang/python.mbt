// Iter

///|
#owned(a)
pub extern "C" fn py_seq_iter_new(a : PyObjectRef) -> PyObjectRef = "PySeqIter_New"

///|
#owned(a, b)
pub extern "C" fn py_call_iter_new(
  a : PyObjectRef,
  b : PyObjectRef,
) -> PyObjectRef = "PyCallIter_New"
