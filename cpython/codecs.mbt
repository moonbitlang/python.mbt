// code cs

///|
pub extern "C" fn py_codec_register(search_function : PyObjectRef) -> Int = "PyCodec_Register"

///|
pub extern "C" fn py_codec_known_encoding(encoding : CStr) -> Int = "PyCodec_KnownEncoding"

///|
pub extern "C" fn py_codec_encode(
  object : PyObjectRef,
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_Encode"

///|
pub extern "C" fn py_codec_decode(
  object : PyObjectRef,
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_Decode"

///|
pub extern "C" fn py_codec_encoder(encoding : CStr) -> PyObjectRef = "PyCodec_Encoder"

///|
pub extern "C" fn py_codec_decoder(encoding : CStr) -> PyObjectRef = "PyCodec_Decoder"

///|
pub extern "C" fn py_codec_incremental_encoder(
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_IncrementalEncoder"

///|
pub extern "C" fn py_codec_incremental_decoder(
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_IncrementalDecoder"

///|
pub extern "C" fn py_codec_stream_reader(
  encoding : CStr,
  stream : PyObjectRef,
  errors : CStr,
) -> PyObjectRef = "PyCodec_StreamReader"

///|
pub extern "C" fn py_codec_stream_writer(
  encoding : CStr,
  stream : PyObjectRef,
  errors : CStr,
) -> PyObjectRef = "PyCodec_StreamWriter"

///|
pub extern "C" fn py_codec_register_error(
  name : CStr,
  error : PyObjectRef,
) -> Int = "PyCodec_RegisterError"

///|
pub extern "C" fn py_codec_lookup_error(name : CStr) -> PyObjectRef = "PyCodec_LookupError"

///|
pub extern "C" fn py_codec_strict_errors(exc : PyObjectRef) -> PyObjectRef = "PyCodec_StrictErrors"

///|
pub extern "C" fn py_codec_ignore_errors(exc : PyObjectRef) -> PyObjectRef = "PyCodec_IgnoreErrors"

///|
pub extern "C" fn py_codec_replace_errors(exc : PyObjectRef) -> PyObjectRef = "PyCodec_ReplaceErrors"

///|
pub extern "C" fn py_codec_xml_char_ref_replace_errors(
  exc : PyObjectRef,
) -> PyObjectRef = "PyCodec_XMLCharRefReplaceErrors"

///|
pub extern "C" fn py_codec_backslash_replace_errors(
  exc : PyObjectRef,
) -> PyObjectRef = "PyCodec_BackslashReplaceErrors"

///|
pub extern "C" fn py_codec_name_replace_errors(
  exc : PyObjectRef,
) -> PyObjectRef = "PyCodec_NameReplaceErrors"
