# Digital Audio Visualizer
Digital Audio Visualizer (DAV) is a new IEEE project that will pilot in the 2020-2021 academic year. The goal is to teach future members about new topics that existing projects do not cover, such as signal processing, digital logic, FPGA’s, and Verilog. 

To do so, members will design a system that uses an FPGA as a digital signals processor. The FPGA will receive audio inputs in real time through an external microphone and display the resulting frequency spectrum on an external display. A block diagram is shown below.

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/Block%20Diagram.png)

I designed and implemented the system to verify that it is possible on the chosen hardware. This documentation describes all of the steps taken and difficulties encountered while implementing the digital audio visualizer. The reader should understand how to replicate or even improve the existing design.

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/System.png)
![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/Ext.Display.png)

## Hardware
* [SPH0645 i2S MEMS Microphone](https://www.adafruit.com/product/3421)
* [DE10-Lite FPGA Dev Kit](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=234&No=1021&PartNo=8)
* VGA Compatible Monitor
* VGA Male to Male Cable
* Wires

I selected an i2S MEMS microphone primarily because it can transmit audio information through a digital communication protocol. Analog or PCM microphones were not considered since an FPGA is a digital device and can't interface with these microphones. However, I later discovered that this is not true and more information is provided in the Future Improvements section.

I chose the DE10-Lite FPGA Dev Kit because it is cheap, fast (50MHz), and provides the necessary I/O for me to interface with the microphone and VGA display. To use the DE10-Lite, you must connect your computer to your FPGA through a USB A to B cable (one is packaged with the DE10-Lite). This will provide power to the FPGA and allow you to program it through intel's Quartus IDE. The table below lists all of the wire connections between the microphone and the FPGA. Any pins that are not listed are left floating.

| Microphone | FPGA |
|------------|------|
| VCC | GPIO 29 (3.3V pin) |
| GND | GPIO 30 (GND pin) |
| BCLK | Defined by Designer |
| DOUT | Defined by Designer |
| LRCLK | Defined by Designer |

I used a VGA monitor as my external display because it is simple to use with an FPGA, provides a lot of flexibility, and offers a lot of pixels to visualize data. Additionally, there is a lot of open-source code and online information on how to design a VGA controller using Verilog. I connected the FPGA's VGA port to the monitor through the VGA Male to Male Cable. 

The "Quartus for Designing and Debugging" section will go over how to use Quartus, read/write to the FPGA's GPIO and VGA port pins, and define the microphone's BCLK, DOUT, and LRCLK pins.

## Files
### System Verilog (*.sv)
All of the synthesizable files are listed below in the heirarchy that they are used in the audio visualizer design.
* FFT
    * clkdiv
    * mic_translator
    * FFT_Processor
        * butterflyunit
    * VGA_generator

The **FFT** module is the top-level of the audio visualizer. Its inputs are the FPGA's 50MHz base clock (clk), a reset button on the FPGA board (reset), and the microphone's data signal (DOUT). Its outputs are the microphone's clk and control signals (BCLK, LRCLK), and the VGA's clk, control, and data signals (vsync, hsync, r[3:0], g[3:0], b[3:0]).

Internally, there are two clkdiv's, the mic_translator, FFT_Processor, and VGA_generator. The two clkdiv's are used to derive a 125kHz system clock and 25MHz vga clock from the FPGA's main 50MHz base clock. The system clock controls the mic_translator and FFT_Processor. I arbitrarily set to 125kHz to provide plenty of headroom for the mic_translator and FFT_Processor to meet timing constraints, such as any setup and hold times. The designer can experiment with a faster system clock speed if they desire. However, it doesn't matter for a VGA display since the VGA protocol is locked at 60 FPS. At 125kHz, the mic_translator and FFT_Processor can still complete multiple cycles within a single frame of the VGA monitor. The vga clock drives the VGA_generator and is set to 25MHz because it is required by the VGA protocol. Along with establishing the system and vga clock domains, the FFT file also connects the mic_translator, FFT_Processor, and VGA_generator together and links them with their respective I/O pins. A block diagram is shown below.

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/FFT%20Diagram.png)

The **clkdiv** module is used to generate a slower output clock (clk_out) from a faster input clock signal (clk_in). It also has a single parameter called counter_threshold, which can be used by the designer to set the output clock speed whenever a new clkdiv module is used in the project. The output clock frequency is based on the formula clk_out [Hz] = clk_in [Hz] / (2+2*counter_threshold). 

