RACK_DIR ?= ../..

# FLAGS will be passed to both the C and C++ compiler
FLAGS +=
CFLAGS +=
CXXFLAGS +=


# Careful about linking to libraries, since you can't assume much about the user's environment and library search path.
# Static libraries are fine.
LDFLAGS +=

# Add .cpp and .c files to the build
SOURCES += $(wildcard src/*.cpp)

# Add files to the ZIP package when running `make dist`
DISTRIBUTABLES += $(wildcard Manual* License*) res

include $(RACK_DIR)/plugin.mk

mm-plugin:
	cmake -B build -G Ninja -DMETAMODULE_SDK_DIR=metamodule-plugin-sdk
	cmake --build build

install-mm-sdk:
	rm -rf metamodule-plugin-sdk
	git clone https://github.com/4ms/metamodule-plugin-sdk --recursive 

install-mm-sdk-2.0:
	rm -rf metamodule-plugin-sdk
	git clone -b v2.0-dev https://github.com/4ms/metamodule-plugin-sdk --recursive 
