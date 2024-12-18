cmake_minimum_required(VERSION 3.22)

#########################################################################
# Set the environment variable METAMODULE_SDK_DIR to the path of the 
# metamodule-plugin-sdk directory.
#
# For example, add this to your .bashrc file:
# export METAMODULE_SDK_DIR=/Users/MyName/projects/metamodule-plugin-sdk
#
if (DEFINED ENV{METAMODULE_SDK_DIR})
    set(METAMODULE_SDK_DIR "$ENV{METAMODULE_SDK_DIR}")
elseif("${METAMODULE_SDK_DIR}" STREQUAL "")
    set(METAMODULE_SDK_DIR "${CMAKE_CURRENT_LIST_DIR}/../metamodule-plugin-sdk")
endif()
include(${METAMODULE_SDK_DIR}/plugin.cmake)

#########################################################################
# Step 2: Edit the following to set your project name and info
project(MSMMetaModulePlugin
    DESCRIPTION "MSM Plugin for MetaModule" 
    LANGUAGES   C CXX ASM
)

#########################################################################
# Step 3: Create a static library for your plugin and add all your 
# sources, compile flags, includes, etc.
add_library(MSM STATIC)

set(SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR})

target_sources(MSM
    PRIVATE
    ${SOURCE_DIR}/src/MSM.cpp
    ${SOURCE_DIR}/src/ADSR.cpp
    ${SOURCE_DIR}/src/Bitcrusher.cpp
    ${SOURCE_DIR}/src/BlankPanel.cpp
    ${SOURCE_DIR}/src/Delay.cpp
    ${SOURCE_DIR}/src/ExperimentalVCO.cpp
    ${SOURCE_DIR}/src/Fade.cpp
    ${SOURCE_DIR}/src/MLFO.cpp
    ${SOURCE_DIR}/src/MSM.cpp
    ${SOURCE_DIR}/src/Morpher.cpp
    ${SOURCE_DIR}/src/Mult.cpp
    ${SOURCE_DIR}/src/Noise.cpp
    ${SOURCE_DIR}/src/Phaser.cpp
    ${SOURCE_DIR}/src/RandomSource.cpp
    ${SOURCE_DIR}/src/RingMod.cpp
    ${SOURCE_DIR}/src/SwitchedMult.cpp
    ${SOURCE_DIR}/src/VCA.cpp
    ${SOURCE_DIR}/src/VCO.cpp
    ${SOURCE_DIR}/src/WaveShaper.cpp
    ${SOURCE_DIR}/src/Wavefolder.cpp
    ${SOURCE_DIR}/src/XSEQ.cpp
    ${SOURCE_DIR}/src/slider.cpp
)

target_include_directories(MSM PRIVATE 
	${SOURCE_DIR}/src 
)

target_compile_options(MSM
	PRIVATE 
	# -Wno-double-promotion 
	# $<$<COMPILE_LANGUAGE:CXX>:-Wno-deprecated-enum-float-conversion>
)

set_property(TARGET MSM PROPERTY CXX_STANDARD 20)

if("${INSTALL_DIR}" STREQUAL "")
    set(INSTALL_DIR ${CMAKE_CURRENT_LIST_DIR}/metamodule-plugins)
endif()

#########################################################
# Step 4: call create_plugin()
create_plugin(
    SOURCE_LIB      MSM # This is the cmake target name (defined in add_target)
    PLUGIN_NAME     MSM                                         # This must match the brand "slug" used in VCV Rack
    PLUGIN_JSON     ${SOURCE_DIR}/plugin.json                      # Path to the plugin.json file used by VCV Rack
    SOURCE_ASSETS   ${CMAKE_CURRENT_LIST_DIR}/assets               # Path to the assets/ dir containing the PNGs
    DESTINATION     ${INSTALL_DIR}  # Dir where plugin .mmplugin file should be put
)

#########################################################
# Step 5:
# Create plugin-mm.json in the same directory as this CMakeLists file
# It can be blank if you don't intend to publish the plugin on the metamodule website
# Otherwise, see other examples for how to populate it.
