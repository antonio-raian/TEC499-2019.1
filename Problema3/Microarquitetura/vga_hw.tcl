# TCL File Generated by Component Editor 13.0sp1
# Tue Sep 10 22:52:44 AMT 2019
# DO NOT MODIFY


# 
# vga "vga" v1.0
#  2019.09.10.22:52:44
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module vga
# 
set_module_property DESCRIPTION ""
set_module_property NAME vga
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME vga
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL top
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file top.v VERILOG PATH ../top.v TOP_LEVEL_FILE
add_fileset_file vga640x480.v VERILOG PATH ../vga640x480.v
add_fileset_file LFSR.v VERILOG PATH ../LFSR.v
add_fileset_file ball.v VERILOG PATH ../ball.v
add_fileset_file bar.v VERILOG PATH ../bar.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock CLK clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset RESET reset Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset reset
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end BUTTONS export Input 4
add_interface_port conduit_end START export Input 1
add_interface_port conduit_end VGA_HS export Output 1
add_interface_port conduit_end VGA_VS export Output 1
add_interface_port conduit_end VGA_R export Output 4
add_interface_port conduit_end VGA_G export Output 4
add_interface_port conduit_end VGA_B export Output 4

