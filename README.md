# The Wheel Base Sensor System Repository

[![CircleCI](https://dl.circleci.com/status-badge/img/circleci/12HSJKR4Y3XJ4mMsZkizAh/PB9RMDcgrGtSuYaj64ENhc/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/circleci/12HSJKR4Y3XJ4mMsZkizAh/PB9RMDcgrGtSuYaj64ENhc/tree/main)
![Static Badge](https://img.shields.io/badge/fsae_season-2026-brightgreen?style=flat-square&logoColor=8A2BE2&color=8A2BE2) ![Static Badge](https://img.shields.io/badge/deadline-dec_2025-brightgreen?style=flat-square&color=655991) ![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/DallasFormulaRacing/WheelBaseSensorSystem/main?style=flat-square) ![Static Badge](https://img.shields.io/badge/H7-5e5e5e?style=flat-square&logo=stmicroelectronics)

## Overview

The Wheel Base Sensor System (WBSS) is the current development version of the data acquisitions system for the Dallas Formula Racing combustion engine vehicle. This repository has all firmware, style guidelines, and component documentation pertinent to the WBSS and its development.

A key improvement of the WBSS over the previous data acquisition system is its ability to sample data directly at the base of each wheel, where it filters out noise at the source, digitizes the signal, and forwards it to the CAN bus, mitigating signal degradation.

## Components

There exist two types of sensors on the WBSS: integrated sensors and modular sensors.

Integrated sensors are permanent components on the custom PCB and remain on the car during competitions. Since there are 4 wheels, there are 4 copies of the PCB at each base, thus there are 4 copies of each sensor.

Modular sensors are easily removable and will be removed prior to a competition. Modular sensors are independent of one another.

### Integrated Sensors (x4)

| Sensor Name               | Signal  | Protocol | Location   |
| ------------------------- | ------- | -------- | ---------- |
| Wheel Speed               | Digital | ?        | Base       |
| Linear Pots               | Analog  | ?        | Suspension |
| Differential Pressure     | Digital | ?        | Tire       |
| Global Positioning System | Digital | ?        | Chassis    |
| Accelerometer             | ?       | ?        | Base       |

### Modular Sensors

| Sensor Name               | Signal  | Protocol | Location      |
| ------------------------- | ------- | -------- | ------------- |
| Tire Temperature          | Digital | ?        | Wheel Base x4 |
| Absolute Pressure Sensors | ?       | ?        | Nose          |

## Directory Structure
```
.
├── CM4
│   └── Core
│       ├── Inc
│       ├── Src
│       └── Startup
├── CM7
│   └── Core
│       ├── Inc
│       ├── Src
│       └── Startup
├── Common
│   └── Src
└── Drivers
    ├── BSP
    │   └── STM32H7xx_Nucleo
    ├── CMSIS
    │   ├── Device
    │   │   └── ST
    │   │       └── STM32H7xx
    │   │           └── Include
    │   └── Include
    └── STM32H7xx_HAL_Driver
        ├── Inc
        │   └── Legacy
        └── Src

26 directories
```
Subject to Change

## Things You Need...

### On Your Machine

- Git
- Github account
- STM32CubeIDE
- CMAKE
- Arm compiler
- STLink
- OpenOCD
