# Author: Will K
# Date: 25 Feb 25
# Purpose of file: Makefile config to support workflow. A makefile is essentually a shortcuts library for building on the command line.

PROJECT_CM4 := Wheelbase_CM4
PROJECT_CM7 := Wheelbase_CM7

BUILD_DIR_CM4 := build-CM4
BUILD_DIR_CM7 := build-CM7

CM4_SRC_DIR := CM4/Core/Src
CM4_INC_DIR := CM4/Core/Inc 
CM7_SRC_DIR := CM7/Core/Src 
CM7_INC_DIR := CM7/Core/Inc 

HAL_INC_DIR := Drivers/STM32H7xx_HAL_Driver/Inc
CMSIS_DEVICE_INC_DIR := Drivers/CMSIS/Device/ST/STM32H7xx/Include
CMSIS_CORE_INC_DIR := Drivers/CMSIS/Include

CC := arm-none-eabi-gcc
LD := arm-none-eabi-ld
SZ := arm-none-eabi-size

CPU_CM7 := -mcpu=cortex-m7
FPU_CM7 := -mfpu=fpv5-d16
FLOAT_ABI_CM7 := -mfloat-abi=hard
MCU_FLAGS_CM7 := $(CPU_CM7) -mthumb $(FPU_CM7) $(FLOAT_ABI_CM7)

CPU_CM4 := -mcpu=cortex-m4
FPU_CM4 := -mfpu=fpv4-sp-d16
FLOAT_ABI_CM4 := -mfloat-abi=hard
MCU_FLAGS_CM4 := $(CPU_CM4) -mthumb $(FPU_CM4) $(FLOAT_ABI_CM4)

CDEFS_CM7 := -DSTM32H743xx -DUSE_HAL_DRIVER -DCORE_CM7
CDEFS_CM4 := -DSTM32H743xx -DUSE_HAL_DRIVER -DCORE_CM4

LDSCRIPT_CM7 := CM7/STM32H755ZITX_FLASH.ld
LDSCRIPT_CM4 := CM4/STM32H755ZITX_FLASH.ld

LDFLAGS_CM7 := $(MCU_FLAGS_CM7) -T$(LDSCRIPT_CM7) -Wl,-Map=$(BUILD_DIR_CM7)/$(PROJECT_CM7).map,--gc-sections
LDFLAGS_CM4 := $(MCU_FLAGS_CM4) -T$(LDSCRIPT_CM4) -Wl,-Map=$(BUILD_DIR_CM4)/$(PROJECT_CM4).map,--gc-sections

