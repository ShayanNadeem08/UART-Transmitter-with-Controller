# UART-Transmitter-with-Controller
A repository containing Verilog implementations of a UVART Transmitter module and a Controller module for serial data transmission using a UART protocol.
# UVART Task

This repository contains the implementation of a UVART (Universal Asynchronous Receiver Transmitter) task. The task involves designing a UVART transmitter module and a controller module to control the transmission of data over a UART communication protocol.

## Task Description

The UVART task aims to transmit data using the UART protocol, which involves converting parallel data into serial data and transmitting it asynchronously. The UVART transmitter module and controller module work together to achieve this functionality.

The UVART transmitter module includes a shift register, counters, clock generation logic, and control logic. It takes parallel data as input and converts it into serial data using the shift register. The transmitter operates based on two clocks: a fast clock and a slow clock. The fast clock is used to control the timing of data transmission, while the slow clock is used for generating the start bit, data bits, and stop bit.

The controller module manages the overall operation of the UVART transmitter. It controls the state transitions and timing of the data transmission process. The controller module interacts with the UVART transmitter module to ensure proper synchronization and data transmission. It includes states such as S0, S1, S2, and S3, which govern the behavior of the UVART transmitter based on input signals such as Byte_ready, T_Byte, clk, rst, counter_of_i, and counter_baud_of_i.

The UVART task involves specific requirements, such as resetting the shift register after transmitting 9 bits of data and resetting the counter after reaching a certain value (5208 in this case). These requirements ensure proper data transmission and synchronization in the UART protocol.

## Repository Contents

- `UART_controller.sv`: SystemVerilog implementation of the UVART Controller module.
- `UART_datapath.sv`: SystemVerilog implementation of the UVART Datapath module.
- `UART_transmitter.sv`: SystemVerilog implementation of the UVART Transmitter module.
- `UART_transmitter_tb.sv`: SystemVerilog testbench to verify the functionality of the UVART Transmitter module.
- `README.md`: This file, providing an overview of the UVART task and repository.

## Getting Started

To use the UVART Transmitter module and the Controller module, follow these steps:

1. Clone the repository:

2. Open the files `UART_controller.sv`, `UART_datapath.sv`, and `UART_transmitter.sv` in your SystemVerilog compatible simulator or synthesis tool.

3. Compile and simulate/synthesize the modules according to your specific tool's instructions.

4. Use the `UART_transmitter_tb.sv` testbench to verify the functionality of the UVART Transmitter module.

5. Analyze the simulation/synthesis results and waveform to ensure proper operation of the UVART task implementation.

For detailed module usage and interface information, refer to the comments/documentation within each respective SystemVerilog file.
