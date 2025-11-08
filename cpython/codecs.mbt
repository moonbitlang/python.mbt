// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// code cs

///|
#owned(search_function)
pub extern "C" fn py_codec_register(search_function : PyObjectRef) -> Int = "PyCodec_Register"

///|
#owned(encoding)
pub extern "C" fn py_codec_known_encoding(encoding : CStr) -> Int = "PyCodec_KnownEncoding"

///|
#owned(object, encoding, errors)
pub extern "C" fn py_codec_encode(
  object : PyObjectRef,
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_Encode"

///|
#owned(object, encoding, errors)
pub extern "C" fn py_codec_decode(
  object : PyObjectRef,
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_Decode"

///|
#owned(encoding)
pub extern "C" fn py_codec_encoder(encoding : CStr) -> PyObjectRef = "PyCodec_Encoder"

///|
#owned(encoding)
pub extern "C" fn py_codec_decoder(encoding : CStr) -> PyObjectRef = "PyCodec_Decoder"

///|
#owned(encoding, errors)
pub extern "C" fn py_codec_incremental_encoder(
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_IncrementalEncoder"

///|
#owned(encoding, errors)
pub extern "C" fn py_codec_incremental_decoder(
  encoding : CStr,
  errors : CStr,
) -> PyObjectRef = "PyCodec_IncrementalDecoder"

///|
#owned(encoding, stream, errors)
pub extern "C" fn py_codec_stream_reader(
  encoding : CStr,
  stream : PyObjectRef,
  errors : CStr,
) -> PyObjectRef = "PyCodec_StreamReader"

///|
#owned(encoding, stream, errors)
pub extern "C" fn py_codec_stream_writer(
  encoding : CStr,
  stream : PyObjectRef,
  errors : CStr,
) -> PyObjectRef = "PyCodec_StreamWriter"

///|
#owned(name, error)
pub extern "C" fn py_codec_register_error(
  name : CStr,
  error : PyObjectRef,
) -> Int = "PyCodec_RegisterError"

///|
#owned(name)
pub extern "C" fn py_codec_lookup_error(name : CStr) -> PyObjectRef = "PyCodec_LookupError"

///|
#owned(exc)
pub extern "C" fn py_codec_strict_errors(exc : PyObjectRef) -> PyObjectRef = "PyCodec_StrictErrors"

///|
#owned(exc)
pub extern "C" fn py_codec_ignore_errors(exc : PyObjectRef) -> PyObjectRef = "PyCodec_IgnoreErrors"

///|
#owned(exc)
pub extern "C" fn py_codec_replace_errors(exc : PyObjectRef) -> PyObjectRef = "PyCodec_ReplaceErrors"

///|
#owned(exc)
pub extern "C" fn py_codec_xml_char_ref_replace_errors(
  exc : PyObjectRef,
) -> PyObjectRef = "PyCodec_XMLCharRefReplaceErrors"

///|
#owned(exc)
pub extern "C" fn py_codec_backslash_replace_errors(
  exc : PyObjectRef,
) -> PyObjectRef = "PyCodec_BackslashReplaceErrors"

///|
#owned(exc)
pub extern "C" fn py_codec_name_replace_errors(
  exc : PyObjectRef,
) -> PyObjectRef = "PyCodec_NameReplaceErrors"
