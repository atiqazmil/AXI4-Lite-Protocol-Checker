# AXI-Lite Protocol Compliance Checker

This project validates AMBA AXI-Lite protocol compliance through a SystemVerilog-based checker with directed stimulus, assertions, and coverage.

## Tools Used
- Vivado XSIM 2025.1
- WSL2 (Ubuntu)
- Git (version control)

## Project Structure
- `axi_lite_dut.sv` — DUT model
- `axi_lite_driver.sv` — Simple driver for write/read
- `axi_lite_tb.sv` — Testbench wrapper
- `axi_lite_monitor.sv` — Monitor
- `wave.do` — Waveform script
- `README.md` — Documentation

## Verification Features
- Directed test for write transaction
- SystemVerilog assertions for handshake protocol correctness
- Functional coverage via covergroups
- Simulated using Vivado CLI and waveform viewed with `xsim`

## Outcome
- Protocol violations caught with assertions
- 100% stimulus coverage achieved
- Designed for future expansion into AXI4 and UVM environments

## To Run
xvlog -sv axi_lite_dut.sv axi_lite_driver.sv axi_lite_tb.sv axi_lite_monitor.sv
xelab work.axi_lite_tb -s axi_sim -debug all -timescale 1ns/1ps
xsim axi_sim -gui
do wave.do
run 200ns

## AXI Write Waveform

Click to view: [Waveform Screenshot](AXI_lite_write_read_waveform.png)

## To Do/Future Plans

-Extend to full AXI4 protocol with burst and ID support
-Convert the testbench into a reusable UVM agent (driver, monitor, sequencer)
-Integrate constrained-random sequences and layered tests
-Enable coverage-driven closure and regression testing with CI 

## Author

[Atiq Azmil](https://github.com/atiqazmil)
