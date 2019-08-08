# TCL File Generated by Component Editor 13.0sp1
# Fri Jun 28 13:02:20 AMT 2019
# DO NOT MODIFY


# 
# LCD_controller "LCD_controller" v1.0
#  2019.06.28.13:02:20
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module LCD_controller
# 
set_module_property DESCRIPTION ""
set_module_property NAME LCD_controller
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME LCD_controller
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL LCD_Controll
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file LCD_Controll.v VERILOG PATH LCD_Controll.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end LCD_rs rs Output 1
add_interface_port conduit_end LCD_en en Output 1
add_interface_port conduit_end LCD_dados dados Output 8
add_interface_port conduit_end LCD_rw rw Output 1


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave data_a dataa Input 32
add_interface_port nios_custom_instruction_slave data_b datab Input 32
add_interface_port nios_custom_instruction_slave result result Output 32
add_interface_port nios_custom_instruction_slave clock clk Input 1
add_interface_port nios_custom_instruction_slave clock_en clk_en Input 1
add_interface_port nios_custom_instruction_slave start start Input 1
add_interface_port nios_custom_instruction_slave reset reset Input 1
add_interface_port nios_custom_instruction_slave done done Output 1

