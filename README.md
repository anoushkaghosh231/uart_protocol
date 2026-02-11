# uart_protocol

## Implementation of UART protocol through VIVADO 
- Baud Rate Generator – derives transmit (enb_tx) and receive (enb_rx) clock enables from a system clock, parameterized by frequency and baud rate.
- UART Transmitter – serializes 8‑bit parallel data into start, data, and stop bits, driven by enb_tx. It asserts busy while transmission is active.
- UART Receiver – oversamples the incoming serial line (rx) using enb_rx, detects the start bit, samples data bits at mid‑bit timing, and reconstructs the parallel byte. It asserts rdy when a valid byte is available.
- Top Module – integrates the generator, transmitter, and receiver, wiring the transmitter output directly to the receiver input for loopback testing.

It brings together a transmitter, receiver, and baud‑rate generator into a simple top‑level design, with testbenches to verify everything in simulation. The transmitter pushes out bytes bit‑by‑bit, the receiver oversamples to capture them reliably, and the baud generator keeps both sides in sync.

<img width="1477" height="647" alt="image" src="https://github.com/user-attachments/assets/70cc86fd-2eeb-4b46-a29c-b6cfb78029b9" />
