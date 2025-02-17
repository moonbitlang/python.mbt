#include "moonbit.h"
#include <Python.h>

void *moonbit_str_to_c_str(struct moonbit_string *ms) {
  int32_t len = Moonbit_array_length(ms);
  char *ptr = (char *)malloc(len + 1);
  uint16_t *data = ms->data;
  for (int i = 0; i < len; i++) {
    if (data[i] < 0x80) {
      ptr[i] = data[i];
    } else {
      ptr[i] = '?';
    }
  }
  ptr[len] = '\0';
  return ptr;
}

struct moonbit_string *c_str_to_moonbit_str(void *ptr) {
  char *cptr = (char *)ptr;
  int32_t len = strlen(cptr);
  struct moonbit_string *ms = moonbit_make_string(len, 0);
  for (int i = 0; i < len; i++) {
    ms->data[i] = (uint16_t)cptr[i];
  }
  // free(ptr);
  return ms;
}

struct moonbit_string *c_str_to_moonbit_str_with_length(void *ptr,
                                                        unsigned len) {
  char *cptr = (char *)ptr;
  struct moonbit_string *ms = moonbit_make_string(len, 0);
  for (int i = 0; i < len; i++) {
    ms->data[i] = (uint16_t)cptr[i];
  }
  // free(ptr);
  return ms;
}

void print_pyobject(PyObject *obj) { PyObject_Print(obj, stdout, 0); }

void py_incref(PyObject *obj) { Py_INCREF(obj); }

void py_decref(PyObject *obj) { Py_DECREF(obj); }

int Moonbit_PyObjectRef_is_null(PyObject *obj) { return obj == NULL; }

int Moonbit_PyFunction_Check(PyObject *obj) { PyFunction_Check(obj); }

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
