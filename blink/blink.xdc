# see this: https://github.com/Digilent/digilent-xdc/blob/master/Arty-S7-50-Master.xdc
## Arty S7-50 constraints (blink)

# 100 MHz clock (on-board oscillator)
set_property PACKAGE_PIN R2 [get_ports {CLK}]
set_property IOSTANDARD SSTL135 [get_ports {CLK}]
create_clock -name sys_clk_pin -period 10.000 -waveform {0 5} [get_ports {CLK}]

# Reset -> use push button BTN0 (active-high)
set_property PACKAGE_PIN G15 [get_ports {RST}]
set_property IOSTANDARD LVCMOS33 [get_ports {RST}]

# User LEDs (LD0..LD3)  ※[LED2..LED5]に相当
set_property PACKAGE_PIN E18 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]

set_property PACKAGE_PIN F13 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]

set_property PACKAGE_PIN E13 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]

set_property PACKAGE_PIN H15 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
