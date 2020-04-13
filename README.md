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

The **butterflyunit** module performs the smallest unit operation of the FFT on two inputs. More information on the butterfly unit can be found online. The inputs are the real & imaginary input samples (A_t[47:0] and B_t[47:0]) and the twiddle factor (W[47:0]). THe outputs are the real & imaginary output samples (A_f[47:0], B_f[47:0]).

Internally, there's also a lot of complicated shit.

The **VGA_generator** sldkfja;slidgja;wlrj

### Testbenches (*_TB.sv)
The following testbench files were used to debug the their respective *.sv files.
* clkdiv
* mic_translator
* FFT_Processor
* butterflyunit
### Debugging Scripts (*.py)
The following scripts were used to perform quick calculations used to verify the testbench results.
* butteryfly_test

## Quartus for Design and Debugging

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