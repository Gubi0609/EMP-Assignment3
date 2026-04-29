//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Wed Apr 29 13:30:16 2026
//Host        : Odysseus running 64-bit Ubuntu 24.04.4 LTS
//Command     : generate_target UART_w_RAM.bd
//Design      : UART_w_RAM
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "UART_w_RAM,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=UART_w_RAM,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "UART_w_RAM.hwdef" *) 
module UART_w_RAM
   (btn_0,
    jb_0,
    jb_1,
    sysclk);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.BTN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.BTN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input btn_0;
  input jb_0;
  output jb_1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYSCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYSCLK, ASSOCIATED_RESET btn_0, CLK_DOMAIN UART_w_RAM_sysclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input sysclk;

  wire [7:0]RAM_16_4_0_dout;
  wire btn_0;
  wire clk_divider_0_clk_div;
  wire jb_0;
  wire jb_1;
  wire [3:0]ram_ctrl_0_addr;
  wire [7:0]ram_ctrl_0_data_in;
  wire [7:0]ram_ctrl_0_din;
  wire ram_ctrl_0_shift_load;
  wire ram_ctrl_0_wr;
  wire [7:0]rx_mod_0_data_out;
  wire rx_mod_0_intr;
  wire sysclk;
  wire tx_mod_0_xmitmt;

  UART_w_RAM_RAM_16_4_0_0 RAM_16_4_0
       (.addr(ram_ctrl_0_addr),
        .clk(clk_divider_0_clk_div),
        .din(ram_ctrl_0_din),
        .dout(RAM_16_4_0_dout),
        .wr(ram_ctrl_0_wr));
  UART_w_RAM_clk_divider_0_0 clk_divider_0
       (.clk(sysclk),
        .clk_div(clk_divider_0_clk_div),
        .rst(btn_0));
  UART_w_RAM_ram_ctrl_0_0 ram_ctrl_0
       (.addr(ram_ctrl_0_addr),
        .clkfast(clk_divider_0_clk_div),
        .data_in(ram_ctrl_0_data_in),
        .data_out(rx_mod_0_data_out),
        .din(ram_ctrl_0_din),
        .dout(RAM_16_4_0_dout),
        .intr(rx_mod_0_intr),
        .rst(btn_0),
        .shift_load(ram_ctrl_0_shift_load),
        .wr(ram_ctrl_0_wr),
        .xmitmt(tx_mod_0_xmitmt));
  UART_w_RAM_rx_mod_0_0 rx_mod_0
       (.clk(sysclk),
        .data_out(rx_mod_0_data_out),
        .intr(rx_mod_0_intr),
        .rst(btn_0),
        .sin(jb_0));
  UART_w_RAM_tx_mod_0_0 tx_mod_0
       (.clkfast(clk_divider_0_clk_div),
        .data_in(ram_ctrl_0_data_in),
        .rst(btn_0),
        .shift_load(ram_ctrl_0_shift_load),
        .sout(jb_1),
        .xmitmt(tx_mod_0_xmitmt));
endmodule