The **mic_translator** module is used to generate the microphone's i2S signals and translate them into a readable format for the FFT_Processor. The mic_translator also stores 16 sets of audio data, which is necessary for a 16 point FFT. The inputs are the 125kHz system clock (clk), a reset button on the FPGA board (reset), and the microphone's data signal (DOUT). The outputs are the microphone's clk and control signals (BCLK, LRCLK), a flag signal that indicates when a new audio sample has been acquired (new_t), and all 16 sets of stored audio data (t0[17:0] - t15[17:0]). It should be noted that the i2S signals' speed is dependant on the clk input, where BCLK is equal to the frequency of the input clk. Therefore, increasing the input clk frequency will increase the sample rate.

Internally, the mic_translator has several data buffers and counters controlled by sequential logic to generate and translate the microphone's i2S signals. You can find more information about the i2S protocol from online or from the microphone's datasheet.

The **FFT_Processor** module takes the audio data from the microphone, calculates the 16 point radix 2 decimation in time FFT over four clock cycles, and outputs the corresponding frequency data. The inputs are the 125kHz system clock (clk), a reset button on the FPGA (reset), a flag signal that indicates when a new audio sample has been acquired (new_t), and all 16 sets of stored audio data from the mic_translator (t0[17:0] - t15[17:0]). The outputs are a flag signal that indicates when the FFT calculation is finished, and all 16 sets of frequency data (f0[23:0] - f15[23:0]). 

