// Abstract

///| Call a callable Python object 'callable' with arguments given by the
/// tuple 'args' and keywords arguments given by the dictionary 'kwargs'.
///
/// 'args' must not be NULL, use an empty tuple if no arguments are
/// needed. If no named arguments are needed, 'kwargs' can be NULL.
///
/// This is the equivalent of the Python expression:
/// callable(*args, **kwargs).
#owned(callable, args, kwargs)
pub extern "C" fn py_object_call(
  callable : PyObjectRef,
  args : PyObjectRef,
  kwargs : PyObjectRef,
) -> PyObjectRef = "PyObject_Call"

///| Call a callable Python object 'callable', with arguments given by the
/// tuple 'args'.  If no arguments are needed, then 'args' can be NULL.
///
/// Returns the result of the call on success, or NULL on failure.
///
/// This is the equivalent of the Python expression:
/// callable(*args).
#owned(callable, args)
pub extern "C" fn py_object_call_object(
  callable : PyObjectRef,
  args : PyObjectRef,
) -> PyObjectRef = "PyObject_CallObject"

///| Get the type of an object.
///
/// On success, returns a type object corresponding to the object type of object
/// 'o'. On failure, returns NULL.
///
/// This is equivalent to the Python expression: type(o)
#owned(obj)
pub extern "C" fn py_object_type(obj : PyObjectRef) -> PyObjectRef = "PyObject_Type"

///| Return the size of object 'o'.  If the object 'o' provides both sequence and
/// mapping protocols, the sequence size is returned.
///
/// On error, -1 is returned.
///
/// This is the equivalent to the Python expression: len(o) */
#owned(obj)
pub extern "C" fn py_object_size(obj : PyObjectRef) -> UInt64 = "PyObject_Size"

///| Return element of 'o' corresponding to the object 'key'. Return NULL
/// on failure.
///
/// This is the equivalent of the Python expression: o[key] */
#owned(obj, key)
pub extern "C" fn py_object_get_item(
  obj : PyObjectRef,
  key : PyObjectRef,
) -> PyObjectRef = "PyObject_GetItem"

///| Map the object 'key' to the value 'v' into 'o'.
///
/// Raise an exception and return -1 on failure; return 0 on success.
///
/// This is the equivalent of the Python statement: o[key]=v. */
#owned(obj, key, value)
pub extern "C" fn py_object_set_item(
  obj : PyObjectRef,
  key : PyObjectRef,
  value : PyObjectRef,
) -> Int = "py_object_SetItem"

///| Remove the mapping for the string 'key' from the object 'o'.
/// Returns -1 on failure.
///
/// This is equivalent to the Python statement: del o[key].
#owned(obj, key)
pub extern "C" fn py_object_del_item_string(
  obj : PyObjectRef,
  key : CStr,
) -> Int = "PyObject_DelItemString"

///| Delete the mapping for the object 'key' from the object 'o'.
/// Returns -1 on failure.
///
/// This is the equivalent of the Python statement: del o[key].
#owned(obj, key)
pub extern "C" fn py_object_del_item(
  obj : PyObjectRef,
  key : PyObjectRef,
) -> Int = "PyObject_DelItem"

///| Takes an arbitrary object and returns the result of calling
/// obj.__format__(format_spec).
#owned(obj, format_spec)
pub extern "C" fn pyobkect_format(
  obj : PyObjectRef,
  format_spec : PyObjectRef,
) -> PyObjectRef = "PyObject_Format"

///| Takes an object and returns an iterator for it.
/// This is typically a new iterator but if the argument is an iterator, this
/// returns itself. */
#owned(obj)
pub extern "C" fn py_object_get_iter(obj : PyObjectRef) -> PyObjectRef = "PyObject_GetIter"

///| Returns 1 if the object 'obj' provides iterator protocols, and 0 otherwise.
///
/// This function always succeeds. */
#owned(obj)
pub extern "C" fn pyiter_check(obj : PyObjectRef) -> Int = "PyIter_Check"

