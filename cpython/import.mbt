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

// Import

///|
pub extern "C" fn py_import_get_magic_number() -> Int = "PyImport_GetMagicNumber"

///|
pub extern "C" fn py_import_get_magic_tag() -> CStr = "PyImport_GetMagicTag"

///|
#owned(name, co)
pub extern "C" fn py_import_exec_code_module(
  name : CStr,
  co : PyObjectRef,
) -> PyObjectRef = "PyImport_ExecCodeModule"

///|
#owned(name, co, pathname)
pub extern "C" fn py_import_exec_code_module_ex(
  name : CStr,
  co : PyObjectRef,
  pathname : CStr,
) -> PyObjectRef = "PyImport_ExecCodeModuleEx"

///|
#owned(name, co, pathname, cpathname)
pub extern "C" fn py_import_exec_code_module_with_pathnames(
  name : CStr,
  co : PyObjectRef,
  pathname : CStr,
  cpathname : CStr,
) -> PyObjectRef = "PyImport_ExecCodeModuleWithPathnames"

///|
#owned(name, co, pathname, cpathname)
pub extern "C" fn py_import_exec_code_module_object(
  name : PyObjectRef,
  co : PyObjectRef,
  pathname : PyObjectRef,
  cpathname : PyObjectRef,
) -> PyObjectRef = "PyImport_ExecCodeModuleObject"

///|
pub extern "C" fn py_import_get_module_dict() -> PyObjectRef = "PyImport_GetModuleDict"

///|
#owned(name)
pub extern "C" fn py_import_get_module(name : PyObjectRef) -> PyObjectRef = "PyImport_GetModule"

///|
#owned(name)
pub extern "C" fn py_import_add_module_object(
  name : PyObjectRef,
) -> PyObjectRef = "PyImport_AddModuleObject"

///|
#owned(name)
pub extern "C" fn py_import_add_module(name : CStr) -> PyObjectRef = "PyImport_AddModule"

///|
#owned(name)
extern "C" fn __py_import_import_module(name : Bytes) -> PyObjectRef = "PyImport_ImportModule"

//extern "C" fn __py_import_import_module(name: Bytes) -> PyObjectRef = "py_import_import_module"

///|
pub fn py_import_import_module(name : String) -> PyObjectRef {
  let cstr = ToCStr::to_cstr(name)
  __py_import_import_module(cstr)
}

///|
#owned(name)
pub extern "C" fn py_import_import_module_no_block(name : CStr) -> PyObjectRef = "PyImport_ImportModuleNoBlock"

///|
#owned(name, globals, locals, fromlist)
pub extern "C" fn py_import_import_module_level(
  name : CStr,
  globals : PyObjectRef,
  locals : PyObjectRef,
  fromlist : PyObjectRef,
  level : Int,
) -> PyObjectRef = "PyImport_ImportModuleLevel"

///|
#owned(name, globals, locals, fromlist)
pub extern "C" fn py_import_import_module_level_object(
  name : PyObjectRef,
  globals : PyObjectRef,
  locals : PyObjectRef,
  fromlist : PyObjectRef,
  level : Int,
) -> PyObjectRef = "PyImport_ImportModuleLevelObject"

///|
#owned(path)
pub extern "C" fn py_import_get_importer(path : PyObjectRef) -> PyObjectRef = "PyImport_GetImporter"

///|
#owned(name)
pub extern "C" fn py_import_import(name : PyObjectRef) -> PyObjectRef = "PyImport_Import"

///|
#owned(m)
pub extern "C" fn py_import_reload_module(m : PyObjectRef) -> PyObjectRef = "PyImport_ReloadModule"

///|
pub extern "C" fn py_import_cleanup() = "PyImport_Cleanup"

///|
#owned(name)
pub extern "C" fn py_import_import_frozen_module_object(
  name : PyObjectRef,
) -> Int = "PyImport_ImportFrozenModuleObject"

///|
#owned(name)
pub extern "C" fn py_import_import_frozen_module(name : CStr) -> Int = "PyImport_ImportFrozenModule"
