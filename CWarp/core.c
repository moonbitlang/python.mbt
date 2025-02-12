#include <Python.h>

#define NULL 0

void print_pyobject(PyObject *obj) { PyObject_Print(obj, stdout, 0); }

void py_incref(PyObject *obj) { Py_INCREF(obj); }

void py_decref(PyObject *obj) { Py_DECREF(obj); }

int Moonbit_PyObjectRef_is_null(PyObject *obj) { return obj == NULL; }

int Moonbit_PyFunction_Check(PyObject *obj) { PyFunction_Check(obj); }
