onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/rst
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/clk
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/clkdiv
add wave -noupdate -expand -group Source /dvb_ts_shaper_tb/SHAPER_0/dvb_indrdy
add wave -noupdate -expand -group Source -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/dvb_indata
add wave -noupdate -expand -group Source /dvb_ts_shaper_tb/SHAPER_0/dvb_indsop
add wave -noupdate -expand -group Source /dvb_ts_shaper_tb/SHAPER_0/dvb_indval
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/dvb_clk
add wave -noupdate -expand -group Stream /dvb_ts_shaper_tb/SHAPER_0/dvb_out_clk
add wave -noupdate -expand -group Stream -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/dvb_out_data
add wave -noupdate -expand -group Stream /dvb_ts_shaper_tb/SHAPER_0/dvb_out_dval
add wave -noupdate -expand -group Stream /dvb_ts_shaper_tb/SHAPER_0/dvb_out_dsop
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/fifo_we
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/fifo_wr_ptr
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/ram_wr_addr
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/fifo_rd_ptr_sync
add wave -noupdate -radix unsigned /dvb_ts_shaper_tb/SHAPER_0/fifo_fill
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/fifo_re
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/fifo_rd_ptr
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/ram_rd_addr
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/fifo_wr_ptr_sync
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/dvb_out_clk_edge
add wave -noupdate -radix unsigned /dvb_ts_shaper_tb/SHAPER_0/dvb_out_clk_cnt
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/fifo_ram_latch
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/fifo_ram_latch_valid
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/fifo_ram_latch_clk
add wave -noupdate -radix hexadecimal /dvb_ts_shaper_tb/SHAPER_0/fifo_ram_reg
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/fifo_ram_reg_valid
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/fifo_ram_reg_clk
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/dvb_rst_meta
add wave -noupdate /dvb_ts_shaper_tb/SHAPER_0/dvb_rst_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32125 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 141
configure wave -valuecolwidth 75
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
WaveRestoreZoom {0 ps} {601768 ps}
