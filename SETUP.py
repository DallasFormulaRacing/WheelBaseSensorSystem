import os
import sys
import platform
import subprocess
import shutil

# Deprecated

### CONFIGURATION ###
VS_CODE_EXTENSIONS = [
    "ms-vscode.cpptools",
    "llvm-vs-code-extensions.vscode-clangd",
    "twxs.cmake",
    "marus25.cortex-debug"
]

### DETECT OS ###
OS_NAME = platform.system().lower()
IS_WINDOWS = OS_NAME == "windows"
IS_LINUX = OS_NAME == "linux"
IS_MAC = OS_NAME == "darwin"

### INSTALLATION COMMANDS ###
INSTALL_CMDS = {
    "cmake": {
        "windows": "winget install Kitware.CMake",
        "linux": "sudo apt install cmake -y",
        "mac": "brew install cmake"
    },
    "ninja": {
        "windows": "winget install Ninja-build.Ninja",
        "linux": "sudo apt install ninja-build -y",
        "mac": "brew install ninja"
    },
    "gcc_arm": {
        "windows": "winget install Arm.GnuArmEmbeddedToolchain",
        "linux": "sudo apt install gcc-arm-none-eabi -y",
        "mac": "brew install arm-none-eabi-gcc"
    },
    "openocd": {
        "windows": "winget install OpenOCD",
        "linux": "sudo apt install openocd -y",
        "mac": "brew install openocd"
    },
    "python": {
        "windows": "winget install Python.Python",
        "linux": "sudo apt install python3 -y",
        "mac": "brew install python"
    },
    "clangd": {
        "windows": "winget install LLVM.LLVM",
        "linux": "sudo apt install clangd -y",
        "mac": "brew install llvm"
    },
}

### MENU SYSTEM ###
def menu():
    print("\n=== STM32H7 Development Setup ===")
    print("1. Install All Required Software")
    print("2. Install Individual Components")
    print("3. Setup VS Code Configurations")
    print("4. Verify Installation")
    print("5. Exit")
    
    choice = input("\nEnter choice: ")
    if choice == "1":
        install_all()
    elif choice == "2":
        install_individual()
    elif choice == "3":
        setup_vscode()
    elif choice == "4":
        verify_installation()
    elif choice == "5":
        sys.exit(0)
    else:
        print("Invalid choice!")
        menu()

### INSTALL EVERYTHING ###
def install_all():
    print("\n Installing all required software...\n")
    for tool, cmds in INSTALL_CMDS.items():
        install(tool, cmds)
    setup_vscode()
    verify_installation()

### INSTALL INDIVIDUAL COMPONENTS ###
def install_individual():
    print("\n Select software to install:")
    for idx, tool in enumerate(INSTALL_CMDS.keys(), 1):
        print(f"{idx}. Install {tool}")
    
    choice = input("\nEnter number (or 'q' to quit): ")
    if choice.lower() == "q":
        menu()
    
    keys = list(INSTALL_CMDS.keys())
    if choice.isdigit() and 1 <= int(choice) <= len(keys):
        tool = keys[int(choice) - 1]
        install(tool, INSTALL_CMDS[tool])
    else:
        print("Invalid selection.")
    
    install_individual()

### RUN INSTALL COMMAND ###
def install(tool, cmds):
    print(f"\n🔹 Installing {tool}...")
    cmd = cmds["windows"] if IS_WINDOWS else cmds["linux"] if IS_LINUX else cmds["mac"]
    try:
        subprocess.run(cmd, shell=True, check=True)
        print(f"{tool} installed successfully!")
    except subprocess.CalledProcessError:
        print(f"Failed to install {tool}.")

### SETUP VS CODE CONFIGURATIONS ###
def setup_vscode():
    print("\n Configuring VS Code...")

    vscode_settings = {
        "c_cpp_properties.json": {
            "configurations": [
                {
                    "name": "STM32",
                    "includePath": [
                        "${workspaceFolder}/Core/Inc",
                        "${workspaceFolder}/Drivers/CMSIS/Include"
                    ],
                    "defines": ["STM32H755xx", "USE_HAL_DRIVER"],
                    "compilerPath": "arm-none-eabi-gcc",
                    "cStandard": "c11",
                    "cppStandard": "c++17"
                }
            ],
            "version": 4
        }
    }

    # Create .vscode directory if it doesn’t exist
    vscode_dir = os.path.join(os.getcwd(), ".vscode")
    os.makedirs(vscode_dir, exist_ok=True)

    # Write configuration files
    for filename, content in vscode_settings.items():
        with open(os.path.join(vscode_dir, filename), "w") as f:
            import json
            json.dump(content, f, indent=4)
        print(f"{filename} configured.")

    # Install VS Code Extensions
    for ext in VS_CODE_EXTENSIONS:
        subprocess.run(f"code --install-extension {ext}", shell=True)

    print("VS Code setup complete!")

### VERIFY INSTALLATION ###
def verify_installation():
    print("\n🔹 Verifying Installation...")

    checks = {
        "CMake": "cmake --version",
        "Ninja": "ninja --version",
        "GCC ARM Toolchain": "arm-none-eabi-gcc --version",
        "OpenOCD": "openocd --version",
        "Python": "python --version",
        "Clangd": "clangd --version",
    }

    for tool, cmd in checks.items():
        try:
            subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
            print(f"{tool} is installed.")
        except subprocess.CalledProcessError:
            print(f"{tool} is missing!")

    print("\n🔹 Setup complete! Run `code .` to start developing.")

if __name__ == "__main__":
    menu()
