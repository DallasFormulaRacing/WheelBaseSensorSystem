# The Wheel Base Sensor System Repository

![CircleCI](https://img.shields.io/circleci/build/github/DallasFormulaRacing/WheelBaseSensorSystem?style=flat-square)
![Static Badge](https://img.shields.io/badge/fsae_season-2026-brightgreen?style=flat-square&logoColor=8A2BE2&color=8A2BE2)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/DallasFormulaRacing/WheelBaseSensorSystem/main?style=flat-square) ![Static Badge](https://img.shields.io/badge/H7-5e5e5e?style=flat-square&logo=stmicroelectronics)

## Overview

The Wheel Base Sensor System (WBSS) is the current development version of the data acquisitions system for the Dallas Formula Racing combustion engine vehicle. This repository has all firmware, style guidelines, and component documentation pertinent to the WBSS and its development.

A key improvement of the WBSS over the previous data acquisition system is its ability to sample data directly at the base of each wheel, where it filters out noise at the source, digitizes the signal, and forwards it to the CAN bus, mitigating signal degradation.

## Components

There exist two types of sensors on the WBSS: integrated sensors and modular sensors.

Integrated sensors are permanent components on the custom PCB and remain on the car during competitions. Since there are 4 wheels, there are 4 copies of the PCB at each base, thus there are 4 copies of each sensor.

Modular sensors are easily removable and will be removed prior to a competition. Modular sensors are independent of one another.
