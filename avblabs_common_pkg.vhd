-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package avblabs_common_pkg is

	procedure write_sr_flag (
		signal flag 		: out std_logic;
		constant baseaddr	: natural;
		constant bitpos		: natural;
		signal addr			: in std_logic_vector;
		signal data			: in std_logic_vector;
		signal be			: in std_logic_vector
	);

	procedure write_reg (
		signal reg 			: out std_logic_vector;
		constant baseaddr	: natural;
		signal addr			: in std_logic_vector;
		signal data			: in std_logic_vector;
		signal be			: in std_logic_vector
	);

	function ulen (arg : natural) return natural;
	function slen (arg : integer) return natural;

	function bin_to_gray (inputs: unsigned) return std_logic_vector;
	function gray_to_bin (inputs: std_logic_vector) return unsigned;

	function fifo_not_full (
		wrptr : std_logic_vector; 
		rdptr : std_logic_vector
	) return std_logic;

	function fifo_not_empty (
		wrptr : std_logic_vector; 
		rdptr : std_logic_vector
	) return std_logic;

	function fifo_water_level (
		wrptr : std_logic_vector; 
		rdptr : std_logic_vector
	) return unsigned;

end package;

package body avblabs_common_pkg is

	procedure write_sr_flag (
		signal flag 		: out std_logic;
		constant baseaddr	: natural;
		constant bitpos		: natural;
		signal addr			: in std_logic_vector;
		signal data			: in std_logic_vector;
		signal be			: in std_logic_vector
	) is
	begin
		if unsigned(addr(addr'left downto addr'right + 1)) = baseaddr / 2 then
			if be(bitpos / 8) and data(bitpos) then
				flag <= not addr(addr'right);
			end if;
		end if;
	end procedure;

	procedure write_reg (
		signal reg 			: out std_logic_vector;
		constant baseaddr	: natural;
		signal addr			: in std_logic_vector;
		signal data			: in std_logic_vector;
		signal be			: in std_logic_vector
	) is
	begin
		if unsigned(addr) = baseaddr then
			for i in reg'range loop
				if be(i / 8) then
					reg(i) <= data(i);
				end if;
			end loop;
		end if;
	end procedure;

	function ulen (arg : natural) return natural is
	begin
		if arg < 2 then 
			return 1;
		else
			return ulen(arg / 2) + 1;
		end if;
	end function;

	function slen (arg : integer) return natural is
	begin
		if arg < 0 then
			return ulen(abs(arg) - 1) + 1;
		else
			return ulen(arg) + 1;
		end if;
	end function;

	function bin_to_gray (inputs: unsigned) return std_logic_vector is
	begin
		return std_logic_vector(inputs xor ('0' & inputs(inputs'left downto inputs'right + 1)));
	end function;

	function gray_to_bin_i (inputs: std_logic_vector) return std_logic_vector is
		variable u_result : std_logic_vector(inputs'left downto inputs'length / 2 + inputs'right);
		variable l_result : std_logic_vector(inputs'length / 2 + inputs'right - 1 downto inputs'right);
	begin
		u_result := inputs(u_result'range);
		l_result := inputs(l_result'range);
		if u_result'length > 1 then
			u_result := gray_to_bin_i(u_result);
		end if;
		if l_result'length > 1 then
			l_result := gray_to_bin_i(l_result);
		end if;
		l_result := l_result xor (l_result'range => u_result(u_result'right));
		return u_result & l_result;
	end function;

	function gray_to_bin (inputs: std_logic_vector) return unsigned is
--		variable result : unsigned(inputs'range);
	begin
--		result(result'left) := inputs(inputs'left);
--		for i in inputs'left - 1 downto inputs'right loop
--			result(i) := inputs(i) xor result(i + 1);
--		end loop;
--		return result;
		return unsigned(gray_to_bin_i(inputs));
	end function;

	function fifo_not_full (
		wrptr : std_logic_vector; 
		rdptr : std_logic_vector
	) return std_logic is
	begin
		if wrptr(wrptr'left - 2 downto 0) = rdptr(rdptr'left - 2 downto 0) then
			return (wrptr(wrptr'left) xor rdptr(rdptr'left)) nand (wrptr(wrptr'left - 1) xor rdptr(rdptr'left - 1));
		else
			return '1';
		end if;
	end function;

	function fifo_not_empty (
		wrptr : std_logic_vector; 
		rdptr : std_logic_vector
	) return std_logic is
	begin
		if wrptr = rdptr then
			return '0';
		else
			return '1';
		end if;
	end function;

	function fifo_water_level (
		wrptr : std_logic_vector; 
		rdptr : std_logic_vector
	) return unsigned is
		variable wraddr	: std_logic_vector(wrptr'left - 1 downto wrptr'right);
		variable rdaddr	: std_logic_vector(rdptr'left - 1 downto rdptr'right);
	begin
		wraddr := (wrptr(wrptr'left) xor wrptr(wrptr'left - 1)) & wrptr(wrptr'left - 2 downto 0);
		rdaddr := (rdptr(rdptr'left) xor rdptr(rdptr'left - 1)) & rdptr(rdptr'left - 2 downto 0);
		return gray_to_bin(wraddr) - gray_to_bin(rdaddr);
	end function;

end package body;
