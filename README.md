# SPI Slave with Single Port RAM Verification Project

## Overview
This project presents a complete **UVM-based verification environment** for an **SPI Slave connected to a Single Port RAM**.  
The verification flow includes:

- Functional Verification
- Code Coverage Analysis
- Assertion-Based Verification (SVA)
- Functional Coverage
- FSM Coverage
- UVM Testbench Development
- Bug Detection and Fixing

The project was divided into three main parts:

1. SPI Slave Verification
2. Single Port RAM Verification
3. Wrapper Verification using UVM

---

# Project Objectives

The main goals of this project were:

- Verify the functionality of the SPI Slave design
- Verify correct communication between SPI and RAM
- Build a reusable UVM verification environment
- Achieve high functional and code coverage
- Detect and fix RTL bugs using assertions and coverage analysis
- Validate write/read transactions through SPI protocol

---

# Tools & Methodology

## Verification Techniques Used

- SystemVerilog
- UVM (Universal Verification Methodology)
- Assertions (SVA)
- Functional Coverage
- Code Coverage
- FSM Coverage
- Scoreboard Checking
- Directed & Randomized Testing

---

# Project Architecture

## DUT Components

### 1. SPI Slave
Responsible for:
- Receiving serial data from MOSI
- Decoding commands
- Writing/reading data
- Sending data on MISO

### 2. Single Port RAM
Responsible for:
- Storing incoming data
- Returning stored data during read operations

### 3. Wrapper
Connects:
- SPI Slave
- RAM
- Verification Environment

---

# SPI Slave Verification

## FSM States

The SPI Slave FSM contains the following states:

| State | Description |
|---|---|
| IDLE | Waiting for communication |
| CHK_CMD | Checking incoming command |
| WRITE | Writing incoming data |
| READ_ADD | Receiving read address |
| READ_DATA | Sending read data |

---

# Verification Plan

The SPI verification plan included checking:

- Reset functionality
- Write operations
- Read address handling
- Read data handling
- FSM transitions
- MISO behavior
- rx_valid generation
- Counter behavior

---

# Functional Coverage

The following coverpoints were implemented:

- `rx_data`
- `MOSI`
- `SS_n`
- Transaction sequences
- Read/Write transitions

## Coverage Results

| Coverage Type | Result |
|---|---|
| Functional Coverage | 100% |
| Covergroup Coverage | 100% |
| Directive Coverage | 100% |

---

# Assertions (SVA)

Several assertions were implemented to validate the design behavior.

## Example Checks

- Reset behavior
- Stable MISO outside READ state
- Correct FSM transitions
- Proper rx_valid generation
- Counter operation correctness

## Assertion Results

| Assertions | Result |
|---|---|
| Assertion Coverage | 100% |
| Passed Assertions | All |
| Failed Assertions | 0 |

---

# Code Coverage Results

## SPI Slave Coverage

| Coverage Type | Result |
|---|---|
| Statement Coverage | 100% |
| Branch Coverage | 100% |
| Toggle Coverage | 100% |
| Condition Coverage | 100% |
| FSM State Coverage | 100% |
| FSM Transition Coverage | 87.5% |

---

# Bugs Found & Fixed

## Bug #1 — Wrong FSM Transition

### Problem
The FSM moved to the wrong next state when:
- `received_address == 1`

### Before Fix
```systemverilog
if (received_address)
    ns = READ_ADD;
else
    ns = READ_DATA;
