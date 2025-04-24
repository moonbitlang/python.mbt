export PY_VERSION="$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")"
export CC=gcc # Or any C Compiler You want
export CC_FLAGS="-I$(python3-config --prefix)/include/python$PY_VERSION -dynamic -DNDEBUG"
export CC_LINK_FLAGS="$(python3-config --ldflags) -lpython$PY_VERSION"
export C_INCLUDE_PATH="$(python3-config --prefix)/include/python$PY_VERSION":$C_INCLUDE_PATH
