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

I chose the DE10-Lite FPGA Dev Kit because it is cheap and provides the necessary I/O for me to interface with the microphone and VGA display. To use the DE10-Lite, you must connect your computer to your FPGA through a USB A to B cable (one is packaged with the DE10-Lite). This will provide power to the FPGA and allow you to program it through intel's Quartus IDE. The table below lists all of the wire connections between the microphone and the FPGA. Any pins that are not listed are left floating.

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
* FFT
    * clkdiv
    * mic_translator
    * FFT_Processor
        * butterflyunit
    * VGA_Components
### Testbenches (*_TB.sv)
* clkdiv
* mic_translator
* FFT_Processor
* butterflyunit
### Debugging Scripts (*.py)
* butteryfly_test

## Ext. Mic to Mic Translator

## Mic Translator to FFT Processor

## FFT Processor to Display Generator

## Display Generator to Ext. Display

## Quartus for Design and Debugging

## Future Improvements
### FPGA with flash memory
### Microphone options with ADC
Further into the project's development, I discovered that the FPGA has an on-die ADC. This would allow the FPGA to interface with analog or PCM microphones, eliminating the need for a complicated mic_translator module. Additionally, this opens up a wide range of new micrphones that could be used, such as an [electret](https://www.adafruit.com/product/1063) or standard karaoke microphone. 

However, using the on-die ADC may require an additional module to translate between the ADC and the FFT_Processor. This could potentially take more resources than the existing mic_translator. Intel provides a demo design on how to use the on-die ADC [here](https://fpgacloud.intel.com/devstore/platform/15.1.0/Standard/adc-rtl-max10-de10-lite/).

### Different Displays
Although the VGA display was a convenient option for me, others might find it difficult to develop the VGA_components on their own. The designer is free to use any other external display that is more convenient for them, such as an array of LED strips, numbers on the onboard 7-seg displays, or even an array of speakers that can recreate the sound that is sensed by the microphone.