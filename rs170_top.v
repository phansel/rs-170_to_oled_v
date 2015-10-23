module rs170_top (
  input clk,
  input rst,
  input [7:0] adc_data;
  output adc_en;
  
  output [7:0] oled_data,
  output oled_e,
  output oled_rw,
  output oled_dc,
  output oled_cs
);
