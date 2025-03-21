## Digital Stopwatch (SystemVerilog)  
**Course:** CIE 239 – Digital Design and Computer Architecture  
**Platform:** DE0-Nano FPGA  
**Language:** SystemVerilog (IEEE 1800-2017)

### Description
This project is a fully functional digital stopwatch designed and implemented using SystemVerilog and deployed on the DE0-Nano FPGA board. The stopwatch supports counting in both upward and downward directions, with various operational controls such as speed modification, reset, and time adjustment. The project was developed following structural design principles and modular hardware description.

---

### Functional Requirements
- 4-digit stopwatch in MM:SS format
- Starting value: 10:20  
- Maximum value: 49:30  
- Input Controls:
  - **Start/Pause** switch
  - **Count Up/Down** mode switch (only toggles when paused)
  - **Speed Up** mode (2 units/second)
  - **Slow Down** mode (1 unit/2 seconds)
  - **Reset** button (resets to 10:20)
  - **Add/Subtract 2 minutes** button

---

### Optional Features Implemented
- **Error Code 1 (F3:F3)**: Flashes when the mode is toggled during active counting.
- **Error Code 2 (55:55)**: Flashes and pauses the system when both speed-up and slow-down are active.
- **Seven Segment Display Support**: Stopwatch time output can be shown on external 7-segment displays.

---

### Key Modules
- `Main.sv`: Top-level module coordinating the stopwatch system.
- `Clock_Divider.sv` / `ClockDivider.sv`: Adjusts the input clock frequency.
- `4BitCounterSeconds.sv`, `FourBitCounterMinutes.sv`: Counters for seconds and minutes.
- `ThreeBit_Minutes.sv`, `ThreeBit_Seconds.sv`: Helper counters.
- `D_Flip_Flop.sv`, `T_Flip_Flop.v`: Basic sequential building blocks.
- `FullAdder.sv`, `FourBitAdderSubtractor.sv`: Arithmetic units.
- `mux21.sv`, `mux42.sv`: Multiplexer modules.
- `Decoder_Seven_Segments.sv`: Converts binary input to 7-segment display format.

---

### Simulation & Testing
- Simulated using ModelSim with complete testbenches.
- Verified all control signals and edge cases including mode switches and error conditions.
- Files like `transcript` and `vsim.wlf` reflect simulation outputs.

---

### How to Run on FPGA (DE0-Nano)
1. Open the project using ModelSim or your preferred HDL simulation tool.
2. Simulate and verify using `Main.sv` as the top module.
3. Synthesize and upload the design to the DE0-Nano board using appropriate tools (e.g., Quartus Prime).
4. Connect the required switches and LEDs as per the functional description.
