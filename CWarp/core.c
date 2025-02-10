#include <Python.h>

void print_pyobject(PyObject *obj) { PyObject_Print(obj, stdout, 0); }

void py_incref(PyObject *obj) { Py_INCREF(obj); }

void py_decref(PyObject *obj) { Py_DECREF(obj); }
