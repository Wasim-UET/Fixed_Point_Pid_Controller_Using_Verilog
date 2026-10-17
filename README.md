# Fixed_Point_Pid_Controller_Using_Verilog
A synthesizable fixed-point PID controller implementation in Verilog with anti-windup protection, output clamping, and testbench simulation.

# Fixed-Point PID Controller in Verilog

This repository contains a fully synthesizable **PID (Proportional-Integral-Derivative) Controller** implemented in Verilog HDL[cite: 1]. It includes fixed-point arithmetic scaling, integral anti-windup protection, output clamping, and a comprehensive testbench for simulation[cite: 1, 2].

## Features
- **Fixed-Point Arithmetic:** Scaled by $2^8$ (`SCALING_FACTOR = 8`) for efficient hardware implementation without floating-point units[cite: 1].
- **Anti-Windup Protection:** Clamps the integral term when error bounds are exceeded to prevent controller saturation[cite: 1].
- **Output Clamping:** Ensures the final PWM output stays safely within the 8-bit range (0 to 255)[cite: 1].
- **Testbench Included:** Simulates step response and overshoot scenario with VCD waveform dumping support[cite: 2].

## Project Structure
- `design.sv` (or `pid_controller.v`): Main PID controller module logic[cite: 1].
- `testbench.sv` (or `pid_controller_tb.v`): Testbench module for verifying design response[cite: 2].

## Port Signals
| Signal Name | Direction | Bit Width | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1 | Clock signal[cite: 1] |
| `rst_n` | Input | 1 | Active-low asynchronous reset[cite: 1] |
| `setpoint` | Input | 16 (Signed) | Desired reference input value[cite: 1] |
| `feedback` | Input | 16 (Signed) | Measured system feedback from sensor[cite: 1] |
| `Kp`, `Ki`, `Kd` | Input | 8 | Proportional, Integral, and Derivative gain constants[cite: 1] |
| `pwm_duty_out` | Output | 8 | Final calculated PWM duty cycle output (0-255)[cite: 1] |

## How to Run Simulation

### Online (EDA Playground / ChipVerify)
1. Copy `design.sv` and `testbench.sv` into EDA Playground / ChipVerify editor.
2. Choose **Icarus Verilog** or **ModelSim** as the simulator.
3. Check the **"Open EPWave after run"** option to view generated waveform diagrams.

### Local Simulation (Icarus Verilog + GTKWave)
Run the following commands in your terminal:
```bash
iverilog -o pid_sim pid_controller.v pid_controller_tb.v
vvp pid_sim
gtkwave dump.vcd
