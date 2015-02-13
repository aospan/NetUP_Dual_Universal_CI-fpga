onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dvb_dma_tb/rst
add wave -noupdate /dvb_dma_tb/clk
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_IN0 /dvb_dma_tb/DVB_DMA_0/dvb_sop
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_IN0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/dvb_data
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_IN0 /dvb_dma_tb/DVB_DMA_0/dvb_dval
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_GROUP0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/address
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_GROUP0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/byteenable
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_GROUP0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/writedata
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_GROUP0 /dvb_dma_tb/DVB_DMA_0/write
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_GROUP0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/readdata
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_GROUP0 /dvb_dma_tb/DVB_DMA_0/interrupt
add wave -noupdate -expand -group DVB_DMA_0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/pkt_size
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/dvb_latch_data
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 /dvb_dma_tb/DVB_DMA_0/dvb_latch_dval
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 -radix decimal /dvb_dma_tb/DVB_DMA_0/dvb_cnt
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 /dvb_dma_tb/DVB_DMA_0/dvb_overrun_n
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/write_addr_l
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/write_page
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_WRITE0 /dvb_dma_tb/DVB_DMA_0/fifo_full
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_STAT0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/stat_pkts_received
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_STAT0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/stat_pkts_accepted
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_STAT0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/stat_pkt_overruns
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_STAT0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/stat_pkt_underruns
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DMA_STAT0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/stat_fifo_overruns
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/dma_cnt
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/read_page
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/fifo_empty
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/fifo_rdclken
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/fifo_rddata
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/fifo_latch_valid
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/fifo_rddata_valid
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/dma_reg
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/dma_reg_be
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/dma_reg_pad
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/dma_reg_pad_be
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/dma_reg_pad_wren
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/mem_write_i
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/burst_addr
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/burst
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/burst_end
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/dma_reload_n
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/dma_pkt_cnt
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/dma_blk_cnt
add wave -noupdate -expand -group DVB_DMA_0 -expand -group FIFO_READ0 /dvb_dma_tb/DVB_DMA_0/dma_irq_pend
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_MEM0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/mem_size
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_MEM0 -radix unsigned /dvb_dma_tb/DVB_DMA_0/mem_addr
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_MEM0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/mem_byteen
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_MEM0 -radix hexadecimal /dvb_dma_tb/DVB_DMA_0/mem_wrdata
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_MEM0 /dvb_dma_tb/DVB_DMA_0/mem_write
add wave -noupdate -expand -group DVB_DMA_0 -expand -group DVB_DMA_MEM0 /dvb_dma_tb/DVB_DMA_0/mem_waitreq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {148357853 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 183
configure wave -valuecolwidth 66
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
WaveRestoreZoom {144223431 ps} {152492275 ps}
