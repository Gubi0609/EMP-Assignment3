//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Wed Apr 29 13:30:16 2026
//Host        : Odysseus running 64-bit Ubuntu 24.04.4 LTS
//Command     : generate_target UART_w_RAM_wrapper.bd
//Design      : UART_w_RAM_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module UART_w_RAM_wrapper
   (btn_0,
    jb_0,
    jb_1,
    sysclk);
  input btn_0;
  input jb_0;
  output jb_1;
  input sysclk;

  wire btn_0;
  wire jb_0;
  wire jb_1;
  wire sysclk;

  UART_w_RAM UART_w_RAM_i
       (.btn_0(btn_0),
        .jb_0(jb_0),
        .jb_1(jb_1),
        .sysclk(sysclk));
endmodule