C_SOURCES_CM7 := $(wildcard $(CM7_SRC_DIR)/*.c) CM7/Startup/startup_stm32h755xx.s
C_SOURCES_CM4 := $(wildcard $(CM4_SRC_DIR)/*.c) CM4/Startup/startup_stm32h755xx.s

OBJ_FILES_CM7 := $(patsubst $(CM7_SRC_DIR)/%.c, $(BUILD_DIR_CM7)/%.o, $(C_SOURCES_CM7)) \
                 $(BUILD_DIR_CM7)/startup_stm32h755xx.o

OBJ_FILES_CM4 := $(patsubst $(CM4_SRC_DIR)/%.c, $(BUILD_DIR_CM4)/%.o, $(C_SOURCES_CM4)) \
                 $(BUILD_DIR_CM4)/startup_stm32h755xx.o


CINCLUDES_CM7 := -I$(CM7_INC_DIR) -I$(HAL_INC_DIR) -I$(CMSIS_DEVICE_INC_DIR) -I$(CMSIS_CORE_INC_DIR)
CINCLUDES_CM4 := -I$(CM4_INC_DIR) -I$(HAL_INC_DIR) -I$(CMSIS_DEVICE_INC_DIR) -I$(CMSIS_CORE_INC_DIR)

NPROC := $(shell nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1) # find cores
CFLAGS := -g -O2 -Wall -Werror -ffunction-sections -fdata-sections --specs=nano.specs -static -fno-common 
# "-j$(NPROC)" 

################################################################################################################
################################################################################################################
RESET  := \033[0m
BOLD   := \033[1m
GREEN  := \033[32m
BLUE   := \033[34m
YELLOW := \033[33m
RED    := \033[31m


# Build everything
all: cm7 cm4
	@echo "$(BOLD)$(GREEN)All cores builds completed successfully!$(RESET)"

# Cortex-M7 build target
cm7: $(BUILD_DIR_CM7) $(BUILD_DIR_CM7)/$(PROJECT_CM7).elf

# Cortex-M4 build target
cm4: $(BUILD_DIR_CM4) $(BUILD_DIR_CM4)/$(PROJECT_CM4).elf

# Create build directory for Cortex-M7
$(BUILD_DIR_CM7):
	mkdir -p $(BUILD_DIR_CM7)

# Create build directory for Cortex-M4
$(BUILD_DIR_CM4):
	mkdir -p $(BUILD_DIR_CM4)

# Cortex-M7 Build
$(BUILD_DIR_CM7)/%.o: $(SRC_DIR_CM7)/%.c | $(BUILD_DIR_CM7)
	@echo "$(BOLD)$(YELLOW)[CM7] Compiling:$(RESET) $<"
	mkdir -p $(dir $@)
	$(CC) $(MCU_FLAGS_CM7) $(CFLAGS) $(CDEFS_CM7) $(CINCLUDES_CM7) -c $< -o $@

$(BUILD_DIR_CM7)/$(PROJECT_CM7).elf: $(OBJ_FILES_CM7) | $(BUILD_DIR_CM7)
	@echo "$(BOLD)$(GREEN)[CM7] Linking:$(RESET) $@"
	$(CC) $^ $(LDFLAGS_CM7) -o $@
	$(SZ) $@
	@echo "$(BOLD)$(GREEN)[CM7] Build completed successfully!$(RESET)"

$(BUILD_DIR_CM7)/%.o: CM7/Startup/%.s | $(BUILD_DIR_CM7)
	@echo "$(BOLD)$(YELLOW)[CM7] Assembling:$(RESET) $<"
	$(CC) -x assembler-with-cpp $(MCU_FLAGS_CM7) -c $< -o $@


# Cortex-M4 Build
$(BUILD_DIR_CM4)/%.o: $(SRC_DIR_CM4)/%.c | $(BUILD_DIR_CM4)
	@echo "$(BOLD)$(BLUE)[CM4] Compiling:$(RESET) $<"
	mkdir -p $(dir $@)
	$(CC) $(MCU_FLAGS_CM4) $(CFLAGS) $(CDEFS_CM4) $(CINCLUDES_CM4) -c $< -o $@

$(BUILD_DIR_CM4)/$(PROJECT_CM4).elf: $(OBJ_FILES_CM4) | $(BUILD_DIR_CM4)
	@echo "$(BOLD)$(GREEN)[CM4] Linking:$(RESET) $@"
	$(CC) $^ $(LDFLAGS_CM4) -o $@
	$(SZ) $@
	@echo "$(BOLD)$(GREEN)[CM4] Build completed successfully!$(RESET)"

$(BUILD_DIR_CM4)/%.o: CM4/Startup/%.s | $(BUILD_DIR_CM4)
	@echo "$(BOLD)$(BLUE)[CM4] Assembling:$(RESET) $<"
	$(CC) -x assembler-with-cpp $(MCU_FLAGS_CM4) -c $< -o $@


# Clean up build files
clean:
	@echo "$(BOLD)$(RED)[make CLEAN] Removing build directories$(RESET)"
	rm -rf $(BUILD_DIR_CM7) $(BUILD_DIR_CM4)

colors:
	@echo "$(BOLD)This is bold$(RESET)"
	@echo "$(GREEN)Success Message$(RESET)"
	@echo "$(BLUE)Info Message$(RESET)"
	@echo "$(YELLOW)Warning Message$(RESET)"
	@echo "$(RED)Error Message$(RESET)"


.PHONY: all clean cm7 cm4