The audio data from the mic_translator is first sign extended to convert it from 18 bits into 24. This is important because of bit growth, the additions and multiplications that occur throughout the calculation can increase the number of bits required to represent the output. For example, adding two 18 bit numbers requires a 19 bit output. Through simulations, we found that our implementation needs 6 extra bits to accomodate for bit growth. Additionally, the audio data from the mic_translator is zero padded into a 48 bit number. Those zeros represent the imaginary part of the audio data, which is set to 0 since it purely real. The result is formatted as {6'b sign_extension, 18'b audio_data, 24'b 0} which matches the butterflyunit's input format {24'b real, 24'b imag}. 

The FFT_Processor contains 8 butterflyunits that represent a single "layer" of the hardware FFT implementation and requires 4 clock cycles to complete an entire FFT calculation. More information on the hardware FFT implementation can be found [here](http://www.themobilestudio.net/the-fourier-transform-part-14) and a diagram is shown below. Larger FFT calculations would require more butterflyunits and clock cycles. For example, a 32 point FFT would require 16 butterflyunits and 5 clock cycles to complete. 

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/FFT%20Hardware%20Diagram.png)

The FFT_Processor uses sequential logic, summarized as its "control logic", to determine the inputs and twiddle factors to each butterflyunit. For example, when new formatted audio data is present (new_t high) and the FFT_Processor is inactive (done is high), the control logic will set the new formatted audio data as the next input to the butterflyunit array and set the twiddle factors for the first layer. During the next 3 clock cycles, the control logic will direct the outputs of the butterflyunits back to their inputs and set the twiddle factors for the next layer. This will allow the FFT_Processor to move through each "layer" of the hardware FFT implementation. After the final layer, the FFT_Processor will remain inactive (done is high). The f0[23:0] - f15[23:0] outputs will contain only the real values of the calculation since those are the values we are interested in visualizing. A block diagram is shown below. 
![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/FFT_Processor%20Diagram.png)
The **butterflyunit** module performs the smallest unit operation of the FFT on two inputs. More information on the butterfly unit can be found online. The inputs are the real & imaginary input samples (A_t[47:0] and B_t[47:0]) and the twiddle factor (W[47:0]). The outputs are the real & imaginary output samples (A_f[47:0], B_f[47:0]).

The input and output samples are formatted as {24'b real, 24'b imag}. For example, the upper 24 bits of A_t are the real values and the lower 24 bits are the imaginary values of input A_t. Internally, their is combinational logic that makes up 1 complex multiplier connected to 1 complex adder and 1 complex subtractor as shown below. It is important to note that multiplying two signed 48 bit numbers results in a 96 bit product with a redundant sign bit. However, the complex adder and subtractor both require 48 bit inputs. As a result, we must remove the redundant sign bit then truncate the product by passing only the upper 24 bits of the real and imaginary components to the adder and subtractor. This is equivalent to dividing the original product by 2^23. To compensate for this, we must multiply the twiddle factor by 2^23. 
![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/butterflyunit%20Diagram.png)
The **VGA_generator** is responsible for visualizing the FFT results onto a monitor. The inputs are a 25MHz VGA clock (clk), a flag signal from the FFT_Processor that notifies when it is done with a new FFT calculation (done), and all 16 sets of frequency data (f0[23:0] - f15[23:0]). The outputs are the VGA's vertical clock (vsync), horizontal clock (hsync), and color data (r[3:0], g[3:0], b[3:0]). You can find more information about the VGA protocol online. Additionally, there are plenty of open source verilog VGA controllers online that are probably less complicated than our implementation. The only unique part of our VGA_generator is the display module, which determines the color of each pixel based on the FFT results.

Since the FFT_Processor and VGA_generator are on two different clock domains, with the former at 125kHz and the later at 25MHz, they are asynchronous relative to each other. As a result, we need to use [synchronizers](http://www-inst.eecs.berkeley.edu/~cs150/sp12/agenda/lec/lec16-synch.pdf) on the frequency data passed between the two. This is done by using registers (f0_reg[23:0] - f15_reg[23:0]) that are clocked by the VGA_generator's 25MHz clock. This grabs onto the frequency data and synchronizes it with the rest of the VGA_generator's logic. Following that, we use another set of registers (f0_display[23:0] - f15_display[23:0]) that equals the respective f0_reg - f15_reg if it is a positive value or 23'b0 if it is a negative value. By doing this, we only display the real and positive output of the FFT calculation. This process is run between each frame when the FFT_Processor's done signal is flagged. The rest of the process is handled by 3 submodules within the VGA_generator that splits up the task of controlling the VGA signals. These are the **hsync** module, **vsync** module, and **display** module. 

The **hsync** module takes the 25MHz VGA_generator clock and generates the hsync signal using a counter. In addition to that, it generates flags for the vsync and display. This includes a blank_out flag that tells the display when it is unnecessary to output any data, the newline_out flag that tell the vsync when a full horizontal line has been completed, and the pixel_count which tells the display which column the current pixel is in.

The **vsync** module takes the hsync's newline_out flag, treats it like a clock, and generates the vsync signal using a counter. In addition to that, it generates flags for the display. This includes a blank_out flag that tells the display when it is unnecessary to output any data and the pixel_count which tells the display which row the current pixel is in.

The **display** module is where all of the logic for setting pixel colors is located. The inputs are the 25MHz VGA_generator clock (clk), a flag from the FFT_Processor that notifies when it is done with a new FFT calculation (done), blank signals from the hsync module and vsync module (hblank, vblank), the pixel column and row number from the hsync module and vsync module (horizontal_count, vertical_count) and all 16 sets of positive and real frequency data (f0[23:0] - f15[23:0]). The outputs are the pixel's color data (r[3:0], g[3:0], b[3:0]).

The first step is to map the positive and real frequency data to an appropriate value for our VGA display. In other words, we need to linearly transform the positive and real frequency data, which ranges from 0 to 8388607, to the number of vertical pixels on our VGA display, which ranges from 0 to 480. To complicate further, the vertical pixel count actually starts at the top of the display, meaning we need to invert the vertical pixel range. In addition, the actual frequency data from normal usage is significantly smaller than 8388607, probably due to the microphone's sensitivity. As a result, we set the frequency data range to be 0 to 16383 instead of 8388607. In the end, we are transforming a number from 0 to 16383 (not 0 to 8388607) into a number from 480 to 0 (not 0 to 480). This [stack exchange](https://stackoverflow.com/questions/929103/convert-a-number-range-to-another-range-maintaining-ratio) page explains math behind such a transform, but to summarize, we use the equation scaled_f = (f * -480 + 480 * 16383) / 16383 where f is the number in range 0 to 16383 and scaled_f is the mapped number in range 480 to 0. The diagram below shows the range for f next to its mapped range for scaled_f.

After that, the display module uses the scaled frequency data (scaled_f) along with the pixel's column and row number (horizontal_count and vertical_count) to determine the pixel's color. For our implementation, we divided the VGA display horizontally into 16 equal sections. The first column (pixels 0-40) visualizes a bar for scaled_f0, the second column (pixels 40-80) visualizes a bar for scaled_f1, and so on. Each bar is colored red and the background, empty space is colored black. To determine whether a pixel is red or black, the display module first checks the pixel's horizontal_count to determine which column is it in. After that, it compares the pixel's vertical_count with the column's scaled_f. The pixel will be set black if vertical_count < scaled_f and red if vertical_count >= scaled_f. The diagram below shows an example frame with the comparison shown for the fourth column.
![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/VGA_generator%20Diagram.png)
### Testbenches (*_TB.sv)
The following testbench files were used to debug the their respective *.sv files through simulation.
* clkdiv
* mic_translator
* FFT_Processor
* butterflyunit
### Debugging Scripts (*.py)
The following scripts were used to perform quick calculations used to verify the testbench results.
* butteryfly_test

The butterfly_test script is used to help debug the butterflyunit module. To use it, you call the command shown below 

`python butterfly_test [a_real] [a_imag] [b_real] [b_imag]`

## Quartus for Design and Debugging
Quartus is intel's IDE for developing with their line of FPGA's. For this project, we used Quartus Lite (version 18.1) because it is free. Intel has a [youtube channel](https://www.youtube.com/channel/UC0wEPiFb0J6AZZ3oPXRoRpw) where they post many long and dry tutorial videos on how to use Quartus and its features. The main features that we'll need to use are the pin planner, compiler, simulator, programmer, and the Signal Tap Logic Analyzer.

The pin planner is built right into Quartus and accessable through the Assignment tab. In it, you will be able to assign the dev board's pins to the FFT top level module's input and output pins. For example, you will be able to determine which GPIO pin on the DE10-Lite dev board should act as BCLK, LRCLK, or DOUT on the FFT module. To do this, you first need to look at the DE10-Lite datasheet to see which pin on the actual FPGA chip connects to which pin on the dev board. Once you know the name of the FPGA pin you want to use, you just assign that it the input/output you want to use it as.  

The compiler is built right into Quartus and goes through the full process of taking your verilog files and generating a programming file for your FPGA. This includes going through the Analysis and Synthesis, Fitter, Assembler, Timing Analysis, and Netlist Writer. It is important to note that you can set the synthesizer's optimization by editting the Analysis and Synthesizer settings. For example, you can choose to optimize the design for energy efficiency, space efficiency, best performance, or a balance between the three. For our project, we chose to optimize for best performance.

The simulator is for pre-programming debugging. Technically, the simulator is an entirely separate program from Quartus. You can use any simulator available online, but we chose to use ModelSim since it is an optional add-on when you download Quartus. You can use the simulator for debugging by creating a testbench file with all the modules you want to test, writing test cases by setting each input, and checking the resulting output waveforms visually. Tutorials can be found online, you might even find tutorials that can teach you how to write testbenches that don't require you to check outputs visually. The downside of using a simulator is that it assumes everything is ideal, so no time contraints or real world parasitics are taken into account.

The programmer is also built right into Quartus. It takes the programming files generated by the compiler and programs the FPGA. Nice and straight forward.

The Signal Tap Logic Analyzer is for post-programming debugging. Unlike pre-programming debugging with a simulator, post-programming debugging includes all of the timing constraints and real world parastics that could cause issues with the system. The Signal Tap Logic Analyzer works by making a logic analyzer module that gets compiled and uploaded to the FPGA along with the rest of the design. The user can configure which signals to analyze, the buffer sizes, sampling rate, edge trigger, etc. All the sampled data will be sent over from the FPGA to your desktop through the USB cable and shown on Quartus in real time for convenient debugging. The downside to this is that the logic analyzer module itself takes FPGA resources to implement. If the designer's FFT module takes up all of the FPGA's resources, the logic analyzer won't fit and can't be used. The alternative is to take the signals you want to analyze, "break them out" all the way to the top level module, connect them to some FPGA GPIO pins, and analyze them with an external logic analyzer, oscillosope, or DMM.

## Future Improvements
### FPGA with flash memory
The DE10 Lite FPGA does not have flash memory. As a result, it cannot save its programming data after it is power off and must be reprogrammed each power cycle. An FPGA dev kit with flash memory would be more convenient, if there are any available in the market.

### 32 point FFT or higher instead of 16
When I first started designing the project, I didn't realize that the real portion of the DFT is symmetric. As a result, the resolution of my visualizer is lower than expected. With a 32 point FFT or above, you can have a finer resolution for better visualization. However, this will require a lot more resources from the FPGA. With the current implementation of the FFT_Processor, a 32 point FFT will not fit on the DE10 Lite FPGA. However, you can adjust the FFT_Processor to use only one butterflyunit and store all the results in registers. This is explained in greater detail in [George Slade's article](http://web.mit.edu/6.111/www/f2017/handouts/FFTtutorial121102.pdf?fbclid=IwAR1bvgwIdH4KpCR6y5HdHb4cVpvUhySQTUzOMBI4a99tWIJc6waVf-O8PHQ).

### Microphone options with ADC
Further into the project's development, I discovered that the FPGA has an on-die ADC. This would allow the FPGA to interface with analog or PCM microphones, eliminating the need for a complicated mic_translator module. Additionally, this opens up a wide range of new micrphones that could be used, such as an [electret](https://www.adafruit.com/product/1063) or standard karaoke microphone. 

However, using the on-die ADC may require an additional module to translate between the ADC and the FFT_Processor. This could potentially take more resources than the existing mic_translator. Intel provides a demo design on how to use the on-die ADC [here](https://fpgacloud.intel.com/devstore/platform/15.1.0/Standard/adc-rtl-max10-de10-lite/).

### Different Displays
Although the VGA display was a convenient option for me, others might find it difficult to develop the VGA_generator on their own. The designer is free to use any other external display that is more convenient for them, such as an array of LED strips, numbers on the onboard 7-seg displays, or even an array of speakers that can recreate the sound that is sensed by the microphone.

### Reset Button
I still need to implement the reset button into all modules so that the regs initialize with a starting value.