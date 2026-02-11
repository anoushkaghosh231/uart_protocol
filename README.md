# uart_protocol
It brings together a transmitter, receiver, and baud‑rate generator into a simple top‑level design, with testbenches to verify everything in simulation. The transmitter pushes out bytes bit‑by‑bit, the receiver oversamples to capture them reliably, and the baud generator keeps both sides in sync.
