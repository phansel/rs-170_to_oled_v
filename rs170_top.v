// Code your design here
module rs170_top (
    input clk,
    output led134,
    //input adcclk,
    //input [7:0] adcd,
    output reg oled_dc = 0,
    output reg oled_rw = 0,
    output reg oled_cs = 1,
    output reg oled_e = 1,
    output reg oled_reset = 1,
    output reg [7:0] oled_data
  );



  reg [4:0] counter = 0;

  reg initializing = 1;

  reg donewithgddram = 0;

  reg [7:0] oled_inits[0:24];

  reg [7:0] oled_gdram [0:1023];  // 0

  reg [7:0] buffered_oled_cmds;

  reg [7:0] buffered_oled_data;



  assign led134 = 1;          // led on to show that it synthesized correctly



  reg [4:0] counter = 0;

  reg initializing = 1;

  reg donewithgddram = 0;

  reg [7:0] oled_inits[0:24];

  reg [7:0] oled_gdram [0:1023];

  reg [7:0] buffered_oled_cmds;

  reg [7:0] buffered_oled_data;



  assign led134 = 1;          // led on to show that it synthesized correctly


  // reg [7:0] oled_gddram [0:127] [0:7]; // 8 pages of 128 bytes each

  reg [0:6]  which_init = 7'd0;
  reg [0:10] which_byte = 11'd0;
  reg [4:0] clocksperbyte = 5'd16;     ///////////////// this sets the length of each byte in 50MHz clocks


  always @(negedge clk) begin
    if(initializing == 0)
      oled_dc <= 1;
  end
  // reg initializing = 1;
  // reg donewithgddram = 0;

  always @(posedge clk) begin

    // this counter manages outputs, states, etc; eerything
    counter <= counter + 1;   // one counter = one clock

    if(initializing == 1 & counter > 1 & counter < 5 & which_init == 0)
      oled_reset <= 0;
    else
      oled_reset <= 1;

    if(counter > 1 & counter < 14)
      oled_cs <= 0;
    else
      oled_cs <= 1;




    if(which_init < 25) begin
      initializing <= 1;
    end

    if(which_init > 25 & initializing != 0)begin
      initializing <= 0;
    end
    if(which_byte > 1023) begin
      initializing <= 0;
      donewithgddram <= 1;
      which_byte <= 0;
    end

    if (counter >= 8 & counter != 16 & donewithgddram != 1) begin
      oled_e <= 0;
    end

    if (counter == 0)
      oled_e <= 1;

    if( initializing == 1) begin
      oled_data <= buffered_oled_cmds;
    end
    else
      oled_data <= buffered_oled_data;

    if (counter == 15) begin
      oled_e <= 0;

      if(which_byte <= 1024 & initializing == 0 & donewithgddram != 1)
        which_byte <= which_byte + 1;

      if(which_init <= 25 & initializing == 1)
        which_init <= which_init + 1;
    end


    if(counter == 16)
      counter <= 0;


    //counter2 <= counter2 + 1;
    if(counter == clocksperbyte)
      counter <= 0;

    if(initializing == 1 & donewithgddram != 1)
      buffered_oled_cmds <= oled_inits[which_init];

    if(initializing == 0 & donewithgddram != 1)
      buffered_oled_data <= oled_gdram[which_byte];
  end



  /*
  reg [7:0] oled_
  [0:24];

  reg [7:0] buffered_oled_data;


  assign led134 = 1;          // led on to show  that it synthesized correctly


  reg [7:0] oled_gddram [0:1023]; // 8 pages of 128 bytes each

  reg [10:0] i = 0;
  always @* begin
  if (i >= 500 & i <= 800)
  oled_gddram [i] <= 8'b11111111;
  i <= i + 1;
  end

  reg [0:6] which_init = 7'd0;
  reg [0:10] which_byte = 11'd0;


  reg [4:0] counter = 0;
  reg [7:0] counter2 = 0;

  always @(posedge clk) begin
  if(which_init < 25)
  buffered_oled_data <= oled_inits[which_init];
  if(which_init > 25)
  buffered_oled_data <= oled_gddram[which_byte];
  end


  always @(posedge clk) begin
  counter <= counter + 1;   // one counter = one clock
  counter2 <= counter2 + 1;

  if (counter < 8) begin
  oled_data <= buffered_oled_data;
  oled_e <= 1;
  end
  if (counter >= 8 & counter != 16) begin
  oled_e <= 0;
  end
  if (counter == 15) begin
  oled_e <= 0;
  if(which_init <= 25)
  which_init <= which_init + 1;
  if(which_init > 25 & which_byte < 1023)
  which_byte <= which_byte + 1;
  else
  which_byte <= 0;
  end

  if(counter == 16)
  counter <= 0;
  end

  always @(posedge clk) begin

  if(which_init > 25) begin
  oled_dc <= 1;
  end
  else
  oled_dc <= 0;

  end

  */

  always @(posedge clk) begin

    oled_gdram[400] <= 8'b11111111;
    oled_gdram[420] <= 8'b11111111;
    oled_gdram[440] <= 8'b11111111;
    oled_gdram[460] <= 8'b11111111;
    oled_gdram[480] <= 8'b11111111;
    oled_gdram[500] <= 8'b11111111;
    oled_gdram[520] <= 8'b11111111;
    //oled_gdram[510] <= 8'b01010101;
//    oled_gdram[530] <= 8'b01010101;
//    oled_gdram[550] <= 8'b01010101;
//    oled_gdram[580] <= 8'b01010101;
//    oled_gdram[590] <= 8'b01010101;
//   oled_gdram[600] <= 8'b01010101;
//   oled_gdram[610] <= 8'b01010101;
//   oled_gdram[630] <= 8'b01010101;
//   oled_gdram[670] <= 8'b01010101;
//    oled_gdram[780] <= 8'b01010101;
//    oled_gdram[800] <= 8'b01010101;

    oled_inits[0]  <= 8'hAE;
    oled_inits[1]  <= 8'hD5;
    oled_inits[2]  <= 8'h80;

    oled_inits[3]  <= 8'hA8;
    oled_inits[4]  <= 8'h2F;

    oled_inits[5]  <= 8'hD3;
    oled_inits[6]  <= 8'h00;

    oled_inits[7]  <= 8'h00;

    oled_inits[8]  <= 8'h8D;   // charge pump
    oled_inits[9]  <= 8'h14;

    oled_inits[10] <= 8'hA6;
    oled_inits[11] <= 8'hA4;

    oled_inits[12] <= 8'hA0;
    oled_inits[13] <= 8'hC0;

    oled_inits[14] <= 8'hA8;

    oled_inits[15] <= 8'hDA;
    oled_inits[16] <= 8'h12;

    oled_inits[17] <= 8'h81;
    oled_inits[18] <= 8'hFF;

    oled_inits[19] <= 8'hD9;
    oled_inits[20] <= 8'hF1;

    oled_inits[21] <= 8'hDB;
    oled_inits[22] <= 8'h40;

    oled_inits[23] <= 8'hAF;   // display on
    oled_inits[24] <= 8'h00; // dummy byte      //hA6;   // this is supposed to invert
  end







endmodule
