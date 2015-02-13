-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity twi_master is
	port (
		rst			: in std_logic;
		clk			: in std_logic;
		-- Avalon-MM 32-bits slave
		addr		: in std_logic_vector(1 downto 0);
		byte_en		: in std_logic_vector(1 downto 0)	:= (others => '1');
		in_data		: in std_logic_vector(15 downto 0);
		wr_en		: in std_logic;
		out_data	: out std_logic_vector(15 downto 0);
		--
		source_irq	: in std_logic;
		sink_irq	: in std_logic;
		irq			: out std_logic;
		-- DATA source
		in_octet	: in std_logic_vector(7 downto 0);
		in_valid	: in std_logic;
		in_ready	: out std_logic;
		-- DATA sink
		out_octet	: out std_logic_vector(7 downto 0);
		out_valid	: out std_logic;
		out_ready	: in std_logic;
		-- TWI bus (export)
		scl_in		: in std_logic;
		scl_act		: out std_logic;
		sda_in		: in std_logic;
		sda_act		: out std_logic
	);
end entity;

architecture RTL of twi_master is

	-- registers addresses
	constant REG_PRESC			: std_logic_vector(1 downto 0) := "00";
	constant REG_INT_CTRLSTAT	: std_logic_vector(1 downto 0) := "01";
	constant REG_TWI_CTRL		: std_logic_vector(1 downto 0) := "10";
	constant REG_DATA_LEN		: std_logic_vector(1 downto 0) := "11";
	-- int control register bits
	constant TWI_COMPL_MASK		: natural := 0;
	constant TWI_ANACK_MASK		: natural := 1;
	constant TWI_DNACK_MASK		: natural := 2;
	-- int status register bits
	constant TWI_COMPL			: natural := 8;
	constant TWI_ANACK			: natural := 9;
	constant TWI_DNACK			: natural := 10;
	constant TWI_SOURCE_REQ		: natural := 11;
	constant TWI_SINK_REQ		: natural := 12;
	constant TWI_SDA_SENSE		: natural := 14;
	constant TWI_SCL_SENSE		: natural := 15;
	-- TWI control register bits
	constant TWI_TRANSFER		: natural := 8;
	constant TWI_NOSTOP			: natural := 9;
	constant TWI_NOSTART		: natural := 10;
	constant TWI_SOFT_RESET		: natural := 13;
	constant TWI_SDA_OVERRIDE	: natural := 14;
	constant TWI_SCL_OVERRIDE	: natural := 15;

	signal int_ctrlstat_reg		: std_logic_vector(15 downto 0);
	signal twi_control_reg		: std_logic_vector(15 downto 8);

	signal presc_div	: unsigned(15 downto 0);

	signal compl_mask	: std_logic;
	signal anack_mask	: std_logic;
	signal dnack_mask	: std_logic;
	signal compl		: std_logic;
	signal anack		: std_logic;
	signal dnack		: std_logic;

	signal slave_addr	: std_logic_vector(7 downto 0);
	signal transfer		: std_logic;
	signal nostop		: std_logic;
	signal nostart		: std_logic;
	signal sda_ovr		: std_logic;
	signal scl_ovr		: std_logic;

	signal scl_sen_meta	: std_logic;
	signal scl_sen		: std_logic;
	signal sda_sen_meta	: std_logic;
	signal sda_sen		: std_logic;

	signal data_len		: unsigned(15 downto 0);

	signal prescl_wren		: std_logic;
	signal presch_wren		: std_logic;
	signal int_ctrl_wren	: std_logic;
	signal int_stat_wren	: std_logic;
	signal twi_ctrl_wren	: std_logic;
	signal slave_addr_wren	: std_logic;
	signal dlenl_wren		: std_logic;
	signal dlenh_wren		: std_logic;

	signal soft_reset		: std_logic;
	signal start_transfer	: std_logic;
	signal end_transfer		: std_logic;

	signal presc_cntr		: unsigned(15 downto 0);
	signal tick_en			: std_logic;
	signal phase_tick_en	: std_logic;
	signal bit_tick_en		: std_logic;
	signal symbol_tick_en	: std_logic;
	signal state_tick_en	: std_logic;
	signal scl_tick_en		: std_logic;
	signal symbol_pending	: std_logic;
	signal bit_cntr_en		: std_logic;

	signal shift_reg			: std_logic_vector(8 downto 0);
	signal shift_reg_ld_addr	: std_logic;
	signal shift_reg_ld_data	: std_logic;
	signal shift_reg_ld_dummy	: std_logic;
	signal shift_reg_ack_bit	: std_logic;

	signal bit_phase	: unsigned(1 downto 0);
	signal bit_cntr		: unsigned(3 downto 0);

	type twi_state_t is (twi_st_idle, twi_st_start, twi_st_addr, twi_st_data, twi_st_stop, twi_st_end);

	signal twi_state		: twi_state_t;
	signal twi_next_state	: twi_state_t;

	signal slave_nack	: std_logic;
	signal anack_i		: std_logic;
	signal dnack_i		: std_logic;

	signal scl_i		: std_logic;
	signal sda_i		: std_logic;
	signal in_ready_i	: std_logic;
	signal out_valid_i	: std_logic;

	signal in_stall		: std_logic;
	signal out_stall	: std_logic;

