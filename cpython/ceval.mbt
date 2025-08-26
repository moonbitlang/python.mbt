// ceval

///|
pub extern "C" fn py_eval_call_object_with_keywords(
  callable : PyObjectRef,
  args : PyObjectRef,
  kwargs : PyObjectRef,
) -> PyObjectRef = "PyEval_CallObjectWithKeywords"

// pub extern "C" fn py_eval_call_function(callable: PyObjectRef, format: CStr, ...) -> PyObjectRef = "PyEval_CallFunction" // 可变参数 ...
// pub extern "C" fn py_eval_call_method(obj: PyObjectRef, name: CStr, format: CStr, ...) -> PyObjectRef = "PyEval_CallMethod" // 可变参数 ...
// pub extern "C" fn py_eval_set_profile(a: Py_tracefunc, b: PyObjectRef) = "PyEval_SetProfile"
// pub extern "C" fn py_eval_set_trace(a: Py_tracefunc, b: PyObjectRef) = "PyEval_SetTrace"

///|
pub extern "C" fn py_eval_get_builtins() -> PyObjectRef = "PyEval_GetBuiltins"

///|
pub extern "C" fn py_eval_get_globals() -> PyObjectRef = "PyEval_GetGlobals"

///|
pub extern "C" fn py_eval_get_locals() -> PyObjectRef = "PyEval_GetLocals"

// pub extern "C" fn py_eval_merge_compiler_flags(cf: *PyCompilerFlags) -> Int = "PyEval_MergeCompilerFlags" // 指针类型 *
// pub extern "C" fn py_add_pending_call(func: *fn(a: *Void) -> Int, arg: *Void) -> Int = "Py_AddPendingCall" // 函数指针, void 指针

///|
pub extern "C" fn py_make_pending_calls() -> Int = "Py_MakePendingCalls"

///|
pub extern "C" fn py_set_recursion_limit(a : Int) = "Py_SetRecursionLimit"

///|
pub extern "C" fn py_get_recursion_limit() -> Int = "Py_GetRecursionLimit"

///|
pub extern "C" fn py_eval_get_func_name(a : PyObjectRef) -> CStr = "PyEval_GetFuncName"

///|
pub extern "C" fn py_eval_get_func_desc(a : PyObjectRef) -> CStr = "PyEval_GetFuncDesc"

///|
pub extern "C" fn py_eval_save_thread() -> PyThreadStateRef = "PyEval_SaveThread"

///|
pub extern "C" fn py_eval_restore_thread(a : PyThreadStateRef) = "PyEval_RestoreThread"

///|
pub extern "C" fn py_eval_threads_initialized() -> Int = "PyEval_ThreadsInitialized"

///|
pub extern "C" fn py_eval_init_threads() = "PyEval_InitThreads"

///|
pub extern "C" fn py_eval_acquire_thread(tstate : PyThreadStateRef) = "PyEval_AcquireThread"

///|
pub extern "C" fn py_eval_release_thread(tstate : PyThreadStateRef) = "PyEval_ReleaseThread"
