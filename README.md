# rs-170_to_oled_v
A Verilog RS-170 (NTSC) to SSD1306 library. This is not the first SSD1306 library; but it is probably the first SSD1306 6800-interface driver in HDL.

The first step is to display bitmaps on the OLED; then, to convert analog RS-170/NTSC data to digital values with the TI ADC08100; and then to link the two with a framebuffer. The OLED is only 64x48; the SSD1306 supports up to 128x64, so not all of the framebuffer is going to be actual data. Probably room for scrolling/distortion effects.

RS-170 is ~30 frames per second; each frame is officially composed of 485 780-pixel-wide lines, divided into fields made of the even and odd lines. It's functionally very similar to NTSC.

The FPGA is a Spartan6 LX9, speed grade -2 from Xilinx. It has about 80 output pins and an internal 50 MHz clock, so it should be enough for this application.

The OLED is a 1-bit 64x48 display driven by the SSD1306 that takes data in over I2C, SPI, and either an 8080- or 6800-style parallel interface. This library is designed around the 6800-style interface.

The ADC08100 is an extremely low-power 20-100 MSPS analog-to-digital converter from TI that is sufficient for ~5 bits of RS-170 video depth, or more if opamps are used to dynamically control the range. The current hardware for this project does not permit this.

This OLED driver chip has been driven at speeds up to (and possibly exceeding) 500Hz; so PWMing the display to increase the bit depth is the next step. To achieve 3 effective bits, each of the 30 RS-170 frames would be converted to 8 bitmaps with different brightness thresholds, which would then be displayed sequentially for a total speed of 240 Hz (or, with frame doubling, 480 Hz). With better hardware on the ADC end, better bitdepth is no doubt possible.

This is a work in progress. I would not recommend building it, as you will get thrown a number of errors.