begin
	int_ctrlstat_reg <= (
		TWI_COMPL_MASK => compl_mask,
		TWI_ANACK_MASK => anack_mask,
		TWI_DNACK_MASK => dnack_mask,
		--
		TWI_COMPL => compl,
		TWI_ANACK => anack,
		TWI_DNACK => dnack,
		TWI_SOURCE_REQ => source_irq,
		TWI_SINK_REQ => sink_irq,
		TWI_SDA_SENSE => not sda_sen,
		TWI_SCL_SENSE => not scl_sen,
		--
		others => '0'
	);
	twi_control_reg <= (
		TWI_SCL_OVERRIDE => scl_ovr, 
		TWI_SDA_OVERRIDE => sda_ovr, 
		TWI_NOSTOP => nostop, 
		TWI_NOSTART => nostart,
		TWI_TRANSFER => transfer,
		--
		others => '0'
	);

	with addr select
		out_data <= std_logic_vector(presc_div)		when REG_PRESC,
					int_ctrlstat_reg				when REG_INT_CTRLSTAT,
					twi_control_reg & slave_addr	when REG_TWI_CTRL,
					std_logic_vector(data_len)		when REG_DATA_LEN,
					(others => '0') 				when others;

	prescl_wren <= wr_en and byte_en(0) and not transfer when addr = REG_PRESC else '0';
	presch_wren <= wr_en and byte_en(1) and not transfer when addr = REG_PRESC else '0';
	int_ctrl_wren <= wr_en and byte_en(0) when addr = REG_INT_CTRLSTAT else '0';
	int_stat_wren <= wr_en and byte_en(1) when addr = REG_INT_CTRLSTAT else '0';
	slave_addr_wren <= wr_en and byte_en(0) and not transfer when addr = REG_TWI_CTRL else '0';
	twi_ctrl_wren <= wr_en and byte_en(1) when addr = REG_TWI_CTRL else '0';
	dlenl_wren <= wr_en and byte_en(0) when addr = REG_DATA_LEN else '0';
	dlenh_wren <= wr_en and byte_en(1) when addr = REG_DATA_LEN else '0';

	soft_reset <= twi_ctrl_wren and in_data(TWI_SOFT_RESET);
	start_transfer <= twi_ctrl_wren and in_data(TWI_TRANSFER) and not transfer;

	tick_en <= '1' when presc_div = presc_cntr else '0';

	process (rst, clk)
	begin
		if rising_edge(clk) then
			-- resync input pins
			scl_sen_meta <= scl_in;
			scl_sen <= scl_sen_meta;
			sda_sen_meta <= sda_in;
			sda_sen <= sda_sen_meta;
			-- clock divider register
			if prescl_wren = '1' then
				presc_div(7 downto 0) <= unsigned(in_data(7 downto 0));
			end if;
			if presch_wren = '1' then
				presc_div(15 downto 8) <= unsigned(in_data(15 downto 8));
			end if;
			-- slave address register
			if slave_addr_wren = '1' then
				slave_addr <= in_data(7 downto 0);
			end if;
			-- TWI control register
			if twi_ctrl_wren = '1' then
				scl_ovr <= in_data(TWI_SCL_OVERRIDE);
				sda_ovr <= in_data(TWI_SDA_OVERRIDE);
			end if;
			if (twi_ctrl_wren and not transfer) = '1' then
				nostop <= in_data(TWI_NOSTOP);
				nostart <= in_data(TWI_NOSTART);
			end if;
			if (soft_reset or end_transfer) = '1' then
				transfer <= '0';
			elsif start_transfer = '1' then
				transfer <= '1';
			end if;
			-- int control register
			if int_ctrl_wren = '1' then
				compl_mask <= in_data(TWI_COMPL_MASK);
				anack_mask <= in_data(TWI_ANACK_MASK);
				dnack_mask <= in_data(TWI_DNACK_MASK);
			end if;
			-- int status register
			if ((int_stat_wren and in_data(TWI_COMPL)) or start_transfer or soft_reset) = '1' then
				compl <= '0';
			elsif end_transfer = '1' then
				compl <= anack_i nor dnack_i;
			end if;
			if ((int_stat_wren and in_data(TWI_ANACK)) or start_transfer or soft_reset) = '1' then
				anack <= '0';
			elsif end_transfer = '1' then
				anack <= anack_i;
			end if;
			if ((int_stat_wren and in_data(TWI_DNACK)) or start_transfer or soft_reset) = '1' then
				dnack <= '0';
			elsif end_transfer = '1' then
				dnack <= dnack_i;
			end if;
			-- data length register
			if (transfer and (shift_reg_ld_data or shift_reg_ld_dummy)) = '1' then
				data_len <= data_len - 1;
			else
				if dlenl_wren = '1' then
					data_len(7 downto 0) <= unsigned(in_data(7 downto 0));
				end if;
				if dlenh_wren = '1' then
					data_len(15 downto 8) <= unsigned(in_data(15 downto 8));
				end if;
			end if;
			-- clock_processing
			if (tick_en or prescl_wren or presch_wren) = '1' then
				presc_cntr <= (others => '0');
			else
				presc_cntr <= presc_cntr + 1;
			end if;
		end if;
		if rst = '1' then
			scl_sen_meta <= '0';
			scl_sen <= '0';
			sda_sen_meta <= '0';
			sda_sen <= '0';
			scl_ovr <= '0';
			sda_ovr <= '0';
			transfer <= '0';
			nostart <= '0';
			nostop <= '0';
			compl <= '0';
			anack <= '0';
			dnack <= '0';
			compl_mask <= '0';
			anack_mask <= '0';
			dnack_mask <= '0';
			data_len <= (others => '0');
			presc_div <= (others => '0');
			presc_cntr <= (others => '0');
			slave_addr <= (others => '0');
		end if;
	end process;

	slave_nack <= (sda_sen and symbol_tick_en) when twi_state = twi_st_addr else (sda_sen and symbol_tick_en and not slave_addr(0));

	shift_reg_ld_addr <= bit_tick_en when twi_state = twi_st_start else '0';
	shift_reg_ld_data <= state_tick_en and not slave_addr(0) and in_valid when twi_next_state = twi_st_data else '0';
	shift_reg_ld_dummy <= state_tick_en and slave_addr(0) when twi_next_state = twi_st_data else '0';

	shift_reg_ack_bit <= not nostop when data_len = 1 else '0';

	in_ready_i <= tick_en and not slave_addr(0) when bit_phase = 0 and bit_cntr = 8 and data_len /= 0 else '0';

	out_stall <= out_valid_i and not out_ready;
	in_stall <= in_ready_i and not in_valid;

	phase_tick_en <= tick_en and (out_stall nor in_stall) when bit_phase /= 3 or scl_sen = '1' else '0';
	bit_tick_en <= phase_tick_en when bit_phase = 0 else '0';
	symbol_tick_en <= bit_tick_en when bit_cntr = 8 else '0';
	with twi_state select
		state_tick_en <= bit_tick_en when twi_st_idle | twi_st_start | twi_st_stop,
					 	 symbol_tick_en when twi_st_addr | twi_st_data,
					 	 '0' when others;

	scl_tick_en <= '0' when bit_phase = 1 else phase_tick_en;
	bit_cntr_en <= bit_tick_en when twi_state = twi_st_addr or twi_state = twi_st_data else '0';
	symbol_pending <= slave_addr(0) and bit_tick_en when twi_state = twi_st_data and bit_cntr = 7 else '0';

	end_transfer <= phase_tick_en when twi_state = twi_st_end else '0';

	process (rst, transfer, clk)
	begin
		if rising_edge(clk) then
			-- upstream state machine
			if (out_valid_i and out_ready) = '1' then
				out_valid_i <= '0';
			elsif symbol_pending = '1' then
				out_valid_i <= '1';
			end if;
			-- bit phase processing
			if phase_tick_en = '1' then
				bit_phase <= bit_phase + 1;
			end if;
			-- SDA state machine
			if soft_reset = '1' then
				sda_i <= '0';
			elsif phase_tick_en = '1' then
				case twi_state is 
					when twi_st_start =>
						sda_i <= bit_phase(0) xnor bit_phase(1);
					when twi_st_data | twi_st_addr =>
						sda_i <= not shift_reg(8);
					when twi_st_stop =>
						sda_i <= bit_phase(0) xor bit_phase(1);
					when others =>
						null;
				end case;
			end if;
			-- SCL state machine
			if soft_reset = '1' then
				scl_i <= '0';
			elsif scl_tick_en = '1' then
				case twi_state is 
					when twi_st_start | twi_st_addr | twi_st_data =>
						scl_i <= not bit_phase(1);
					when twi_st_stop =>
						scl_i <= '0';
					when others =>
						null;
				end case;
			end if;
			-- bit counter
			if bit_cntr_en = '1' then
				if symbol_tick_en = '1' then
					bit_cntr <= (others => '0');
				else
					bit_cntr <= bit_cntr + 1;
				end if;
			end if;
			-- TWI state machine
			if state_tick_en = '1' then
				twi_state <= twi_next_state;
			end if;
			-- shift register process
			if shift_reg_ld_addr = '1' then				-- load shift register with slave address
				shift_reg <= slave_addr & '1';
			elsif shift_reg_ld_data = '1' then			-- load shift register with next data octet
				shift_reg <= in_octet & '1';
			elsif shift_reg_ld_dummy = '1' then			-- load shift register with dummy value
				shift_reg <= (0 => shift_reg_ack_bit, others => '1');
			elsif bit_tick_en = '1' then				-- shift register and load next bit
				shift_reg <= shift_reg(7 downto 0) & sda_sen;
			end if;
			-- remember ack bit
			if symbol_tick_en = '1' and twi_state = twi_st_addr then
				anack_i <= sda_sen;
			end if;
			if symbol_tick_en = '1' and twi_state = twi_st_data then
				dnack_i <= sda_sen and not slave_addr(0);
			end if;
		end if;
		if transfer = '0' then
			twi_state <= twi_st_idle;
			out_valid_i <= '0';
			anack_i <= '0';
			dnack_i <= '0';
			bit_phase <= (others => '0');
			bit_cntr <= (others => '0');
			shift_reg <= (others => '0');
		end if;
		if rst = '1' then
			scl_i <= '0';
			sda_i <= '0';
		end if;
	end process;

	twi_next_state <=	twi_st_start when twi_state = twi_st_idle and nostart = '0' else
						twi_st_addr when twi_state = twi_st_start else
						twi_st_data when twi_state /= twi_st_stop and data_len /= 0 and slave_nack = '0' else
						twi_st_stop when twi_state /= twi_st_stop and twi_state /= twi_st_end and nostop = '0' else
						twi_st_end;

	scl_act <= scl_i or scl_ovr;
	sda_act <= sda_i or scl_ovr;

	in_ready <= in_ready_i;
	out_valid <= out_valid_i;
	out_octet <= shift_reg(7 downto 0);

	irq <= source_irq or sink_irq or (compl and compl_mask) or (anack and anack_mask) or (dnack and dnack_mask);

end architecture;
