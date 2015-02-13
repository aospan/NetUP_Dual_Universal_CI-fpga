onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/rst
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/clk
add wave -noupdate -expand -group ControlPort -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_addr
add wave -noupdate -expand -group ControlPort -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_wrdata
add wave -noupdate -expand -group ControlPort /dvb_ts_filter_tb/FILTER_0/pid_tbl_write
add wave -noupdate -expand -group ControlPort -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_rddata
add wave -noupdate -expand -group ControlPort /dvb_ts_filter_tb/FILTER_0/pid_tbl_read
add wave -noupdate -expand -group ControlPort /dvb_ts_filter_tb/FILTER_0/pid_tbl_waitreq
add wave -noupdate -expand -group Input /dvb_ts_filter_tb/FILTER_0/dvb_in_dsop
add wave -noupdate -expand -group Input -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_in_data
add wave -noupdate -expand -group Input /dvb_ts_filter_tb/FILTER_0/dvb_in_dval
add wave -noupdate -expand -group Output /dvb_ts_filter_tb/FILTER_0/dvb_out_dsop
add wave -noupdate -expand -group Output -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_out_data
add wave -noupdate -expand -group Output /dvb_ts_filter_tb/FILTER_0/dvb_out_dval
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_ram_addr_a
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/pid_tbl_ram_we_a
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_ram_d_a
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_ram_q_a
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_ram_addr_b
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_ram_q_b
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/pid_tbl_rddata_latch
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/latch_valid
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/rddata_valid
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/header
add wave -noupdate /dvb_ts_filter_tb/FILTER_0/pkten
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_word_0
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_word_1
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_word_2
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_word_3
add wave -noupdate -radix hexadecimal /dvb_ts_filter_tb/FILTER_0/dvb_word_4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 174
configure wave -valuecolwidth 73
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 8000
configure wave -griddelta 25
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {902025 ps}
