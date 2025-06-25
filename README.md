# AXI Lite Easy Project

This is a beginner-friendly AXI4-Lite slave and testbench written in SystemVerilog for learning digital design verification.

## Structure

- `axi_lite_dut.sv`: A minimal AXI4-Lite slave DUT with basic handshaking
- `axi_lite_tb.sv`: Simple testbench with one write transaction
- `axi_write` task: Drives address, data, and write handshakes

## Tools

- Simulated using Vivado XSIM (Vivado GUI or Tcl)
- Developed on WSL2 + Vim 

## AXI Write Waveform

Click to view: [Waveform Screenshot](AXI_lite_write_read_waveform.png)
## To Do

- [ ] Add AXI read transaction
- [ ] Add assertions and functional coverage
- [ ] Add waveform screenshots

## Author

[Atiq Azmil](https://github.com/atiqazmil)
