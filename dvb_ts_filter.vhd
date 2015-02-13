-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library altera_mf;
use altera_mf.all;

use work.avblabs_common_pkg.all;

entity dvb_ts_filter is

	port (
		rst			: in std_logic;
		clk			: in std_logic;
		--
		pid_tbl_addr	: in std_logic_vector(7 downto 0);
		pid_tbl_be		: in std_logic_vector(3 downto 0);
		pid_tbl_wrdata	: in std_logic_vector(31 downto 0);
		pid_tbl_write	: in std_logic;
		pid_tbl_rddata	: out std_logic_vector(31 downto 0);
		pid_tbl_read	: in std_logic;
		pid_tbl_waitreq	: out std_logic;
		--
		dvb_in_dsop		: in std_logic;
		dvb_in_data		: in std_logic_vector(7 downto 0);
		dvb_in_dval		: in std_logic;
		--
		dvb_out_dsop	: out std_logic;
		dvb_out_data	: out std_logic_vector(7 downto 0);
		dvb_out_dval	: out std_logic
	);

end entity;

architecture rtl of dvb_ts_filter is

--	type mem_t is array(0 to 255) of std_logic_vector(7 downto 0);

--	shared variable pid_tbl_ram_0	: mem_t;
--	shared variable pid_tbl_ram_1	: mem_t;
--	shared variable pid_tbl_ram_2	: mem_t;
--	shared variable pid_tbl_ram_3	: mem_t;

--	signal pid_tbl_ram_addr_a	: unsigned(12 downto 5);
--	signal pid_tbl_ram_be_a		: std_logic_vector(3 downto 0);
--	signal pid_tbl_ram_we_a		: std_logic;
--	signal pid_tbl_ram_d_a		: std_logic_vector(7 downto 0);
	signal pid_tbl_ram_q_a_0	: std_logic_vector(7 downto 0);
	signal pid_tbl_ram_q_a_1	: std_logic_vector(7 downto 0);
	signal pid_tbl_ram_q_a_2	: std_logic_vector(7 downto 0);
	signal pid_tbl_ram_q_a_3	: std_logic_vector(7 downto 0);
--	signal pid_tbl_ram_addr_b	: unsigned(12 downto 1);
	signal pid_tbl_ram_q_b_0	: std_logic_vector(0 downto 0);
	signal pid_tbl_ram_q_b_1	: std_logic_vector(0 downto 0);
	signal pid_tbl_ram_q_b_2	: std_logic_vector(0 downto 0);
	signal pid_tbl_ram_q_b_3	: std_logic_vector(0 downto 0);

	signal pid_tbl_value		: std_logic_vector(3 downto 0);

	signal pid_tbl_rddata_latch	: std_logic_vector(31 downto 0);
	signal latch_valid			: std_logic;
	signal rddata_valid			: std_logic;

	signal header	: std_logic;
	signal pkten	: std_logic;
	
	signal dvb_word_0	: std_logic_vector(9 downto 0);
	signal dvb_word_1	: std_logic_vector(9 downto 0);
	signal dvb_word_2	: std_logic_vector(9 downto 0);
	signal dvb_word_3	: std_logic_vector(9 downto 0);
	signal dvb_word_4	: std_logic_vector(9 downto 0);

--	attribute ramstyle : string;
--	attribute ramstyle of pid_tbl_ram_0 : variable is "M9K, no_rw_check";
--	attribute ramstyle of pid_tbl_ram_1 : variable is "M9K, no_rw_check";
--	attribute ramstyle of pid_tbl_ram_2 : variable is "M9K, no_rw_check";
--	attribute ramstyle of pid_tbl_ram_3 : variable is "M9K, no_rw_check";

