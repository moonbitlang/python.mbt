// Import
pub extern "C" fn py_import_get_magic_number() -> Int = "PyImport_GetMagicNumber"
pub extern "C" fn py_import_get_magic_tag() -> CStr = "PyImport_GetMagicTag"
pub extern "C" fn py_import_exec_code_module(name: CStr, co: PyObjectRef) -> PyObjectRef = "PyImport_ExecCodeModule"
pub extern "C" fn py_import_exec_code_module_ex(name: CStr, co: PyObjectRef, pathname: CStr) -> PyObjectRef = "PyImport_ExecCodeModuleEx"
pub extern "C" fn py_import_exec_code_module_with_pathnames(name: CStr, co: PyObjectRef, pathname: CStr, cpathname: CStr) -> PyObjectRef = "PyImport_ExecCodeModuleWithPathnames"
pub extern "C" fn py_import_exec_code_module_object(name: PyObjectRef, co: PyObjectRef, pathname: PyObjectRef, cpathname: PyObjectRef) -> PyObjectRef = "PyImport_ExecCodeModuleObject"
pub extern "C" fn py_import_get_module_dict() -> PyObjectRef = "PyImport_GetModuleDict"
pub extern "C" fn py_import_get_module(name: PyObjectRef) -> PyObjectRef = "PyImport_GetModule"
pub extern "C" fn py_import_add_module_object(name: PyObjectRef) -> PyObjectRef = "PyImport_AddModuleObject"
pub extern "C" fn py_import_add_module(name: CStr) -> PyObjectRef = "PyImport_AddModule"

extern "C" fn __py_import_import_module(name: Bytes) -> PyObjectRef = "PyImport_ImportModule"
//extern "C" fn __py_import_import_module(name: Bytes) -> PyObjectRef = "py_import_import_module"
pub fn py_import_import_module(name: String) -> PyObjectRef {
  let cstr = name.to_bytes()
                 .to_array()
                 .filter(fn (c) { c != 0 })
                ..push(0) 
                |> @bytes.from_array
  __py_import_import_module(cstr)
}
pub extern "C" fn py_import_import_module_no_block(name: CStr) -> PyObjectRef = "PyImport_ImportModuleNoBlock"
pub extern "C" fn py_import_import_module_level(name: CStr, globals: PyObjectRef, locals: PyObjectRef, fromlist: PyObjectRef, level: Int) -> PyObjectRef = "PyImport_ImportModuleLevel"
pub extern "C" fn py_import_import_module_level_object(name: PyObjectRef, globals: PyObjectRef, locals: PyObjectRef, fromlist: PyObjectRef, level: Int) -> PyObjectRef = "PyImport_ImportModuleLevelObject"
pub extern "C" fn py_import_get_importer(path: PyObjectRef) -> PyObjectRef = "PyImport_GetImporter"
pub extern "C" fn py_import_import(name: PyObjectRef) -> PyObjectRef = "PyImport_Import"
pub extern "C" fn py_import_reload_module(m: PyObjectRef) -> PyObjectRef = "PyImport_ReloadModule"
pub extern "C" fn py_import_cleanup() = "PyImport_Cleanup"
pub extern "C" fn py_import_import_frozen_module_object(name: PyObjectRef) -> Int = "PyImport_ImportFrozenModuleObject"
pub extern "C" fn py_import_import_frozen_module(name: CStr) -> Int = "PyImport_ImportFrozenModule"