///| Takes an iterator object and calls its tp_iternext slot,
/// returning the next value.
///
/// If the iterator is exhausted, this returns NULL without setting an
/// exception.
///
/// NULL with an exception means an error occurred. */
#owned(iter)
pub extern "C" fn pyiter_next(iter : PyObjectRef) -> PyObjectRef = "PyIter_Next"

///| Returns 1 if the object 'o' provides numeric protocols, and 0 otherwise.
///
/// This function always succeeds. */
#owned(obj)
pub extern "C" fn pynumber_check(obj : PyObjectRef) -> Int = "PyNumber_Check"

///| Returns the result of adding o1 and o2, or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 + o2. */
#owned(obj1, obj2)
pub extern "C" fn pynumber_add(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Add"

///| Returns the result of subtracting o2 from o1, or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 - o2. */
#owned(obj1, obj2)
pub extern "C" fn pynumber_subtract(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Subtract"

///| Returns the result of multiplying o1 and o2, or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 * o2. */
#owned(obj1, obj2)
pub extern "C" fn pynumber_multiply(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Multiply"

///| Returns the result of dividing o1 by o2 giving an integral result,
/// or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 // o2. */
#owned(obj1, obj2)
pub extern "C" fn pynumber_floor_divide(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_FloorDivide"

///| Returns the result of dividing o1 by o2 giving a float result, or NULL on
/// failure.
///
/// This is the equivalent of the Python expression: o1 / o2.
#owned(obj1, obj2)
pub extern "C" fn pynumber_true_divide(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_TrueDivide"

///| Returns the remainder of dividing o1 by o2, or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 % o2.
#owned(obj1, obj2)
pub extern "C" fn pynumber_remainder(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Remainder"

///| See the built-in function divmod.
///
/// Returns NULL on failure.
///
/// This is the equivalent of the Python expression: divmod(o1, o2).
#owned(obj1, obj2)
pub extern "C" fn pynumber_divmod(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Divmod"

///| See the built-in function pow. Returns NULL on failure.
///
/// This is the equivalent of the Python expression: pow(o1, o2, o3),
/// where o3 is optional.
#owned(obj1, obj2, obj3)
pub extern "C" fn pynumber_power(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
  obj3 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Power"

///| Returns the negation of o on success, or NULL on failure.
///
/// This is the equivalent of the Python expression: -o.
pub extern "C" fn pynumber_negative(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Negative"

///| Returns the positive of o on success, or NULL on failure.
///
/// This is the equivalent of the Python expression: +o.
pub extern "C" fn pynumber_positive(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Positive"

///| Returns the absolute value of 'o', or NULL on failure.
///
/// This is the equivalent of the Python expression: abs(o).
pub extern "C" fn pynumber_absolute(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Absolute"

///| Returns the bitwise negation of 'o' on success, or NULL on failure.
///
/// This is the equivalent of the Python expression: ~o.
pub extern "C" fn pynumber_invert(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Invert"

///| Returns the result of left shifting o1 by o2 on success, or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 << o2.
pub extern "C" fn pynumber_lshift(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Lshift"

///| Returns the result of right shifting o1 by o2 on success, or NULL on
/// failure.
///
/// This is the equivalent of the Python expression: o1 >> o2.
pub extern "C" fn pynumber_rshift(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Rshift"

///| Returns the result of bitwise and of o1 and o2 on success, or NULL on
/// failure.
///
/// This is the equivalent of the Python expression: o1 & o2.
pub extern "C" fn pynumber_and(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_And"

///| Returns the bitwise exclusive or of o1 by o2 on success, or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 ^ o2.
pub extern "C" fn pynumber_xor(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Xor"

///| Returns the result of bitwise or on o1 and o2 on success, or NULL on
/// failure.
///
/// This is the equivalent of the Python expression: o1 | o2.
pub extern "C" fn pynumber_or(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_Or"

///| Returns 1 if obj is an index integer (has the nb_index slot of the
/// tp_as_number structure filled in), and 0 otherwise.
pub extern "C" fn pyindex_check(obj : PyObjectRef) -> Int = "PyIndex_Check"

///| Returns the object 'o' converted to a Python int, or NULL with an exception
/// raised on failure.
pub extern "C" fn pynumber_index(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Index"

///| Returns the object 'o' converted to Py_ssize_t by going through
/// PyNumber_Index() first.
///
/// If an overflow error occurs while converting the int to Py_ssize_t, then the
/// second argument 'exc' is the error-type to return.  If it is NULL, then the
/// overflow error is cleared and the value is clipped.
pub extern "C" fn pynumber_as_ssize_t(
  obj : PyObjectRef,
  exc : PyObjectRef,
) -> Int = "PyNumber_AsSsize_t"

///| Returns the object 'o' converted to an integer object on success, or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: int(o).
pub extern "C" fn pynumber_long(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Long"

///| Returns the object 'o' converted to a float object on success, or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: float(o).
pub extern "C" fn pynumber_float(obj : PyObjectRef) -> PyObjectRef = "PyNumber_Float"

///| Returns the result of adding o2 to o1, possibly in-place, or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: o1 += o2.
pub extern "C" fn pynumber_inplace_add(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceAdd"

///| Returns the result of subtracting o2 from o1, possibly in-place or
/// NULL on failure.
///
/// This is the equivalent of the Python expression: o1 -= o2.
pub extern "C" fn pynumber_inplace_subtract(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceSubtract"

///| Returns the result of multiplying o1 by o2, possibly in-place, or NULL on
/// failure.
///
/// This is the equivalent of the Python expression: o1 *= o2.
pub extern "C" fn pynumber_inplace_multiply(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceMultiply"

///|
pub extern "C" fn pynumber_inplace_floor_divide(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceFloorDivide"

///| Returns the result of dividing o1 by o2 giving a float result, possibly
/// in-place, or null on failure.
///
/// This is the equivalent of the Python expression: o1 /= o2.
pub extern "C" fn pynumber_inplace_true_divide(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceTrueDivide"

///| Returns the remainder of dividing o1 by o2, possibly in-place, or NULL on
/// failure.
///
/// This is the equivalent of the Python expression: o1 %= o2.
pub extern "C" fn pynumber_inplace_remainder(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceRemainder"

///| Returns the result of raising o1 to the power of o2, possibly in-place,
/// or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 **= o2,
/// or o1 = pow(o1, o2, o3) if o3 is present.
pub extern "C" fn pynumber_inplace_power(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
  obj3 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlacePower"

///| Returns the result of left shifting o1 by o2, possibly in-place, or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: o1 <<= o2.
pub extern "C" fn pynumber_inplace_lshift(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceLshift"

///| Returns the result of right shifting o1 by o2, possibly in-place or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: o1 >>= o2.
pub extern "C" fn pynumber_inplace_rshift(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceRshift"

///| Returns the result of bitwise and of o1 and o2, possibly in-place, or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: o1 &= o2.
pub extern "C" fn pynumber_inplace_and(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceAnd"

///| Returns the bitwise exclusive or of o1 by o2, possibly in-place, or NULL
/// on failure.
///
/// This is the equivalent of the Python expression: o1 ^= o2.
pub extern "C" fn pynumber_inplace_xor(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceXor"

///| Returns the result of bitwise or of o1 and o2, possibly in-place,
/// or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 |= o2.
pub extern "C" fn pynumber_inplace_or(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PyNumber_InPlaceOr"

///| Returns the integer n converted to a string with a base, with a base
/// marker of 0b, 0o or 0x prefixed if applicable.
///
/// If n is not an int object, it is converted with PyNumber_Index first. */
pub extern "C" fn pynumber_to_base(
  obj : PyObjectRef,
  base : Int,
) -> PyObjectRef = "PyNumber_ToBase"

///| Return 1 if the object provides sequence protocol, and zero
/// otherwise.
///
/// This function always succeeds.
pub extern "C" fn pysequence_check(obj : PyObjectRef) -> Int = "PySequence_Check"

///| Return the size of sequence object o, or -1 on failure. */
pub extern "C" fn pysequence_size(obj : PyObjectRef) -> Int = "PySequence_Size"

///| Return the concatenation of o1 and o2 on success, and NULL on failure.
///
/// This is the equivalent of the Python expression: o1 + o2. */
pub extern "C" fn pysequence_concat(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PySequence_Concat"

///| Return the result of repeating sequence object 'o' 'count' times,
/// or NULL on failure.
///
/// This is the equivalent of the Python expression: o * count. */
pub extern "C" fn pysequence_repeat(
  obj : PyObjectRef,
  count : Int,
) -> PyObjectRef = "PySequence_Repeat"

///| Return the ith element of o, or NULL on failure.
///
/// This is the equivalent of the Python expression: o[i].
pub extern "C" fn pysequence_get_item(
  obj : PyObjectRef,
  idx : UInt64,
) -> PyObjectRef = "PySequence_GetItem"

///| Return the slice of sequence object o between i1 and i2, or NULL on failure.
///
/// This is the equivalent of the Python expression: o[i1:i2].
pub extern "C" fn pysequence_get_slice(
  obj : PyObjectRef,
  start : UInt64,
  end : UInt64,
) -> PyObjectRef = "PySequence_GetSlice"

///| Assign object 'v' to the ith element of the sequence 'o'. Raise an exception
/// and return -1 on failure; return 0 on success.
///
/// This is the equivalent of the Python statement o[i] = v. */
pub extern "C" fn pysequence_set_item(
  obj : PyObjectRef,
  idx : UInt64,
  value : PyObjectRef,
) -> Int = "PySequence_SetItem"

///| Delete the 'i'-th element of the sequence 'v'. Returns -1 on failure.
///
/// This is the equivalent of the Python statement: del o[i]. */
pub extern "C" fn pysequence_del_item(obj : PyObjectRef, idx : UInt64) -> Int = "PySequence_DelItem"

///| Assign the sequence object 'v' to the slice in sequence object 'o',
/// from 'i1' to 'i2'. Returns -1 on failure.
///
/// This is the equivalent of the Python statement: o[i1:i2] = v. */
pub extern "C" fn pysequence_set_slice(
  obj : PyObjectRef,
  start : UInt64,
  end : UInt64,
  new_list : PyObjectRef,
) -> Int = "PySequence_SetSlice"

///| Delete the slice in sequence object 'o' from 'i1' to 'i2'.
/// Returns -1 on failure.
///
/// This is the equivalent of the Python statement: del o[i1:i2]. */
pub extern "C" fn pysequence_del_slice(
  obj : PyObjectRef,
  start : UInt64,
  end : UInt64,
) -> Int = "PySequence_DelSlice"

///| Returns the sequence 'o' as a tuple on success, and NULL on failure.
///
/// This is equivalent to the Python expression: tuple(o). */
pub extern "C" fn pysequence_tuple(obj : PyObjectRef) -> PyObjectRef = "PySequence_Tuple"

///| Returns the sequence 'o' as a list on success, and NULL on failure.
/// This is equivalent to the Python expression: list(o) */
pub extern "C" fn pysequence_list(obj : PyObjectRef) -> PyObjectRef = "PySequence_List"

///| Return the sequence 'o' as a list, unless it's already a tuple or list.
///
/// Use PySequence_Fast_GET_ITEM to access the members of this list, and
/// PySequence_Fast_GET_SIZE to get its length.
///
/// Returns NULL on failure.  If the object does not support iteration, raises a
/// TypeError exception with 'm' as the message text. */
pub extern "C" fn pysequence_fast(obj : PyObjectRef, msg : CStr) -> PyObjectRef = "PySequence_Fast"

// PyAPI_FUNC(Py_ssize_t) PySequence_Count(py_object *o, PyObject *value);

///|
pub extern "C" fn pysequence_count(
  obj : PyObjectRef,
  value : PyObjectRef,
) -> Int = "PySequence_Count"

///| Return 1 if 'ob' is in the sequence 'seq'; 0 if 'ob' is not in the sequence
/// 'seq'; -1 on error.
///
/// Use __contains__ if possible, else _PySequence_IterSearch().
pub extern "C" fn pysequence_contains(
  seq : PyObjectRef,
  ob : PyObjectRef,
) -> Int = "PySequence_Contains"

// PyAPI_FUNC(Py_ssize_t) PySequence_Index(py_object *o, PyObject *value);

///|
pub extern "C" fn pysequence_index(
  obj : PyObjectRef,
  value : PyObjectRef,
) -> Int = "PySequence_Index"

///|  Append sequence 'o2' to sequence 'o1', in-place when possible. Return the
///  resulting object, which could be 'o1', or NULL on failure.
///
///  This is the equivalent of the Python expression: o1 += o2. */
pub extern "C" fn pysequence_inplace_concat(
  obj1 : PyObjectRef,
  obj2 : PyObjectRef,
) -> PyObjectRef = "PySequence_InPlaceConcat"

///| Repeat sequence 'o' by 'count', in-place when possible. Return the resulting
/// object, which could be 'o', or NULL on failure.
///
/// This is the equivalent of the Python expression: o1 *= count.  */
pub extern "C" fn pysequence_inplace_repeat(
  obj : PyObjectRef,
  count : Int,
) -> PyObjectRef = "PySequence_InPlaceRepeat"

///| Return 1 if the object provides mapping protocol, and 0 otherwise.
///
/// This function always succeeds.
pub extern "C" fn pymapping_check(obj : PyObjectRef) -> Int = "PyMapping_Check"

///| Returns the number of keys in mapping object 'o' on success, and -1 on
/// failure. This is equivalent to the Python expression: len(o). */
pub extern "C" fn pymapping_size(obj : PyObjectRef) -> Int = "PyMapping_Size"

///| On success, return 1 if the mapping object 'o' has the key 'key',
/// and 0 otherwise.
///
/// This is equivalent to the Python expression: key in o.
///
/// This function always succeeds. */
pub extern "C" fn pymapping_has_key_string(
  obj : PyObjectRef,
  key : CStr,
) -> Int = "PyMapping_HasKeyString"

///| Return 1 if the mapping object has the key 'key', and 0 otherwise.
///
/// This is equivalent to the Python expression: key in o.
///
/// This function always succeeds.
pub extern "C" fn pymapping_has_key(
  obj : PyObjectRef,
  key : PyObjectRef,
) -> Int = "PyMapping_HasKey"

///| On success, return a list or tuple of the keys in mapping object 'o'.
/// On failure, return NULL. */
pub extern "C" fn pymapping_keys(obj : PyObjectRef) -> PyObjectRef = "PyMapping_Keys"

///| On success, return a list or tuple of the values in mapping object 'o'.
/// On failure, return NULL.
pub extern "C" fn pymapping_values(obj : PyObjectRef) -> PyObjectRef = "PyMapping_Values"

///| On success, return a list or tuple of the items in mapping object 'o',
/// where each item is a tuple containing a key-value pair. On failure, return
/// NULL.
pub extern "C" fn pymapping_items(obj : PyObjectRef) -> PyObjectRef = "PyMapping_Items"

///|
pub extern "C" fn pymapping_get_item_string(
  obj : PyObjectRef,
  key : CStr,
) -> PyObjectRef = "PyMapping_GetItemString"

///|
pub extern "C" fn pymapping_set_item_string(
  obj : PyObjectRef,
  key : CStr,
  value : PyObjectRef,
) -> Int = "PyMapping_SetItemString"

///|
pub extern "C" fn py_object_is_instance(
  obj : PyObjectRef,
  typeorclass : PyObjectRef,
) -> Int = "PyObject_IsInstance"

///|
pub extern "C" fn py_object_is_subclass(
  obj : PyObjectRef,
  typeorclass : PyObjectRef,
) -> Int = "PyObject_IsSubclass"

///| PyObject repr to string
pub fn py_object_moonbit_repr(obj : PyObjectRef) -> String {
  let repr = py_object_repr(obj)
  py_unicode_as_moonbit_string(repr)
}

///| PyObject str to string
pub fn py_object_moonbit_str(obj : PyObjectRef) -> String {
  let str = py_object_str(obj)
  py_unicode_as_moonbit_string(str)
}
