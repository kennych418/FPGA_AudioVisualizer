# Digital Audio Visualizer
Digital Audio Visualizer (DAV) is a new IEEE project that will pilot in the 2020-2021 academic year. The goal is to teach future members about new topics that existing projects do not cover, such as signal processing, digital logic, FPGA’s, and Verilog. 

To do so, members will design a system that uses an intel FPGA as a digital signals processor. The FPGA will receive audio inputs in real time through an external microphone and display the resulting frequency spectrum on an external display. A block diagram is shown below.

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/Block%20Diagram.png)

I designed and implemented the system to verify that it is possible on the hardware chosen. This documentation describes all of the steps taken and difficulties encountered while implementing the digital audio visualizer. The reader should understand how to replicate or even improve the existing design.

## Hardware
* [Adafruit SPH0645 i2S MEMS Microphone](https://www.adafruit.com/product/3421)
* [Intel DE10-Lite FPGA](https://www.intel.com/content/www/us/en/programmable/solutions/partners/partner-profile/terasic-inc-/board/max-10-device-family---de10-lite-board.html)
* VGA Compatible Monitor
* VGA Male to Male Cable
* Wires

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/System.png)
![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/Ext.Display.png)

## Files
### System Verilog (*.sv)
* FFT
* clkdiv
* mic_translator
* FFT_Processor
* butterflyunit
* VGA_Components
### Testbenches (*_TB.sv)

### Debugging Scripts (*.py)
* butteryfly_test

## Ext. Mic to Mic Translator

## Mic Translator to FFT Processor

## FFT Processor to Display Generator

## Display Generator to Ext. Display


