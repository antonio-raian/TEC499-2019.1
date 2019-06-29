# Legal Notice: (C)2019 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	Problema1Qsys_nios2_gen2_0_cpu 	Problema1Qsys_nios2_gen2_0_cpu:*
set 	Problema1Qsys_nios2_gen2_0_cpu_oci 	Problema1Qsys_nios2_gen2_0_cpu_nios2_oci:the_Problema1Qsys_nios2_gen2_0_cpu_nios2_oci
set 	Problema1Qsys_nios2_gen2_0_cpu_oci_break 	Problema1Qsys_nios2_gen2_0_cpu_nios2_oci_break:the_Problema1Qsys_nios2_gen2_0_cpu_nios2_oci_break
set 	Problema1Qsys_nios2_gen2_0_cpu_ocimem 	Problema1Qsys_nios2_gen2_0_cpu_nios2_ocimem:the_Problema1Qsys_nios2_gen2_0_cpu_nios2_ocimem
set 	Problema1Qsys_nios2_gen2_0_cpu_oci_debug 	Problema1Qsys_nios2_gen2_0_cpu_nios2_oci_debug:the_Problema1Qsys_nios2_gen2_0_cpu_nios2_oci_debug
set 	Problema1Qsys_nios2_gen2_0_cpu_wrapper 	Problema1Qsys_nios2_gen2_0_cpu_debug_slave_wrapper:the_Problema1Qsys_nios2_gen2_0_cpu_debug_slave_wrapper
set 	Problema1Qsys_nios2_gen2_0_cpu_jtag_tck 	Problema1Qsys_nios2_gen2_0_cpu_debug_slave_tck:the_Problema1Qsys_nios2_gen2_0_cpu_debug_slave_tck
set 	Problema1Qsys_nios2_gen2_0_cpu_jtag_sysclk 	Problema1Qsys_nios2_gen2_0_cpu_debug_slave_sysclk:the_Problema1Qsys_nios2_gen2_0_cpu_debug_slave_sysclk
set 	Problema1Qsys_nios2_gen2_0_cpu_oci_path 	 [format "%s|%s" $Problema1Qsys_nios2_gen2_0_cpu $Problema1Qsys_nios2_gen2_0_cpu_oci]
set 	Problema1Qsys_nios2_gen2_0_cpu_oci_break_path 	 [format "%s|%s" $Problema1Qsys_nios2_gen2_0_cpu_oci_path $Problema1Qsys_nios2_gen2_0_cpu_oci_break]
set 	Problema1Qsys_nios2_gen2_0_cpu_ocimem_path 	 [format "%s|%s" $Problema1Qsys_nios2_gen2_0_cpu_oci_path $Problema1Qsys_nios2_gen2_0_cpu_ocimem]
set 	Problema1Qsys_nios2_gen2_0_cpu_oci_debug_path 	 [format "%s|%s" $Problema1Qsys_nios2_gen2_0_cpu_oci_path $Problema1Qsys_nios2_gen2_0_cpu_oci_debug]
set 	Problema1Qsys_nios2_gen2_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $Problema1Qsys_nios2_gen2_0_cpu_oci_path $Problema1Qsys_nios2_gen2_0_cpu_wrapper $Problema1Qsys_nios2_gen2_0_cpu_jtag_tck]
set 	Problema1Qsys_nios2_gen2_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $Problema1Qsys_nios2_gen2_0_cpu_oci_path $Problema1Qsys_nios2_gen2_0_cpu_wrapper $Problema1Qsys_nios2_gen2_0_cpu_jtag_sysclk]
set 	Problema1Qsys_nios2_gen2_0_cpu_jtag_sr 	 [format "%s|*sr" $Problema1Qsys_nios2_gen2_0_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sr*    -to *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$Problema1Qsys_nios2_gen2_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$Problema1Qsys_nios2_gen2_0_cpu_oci_debug_path|monitor_go
