// Import
pub extern "C" fn pyimport_get_importer(path: PyObjectRef) -> PyObjectRef = "PyImport_GetImporter"
pub extern "C" fn pyimport_import(name: PyObjectRef) -> PyObjectRef = "PyImport_Import"
pub extern "C" fn pyimport_reload_module(m: PyObjectRef) -> PyObjectRef = "PyImport_ReloadModule"
pub extern "C" fn pyimport_cleanup() = "PyImport_Cleanup"