begin
/*
	-- RAM port A (read/write)
	process (clk)
		variable addr_a : integer range 0 to 255;
	begin
		if rising_edge(clk) then
			addr_a := to_integer(unsigned(pid_tbl_addr));
			--
			if pid_tbl_write and pid_tbl_be(0) then
				pid_tbl_ram_0(addr_a) := pid_tbl_wrdata(7 downto 0);
			end if;
			if pid_tbl_write and pid_tbl_be(1) then
				pid_tbl_ram_1(addr_a) := pid_tbl_wrdata(15 downto 8);
			end if;
			if pid_tbl_write and pid_tbl_be(2) then
				pid_tbl_ram_2(addr_a) := pid_tbl_wrdata(23 downto 16);
			end if;
			if pid_tbl_write and pid_tbl_be(3) then
				pid_tbl_ram_3(addr_a) := pid_tbl_wrdata(31 downto 24);
			end if;
			--
			pid_tbl_ram_q_a_0 <= pid_tbl_ram_0(addr_a);
			pid_tbl_ram_q_a_1 <= pid_tbl_ram_1(addr_a);
			pid_tbl_ram_q_a_2 <= pid_tbl_ram_2(addr_a);
			pid_tbl_ram_q_a_3 <= pid_tbl_ram_3(addr_a);
		end if;
	end process;

	-- RAM port B (read only)
	process (clk)
		variable addr_b : integer range 0 to 255;
	begin
		if rising_edge(clk) then
			addr_b := to_integer(unsigned(dvb_word_1(4 downto 0)) & unsigned(dvb_word_0(7 downto 5)) & unsigned(dvb_word_0(2 downto 0)));
			--
			pid_tbl_ram_q_b_0 <= pid_tbl_ram_0(addr_b / 8)(addr_b rem 8);
			pid_tbl_ram_q_b_1 <= pid_tbl_ram_1(addr_b / 8)(addr_b rem 8);
			pid_tbl_ram_q_b_2 <= pid_tbl_ram_2(addr_b / 8)(addr_b rem 8);
			pid_tbl_ram_q_b_3 <= pid_tbl_ram_3(addr_b / 8)(addr_b rem 8);
		end if;
	end process;
*/
	RAM_0 : entity work.pid_table_ram
		port map (
			clock		=> clk,
			--
			address_a	=> pid_tbl_addr,
			data_a		=> pid_tbl_wrdata(7 downto 0),
			wren_a		=> pid_tbl_write and pid_tbl_be(0),
			q_a			=> pid_tbl_ram_q_a_0,
			--
			address_b	=> dvb_word_1(4 downto 0) & dvb_word_0(7 downto 5) & dvb_word_0(2 downto 0),
			data_b		=> (others => '0'),
			wren_b		=> '0',
			q_b			=> pid_tbl_ram_q_b_0
		);
	
	RAM_1 : entity work.pid_table_ram
		port map (
			clock		=> clk,
			--
			address_a	=> pid_tbl_addr,
			data_a		=> pid_tbl_wrdata(15 downto 8),
			wren_a		=> pid_tbl_write and pid_tbl_be(1),
			q_a			=> pid_tbl_ram_q_a_1,
			--
			address_b	=> dvb_word_1(4 downto 0) & dvb_word_0(7 downto 5) & dvb_word_0(2 downto 0),
			data_b		=> (others => '0'),
			wren_b		=> '0',
			q_b			=> pid_tbl_ram_q_b_1
		);

	RAM_2 : entity work.pid_table_ram
		port map (
			clock		=> clk,
			--
			address_a	=> pid_tbl_addr,
			data_a		=> pid_tbl_wrdata(23 downto 16),
			wren_a		=> pid_tbl_write and pid_tbl_be(2),
			q_a			=> pid_tbl_ram_q_a_2,
			--
			address_b	=> dvb_word_1(4 downto 0) & dvb_word_0(7 downto 5) & dvb_word_0(2 downto 0),
			data_b		=> (others => '0'),
			wren_b		=> '0',
			q_b			=> pid_tbl_ram_q_b_2
		);
	
	RAM_3 : entity work.pid_table_ram
		port map (
			clock		=> clk,
			--
			address_a	=> pid_tbl_addr,
			data_a		=> pid_tbl_wrdata(31 downto 24),
			wren_a		=> pid_tbl_write and pid_tbl_be(3),
			q_a			=> pid_tbl_ram_q_a_3,
			--
			address_b	=> dvb_word_1(4 downto 0) & dvb_word_0(7 downto 5) & dvb_word_0(2 downto 0),
			data_b		=> (others => '0'),
			wren_b		=> '0',
			q_b			=> pid_tbl_ram_q_b_3
		);
	
	-- other logic
