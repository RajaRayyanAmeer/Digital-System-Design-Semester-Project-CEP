# Clock (100 MHz board clock)
set_property PACKAGE_PIN E3 [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
create_clock -period 10.000 -name clk_100MHz [get_ports clk_100MHz]

# Reset button (CPU Reset - NOTE: Hardware schematic shows this is ACTIVE-LOW!)
set_property PACKAGE_PIN C12 [get_ports reset_btn]
set_property IOSTANDARD LVCMOS33 [get_ports reset_btn]

# 5 slide switches (SW0 to SW4)
set_property PACKAGE_PIN U9 [get_ports {sw[0]}]
set_property PACKAGE_PIN U8 [get_ports {sw[1]}]
set_property PACKAGE_PIN R7 [get_ports {sw[2]}]
set_property PACKAGE_PIN R6 [get_ports {sw[3]}]
set_property PACKAGE_PIN R5 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]

# Show Button (Using BTNU from the schematic)
set_property PACKAGE_PIN F15 [get_ports show_btn]
set_property IOSTANDARD LVCMOS33 [get_ports show_btn]

# 16 LEDs (LD0 to LD15)
set_property PACKAGE_PIN T8 [get_ports {led[0]}]
set_property PACKAGE_PIN V9 [get_ports {led[1]}]
set_property PACKAGE_PIN R8 [get_ports {led[2]}]
set_property PACKAGE_PIN T6 [get_ports {led[3]}]
set_property PACKAGE_PIN T5 [get_ports {led[4]}]
set_property PACKAGE_PIN T4 [get_ports {led[5]}]
set_property PACKAGE_PIN U7 [get_ports {led[6]}]
set_property PACKAGE_PIN U6 [get_ports {led[7]}]
set_property PACKAGE_PIN V4 [get_ports {led[8]}]
set_property PACKAGE_PIN U3 [get_ports {led[9]}]
set_property PACKAGE_PIN V1 [get_ports {led[10]}]
set_property PACKAGE_PIN R1 [get_ports {led[11]}]
set_property PACKAGE_PIN P5 [get_ports {led[12]}]
set_property PACKAGE_PIN U1 [get_ports {led[13]}]
set_property PACKAGE_PIN R2 [get_ports {led[14]}]
set_property PACKAGE_PIN P2 [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]

# 7-segment display – Anodes (AN0 to AN7, Active-Low)
set_property PACKAGE_PIN N6 [get_ports {an[0]}]
set_property PACKAGE_PIN M6 [get_ports {an[1]}]
set_property PACKAGE_PIN M3 [get_ports {an[2]}]
set_property PACKAGE_PIN N5 [get_ports {an[3]}]
set_property PACKAGE_PIN N2 [get_ports {an[4]}]
set_property PACKAGE_PIN N4 [get_ports {an[5]}]
set_property PACKAGE_PIN L1 [get_ports {an[6]}]
set_property PACKAGE_PIN M1 [get_ports {an[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]

# 7-segment display – Cathodes/Segments (CA to CG + DP, Active-Low)
set_property PACKAGE_PIN L3 [get_ports {seg[0]}]
set_property PACKAGE_PIN N1 [get_ports {seg[1]}]
set_property PACKAGE_PIN L5 [get_ports {seg[2]}]
set_property PACKAGE_PIN L4 [get_ports {seg[3]}]
set_property PACKAGE_PIN K3 [get_ports {seg[4]}]
set_property PACKAGE_PIN M2 [get_ports {seg[5]}]
set_property PACKAGE_PIN L6 [get_ports {seg[6]}]
set_property PACKAGE_PIN M4 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*]}]

# Optional: Drive configurations to optimize brightness/stability
set_property DRIVE 8 [get_ports {seg[*]}]
set_property DRIVE 8 [get_ports {an[*]}]
set_property DRIVE 8 [get_ports {led[*]}]