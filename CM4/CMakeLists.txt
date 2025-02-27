cmake_minimum_required(VERSION 3.22)

#
# This file is generated only once,
# and is not re-generated if converter is called multiple times.
#
# User is free to modify the file as much as necessary
#

# Setup compiler settings
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

# Define the build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

message("Build type: " ${CMAKE_BUILD_TYPE})

# Enable compile command to ease indexing with e.g. clangd
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

# Compiler options
set(STM32_MCU_FLAGS  "-mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard" )

#Linker options
set(STM32_LINKER_SCRIPT stm32h755xx_flash_CM4.ld)
set(STM32_LINKER_OPTION  )

# Include toolchain file
include("../gcc-arm-none-eabi.cmake")

# Set the project name
set(CMAKE_PROJECT_NAME WheelBaseSensorSystem_CM4)
project(${CMAKE_PROJECT_NAME})

# Create an executable object type
add_executable(${CMAKE_PROJECT_NAME})

# Include mx-generated 
include("mx-generated.cmake")

# Enable CMake support for ASM and C languages
enable_language(C ASM)

# In order to use CMake for cross-compiling
set(CMAKE_CXX_COMPILER_FORCED "true") 

# Add project symbols (macros)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE 
    # Add user defined symbols
)

# Add include paths
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user defined include paths
)

# Add sources to executable
target_sources(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user sources here
    Core/Src/main.c
    Core/Src/stm32h7xx_it.c
    Core/Src/stm32h7xx_hal_msp.c
    Core/Src/syscalls.c
    Core/Src/sysmem.c
    ../Common/Src/system_stm32h7xx_dualcore_boot_cm4_cm7.c
)

# Link directories setup
target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user defined library search paths
)

# Add linked libraries
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user defined libraries
)

# Validate that STM32CubeMX code is compatible with C standard
if(CMAKE_C_STANDARD LESS 11)
    message(ERROR "Generated code requires C11 or higher")
endif()