--	pid_tbl_ram_addr_a <= unsigned(pid_tbl_addr);
--	pid_tbl_ram_be_a <= pid_tbl_be;
--	pid_tbl_ram_we_a <= pid_tbl_write;
--	REORG_0 : for i in 0 to 3 generate
--		pid_tbl_rddata_latch(i * 8 + 7 downto i * 8) <= pid_tbl_ram_q_a(i);
--		pid_tbl_ram_d_a(i) <= pid_tbl_wrdata(i * 8 + 7 downto i * 8);
--	end generate;
	pid_tbl_rddata_latch <= pid_tbl_ram_q_a_3 & pid_tbl_ram_q_a_2 & pid_tbl_ram_q_a_1 & pid_tbl_ram_q_a_0;
	pid_tbl_value <= pid_tbl_ram_q_b_3 & pid_tbl_ram_q_b_2 & pid_tbl_ram_q_b_1 & pid_tbl_ram_q_b_0;
--	pid_tbl_ram_addr_b <= unsigned(dvb_word_1(4 downto 0)) & unsigned(dvb_word_0(7 downto 5));

	pid_tbl_waitreq <= pid_tbl_read and not rddata_valid;

	process (rst, clk)
	begin
		if rising_edge(clk) then
			pid_tbl_rddata <= pid_tbl_rddata_latch;
			latch_valid <= pid_tbl_read and (latch_valid nor rddata_valid);
			rddata_valid <= latch_valid;
			--
			if dvb_in_dval then
				if dvb_in_dsop then
					header <= '1';
				elsif dvb_word_1(8) then
					header <= '0';
				end if;
			end if;
			if dvb_word_3(8) then
				pkten <= not pid_tbl_value(to_integer(unsigned(dvb_word_1(4 downto 3))));--(to_integer(unsigned(dvb_word_1(4 downto 3))))(to_integer(unsigned(dvb_word_1(2 downto 0))));
			end if;
			if not header or dvb_in_dval then
				dvb_word_0 <= dvb_in_dval & dvb_in_dsop & dvb_in_data;
				dvb_word_1 <= dvb_word_0;
				dvb_word_2 <= dvb_word_1;
				dvb_word_3 <= dvb_word_2;
				dvb_word_4 <= dvb_word_3;
				-- output stage
				if not pkten then
					dvb_out_dval <= '0';
					dvb_out_dsop <= '0';
					dvb_out_data <= (others => '0');
				else
					dvb_out_dval <= dvb_word_4(9);
					dvb_out_dsop <= dvb_word_4(8);
					dvb_out_data <= dvb_word_4(7 downto 0);
				end if;
			end if;
		end if;
		if rst then
			pid_tbl_rddata <= (others => '0');
			latch_valid <= '0';
			rddata_valid <= '0';
			--
			header <= '0';
			pkten <= '0';
			--
			dvb_word_0 <= (others => '0');
			dvb_word_1 <= (others => '0');
			dvb_word_2 <= (others => '0');
			dvb_word_3 <= (others => '0');
			dvb_word_4 <= (others => '0');
			--
			dvb_out_dval <= '0';
			dvb_out_dsop <= '0';
			dvb_out_data <= (others => '0');
		end if;
	end process;

end architecture;
