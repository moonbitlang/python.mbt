#include "moonbit.h"
#include <Python.h>
#include <stdlib.h>
#include <string.h>

struct PyObjectWrap {
  PyObject* obj_ref;
};

void PyObjectDecref(void* wrap_ptr) {
  struct PyObjectWrap* wrap = (struct PyObjectWrap*)wrap_ptr;
  PyGILState_STATE gstate = PyGILState_Ensure();
  fprintf(stderr, "PyObject Deleted!\n");
  if (wrap->obj_ref) {
    fprintf(stderr, "the deleted object is: ");
    PyObject_Print(wrap->obj_ref, stdout, 0);
    Py_DECREF(wrap->obj_ref);
  }
  PyGILState_Release(gstate);
}

struct PyObjectWrap* newPyObject(PyObject* obj_ref) {
  struct PyObjectWrap* wrap = 
    moonbit_make_external_object(&PyObjectDecref, sizeof(struct PyObjectWrap));
  wrap->obj_ref = obj_ref;
  return wrap;
}

void *moonbit_str_to_c_str(moonbit_string_t ms) {
  int32_t len = Moonbit_array_length(ms);
  char *ptr = (char *)malloc(len + 1);
  for (int i = 0; i < len; i++) {
    if (ms[i] < 0x80) {
      ptr[i] = ms[i];
    } else {
      ptr[i] = '?';
    }
  }
  ptr[len] = '\0';
  return ptr;
}

moonbit_string_t c_str_to_moonbit_str(void *ptr) {
  char *cptr = (char *)ptr;
  int32_t len = strlen(cptr);
  moonbit_string_t ms = moonbit_make_string(len, 0);
  for (int i = 0; i < len; i++) {
    ms[i] = (uint16_t)cptr[i];
  }
  // free(ptr);
  return ms;
}

moonbit_string_t c_str_to_moonbit_str_with_length(void *ptr, unsigned len) {
  char *cptr = (char *)ptr;
  moonbit_string_t ms = moonbit_make_string(len, 0);
  for (int i = 0; i < len; i++) {
    ms[i] = (uint16_t)cptr[i];
  }
  // free(ptr);
  return ms;
}

void print_pyobject(PyObject *obj) { PyObject_Print(obj, stdout, 0); }

void py_incref(PyObject *obj) { Py_INCREF(obj); }

void py_decref(PyObject *obj) { Py_DECREF(obj); }

int Moonbit_PyObjectRef_is_null(PyObject *obj) { return obj == NULL; }

PyTypeObject *py_type(PyObject *obj) { return obj->ob_type; }

int py_tuple_check(PyObject *obj) { return PyTuple_Check(obj); }

int py_list_check(PyObject *obj) { return PyList_Check(obj); }

int py_dict_check(PyObject *obj) { return PyDict_Check(obj); }

int py_set_check(PyObject *obj) { return PySet_Check(obj); }

int py_string_check(PyObject *obj) { return PyUnicode_Check(obj); }

int py_int_check(PyObject *obj) { return PyLong_Check(obj); }

int py_float_check(PyObject *obj) { return PyFloat_Check(obj); }

int py_bool_check(PyObject *obj) { return PyBool_Check(obj); }

int py_none_check(PyObject *obj) { return Py_None == obj; }

int py_callable_check(PyObject *obj) { return PyCallable_Check(obj); }

int py_iter_check(PyObject *obj) { return PyIter_Check(obj); }

int py_module_check(PyObject *obj) { return PyModule_Check(obj); }

int py_type_check(PyObject *obj) { return PyType_Check(obj); }

int py_function_check(PyObject *obj) { return PyFunction_Check(obj); }

int py_method_check(PyObject *obj) { return PyMethod_Check(obj); }

int py_is_true(PyObject *obj) { return 0 != Py_IsTrue(obj); };

int py_is_false(PyObject *obj) { return 0 == Py_IsTrue(obj); }

PyObject* py_import_import_module(const char* name) {
  PyObject *module = PyImport_ImportModule(name);
  return module;
}

moonbit_string_t py_unicode_as_moonbit_string(PyObject* obj) {
  void* data = PyUnicode_DATA(obj);
  int64_t len = PyUnicode_GET_LENGTH(obj);
  moonbit_string_t ms = moonbit_make_string(len, 0);
  if (PyUnicode_KIND(obj) == PyUnicode_2BYTE_KIND) {
    memcpy(ms, data, len * 2);
  } else if (PyUnicode_KIND(obj) == PyUnicode_1BYTE_KIND) {
    for (int i = 0; i < len; i++) {
      ms[i] = (uint16_t)(((Py_UCS1*)data)[i]);
    }
  } else { // PyUnicode_4BYTE_KIND
    for (int i = 0; i < len; i++) {
      ms[i] = (uint16_t)(((Py_UCS4*)data)[i]);
    }
  }
  return ms;
}
