# Digital Audio Visualizer
Digital Audio Visualizer (DAV) is a new IEEE project that will pilot in the 2020-2021 academic year. The goal is to teach future members about new topics that existing projects do not cover, such as signal processing, digital logic, FPGA’s, and Verilog. 

To do so, members will design a system that uses an intel FPGA as a digital signals processor. The FPGA will receive audio inputs in real time through an external microphone and display the resulting frequency spectrum on an external display. A block diagram is shown below.

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/Block%20Diagram.png)

I designed and implemented the system to verify that it is possible on the chosen hardware. This documentation describes all of the steps taken and difficulties encountered while implementing the digital audio visualizer. The reader should understand how to replicate or even improve the existing design.

![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/System.png)
![Block Diagram](https://github.com/kennych418/FPGA_AudioVisualizer/blob/master/pictures/Ext.Display.png)

## Hardware
* [Adafruit SPH0645 i2S MEMS Microphone](https://www.adafruit.com/product/3421)
* [Intel DE10-Lite FPGA](https://www.intel.com/content/www/us/en/programmable/solutions/partners/partner-profile/terasic-inc-/board/max-10-device-family---de10-lite-board.html)
* VGA Compatible Monitor
* VGA Male to Male Cable
* Wires

I selected an i2S MEMS microphone primarily because it can transmit audio information through a digital communication protocol. Analog or PCM microphones were not considered since an FPGA is a digital device and wouldn't be able to interface with these microphones. 

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

## Future Improvements
Further into the project's development, I discovered that the FPGA has an on-die ADC. This would allow the FPGA to interface with analog or PCM microphones, eliminating the need for a complicated mic_translator module. Additionally, this opens up a wide range of new micrphones that could be used, such as an [electret](https://www.adafruit.com/product/1063) or standard karaoke microphone. 
However, using the on-die ADC may require an additional module to translate between the ADC and the FFT_Processor. This could potentially take more resources than the existing mic_translator. Intel provides a demo design on how to use the on-die ADC [here](https://fpgacloud.intel.com/devstore/platform/15.1.0/Standard/adc-rtl-max10-de10-lite/).
