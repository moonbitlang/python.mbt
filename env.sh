export CC=gcc
export CC_FLAGS="$(python3-config --cflags)"
export CC_LINK_FLAGS="$(python3-config --ldflags) -lpython3.13"
export C_INCLUDE_PATH="$(python3-config --prefix)/include/python3.13":$C_INCLUDE_PATH
