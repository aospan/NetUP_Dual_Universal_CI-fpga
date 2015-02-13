-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity dvb_dma is

	port (
		rst			: in std_logic;
		clk			: in std_logic;
		-- control port
		address		: in std_logic_vector(3 downto 0);
		byteenable	: in std_logic_vector(3 downto 0);
		writedata	: in std_logic_vector(31 downto 0);
		write		: in std_logic;
		readdata	: out std_logic_vector(31 downto 0);
		interrupt	: out std_logic;
		-- DVB port
		dvb_sop		: in std_logic;
		dvb_data	: in std_logic_vector(7 downto 0);
		dvb_dval	: in std_logic;
		-- memory port
		mem_size	: out std_logic_vector(6 downto 0);
		mem_addr	: out std_logic_vector(63 downto 3);
		mem_byteen	: out std_logic_vector(7 downto 0);
		mem_wrdata	: out std_logic_vector(63 downto 0);
		mem_write	: out std_logic;
		mem_waitreq	: in std_logic
	);

end;

architecture rtl of dvb_dma is

	constant REG_DMA_CTRLSTAT		: natural := 0;
	constant REG_DMA_CTRLSTAT_SET	: natural := 0;
	constant REG_DMA_CTRLSTAT_CLR	: natural := 1;
	constant REG_DMA_START_ADDR_L	: natural := 2;		-- first address of the ring buffer
	constant REG_DMA_START_ADDR_H	: natural := 3;
	constant REG_DMA_SIZE			: natural := 4;		-- packet size, number of packets per interrupt block and number of blocks per buffer
	constant REG_DMA_TIMEOUT		: natural := 5;		-- force interrupt when timer expires
	constant REG_DMA_CURR_ADDR_L	: natural := 6;
	constant REG_DMA_CURR_ADDR_H	: natural := 7;
	constant REG_STAT_PKT_RECEIVED	: natural := 8;
	constant REG_STAT_PKT_ACCEPTED	: natural := 9;
	constant REG_STAT_PKT_OVERRUNS	: natural := 10;
	constant REG_STAT_PKT_UNDERRUNS	: natural := 11;
	constant REG_STAT_FIFO_OVERRUNS	: natural := 12;

	constant BIT_DMA_RUN	: natural := 0;
	constant BIT_DMA_IRQ	: natural := 9;

	signal dma_ctrlstat_reg	: std_logic_vector(31 downto 0);
	signal dma_start_addr	: std_logic_vector(63 downto 0);
	signal dma_timeout		: std_logic_vector(31 downto 0);

	alias dma_start_addr_l	: std_logic_vector(31 downto 0) is dma_start_addr(31 downto 0);
	alias dma_start_addr_h	: std_logic_vector(31 downto 0) is dma_start_addr(63 downto 32);

	signal dma_packet_size	: std_logic_vector(7 downto 0);
	signal dma_block_size	: std_logic_vector(23 downto 8);
	signal dma_length		: std_logic_vector(31 downto 24);

	-- control stat register fields
	signal dma_run		: std_logic;
	signal dma_irq		: std_logic;

	signal dma_curr_addr	: unsigned(63 downto 0);

	alias dma_curr_addr_l	: unsigned(31 downto 0) is dma_curr_addr(31 downto 0);
	alias dma_curr_addr_h	: unsigned(31 downto 0) is dma_curr_addr(63 downto 32);

	signal dma_irq_reset	: std_logic;

	signal pkt_size	 		: unsigned(dma_packet_size'length downto 0);
	signal block_size		: unsigned(dma_block_size'length downto 0);
	signal blocks_num		: unsigned(dma_length'length downto 0);

	signal dvb_latch_data	: std_logic_vector(dvb_data'range);
	signal dvb_latch_dval	: std_logic;
	signal dvb_overrun_n	: std_logic;
	signal fifo_overflow	: std_logic;

	signal dvb_cnt			: unsigned(pkt_size'range);
	signal write_page		: unsigned(2 downto 0);
	signal write_addr_l		: unsigned(dma_packet_size'range);

	alias write_addr_h is write_page(write_page'left - 1 downto write_page'right);

	signal stat_pkts_received	: unsigned(31 downto 0);
	signal stat_pkts_accepted	: unsigned(31 downto 0);
	signal stat_pkt_overruns	: unsigned(31 downto 0);
	signal stat_pkt_underruns	: unsigned(31 downto 0);
	signal stat_fifo_overruns	: unsigned(31 downto 0);
	
	signal dma_cnt			: unsigned(pkt_size'range);
	signal read_page		: unsigned(2 downto 0);

	alias read_addr_l is dma_cnt(dma_cnt'left - 1 downto dma_cnt'right + 3);
	alias read_addr_h is read_page(read_page'left - 1 downto read_page'right);

	signal fifo_full		: std_logic;
	signal fifo_empty		: std_logic;
	signal fifo_rdclken		: std_logic;
	signal fifo_rdaddr		: std_logic_vector(6 downto 0);
	signal fifo_rddata		: std_logic_vector(63 downto 0);
	signal fifo_wraddr		: std_logic_vector(9 downto 0);
	signal fifo_wrdata		: std_logic_vector(7 downto 0);
	signal fifo_wren		: std_logic;

	signal fifo_latch_valid		: std_logic;
	signal fifo_rddata_valid	: std_logic;
	signal dma_reg				: std_logic_vector(63 downto 0);
	signal dma_reg_be			: std_logic_vector(7 downto 0);
	signal dma_reg_pad			: std_logic_vector(63 downto 8);
	signal dma_reg_pad_be		: std_logic_vector(7 downto 1);
	signal dma_reg_pad_wren		: std_logic;
	signal mem_write_i			: std_logic;

	signal burst_addr		: unsigned(63 downto 0);
	signal burst			: std_logic;
	signal burst_end		: std_logic;

	signal dma_pkt_cnt		: unsigned(dma_block_size'length downto 0);
	signal dma_blk_cnt		: unsigned(dma_length'length downto 0);
	signal dma_irq_pend		: std_logic;
	signal dma_reload_n		: std_logic;

	signal dma_timer		: signed(dma_timeout'length downto 0);
	signal dma_timer_d		: std_logic;

begin

	process (rst, clk)
	begin
		if rising_edge(clk) then
			if write then
				write_sr_flag(dma_run, REG_DMA_CTRLSTAT_SET, BIT_DMA_RUN, address, writedata, byteenable);
				if not dma_run then
					write_reg(dma_start_addr_l, REG_DMA_START_ADDR_L, address, writedata, byteenable);
					write_reg(dma_start_addr_h, REG_DMA_START_ADDR_H, address, writedata, byteenable);
					write_reg(dma_packet_size, REG_DMA_SIZE, address, writedata, byteenable);
					write_reg(dma_block_size, REG_DMA_SIZE, address, writedata, byteenable);
					write_reg(dma_length, REG_DMA_SIZE, address, writedata, byteenable);
					write_reg(dma_timeout, REG_DMA_TIMEOUT, address, writedata, byteenable);
				end if;
			end if;
			if unsigned(address) = REG_DMA_CTRLSTAT_CLR then
				dma_irq_reset <= write and byteenable(BIT_DMA_IRQ / 8) and writedata(BIT_DMA_IRQ);
			else
				dma_irq_reset <= '0';
			end if;
		end if;
		if rst then
			dma_run <= '0';
			dma_irq_reset <= '0';
			--
			dma_start_addr_l <= (others => '0');
			dma_start_addr_h <= (others => '0');
			dma_packet_size <= (others => '0');
			dma_block_size <= (others => '0');
			dma_length <= (others => '0');
			dma_timeout <= (others => '0');
		end if;
	end process;

	dma_ctrlstat_reg <= (
		BIT_DMA_RUN	=> dma_run,
		BIT_DMA_IRQ	=> dma_irq,
		--
		others		=> '0'
	);

	with to_integer(unsigned(address)) select
		readdata <= dma_ctrlstat_reg when REG_DMA_CTRLSTAT_SET | REG_DMA_CTRLSTAT_CLR,
					dma_start_addr_l when REG_DMA_START_ADDR_L,
					dma_start_addr_h when REG_DMA_START_ADDR_H,
					dma_length & dma_block_size & dma_packet_size when REG_DMA_SIZE,
					dma_timeout when REG_DMA_TIMEOUT,
					std_logic_vector(dma_curr_addr_l) when REG_DMA_CURR_ADDR_L,
					std_logic_vector(dma_curr_addr_h) when REG_DMA_CURR_ADDR_H,
					std_logic_vector(stat_pkts_received) when REG_STAT_PKT_RECEIVED,
					std_logic_vector(stat_pkts_accepted) when REG_STAT_PKT_ACCEPTED,
					std_logic_vector(stat_pkt_overruns) when REG_STAT_PKT_OVERRUNS,
					std_logic_vector(stat_pkt_underruns) when REG_STAT_PKT_UNDERRUNS,
					std_logic_vector(stat_fifo_overruns) when REG_STAT_FIFO_OVERRUNS,
					(others => 'X') when others;

	FIFO_0 : entity work.dvb_dma_fifo_ram
		port map (
			wrclock		=> clk,
			wraddress	=> fifo_wraddr,
			data		=> fifo_wrdata,
			wren		=> fifo_wren,
			--
			rdclock		=> clk,
			rdclocken	=> fifo_rdclken,
			rdaddress	=> fifo_rdaddr,
			q			=> fifo_rddata
		);

	fifo_wraddr <= std_logic_vector(write_addr_h & write_addr_l);
	fifo_wrdata <= dvb_latch_data;
	fifo_wren <= dvb_latch_dval;
	fifo_rdaddr <= std_logic_vector(read_addr_h & read_addr_l);
	fifo_rdclken <= mem_write_i nand mem_waitreq;

	fifo_full <= write_page(write_page'left) xor read_page(read_page'left) when write_addr_h = read_addr_h else '0';
	fifo_empty <= '1' when write_page = read_page else '0';

	pkt_size(pkt_size'left) <= '1' when unsigned(dma_packet_size) = 0 else '0';
	pkt_size(pkt_size'left - 1 downto 0) <= unsigned(dma_packet_size);
	block_size(block_size'left) <= '1' when unsigned(dma_block_size) = 0 else '0';
	block_size(block_size'left - 1 downto 0) <= unsigned(dma_block_size);
	blocks_num(blocks_num'left) <= '1' when unsigned(dma_length) = 0 else '0';
	blocks_num(blocks_num'left - 1 downto 0) <= unsigned(dma_length);

	process (rst, dma_run, clk)
		variable sop		: std_logic;
		variable burst_size	: unsigned(8 downto 0);
	begin
		if rising_edge(clk) then
			-- FIFO primary side
			sop := dvb_sop and dvb_dval;
			--
			dvb_latch_data <= dvb_data;
			dvb_latch_dval <= dvb_dval and ((dvb_sop and not fifo_full) or (dvb_cnt(dvb_cnt'left) and not fifo_overflow));
			if dvb_dval then
				if dvb_sop then
					fifo_overflow <= fifo_full;
				end if;
				if dvb_sop then
					dvb_cnt <= unsigned('1' & (-signed(dma_packet_size))) + 1;
				elsif dvb_cnt(dvb_cnt'left) then
					dvb_cnt <= dvb_cnt + 1;
				end if;
				if dvb_sop then
					dvb_overrun_n <= '1';
				else
					dvb_overrun_n <= dvb_cnt(dvb_cnt'left);
				end if;
			end if;
			if sop then
				write_addr_l <= (others => '0');
			elsif dvb_latch_dval then
				write_addr_l <= write_addr_l + 1;
			end if;
			if not dvb_cnt(dvb_cnt'left) and dvb_latch_dval then
				write_page <= write_page + 1;
			end if;
			-- statistic counters
			if sop then
				stat_pkts_received <= stat_pkts_received + 1;
			end if;
			if not dvb_cnt(dvb_cnt'left) and dvb_latch_dval then
				stat_pkts_accepted <= stat_pkts_accepted + 1;
			end if;
			if not dvb_cnt(dvb_cnt'left) and dvb_dval and not dvb_sop and dvb_overrun_n then
				stat_pkt_overruns <= stat_pkt_overruns + 1;
			end if;
			if sop and dvb_cnt(dvb_cnt'left) then
				stat_pkt_underruns <= stat_pkt_underruns + 1;
			end if;
			if sop and fifo_full then
				stat_fifo_overruns <= stat_fifo_overruns + 1;
			end if;
			-- FIFO secondary side
			if fifo_rdclken then
				if burst_end then
					burst <= '0';
				elsif not fifo_empty then
					burst <= '1';
				end if;
				if not burst then
					dma_cnt <= (others => '0');
				else
					dma_cnt <= dma_cnt + 8;
				end if;
				if dma_cnt < pkt_size then
					fifo_latch_valid <= burst;
				else
					fifo_latch_valid <= '0';
				end if;
				fifo_rddata_valid <= fifo_latch_valid;
				if not fifo_latch_valid and fifo_rddata_valid then
					read_page <= read_page + 1;
				end if;
				-- bus alignment
				dma_reg <= fifo_rddata;
				case std_logic_vector(fifo_latch_valid & pkt_size(2 downto 0)) is
					when "0111" =>
						dma_reg_be <= (7 => '0', others => fifo_rddata_valid);
					when "0110" =>
						dma_reg_be <= (7 downto 6 => '0', others => fifo_rddata_valid);
					when "0101" =>
						dma_reg_be <= (7 downto 5 => '0', others => fifo_rddata_valid);
					when "0100" =>
						dma_reg_be <= (7 downto 4 => '0', others => fifo_rddata_valid);
					when "0011" =>
						dma_reg_be <= (7 downto 3 => '0', others => fifo_rddata_valid);
					when "0010" =>
						dma_reg_be <= (7 downto 2 => '0', others => fifo_rddata_valid);
					when "0001" =>
						dma_reg_be <= (7 downto 1 => '0', others => fifo_rddata_valid);
					when others =>
						dma_reg_be <= (others => fifo_rddata_valid);
				end case;
				dma_reg_pad <= dma_reg(63 downto 8);
				dma_reg_pad_be <= dma_reg_be(7 downto 1);
				case burst_addr(2 downto 0) is
					when "111" =>
						mem_wrdata <= dma_reg(7 downto 0) & dma_reg_pad;
						mem_byteen <= dma_reg_be(0) & dma_reg_pad_be;
						dma_reg_pad_wren <= dma_reg_be(1);
					when "110" =>
						mem_wrdata <= dma_reg(15 downto 0) & dma_reg_pad(63 downto 16);
						mem_byteen <= dma_reg_be(1 downto 0) & dma_reg_pad_be(7 downto 2);
						dma_reg_pad_wren <= dma_reg_be(2);
					when "101" =>
						mem_wrdata <= dma_reg(23 downto 0) & dma_reg_pad(63 downto 24);
						mem_byteen <= dma_reg_be(2 downto 0) & dma_reg_pad_be(7 downto 3);
						dma_reg_pad_wren <= dma_reg_be(3);
					when "100" =>
						mem_wrdata <= dma_reg(31 downto 0) & dma_reg_pad(63 downto 32);
						mem_byteen <= dma_reg_be(3 downto 0) & dma_reg_pad_be(7 downto 4);
						dma_reg_pad_wren <= dma_reg_be(4);
					when "011" =>
						mem_wrdata <= dma_reg(39 downto 0) & dma_reg_pad(63 downto 40);
						mem_byteen <= dma_reg_be(4 downto 0) & dma_reg_pad_be(7 downto 5);
						dma_reg_pad_wren <= dma_reg_be(5);
					when "010" =>
						mem_wrdata <= dma_reg(47 downto 0) & dma_reg_pad(63 downto 48);
						mem_byteen <= dma_reg_be(5 downto 0) & dma_reg_pad_be(7 downto 6);
						dma_reg_pad_wren <= dma_reg_be(6);
					when "001" =>
						mem_wrdata <= dma_reg(55 downto 0) & dma_reg_pad(63 downto 56);
						mem_byteen <= dma_reg_be(6 downto 0) & dma_reg_pad_be(7);
						dma_reg_pad_wren <= dma_reg_be(7);
					when others =>
						mem_wrdata <= dma_reg;
						mem_byteen <= dma_reg_be;
						dma_reg_pad_wren <= '0';
				end case;
				mem_write_i <= dma_reg_be(0) or dma_reg_pad_wren;
			end if;
			if not mem_write_i and dma_reg_be(0) then
				burst_size := pkt_size + burst_addr(2 downto 0) + 7;
				mem_size <= '0' & std_logic_vector(burst_size(8 downto 3));
			end if;
			burst_end <= (mem_write_i and not mem_waitreq) and (dma_reg_be(0) nor dma_reg_pad_wren);
			-- process memory pointers
			if dma_pkt_cnt = block_size then
				dma_irq_pend <= not dma_irq_pend;
			else
				dma_irq_pend <= '0';
			end if;
			if dma_blk_cnt = blocks_num then
				dma_reload_n <= not dma_reload_n;
			else
				dma_reload_n <= '1';
			end if;
			if dma_irq_pend then
				dma_pkt_cnt <= (others => '0');
			elsif burst_end then
				dma_pkt_cnt <= dma_pkt_cnt + 1;
			end if;
			if not dma_reload_n then
				dma_blk_cnt <= (others => '0');
			elsif dma_irq_pend then
				dma_blk_cnt <= dma_blk_cnt + 1;
			end if;
			if not dma_reload_n then
				burst_addr <= unsigned(dma_start_addr);
			elsif burst_end then
				burst_addr <= burst_addr + pkt_size;
			end if;
			-- interrupts and status
			if not dma_irq then
				dma_curr_addr <= burst_addr;
			end if;
			if dma_irq_reset then
				dma_irq <= '0';
			elsif dma_irq_pend or (not dma_timer(dma_timer'left) and dma_timer_d) then
				dma_irq <= '1';
			end if;
			-- DMA timeout timer
			if burst_end or not dma_timer(dma_timer'left) then
				dma_timer <= -signed('0' & dma_timeout);
			else
				dma_timer <= dma_timer + 1;
			end if;
			dma_timer_d <= dma_timer(dma_timer'left);
		end if;
		if not dma_run then
			dvb_latch_data <= (others => '0');
			dvb_latch_dval <= '0';
			dvb_cnt <= (others => '0');
			write_addr_l <= (others => '0');
			write_page <= (others => '0');
			dvb_overrun_n <= '0';
			fifo_overflow <= '0';
			-- statistic counters
			stat_pkts_received <= (others => '0');
			stat_pkts_accepted <= (others => '0');
			stat_pkt_overruns <= (others => '0');
			stat_pkt_underruns <= (others => '0');
			stat_fifo_overruns <= (others => '0');
			--
			read_page <= (others => '0');
			--
			dma_pkt_cnt <= (others => '0');
			dma_blk_cnt <= (others => '0');
			dma_irq_pend <= '0';
			dma_reload_n <= '0';
			--
			dma_curr_addr <= (others => '0');
			dma_irq <= '0';
			--
			dma_timer <= (others => '0');
			dma_timer_d <= '0';
		end if;
		if rst then
			dma_cnt <= (others => '0');
			fifo_latch_valid <= '0';
			fifo_rddata_valid <= '0';
			dma_reg <= (others => '0');
			dma_reg_be <= (others => '0');
			dma_reg_pad <= (others => '0');
			dma_reg_pad_be <= (others => '0');
			dma_reg_pad_wren <= '0';
			--
			burst <= '0';
			burst_end <= '0';
			burst_addr <= (others => '0');
			--
			mem_byteen <= (others => '0');
			mem_wrdata <= (others => '0');
			mem_write_i <= '0';
		end if;
	end process;

	mem_addr <= std_logic_vector(burst_addr(63 downto 3));
	mem_write <= mem_write_i;

	interrupt <= dma_irq;

end;
