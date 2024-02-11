# Vivado does not support old UCF syntax
# must use XDC syntax


set_property -dict { PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [ get_ports { a }  ] ;
set_property -dict { PACKAGE_PIN U11 IOSTANDARD LVCMOS33 } [ get_ports { b }  ] ;
set_property -dict { PACKAGE_PIN U12 IOSTANDARD LVCMOS33 } [ get_ports { c }  ] ;
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [ get_ports { output }  ] ;

