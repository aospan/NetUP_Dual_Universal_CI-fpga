-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2014 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity avalon64_to_avalon8_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal avalon64_to_avalon8_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal unici_core_burst_1_downstream_arbitrationshare : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal unici_core_burst_1_downstream_burstcount : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal unici_core_burst_1_downstream_latency_counter : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_read : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_write : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

              -- outputs:
                 signal avalon64_to_avalon8_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal avalon64_to_avalon8_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal avalon64_to_avalon8_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal avalon64_to_avalon8_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal avalon64_to_avalon8_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal avalon64_to_avalon8_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity avalon64_to_avalon8_0_avalon_slave_0_arbitrator;


architecture europa of avalon64_to_avalon8_0_avalon_slave_0_arbitrator is
                signal avalon64_to_avalon8_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_avalon64_to_avalon8_0_avalon_slave_0_from_unici_core_burst_1_downstream :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_1_downstream_arbiterlock :  STD_LOGIC;
                signal unici_core_burst_1_downstream_arbiterlock2 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_continuerequest :  STD_LOGIC;
                signal unici_core_burst_1_downstream_saved_grant_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal wait_for_avalon64_to_avalon8_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT avalon64_to_avalon8_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  avalon64_to_avalon8_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0);
  --assign avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa = avalon64_to_avalon8_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa <= avalon64_to_avalon8_0_avalon_slave_0_readdata;
  internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_1_downstream_read OR unici_core_burst_1_downstream_write)))))));
  --assign avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa = avalon64_to_avalon8_0_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa <= avalon64_to_avalon8_0_avalon_slave_0_waitrequest;
  --avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000") & (unici_core_burst_1_downstream_arbitrationshare)), std_logic_vector'("00000000000000000000000000000001")), 10);
  --avalon64_to_avalon8_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_non_bursting_master_requests <= std_logic'('0');
  --avalon64_to_avalon8_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_any_bursting_master_saved_grant <= unici_core_burst_1_downstream_saved_grant_avalon64_to_avalon8_0_avalon_slave_0;
  --avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(avalon64_to_avalon8_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000") & (avalon64_to_avalon8_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("00000000000000000000000") & (avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 10);
  --avalon64_to_avalon8_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_allgrants <= avalon64_to_avalon8_0_avalon_slave_0_grant_vector;
  --avalon64_to_avalon8_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_end_xfer <= NOT ((avalon64_to_avalon8_0_avalon_slave_0_waits_for_read OR avalon64_to_avalon8_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0 <= avalon64_to_avalon8_0_avalon_slave_0_end_xfer AND (((NOT avalon64_to_avalon8_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0 AND avalon64_to_avalon8_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0 AND NOT avalon64_to_avalon8_0_avalon_slave_0_non_bursting_master_requests));
  --avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(avalon64_to_avalon8_0_avalon_slave_0_arb_counter_enable) = '1' then 
        avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter <= avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((avalon64_to_avalon8_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_avalon64_to_avalon8_0_avalon_slave_0 AND NOT avalon64_to_avalon8_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --unici_core_burst_1/downstream avalon64_to_avalon8_0/avalon_slave_0 arbiterlock, which is an e_assign
  unici_core_burst_1_downstream_arbiterlock <= avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable AND unici_core_burst_1_downstream_continuerequest;
  --avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(avalon64_to_avalon8_0_avalon_slave_0_arb_share_counter_next_value);
  --unici_core_burst_1/downstream avalon64_to_avalon8_0/avalon_slave_0 arbiterlock2, which is an e_assign
  unici_core_burst_1_downstream_arbiterlock2 <= avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable2 AND unici_core_burst_1_downstream_continuerequest;
  --avalon64_to_avalon8_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --unici_core_burst_1_downstream_continuerequest continued request, which is an e_assign
  unici_core_burst_1_downstream_continuerequest <= std_logic'('1');
  internal_unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 <= internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 AND NOT ((unici_core_burst_1_downstream_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_1_downstream_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0, which is an e_mux
  unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 <= (internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 AND unici_core_burst_1_downstream_read) AND NOT avalon64_to_avalon8_0_avalon_slave_0_waits_for_read;
  --avalon64_to_avalon8_0_avalon_slave_0_writedata mux, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_writedata <= unici_core_burst_1_downstream_writedata;
  --master is always granted when requested
  internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 <= internal_unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0;
  --unici_core_burst_1/downstream saved-grant avalon64_to_avalon8_0/avalon_slave_0, which is an e_assign
  unici_core_burst_1_downstream_saved_grant_avalon64_to_avalon8_0_avalon_slave_0 <= internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0;
  --allow new arb cycle for avalon64_to_avalon8_0/avalon_slave_0, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  avalon64_to_avalon8_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  avalon64_to_avalon8_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~avalon64_to_avalon8_0_avalon_slave_0_reset assignment, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_reset <= NOT reset_n;
  --avalon64_to_avalon8_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(avalon64_to_avalon8_0_avalon_slave_0_begins_xfer) = '1'), avalon64_to_avalon8_0_avalon_slave_0_unreg_firsttransfer, avalon64_to_avalon8_0_avalon_slave_0_reg_firsttransfer);
  --avalon64_to_avalon8_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_unreg_firsttransfer <= NOT ((avalon64_to_avalon8_0_avalon_slave_0_slavearbiterlockenable AND avalon64_to_avalon8_0_avalon_slave_0_any_continuerequest));
  --avalon64_to_avalon8_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      avalon64_to_avalon8_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(avalon64_to_avalon8_0_avalon_slave_0_begins_xfer) = '1' then 
        avalon64_to_avalon8_0_avalon_slave_0_reg_firsttransfer <= avalon64_to_avalon8_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --avalon64_to_avalon8_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_beginbursttransfer_internal <= avalon64_to_avalon8_0_avalon_slave_0_begins_xfer;
  --avalon64_to_avalon8_0_avalon_slave_0_read assignment, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_read <= internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 AND unici_core_burst_1_downstream_read;
  --avalon64_to_avalon8_0_avalon_slave_0_write assignment, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_write <= internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 AND unici_core_burst_1_downstream_write;
  shifted_address_to_avalon64_to_avalon8_0_avalon_slave_0_from_unici_core_burst_1_downstream <= unici_core_burst_1_downstream_address_to_slave;
  --avalon64_to_avalon8_0_avalon_slave_0_address mux, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_avalon64_to_avalon8_0_avalon_slave_0_from_unici_core_burst_1_downstream,std_logic_vector'("00000000000000000000000000000011")), 15);
  --d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer <= avalon64_to_avalon8_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --avalon64_to_avalon8_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_waits_for_read <= avalon64_to_avalon8_0_avalon_slave_0_in_a_read_cycle AND internal_avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa;
  --avalon64_to_avalon8_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_in_a_read_cycle <= internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 AND unici_core_burst_1_downstream_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= avalon64_to_avalon8_0_avalon_slave_0_in_a_read_cycle;
  --avalon64_to_avalon8_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_waits_for_write <= avalon64_to_avalon8_0_avalon_slave_0_in_a_write_cycle AND internal_avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa;
  --avalon64_to_avalon8_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  avalon64_to_avalon8_0_avalon_slave_0_in_a_write_cycle <= internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 AND unici_core_burst_1_downstream_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= avalon64_to_avalon8_0_avalon_slave_0_in_a_write_cycle;
  wait_for_avalon64_to_avalon8_0_avalon_slave_0_counter <= std_logic'('0');
  --avalon64_to_avalon8_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  avalon64_to_avalon8_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000") & (unici_core_burst_1_downstream_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 8);
  --vhdl renameroo for output signals
  avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa <= internal_avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 <= internal_unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0;
  --vhdl renameroo for output signals
  unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 <= internal_unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0;
  --vhdl renameroo for output signals
  unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 <= internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0;
--synthesis translate_off
    --avalon64_to_avalon8_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --unici_core_burst_1/downstream non-zero arbitrationshare assertion, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 AND to_std_logic((((std_logic_vector'("0000000000000000000000") & (unici_core_burst_1_downstream_arbitrationshare)) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("unici_core_burst_1/downstream drove 0 on its 'arbitrationshare' port while accessing slave avalon64_to_avalon8_0/avalon_slave_0"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_1/downstream non-zero burstcount assertion, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_1_downstream_burstcount))) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("unici_core_burst_1/downstream drove 0 on its 'burstcount' port while accessing slave avalon64_to_avalon8_0/avalon_slave_0"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ci_bridge_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal ci_bridge_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal ci_bridge_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal ci_bridge_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal ci_bridge_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal ci_bridge_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal ci_bridge_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal ci_bridge_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal d1_ci_bridge_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity ci_bridge_0_avalon_slave_0_arbitrator;


architecture europa of ci_bridge_0_avalon_slave_0_arbitrator is
                signal ci_bridge_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_ci_bridge_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_ci_bridge_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT ci_bridge_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  ci_bridge_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0);
  --assign ci_bridge_0_avalon_slave_0_readdata_from_sa = ci_bridge_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  ci_bridge_0_avalon_slave_0_readdata_from_sa <= ci_bridge_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100100110000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --ci_bridge_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  ci_bridge_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --ci_bridge_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  ci_bridge_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0;
  --ci_bridge_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  ci_bridge_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --ci_bridge_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  ci_bridge_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(ci_bridge_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (ci_bridge_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(ci_bridge_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (ci_bridge_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --ci_bridge_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  ci_bridge_0_avalon_slave_0_allgrants <= ci_bridge_0_avalon_slave_0_grant_vector;
  --ci_bridge_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  ci_bridge_0_avalon_slave_0_end_xfer <= NOT ((ci_bridge_0_avalon_slave_0_waits_for_read OR ci_bridge_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0 <= ci_bridge_0_avalon_slave_0_end_xfer AND (((NOT ci_bridge_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ci_bridge_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  ci_bridge_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0 AND ci_bridge_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0 AND NOT ci_bridge_0_avalon_slave_0_non_bursting_master_requests));
  --ci_bridge_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ci_bridge_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(ci_bridge_0_avalon_slave_0_arb_counter_enable) = '1' then 
        ci_bridge_0_avalon_slave_0_arb_share_counter <= ci_bridge_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ci_bridge_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ci_bridge_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ci_bridge_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_ci_bridge_0_avalon_slave_0 AND NOT ci_bridge_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        ci_bridge_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(ci_bridge_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master ci_bridge_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= ci_bridge_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --ci_bridge_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ci_bridge_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(ci_bridge_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master ci_bridge_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= ci_bridge_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --ci_bridge_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  ci_bridge_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 AND NOT (((NOT(or_reduce(internal_int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0))) AND int_ctrl_0_avalon_master_write));
  --ci_bridge_0_avalon_slave_0_writedata mux, which is an e_mux
  ci_bridge_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_dbs_write_16;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant ci_bridge_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0;
  --allow new arb cycle for ci_bridge_0/avalon_slave_0, which is an e_assign
  ci_bridge_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ci_bridge_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ci_bridge_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~ci_bridge_0_avalon_slave_0_reset assignment, which is an e_assign
  ci_bridge_0_avalon_slave_0_reset <= NOT reset_n;
  --ci_bridge_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  ci_bridge_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(ci_bridge_0_avalon_slave_0_begins_xfer) = '1'), ci_bridge_0_avalon_slave_0_unreg_firsttransfer, ci_bridge_0_avalon_slave_0_reg_firsttransfer);
  --ci_bridge_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  ci_bridge_0_avalon_slave_0_unreg_firsttransfer <= NOT ((ci_bridge_0_avalon_slave_0_slavearbiterlockenable AND ci_bridge_0_avalon_slave_0_any_continuerequest));
  --ci_bridge_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ci_bridge_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ci_bridge_0_avalon_slave_0_begins_xfer) = '1' then 
        ci_bridge_0_avalon_slave_0_reg_firsttransfer <= ci_bridge_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ci_bridge_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ci_bridge_0_avalon_slave_0_beginbursttransfer_internal <= ci_bridge_0_avalon_slave_0_begins_xfer;
  --ci_bridge_0_avalon_slave_0_write assignment, which is an e_mux
  ci_bridge_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_ci_bridge_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= A_EXT (Std_Logic_Vector'(A_SRL(int_ctrl_0_avalon_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(int_ctrl_0_avalon_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 15);
  --ci_bridge_0_avalon_slave_0_address mux, which is an e_mux
  ci_bridge_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_ci_bridge_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000001")), 2);
  --d1_ci_bridge_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ci_bridge_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_ci_bridge_0_avalon_slave_0_end_xfer <= ci_bridge_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --ci_bridge_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  ci_bridge_0_avalon_slave_0_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ci_bridge_0_avalon_slave_0_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --ci_bridge_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  ci_bridge_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ci_bridge_0_avalon_slave_0_in_a_read_cycle;
  --ci_bridge_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  ci_bridge_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ci_bridge_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --ci_bridge_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  ci_bridge_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ci_bridge_0_avalon_slave_0_in_a_write_cycle;
  wait_for_ci_bridge_0_avalon_slave_0_counter <= std_logic'('0');
  --ci_bridge_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  ci_bridge_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_1(1), int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_1(0), int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_0(1), int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_0(0)) <= int_ctrl_0_avalon_master_byteenable;
  internal_int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_0, int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0;
--synthesis translate_off
    --ci_bridge_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity dma_arbiter_0_avalon_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal d1_pcie_compiler_0_Tx_Interface_end_xfer : IN STD_LOGIC;
                 signal dma_arbiter_0_avalon_master_address : IN STD_LOGIC_VECTOR (30 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_burstcount : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_write : IN STD_LOGIC;
                 signal dma_arbiter_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface : IN STD_LOGIC;
                 signal dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface : IN STD_LOGIC;
                 signal dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface : IN STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_waitrequest_from_sa : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal dma_arbiter_0_avalon_master_address_to_slave : OUT STD_LOGIC_VECTOR (30 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_reset : OUT STD_LOGIC;
                 signal dma_arbiter_0_avalon_master_waitrequest : OUT STD_LOGIC
              );
end entity dma_arbiter_0_avalon_master_arbitrator;


architecture europa of dma_arbiter_0_avalon_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_address_last_time :  STD_LOGIC_VECTOR (30 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_burstcount_last_time :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_byteenable_last_time :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_run :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_write_last_time :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_writedata_last_time :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal internal_dma_arbiter_0_avalon_master_address_to_slave :  STD_LOGIC_VECTOR (30 DOWNTO 0);
                signal internal_dma_arbiter_0_avalon_master_waitrequest :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((std_logic_vector'("00000000000000000000000000000001") AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface OR NOT (dma_arbiter_0_avalon_master_write))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT pcie_compiler_0_Tx_Interface_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((dma_arbiter_0_avalon_master_write))))))))));
  --cascaded wait assignment, which is an e_assign
  dma_arbiter_0_avalon_master_run <= r_1;
  --optimize select-logic by passing only those address bits which matter.
  internal_dma_arbiter_0_avalon_master_address_to_slave <= dma_arbiter_0_avalon_master_address(30 DOWNTO 0);
  --actual waitrequest port, which is an e_assign
  internal_dma_arbiter_0_avalon_master_waitrequest <= NOT dma_arbiter_0_avalon_master_run;
  --~dma_arbiter_0_avalon_master_reset assignment, which is an e_assign
  dma_arbiter_0_avalon_master_reset <= NOT reset_n;
  --vhdl renameroo for output signals
  dma_arbiter_0_avalon_master_address_to_slave <= internal_dma_arbiter_0_avalon_master_address_to_slave;
  --vhdl renameroo for output signals
  dma_arbiter_0_avalon_master_waitrequest <= internal_dma_arbiter_0_avalon_master_waitrequest;
--synthesis translate_off
    --dma_arbiter_0_avalon_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        dma_arbiter_0_avalon_master_address_last_time <= std_logic_vector'("0000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        dma_arbiter_0_avalon_master_address_last_time <= dma_arbiter_0_avalon_master_address;
      end if;

    end process;

    --dma_arbiter_0/avalon_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_dma_arbiter_0_avalon_master_waitrequest AND (dma_arbiter_0_avalon_master_write);
      end if;

    end process;

    --dma_arbiter_0_avalon_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((dma_arbiter_0_avalon_master_address /= dma_arbiter_0_avalon_master_address_last_time))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("dma_arbiter_0_avalon_master_address did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_burstcount check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        dma_arbiter_0_avalon_master_burstcount_last_time <= std_logic_vector'("0000000");
      elsif clk'event and clk = '1' then
        dma_arbiter_0_avalon_master_burstcount_last_time <= dma_arbiter_0_avalon_master_burstcount;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_burstcount matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((dma_arbiter_0_avalon_master_burstcount /= dma_arbiter_0_avalon_master_burstcount_last_time))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("dma_arbiter_0_avalon_master_burstcount did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        dma_arbiter_0_avalon_master_byteenable_last_time <= std_logic_vector'("00000000");
      elsif clk'event and clk = '1' then
        dma_arbiter_0_avalon_master_byteenable_last_time <= dma_arbiter_0_avalon_master_byteenable;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((dma_arbiter_0_avalon_master_byteenable /= dma_arbiter_0_avalon_master_byteenable_last_time))))) = '1' then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("dma_arbiter_0_avalon_master_byteenable did not heed wait!!!"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        dma_arbiter_0_avalon_master_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        dma_arbiter_0_avalon_master_write_last_time <= dma_arbiter_0_avalon_master_write;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(dma_arbiter_0_avalon_master_write) /= std_logic'(dma_arbiter_0_avalon_master_write_last_time)))))) = '1' then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("dma_arbiter_0_avalon_master_write did not heed wait!!!"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        dma_arbiter_0_avalon_master_writedata_last_time <= std_logic_vector'("0000000000000000000000000000000000000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        dma_arbiter_0_avalon_master_writedata_last_time <= dma_arbiter_0_avalon_master_writedata;
      end if;

    end process;

    --dma_arbiter_0_avalon_master_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line6 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((dma_arbiter_0_avalon_master_writedata /= dma_arbiter_0_avalon_master_writedata_last_time)))) AND dma_arbiter_0_avalon_master_write)) = '1' then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("dma_arbiter_0_avalon_master_writedata did not heed wait!!!"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dvb_dma_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal dvb_dma_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_dvb_dma_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal dvb_dma_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal dvb_dma_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal dvb_dma_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_dma_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal dvb_dma_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal dvb_dma_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity dvb_dma_0_avalon_slave_0_arbitrator;


architecture europa of dvb_dma_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_dvb_dma_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_dvb_dma_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT dvb_dma_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  dvb_dma_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0);
  --assign dvb_dma_0_avalon_slave_0_readdata_from_sa = dvb_dma_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  dvb_dma_0_avalon_slave_0_readdata_from_sa <= dvb_dma_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 6) & std_logic_vector'("000000")) = std_logic_vector'("100100100000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --dvb_dma_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  dvb_dma_0_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --dvb_dma_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  dvb_dma_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0;
  --dvb_dma_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  dvb_dma_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --dvb_dma_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  dvb_dma_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(dvb_dma_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_dma_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(dvb_dma_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_dma_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --dvb_dma_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  dvb_dma_0_avalon_slave_0_allgrants <= dvb_dma_0_avalon_slave_0_grant_vector;
  --dvb_dma_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  dvb_dma_0_avalon_slave_0_end_xfer <= NOT ((dvb_dma_0_avalon_slave_0_waits_for_read OR dvb_dma_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0 <= dvb_dma_0_avalon_slave_0_end_xfer AND (((NOT dvb_dma_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --dvb_dma_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  dvb_dma_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0 AND dvb_dma_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0 AND NOT dvb_dma_0_avalon_slave_0_non_bursting_master_requests));
  --dvb_dma_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_dma_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_dma_0_avalon_slave_0_arb_counter_enable) = '1' then 
        dvb_dma_0_avalon_slave_0_arb_share_counter <= dvb_dma_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --dvb_dma_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_dma_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((dvb_dma_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_dvb_dma_0_avalon_slave_0 AND NOT dvb_dma_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        dvb_dma_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(dvb_dma_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master dvb_dma_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= dvb_dma_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_dma_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  dvb_dma_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(dvb_dma_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master dvb_dma_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= dvb_dma_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_dma_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  dvb_dma_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0;
  --dvb_dma_0_avalon_slave_0_writedata mux, which is an e_mux
  dvb_dma_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant dvb_dma_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_dvb_dma_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0;
  --allow new arb cycle for dvb_dma_0/avalon_slave_0, which is an e_assign
  dvb_dma_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  dvb_dma_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  dvb_dma_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~dvb_dma_0_avalon_slave_0_reset assignment, which is an e_assign
  dvb_dma_0_avalon_slave_0_reset <= NOT reset_n;
  --dvb_dma_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  dvb_dma_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(dvb_dma_0_avalon_slave_0_begins_xfer) = '1'), dvb_dma_0_avalon_slave_0_unreg_firsttransfer, dvb_dma_0_avalon_slave_0_reg_firsttransfer);
  --dvb_dma_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  dvb_dma_0_avalon_slave_0_unreg_firsttransfer <= NOT ((dvb_dma_0_avalon_slave_0_slavearbiterlockenable AND dvb_dma_0_avalon_slave_0_any_continuerequest));
  --dvb_dma_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_dma_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_dma_0_avalon_slave_0_begins_xfer) = '1' then 
        dvb_dma_0_avalon_slave_0_reg_firsttransfer <= dvb_dma_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --dvb_dma_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  dvb_dma_0_avalon_slave_0_beginbursttransfer_internal <= dvb_dma_0_avalon_slave_0_begins_xfer;
  --dvb_dma_0_avalon_slave_0_write assignment, which is an e_mux
  dvb_dma_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_dvb_dma_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --dvb_dma_0_avalon_slave_0_address mux, which is an e_mux
  dvb_dma_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_dvb_dma_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 4);
  --d1_dvb_dma_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_dvb_dma_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_dvb_dma_0_avalon_slave_0_end_xfer <= dvb_dma_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --dvb_dma_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  dvb_dma_0_avalon_slave_0_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(dvb_dma_0_avalon_slave_0_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --dvb_dma_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  dvb_dma_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= dvb_dma_0_avalon_slave_0_in_a_read_cycle;
  --dvb_dma_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  dvb_dma_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(dvb_dma_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --dvb_dma_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  dvb_dma_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= dvb_dma_0_avalon_slave_0_in_a_write_cycle;
  wait_for_dvb_dma_0_avalon_slave_0_counter <= std_logic'('0');
  --dvb_dma_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  dvb_dma_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0;
--synthesis translate_off
    --dvb_dma_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dvb_dma_1_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal dvb_dma_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_dvb_dma_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal dvb_dma_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal dvb_dma_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal dvb_dma_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_dma_1_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal dvb_dma_1_avalon_slave_0_write : OUT STD_LOGIC;
                 signal dvb_dma_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC
              );
end entity dvb_dma_1_avalon_slave_0_arbitrator;


architecture europa of dvb_dma_1_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_allgrants :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_dvb_dma_1_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_dvb_dma_1_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT dvb_dma_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  dvb_dma_1_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0);
  --assign dvb_dma_1_avalon_slave_0_readdata_from_sa = dvb_dma_1_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  dvb_dma_1_avalon_slave_0_readdata_from_sa <= dvb_dma_1_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 6) & std_logic_vector'("000000")) = std_logic_vector'("100100101000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --dvb_dma_1_avalon_slave_0_arb_share_counter set values, which is an e_mux
  dvb_dma_1_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --dvb_dma_1_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  dvb_dma_1_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0;
  --dvb_dma_1_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  dvb_dma_1_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --dvb_dma_1_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  dvb_dma_1_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(dvb_dma_1_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_dma_1_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(dvb_dma_1_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_dma_1_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --dvb_dma_1_avalon_slave_0_allgrants all slave grants, which is an e_mux
  dvb_dma_1_avalon_slave_0_allgrants <= dvb_dma_1_avalon_slave_0_grant_vector;
  --dvb_dma_1_avalon_slave_0_end_xfer assignment, which is an e_assign
  dvb_dma_1_avalon_slave_0_end_xfer <= NOT ((dvb_dma_1_avalon_slave_0_waits_for_read OR dvb_dma_1_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0 <= dvb_dma_1_avalon_slave_0_end_xfer AND (((NOT dvb_dma_1_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --dvb_dma_1_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  dvb_dma_1_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0 AND dvb_dma_1_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0 AND NOT dvb_dma_1_avalon_slave_0_non_bursting_master_requests));
  --dvb_dma_1_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_dma_1_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_dma_1_avalon_slave_0_arb_counter_enable) = '1' then 
        dvb_dma_1_avalon_slave_0_arb_share_counter <= dvb_dma_1_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --dvb_dma_1_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_dma_1_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((dvb_dma_1_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_dvb_dma_1_avalon_slave_0 AND NOT dvb_dma_1_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        dvb_dma_1_avalon_slave_0_slavearbiterlockenable <= or_reduce(dvb_dma_1_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master dvb_dma_1/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= dvb_dma_1_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_dma_1_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  dvb_dma_1_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(dvb_dma_1_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master dvb_dma_1/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= dvb_dma_1_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_dma_1_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  dvb_dma_1_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0;
  --dvb_dma_1_avalon_slave_0_writedata mux, which is an e_mux
  dvb_dma_1_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant dvb_dma_1/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_dvb_dma_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0;
  --allow new arb cycle for dvb_dma_1/avalon_slave_0, which is an e_assign
  dvb_dma_1_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  dvb_dma_1_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  dvb_dma_1_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~dvb_dma_1_avalon_slave_0_reset assignment, which is an e_assign
  dvb_dma_1_avalon_slave_0_reset <= NOT reset_n;
  --dvb_dma_1_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  dvb_dma_1_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(dvb_dma_1_avalon_slave_0_begins_xfer) = '1'), dvb_dma_1_avalon_slave_0_unreg_firsttransfer, dvb_dma_1_avalon_slave_0_reg_firsttransfer);
  --dvb_dma_1_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  dvb_dma_1_avalon_slave_0_unreg_firsttransfer <= NOT ((dvb_dma_1_avalon_slave_0_slavearbiterlockenable AND dvb_dma_1_avalon_slave_0_any_continuerequest));
  --dvb_dma_1_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_dma_1_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_dma_1_avalon_slave_0_begins_xfer) = '1' then 
        dvb_dma_1_avalon_slave_0_reg_firsttransfer <= dvb_dma_1_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --dvb_dma_1_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  dvb_dma_1_avalon_slave_0_beginbursttransfer_internal <= dvb_dma_1_avalon_slave_0_begins_xfer;
  --dvb_dma_1_avalon_slave_0_write assignment, which is an e_mux
  dvb_dma_1_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_dvb_dma_1_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --dvb_dma_1_avalon_slave_0_address mux, which is an e_mux
  dvb_dma_1_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_dvb_dma_1_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 4);
  --d1_dvb_dma_1_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_dvb_dma_1_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_dvb_dma_1_avalon_slave_0_end_xfer <= dvb_dma_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  --dvb_dma_1_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  dvb_dma_1_avalon_slave_0_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(dvb_dma_1_avalon_slave_0_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --dvb_dma_1_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  dvb_dma_1_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= dvb_dma_1_avalon_slave_0_in_a_read_cycle;
  --dvb_dma_1_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  dvb_dma_1_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(dvb_dma_1_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --dvb_dma_1_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  dvb_dma_1_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= dvb_dma_1_avalon_slave_0_in_a_write_cycle;
  wait_for_dvb_dma_1_avalon_slave_0_counter <= std_logic'('0');
  --dvb_dma_1_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  dvb_dma_1_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0;
--synthesis translate_off
    --dvb_dma_1/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dvb_ts_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal dvb_ts_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_dvb_ts_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal dvb_ts_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal dvb_ts_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal dvb_ts_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal dvb_ts_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal dvb_ts_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal dvb_ts_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal dvb_ts_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity dvb_ts_0_avalon_slave_0_arbitrator;


architecture europa of dvb_ts_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_dvb_ts_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_dvb_ts_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_dvb_ts_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT dvb_ts_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  dvb_ts_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0);
  --assign dvb_ts_0_avalon_slave_0_readdata_from_sa = dvb_ts_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  dvb_ts_0_avalon_slave_0_readdata_from_sa <= dvb_ts_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("101000000000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign dvb_ts_0_avalon_slave_0_waitrequest_from_sa = dvb_ts_0_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_dvb_ts_0_avalon_slave_0_waitrequest_from_sa <= dvb_ts_0_avalon_slave_0_waitrequest;
  --dvb_ts_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  dvb_ts_0_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --dvb_ts_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  dvb_ts_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0;
  --dvb_ts_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  dvb_ts_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --dvb_ts_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  dvb_ts_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(dvb_ts_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_ts_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(dvb_ts_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_ts_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --dvb_ts_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  dvb_ts_0_avalon_slave_0_allgrants <= dvb_ts_0_avalon_slave_0_grant_vector;
  --dvb_ts_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  dvb_ts_0_avalon_slave_0_end_xfer <= NOT ((dvb_ts_0_avalon_slave_0_waits_for_read OR dvb_ts_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0 <= dvb_ts_0_avalon_slave_0_end_xfer AND (((NOT dvb_ts_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --dvb_ts_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  dvb_ts_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0 AND dvb_ts_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0 AND NOT dvb_ts_0_avalon_slave_0_non_bursting_master_requests));
  --dvb_ts_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_ts_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_ts_0_avalon_slave_0_arb_counter_enable) = '1' then 
        dvb_ts_0_avalon_slave_0_arb_share_counter <= dvb_ts_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --dvb_ts_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_ts_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((dvb_ts_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_dvb_ts_0_avalon_slave_0 AND NOT dvb_ts_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        dvb_ts_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(dvb_ts_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master dvb_ts_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= dvb_ts_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_ts_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  dvb_ts_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(dvb_ts_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master dvb_ts_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= dvb_ts_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_ts_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  dvb_ts_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0;
  --dvb_ts_0_avalon_slave_0_writedata mux, which is an e_mux
  dvb_ts_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant dvb_ts_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_dvb_ts_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0;
  --allow new arb cycle for dvb_ts_0/avalon_slave_0, which is an e_assign
  dvb_ts_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  dvb_ts_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  dvb_ts_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~dvb_ts_0_avalon_slave_0_reset assignment, which is an e_assign
  dvb_ts_0_avalon_slave_0_reset <= NOT reset_n;
  --dvb_ts_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  dvb_ts_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(dvb_ts_0_avalon_slave_0_begins_xfer) = '1'), dvb_ts_0_avalon_slave_0_unreg_firsttransfer, dvb_ts_0_avalon_slave_0_reg_firsttransfer);
  --dvb_ts_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  dvb_ts_0_avalon_slave_0_unreg_firsttransfer <= NOT ((dvb_ts_0_avalon_slave_0_slavearbiterlockenable AND dvb_ts_0_avalon_slave_0_any_continuerequest));
  --dvb_ts_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_ts_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_ts_0_avalon_slave_0_begins_xfer) = '1' then 
        dvb_ts_0_avalon_slave_0_reg_firsttransfer <= dvb_ts_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --dvb_ts_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  dvb_ts_0_avalon_slave_0_beginbursttransfer_internal <= dvb_ts_0_avalon_slave_0_begins_xfer;
  --dvb_ts_0_avalon_slave_0_read assignment, which is an e_mux
  dvb_ts_0_avalon_slave_0_read <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --dvb_ts_0_avalon_slave_0_write assignment, which is an e_mux
  dvb_ts_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_dvb_ts_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --dvb_ts_0_avalon_slave_0_address mux, which is an e_mux
  dvb_ts_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_dvb_ts_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 9);
  --d1_dvb_ts_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_dvb_ts_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_dvb_ts_0_avalon_slave_0_end_xfer <= dvb_ts_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --dvb_ts_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  dvb_ts_0_avalon_slave_0_waits_for_read <= dvb_ts_0_avalon_slave_0_in_a_read_cycle AND internal_dvb_ts_0_avalon_slave_0_waitrequest_from_sa;
  --dvb_ts_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  dvb_ts_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= dvb_ts_0_avalon_slave_0_in_a_read_cycle;
  --dvb_ts_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  dvb_ts_0_avalon_slave_0_waits_for_write <= dvb_ts_0_avalon_slave_0_in_a_write_cycle AND internal_dvb_ts_0_avalon_slave_0_waitrequest_from_sa;
  --dvb_ts_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  dvb_ts_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= dvb_ts_0_avalon_slave_0_in_a_write_cycle;
  wait_for_dvb_ts_0_avalon_slave_0_counter <= std_logic'('0');
  --dvb_ts_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  dvb_ts_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  dvb_ts_0_avalon_slave_0_waitrequest_from_sa <= internal_dvb_ts_0_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0;
--synthesis translate_off
    --dvb_ts_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dvb_ts_1_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_1_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_dvb_ts_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal dvb_ts_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal dvb_ts_1_avalon_slave_0_read : OUT STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_1_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_write : OUT STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC
              );
end entity dvb_ts_1_avalon_slave_0_arbitrator;


architecture europa of dvb_ts_1_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_allgrants :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_dvb_ts_1_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_dvb_ts_1_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_dvb_ts_1_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT dvb_ts_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  dvb_ts_1_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0);
  --assign dvb_ts_1_avalon_slave_0_readdata_from_sa = dvb_ts_1_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  dvb_ts_1_avalon_slave_0_readdata_from_sa <= dvb_ts_1_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("101100000000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign dvb_ts_1_avalon_slave_0_waitrequest_from_sa = dvb_ts_1_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_dvb_ts_1_avalon_slave_0_waitrequest_from_sa <= dvb_ts_1_avalon_slave_0_waitrequest;
  --dvb_ts_1_avalon_slave_0_arb_share_counter set values, which is an e_mux
  dvb_ts_1_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --dvb_ts_1_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  dvb_ts_1_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0;
  --dvb_ts_1_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  dvb_ts_1_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --dvb_ts_1_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  dvb_ts_1_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(dvb_ts_1_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_ts_1_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(dvb_ts_1_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (dvb_ts_1_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --dvb_ts_1_avalon_slave_0_allgrants all slave grants, which is an e_mux
  dvb_ts_1_avalon_slave_0_allgrants <= dvb_ts_1_avalon_slave_0_grant_vector;
  --dvb_ts_1_avalon_slave_0_end_xfer assignment, which is an e_assign
  dvb_ts_1_avalon_slave_0_end_xfer <= NOT ((dvb_ts_1_avalon_slave_0_waits_for_read OR dvb_ts_1_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0 <= dvb_ts_1_avalon_slave_0_end_xfer AND (((NOT dvb_ts_1_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --dvb_ts_1_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  dvb_ts_1_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0 AND dvb_ts_1_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0 AND NOT dvb_ts_1_avalon_slave_0_non_bursting_master_requests));
  --dvb_ts_1_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_ts_1_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_ts_1_avalon_slave_0_arb_counter_enable) = '1' then 
        dvb_ts_1_avalon_slave_0_arb_share_counter <= dvb_ts_1_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --dvb_ts_1_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_ts_1_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((dvb_ts_1_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_dvb_ts_1_avalon_slave_0 AND NOT dvb_ts_1_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        dvb_ts_1_avalon_slave_0_slavearbiterlockenable <= or_reduce(dvb_ts_1_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master dvb_ts_1/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= dvb_ts_1_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_ts_1_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  dvb_ts_1_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(dvb_ts_1_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master dvb_ts_1/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= dvb_ts_1_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --dvb_ts_1_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  dvb_ts_1_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0;
  --dvb_ts_1_avalon_slave_0_writedata mux, which is an e_mux
  dvb_ts_1_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant dvb_ts_1/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_dvb_ts_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0;
  --allow new arb cycle for dvb_ts_1/avalon_slave_0, which is an e_assign
  dvb_ts_1_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  dvb_ts_1_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  dvb_ts_1_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~dvb_ts_1_avalon_slave_0_reset assignment, which is an e_assign
  dvb_ts_1_avalon_slave_0_reset <= NOT reset_n;
  --dvb_ts_1_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  dvb_ts_1_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(dvb_ts_1_avalon_slave_0_begins_xfer) = '1'), dvb_ts_1_avalon_slave_0_unreg_firsttransfer, dvb_ts_1_avalon_slave_0_reg_firsttransfer);
  --dvb_ts_1_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  dvb_ts_1_avalon_slave_0_unreg_firsttransfer <= NOT ((dvb_ts_1_avalon_slave_0_slavearbiterlockenable AND dvb_ts_1_avalon_slave_0_any_continuerequest));
  --dvb_ts_1_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dvb_ts_1_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(dvb_ts_1_avalon_slave_0_begins_xfer) = '1' then 
        dvb_ts_1_avalon_slave_0_reg_firsttransfer <= dvb_ts_1_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --dvb_ts_1_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  dvb_ts_1_avalon_slave_0_beginbursttransfer_internal <= dvb_ts_1_avalon_slave_0_begins_xfer;
  --dvb_ts_1_avalon_slave_0_read assignment, which is an e_mux
  dvb_ts_1_avalon_slave_0_read <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --dvb_ts_1_avalon_slave_0_write assignment, which is an e_mux
  dvb_ts_1_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_dvb_ts_1_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --dvb_ts_1_avalon_slave_0_address mux, which is an e_mux
  dvb_ts_1_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_dvb_ts_1_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 9);
  --d1_dvb_ts_1_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_dvb_ts_1_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_dvb_ts_1_avalon_slave_0_end_xfer <= dvb_ts_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  --dvb_ts_1_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  dvb_ts_1_avalon_slave_0_waits_for_read <= dvb_ts_1_avalon_slave_0_in_a_read_cycle AND internal_dvb_ts_1_avalon_slave_0_waitrequest_from_sa;
  --dvb_ts_1_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  dvb_ts_1_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= dvb_ts_1_avalon_slave_0_in_a_read_cycle;
  --dvb_ts_1_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  dvb_ts_1_avalon_slave_0_waits_for_write <= dvb_ts_1_avalon_slave_0_in_a_write_cycle AND internal_dvb_ts_1_avalon_slave_0_waitrequest_from_sa;
  --dvb_ts_1_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  dvb_ts_1_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= dvb_ts_1_avalon_slave_0_in_a_write_cycle;
  wait_for_dvb_ts_1_avalon_slave_0_counter <= std_logic'('0');
  --dvb_ts_1_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  dvb_ts_1_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  dvb_ts_1_avalon_slave_0_waitrequest_from_sa <= internal_dvb_ts_1_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0;
--synthesis translate_off
    --dvb_ts_1/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_in_8b_sync_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal fifo_in_8b_sync_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal fifo_in_8b_sync_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_in_8b_sync_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity fifo_in_8b_sync_0_avalon_slave_0_arbitrator;


architecture europa of fifo_in_8b_sync_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_fifo_in_8b_sync_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_fifo_in_8b_sync_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT fifo_in_8b_sync_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  fifo_in_8b_sync_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0);
  --assign fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa = fifo_in_8b_sync_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa <= fifo_in_8b_sync_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100100000100000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa = fifo_in_8b_sync_0_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa <= fifo_in_8b_sync_0_avalon_slave_0_waitrequest;
  --fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --fifo_in_8b_sync_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0;
  --fifo_in_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(fifo_in_8b_sync_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_in_8b_sync_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --fifo_in_8b_sync_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_allgrants <= fifo_in_8b_sync_0_avalon_slave_0_grant_vector;
  --fifo_in_8b_sync_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_end_xfer <= NOT ((fifo_in_8b_sync_0_avalon_slave_0_waits_for_read OR fifo_in_8b_sync_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0 <= fifo_in_8b_sync_0_avalon_slave_0_end_xfer AND (((NOT fifo_in_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0 AND fifo_in_8b_sync_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0 AND NOT fifo_in_8b_sync_0_avalon_slave_0_non_bursting_master_requests));
  --fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_in_8b_sync_0_avalon_slave_0_arb_counter_enable) = '1' then 
        fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter <= fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((fifo_in_8b_sync_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_fifo_in_8b_sync_0_avalon_slave_0 AND NOT fifo_in_8b_sync_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master fifo_in_8b_sync_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(fifo_in_8b_sync_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master fifo_in_8b_sync_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_in_8b_sync_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0;
  --fifo_in_8b_sync_0_avalon_slave_0_writedata mux, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant fifo_in_8b_sync_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_fifo_in_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0;
  --allow new arb cycle for fifo_in_8b_sync_0/avalon_slave_0, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  fifo_in_8b_sync_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  fifo_in_8b_sync_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~fifo_in_8b_sync_0_avalon_slave_0_reset assignment, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_reset <= NOT reset_n;
  --fifo_in_8b_sync_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(fifo_in_8b_sync_0_avalon_slave_0_begins_xfer) = '1'), fifo_in_8b_sync_0_avalon_slave_0_unreg_firsttransfer, fifo_in_8b_sync_0_avalon_slave_0_reg_firsttransfer);
  --fifo_in_8b_sync_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_unreg_firsttransfer <= NOT ((fifo_in_8b_sync_0_avalon_slave_0_slavearbiterlockenable AND fifo_in_8b_sync_0_avalon_slave_0_any_continuerequest));
  --fifo_in_8b_sync_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_in_8b_sync_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_in_8b_sync_0_avalon_slave_0_begins_xfer) = '1' then 
        fifo_in_8b_sync_0_avalon_slave_0_reg_firsttransfer <= fifo_in_8b_sync_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --fifo_in_8b_sync_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_beginbursttransfer_internal <= fifo_in_8b_sync_0_avalon_slave_0_begins_xfer;
  --fifo_in_8b_sync_0_avalon_slave_0_read assignment, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_read <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --fifo_in_8b_sync_0_avalon_slave_0_write assignment, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_fifo_in_8b_sync_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --fifo_in_8b_sync_0_avalon_slave_0_address mux, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_fifo_in_8b_sync_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer <= fifo_in_8b_sync_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --fifo_in_8b_sync_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_waits_for_read <= fifo_in_8b_sync_0_avalon_slave_0_in_a_read_cycle AND internal_fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa;
  --fifo_in_8b_sync_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= fifo_in_8b_sync_0_avalon_slave_0_in_a_read_cycle;
  --fifo_in_8b_sync_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_waits_for_write <= fifo_in_8b_sync_0_avalon_slave_0_in_a_write_cycle AND internal_fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa;
  --fifo_in_8b_sync_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  fifo_in_8b_sync_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= fifo_in_8b_sync_0_avalon_slave_0_in_a_write_cycle;
  wait_for_fifo_in_8b_sync_0_avalon_slave_0_counter <= std_logic'('0');
  --fifo_in_8b_sync_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  fifo_in_8b_sync_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa <= internal_fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0;
--synthesis translate_off
    --fifo_in_8b_sync_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_in_8b_sync_0_avalon_streaming_sink_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_streaming_sink_ready : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal twi_master_0_avalon_streaming_source_valid : IN STD_LOGIC;

              -- outputs:
                 signal fifo_in_8b_sync_0_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_streaming_sink_valid : OUT STD_LOGIC
              );
end entity fifo_in_8b_sync_0_avalon_streaming_sink_arbitrator;


architecture europa of fifo_in_8b_sync_0_avalon_streaming_sink_arbitrator is

begin

  --mux fifo_in_8b_sync_0_avalon_streaming_sink_data, which is an e_mux
  fifo_in_8b_sync_0_avalon_streaming_sink_data <= twi_master_0_avalon_streaming_source_data;
  --assign fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa = fifo_in_8b_sync_0_avalon_streaming_sink_ready so that symbol knows where to group signals which may go to master only, which is an e_assign
  fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa <= fifo_in_8b_sync_0_avalon_streaming_sink_ready;
  --mux fifo_in_8b_sync_0_avalon_streaming_sink_valid, which is an e_mux
  fifo_in_8b_sync_0_avalon_streaming_sink_valid <= twi_master_0_avalon_streaming_source_valid;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_in_8b_sync_1_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal fifo_in_8b_sync_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal fifo_in_8b_sync_1_avalon_slave_0_read : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_in_8b_sync_1_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_write : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC
              );
end entity fifo_in_8b_sync_1_avalon_slave_0_arbitrator;


architecture europa of fifo_in_8b_sync_1_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_allgrants :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_fifo_in_8b_sync_1_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_fifo_in_8b_sync_1_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT fifo_in_8b_sync_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  fifo_in_8b_sync_1_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0);
  --assign fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa = fifo_in_8b_sync_1_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa <= fifo_in_8b_sync_1_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100100001100000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa = fifo_in_8b_sync_1_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa <= fifo_in_8b_sync_1_avalon_slave_0_waitrequest;
  --fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter set values, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --fifo_in_8b_sync_1_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0;
  --fifo_in_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(fifo_in_8b_sync_1_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_in_8b_sync_1_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --fifo_in_8b_sync_1_avalon_slave_0_allgrants all slave grants, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_allgrants <= fifo_in_8b_sync_1_avalon_slave_0_grant_vector;
  --fifo_in_8b_sync_1_avalon_slave_0_end_xfer assignment, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_end_xfer <= NOT ((fifo_in_8b_sync_1_avalon_slave_0_waits_for_read OR fifo_in_8b_sync_1_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0 <= fifo_in_8b_sync_1_avalon_slave_0_end_xfer AND (((NOT fifo_in_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0 AND fifo_in_8b_sync_1_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0 AND NOT fifo_in_8b_sync_1_avalon_slave_0_non_bursting_master_requests));
  --fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_in_8b_sync_1_avalon_slave_0_arb_counter_enable) = '1' then 
        fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter <= fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((fifo_in_8b_sync_1_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_fifo_in_8b_sync_1_avalon_slave_0 AND NOT fifo_in_8b_sync_1_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable <= or_reduce(fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master fifo_in_8b_sync_1/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(fifo_in_8b_sync_1_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master fifo_in_8b_sync_1/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_in_8b_sync_1_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0;
  --fifo_in_8b_sync_1_avalon_slave_0_writedata mux, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant fifo_in_8b_sync_1/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_fifo_in_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0;
  --allow new arb cycle for fifo_in_8b_sync_1/avalon_slave_0, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  fifo_in_8b_sync_1_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  fifo_in_8b_sync_1_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~fifo_in_8b_sync_1_avalon_slave_0_reset assignment, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_reset <= NOT reset_n;
  --fifo_in_8b_sync_1_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(fifo_in_8b_sync_1_avalon_slave_0_begins_xfer) = '1'), fifo_in_8b_sync_1_avalon_slave_0_unreg_firsttransfer, fifo_in_8b_sync_1_avalon_slave_0_reg_firsttransfer);
  --fifo_in_8b_sync_1_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_unreg_firsttransfer <= NOT ((fifo_in_8b_sync_1_avalon_slave_0_slavearbiterlockenable AND fifo_in_8b_sync_1_avalon_slave_0_any_continuerequest));
  --fifo_in_8b_sync_1_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_in_8b_sync_1_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_in_8b_sync_1_avalon_slave_0_begins_xfer) = '1' then 
        fifo_in_8b_sync_1_avalon_slave_0_reg_firsttransfer <= fifo_in_8b_sync_1_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --fifo_in_8b_sync_1_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_beginbursttransfer_internal <= fifo_in_8b_sync_1_avalon_slave_0_begins_xfer;
  --fifo_in_8b_sync_1_avalon_slave_0_read assignment, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_read <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --fifo_in_8b_sync_1_avalon_slave_0_write assignment, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_fifo_in_8b_sync_1_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --fifo_in_8b_sync_1_avalon_slave_0_address mux, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_fifo_in_8b_sync_1_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer <= fifo_in_8b_sync_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  --fifo_in_8b_sync_1_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_waits_for_read <= fifo_in_8b_sync_1_avalon_slave_0_in_a_read_cycle AND internal_fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa;
  --fifo_in_8b_sync_1_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= fifo_in_8b_sync_1_avalon_slave_0_in_a_read_cycle;
  --fifo_in_8b_sync_1_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_waits_for_write <= fifo_in_8b_sync_1_avalon_slave_0_in_a_write_cycle AND internal_fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa;
  --fifo_in_8b_sync_1_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  fifo_in_8b_sync_1_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= fifo_in_8b_sync_1_avalon_slave_0_in_a_write_cycle;
  wait_for_fifo_in_8b_sync_1_avalon_slave_0_counter <= std_logic'('0');
  --fifo_in_8b_sync_1_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  fifo_in_8b_sync_1_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa <= internal_fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0;
--synthesis translate_off
    --fifo_in_8b_sync_1/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_in_8b_sync_1_avalon_streaming_sink_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_streaming_sink_ready : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal twi_master_1_avalon_streaming_source_valid : IN STD_LOGIC;

              -- outputs:
                 signal fifo_in_8b_sync_1_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_streaming_sink_valid : OUT STD_LOGIC
              );
end entity fifo_in_8b_sync_1_avalon_streaming_sink_arbitrator;


architecture europa of fifo_in_8b_sync_1_avalon_streaming_sink_arbitrator is

begin

  --mux fifo_in_8b_sync_1_avalon_streaming_sink_data, which is an e_mux
  fifo_in_8b_sync_1_avalon_streaming_sink_data <= twi_master_1_avalon_streaming_source_data;
  --assign fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa = fifo_in_8b_sync_1_avalon_streaming_sink_ready so that symbol knows where to group signals which may go to master only, which is an e_assign
  fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa <= fifo_in_8b_sync_1_avalon_streaming_sink_ready;
  --mux fifo_in_8b_sync_1_avalon_streaming_sink_valid, which is an e_mux
  fifo_in_8b_sync_1_avalon_streaming_sink_valid <= twi_master_1_avalon_streaming_source_valid;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_out_8b_sync_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity fifo_out_8b_sync_0_avalon_slave_0_arbitrator;


architecture europa of fifo_out_8b_sync_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_fifo_out_8b_sync_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_fifo_out_8b_sync_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT fifo_out_8b_sync_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  fifo_out_8b_sync_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0);
  --assign fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa = fifo_out_8b_sync_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa <= fifo_out_8b_sync_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100100000010000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa = fifo_out_8b_sync_0_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa <= fifo_out_8b_sync_0_avalon_slave_0_waitrequest;
  --fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --fifo_out_8b_sync_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0;
  --fifo_out_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(fifo_out_8b_sync_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_out_8b_sync_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --fifo_out_8b_sync_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_allgrants <= fifo_out_8b_sync_0_avalon_slave_0_grant_vector;
  --fifo_out_8b_sync_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_end_xfer <= NOT ((fifo_out_8b_sync_0_avalon_slave_0_waits_for_read OR fifo_out_8b_sync_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0 <= fifo_out_8b_sync_0_avalon_slave_0_end_xfer AND (((NOT fifo_out_8b_sync_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0 AND fifo_out_8b_sync_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0 AND NOT fifo_out_8b_sync_0_avalon_slave_0_non_bursting_master_requests));
  --fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_out_8b_sync_0_avalon_slave_0_arb_counter_enable) = '1' then 
        fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter <= fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((fifo_out_8b_sync_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_fifo_out_8b_sync_0_avalon_slave_0 AND NOT fifo_out_8b_sync_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master fifo_out_8b_sync_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(fifo_out_8b_sync_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master fifo_out_8b_sync_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_out_8b_sync_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0;
  --fifo_out_8b_sync_0_avalon_slave_0_writedata mux, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant fifo_out_8b_sync_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_fifo_out_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0;
  --allow new arb cycle for fifo_out_8b_sync_0/avalon_slave_0, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  fifo_out_8b_sync_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  fifo_out_8b_sync_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~fifo_out_8b_sync_0_avalon_slave_0_reset assignment, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_reset <= NOT reset_n;
  --fifo_out_8b_sync_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(fifo_out_8b_sync_0_avalon_slave_0_begins_xfer) = '1'), fifo_out_8b_sync_0_avalon_slave_0_unreg_firsttransfer, fifo_out_8b_sync_0_avalon_slave_0_reg_firsttransfer);
  --fifo_out_8b_sync_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_unreg_firsttransfer <= NOT ((fifo_out_8b_sync_0_avalon_slave_0_slavearbiterlockenable AND fifo_out_8b_sync_0_avalon_slave_0_any_continuerequest));
  --fifo_out_8b_sync_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_out_8b_sync_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_out_8b_sync_0_avalon_slave_0_begins_xfer) = '1' then 
        fifo_out_8b_sync_0_avalon_slave_0_reg_firsttransfer <= fifo_out_8b_sync_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --fifo_out_8b_sync_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_beginbursttransfer_internal <= fifo_out_8b_sync_0_avalon_slave_0_begins_xfer;
  --fifo_out_8b_sync_0_avalon_slave_0_write assignment, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_fifo_out_8b_sync_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --fifo_out_8b_sync_0_avalon_slave_0_address mux, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_fifo_out_8b_sync_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer <= fifo_out_8b_sync_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --fifo_out_8b_sync_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_waits_for_read <= fifo_out_8b_sync_0_avalon_slave_0_in_a_read_cycle AND internal_fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa;
  --fifo_out_8b_sync_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= fifo_out_8b_sync_0_avalon_slave_0_in_a_read_cycle;
  --fifo_out_8b_sync_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_waits_for_write <= fifo_out_8b_sync_0_avalon_slave_0_in_a_write_cycle AND internal_fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa;
  --fifo_out_8b_sync_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  fifo_out_8b_sync_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= fifo_out_8b_sync_0_avalon_slave_0_in_a_write_cycle;
  wait_for_fifo_out_8b_sync_0_avalon_slave_0_counter <= std_logic'('0');
  --fifo_out_8b_sync_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  fifo_out_8b_sync_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa <= internal_fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0;
--synthesis translate_off
    --fifo_out_8b_sync_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_out_8b_sync_0_avalon_streaming_source_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_streaming_source_valid : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_0_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal fifo_out_8b_sync_0_avalon_streaming_source_ready : OUT STD_LOGIC
              );
end entity fifo_out_8b_sync_0_avalon_streaming_source_arbitrator;


architecture europa of fifo_out_8b_sync_0_avalon_streaming_source_arbitrator is

begin

  --mux fifo_out_8b_sync_0_avalon_streaming_source_ready, which is an e_mux
  fifo_out_8b_sync_0_avalon_streaming_source_ready <= twi_master_0_avalon_streaming_sink_ready_from_sa;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_out_8b_sync_1_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_slave_0_write : OUT STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC
              );
end entity fifo_out_8b_sync_1_avalon_slave_0_arbitrator;


architecture europa of fifo_out_8b_sync_1_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_allgrants :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_fifo_out_8b_sync_1_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_fifo_out_8b_sync_1_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT fifo_out_8b_sync_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  fifo_out_8b_sync_1_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0);
  --assign fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa = fifo_out_8b_sync_1_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa <= fifo_out_8b_sync_1_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100100001010000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa = fifo_out_8b_sync_1_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa <= fifo_out_8b_sync_1_avalon_slave_0_waitrequest;
  --fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter set values, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_arb_share_set_values <= std_logic_vector'("01");
  --fifo_out_8b_sync_1_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0;
  --fifo_out_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(fifo_out_8b_sync_1_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_out_8b_sync_1_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --fifo_out_8b_sync_1_avalon_slave_0_allgrants all slave grants, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_allgrants <= fifo_out_8b_sync_1_avalon_slave_0_grant_vector;
  --fifo_out_8b_sync_1_avalon_slave_0_end_xfer assignment, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_end_xfer <= NOT ((fifo_out_8b_sync_1_avalon_slave_0_waits_for_read OR fifo_out_8b_sync_1_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0 <= fifo_out_8b_sync_1_avalon_slave_0_end_xfer AND (((NOT fifo_out_8b_sync_1_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0 AND fifo_out_8b_sync_1_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0 AND NOT fifo_out_8b_sync_1_avalon_slave_0_non_bursting_master_requests));
  --fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_out_8b_sync_1_avalon_slave_0_arb_counter_enable) = '1' then 
        fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter <= fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((fifo_out_8b_sync_1_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_fifo_out_8b_sync_1_avalon_slave_0 AND NOT fifo_out_8b_sync_1_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable <= or_reduce(fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master fifo_out_8b_sync_1/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(fifo_out_8b_sync_1_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master fifo_out_8b_sync_1/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --fifo_out_8b_sync_1_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0;
  --fifo_out_8b_sync_1_avalon_slave_0_writedata mux, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant fifo_out_8b_sync_1/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_fifo_out_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0;
  --allow new arb cycle for fifo_out_8b_sync_1/avalon_slave_0, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  fifo_out_8b_sync_1_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  fifo_out_8b_sync_1_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~fifo_out_8b_sync_1_avalon_slave_0_reset assignment, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_reset <= NOT reset_n;
  --fifo_out_8b_sync_1_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(fifo_out_8b_sync_1_avalon_slave_0_begins_xfer) = '1'), fifo_out_8b_sync_1_avalon_slave_0_unreg_firsttransfer, fifo_out_8b_sync_1_avalon_slave_0_reg_firsttransfer);
  --fifo_out_8b_sync_1_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_unreg_firsttransfer <= NOT ((fifo_out_8b_sync_1_avalon_slave_0_slavearbiterlockenable AND fifo_out_8b_sync_1_avalon_slave_0_any_continuerequest));
  --fifo_out_8b_sync_1_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_out_8b_sync_1_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(fifo_out_8b_sync_1_avalon_slave_0_begins_xfer) = '1' then 
        fifo_out_8b_sync_1_avalon_slave_0_reg_firsttransfer <= fifo_out_8b_sync_1_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --fifo_out_8b_sync_1_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_beginbursttransfer_internal <= fifo_out_8b_sync_1_avalon_slave_0_begins_xfer;
  --fifo_out_8b_sync_1_avalon_slave_0_write assignment, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_fifo_out_8b_sync_1_avalon_slave_0_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --fifo_out_8b_sync_1_avalon_slave_0_address mux, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_fifo_out_8b_sync_1_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer <= fifo_out_8b_sync_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  --fifo_out_8b_sync_1_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_waits_for_read <= fifo_out_8b_sync_1_avalon_slave_0_in_a_read_cycle AND internal_fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa;
  --fifo_out_8b_sync_1_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= fifo_out_8b_sync_1_avalon_slave_0_in_a_read_cycle;
  --fifo_out_8b_sync_1_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_waits_for_write <= fifo_out_8b_sync_1_avalon_slave_0_in_a_write_cycle AND internal_fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa;
  --fifo_out_8b_sync_1_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  fifo_out_8b_sync_1_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= fifo_out_8b_sync_1_avalon_slave_0_in_a_write_cycle;
  wait_for_fifo_out_8b_sync_1_avalon_slave_0_counter <= std_logic'('0');
  --fifo_out_8b_sync_1_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  fifo_out_8b_sync_1_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa <= internal_fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0;
--synthesis translate_off
    --fifo_out_8b_sync_1/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fifo_out_8b_sync_1_avalon_streaming_source_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_streaming_source_valid : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_1_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal fifo_out_8b_sync_1_avalon_streaming_source_ready : OUT STD_LOGIC
              );
end entity fifo_out_8b_sync_1_avalon_streaming_source_arbitrator;


architecture europa of fifo_out_8b_sync_1_avalon_streaming_source_arbitrator is

begin

  --mux fifo_out_8b_sync_1_avalon_streaming_source_ready, which is an e_mux
  fifo_out_8b_sync_1_avalon_streaming_source_ready <= twi_master_1_avalon_streaming_sink_ready_from_sa;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity gpout_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal gpout_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_gpout_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal gpout_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal gpout_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal gpout_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal gpout_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal gpout_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal gpout_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 : OUT STD_LOGIC
              );
end entity gpout_0_avalon_slave_0_arbitrator;


architecture europa of gpout_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal gpout_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal gpout_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal gpout_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_gpout_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_gpout_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT gpout_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  gpout_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0);
  --assign gpout_0_avalon_slave_0_readdata_from_sa = gpout_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  gpout_0_avalon_slave_0_readdata_from_sa <= gpout_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100100010000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --gpout_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  gpout_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --gpout_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  gpout_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0;
  --gpout_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  gpout_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --gpout_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  gpout_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(gpout_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (gpout_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(gpout_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (gpout_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --gpout_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  gpout_0_avalon_slave_0_allgrants <= gpout_0_avalon_slave_0_grant_vector;
  --gpout_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  gpout_0_avalon_slave_0_end_xfer <= NOT ((gpout_0_avalon_slave_0_waits_for_read OR gpout_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0 <= gpout_0_avalon_slave_0_end_xfer AND (((NOT gpout_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --gpout_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  gpout_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0 AND gpout_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0 AND NOT gpout_0_avalon_slave_0_non_bursting_master_requests));
  --gpout_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      gpout_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(gpout_0_avalon_slave_0_arb_counter_enable) = '1' then 
        gpout_0_avalon_slave_0_arb_share_counter <= gpout_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --gpout_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      gpout_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((gpout_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_gpout_0_avalon_slave_0 AND NOT gpout_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        gpout_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(gpout_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master gpout_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= gpout_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --gpout_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  gpout_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(gpout_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master gpout_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= gpout_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --gpout_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  gpout_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 AND NOT (((NOT(or_reduce(internal_int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0))) AND int_ctrl_0_avalon_master_write));
  --gpout_0_avalon_slave_0_writedata mux, which is an e_mux
  gpout_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_dbs_write_16;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant gpout_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0;
  --allow new arb cycle for gpout_0/avalon_slave_0, which is an e_assign
  gpout_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  gpout_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  gpout_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~gpout_0_avalon_slave_0_reset assignment, which is an e_assign
  gpout_0_avalon_slave_0_reset <= NOT reset_n;
  --gpout_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  gpout_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(gpout_0_avalon_slave_0_begins_xfer) = '1'), gpout_0_avalon_slave_0_unreg_firsttransfer, gpout_0_avalon_slave_0_reg_firsttransfer);
  --gpout_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  gpout_0_avalon_slave_0_unreg_firsttransfer <= NOT ((gpout_0_avalon_slave_0_slavearbiterlockenable AND gpout_0_avalon_slave_0_any_continuerequest));
  --gpout_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      gpout_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(gpout_0_avalon_slave_0_begins_xfer) = '1' then 
        gpout_0_avalon_slave_0_reg_firsttransfer <= gpout_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --gpout_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  gpout_0_avalon_slave_0_beginbursttransfer_internal <= gpout_0_avalon_slave_0_begins_xfer;
  --gpout_0_avalon_slave_0_write assignment, which is an e_mux
  gpout_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_gpout_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= A_EXT (Std_Logic_Vector'(A_SRL(int_ctrl_0_avalon_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(int_ctrl_0_avalon_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 15);
  --gpout_0_avalon_slave_0_address mux, which is an e_mux
  gpout_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_gpout_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000001")), 2);
  --d1_gpout_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_gpout_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_gpout_0_avalon_slave_0_end_xfer <= gpout_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --gpout_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  gpout_0_avalon_slave_0_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(gpout_0_avalon_slave_0_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --gpout_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  gpout_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= gpout_0_avalon_slave_0_in_a_read_cycle;
  --gpout_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  gpout_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(gpout_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --gpout_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  gpout_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= gpout_0_avalon_slave_0_in_a_write_cycle;
  wait_for_gpout_0_avalon_slave_0_counter <= std_logic'('0');
  --gpout_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  gpout_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_1(1), int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_1(0), int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_0(1), int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_0(0)) <= int_ctrl_0_avalon_master_byteenable;
  internal_int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_0, int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0;
--synthesis translate_off
    --gpout_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity int_ctrl_0_avalon_cra_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_cra_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_int_ctrl_0_avalon_cra_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_cra_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_cra_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_cra_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_cra_write : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_cra_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra : OUT STD_LOGIC
              );
end entity int_ctrl_0_avalon_cra_arbitrator;


architecture europa of int_ctrl_0_avalon_cra_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_allgrants :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_allow_new_arb_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_any_bursting_master_saved_grant :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_any_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_arb_counter_enable :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_beginbursttransfer_internal :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_begins_xfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_end_xfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_firsttransfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_grant_vector :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_in_a_read_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_master_qreq_vector :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_non_bursting_master_requests :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_reg_firsttransfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_slavearbiterlockenable :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_slavearbiterlockenable2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_unreg_firsttransfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_waits_for_read :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_waits_for_write :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal shifted_address_to_int_ctrl_0_avalon_cra_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_int_ctrl_0_avalon_cra_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT int_ctrl_0_avalon_cra_end_xfer;
    end if;

  end process;

  int_ctrl_0_avalon_cra_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra);
  --assign int_ctrl_0_avalon_cra_readdata_from_sa = int_ctrl_0_avalon_cra_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  int_ctrl_0_avalon_cra_readdata_from_sa <= int_ctrl_0_avalon_cra_readdata;
  internal_int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100100010010000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --int_ctrl_0_avalon_cra_arb_share_counter set values, which is an e_mux
  int_ctrl_0_avalon_cra_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --int_ctrl_0_avalon_cra_non_bursting_master_requests mux, which is an e_mux
  int_ctrl_0_avalon_cra_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra;
  --int_ctrl_0_avalon_cra_any_bursting_master_saved_grant mux, which is an e_mux
  int_ctrl_0_avalon_cra_any_bursting_master_saved_grant <= std_logic'('0');
  --int_ctrl_0_avalon_cra_arb_share_counter_next_value assignment, which is an e_assign
  int_ctrl_0_avalon_cra_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(int_ctrl_0_avalon_cra_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (int_ctrl_0_avalon_cra_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(int_ctrl_0_avalon_cra_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (int_ctrl_0_avalon_cra_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --int_ctrl_0_avalon_cra_allgrants all slave grants, which is an e_mux
  int_ctrl_0_avalon_cra_allgrants <= int_ctrl_0_avalon_cra_grant_vector;
  --int_ctrl_0_avalon_cra_end_xfer assignment, which is an e_assign
  int_ctrl_0_avalon_cra_end_xfer <= NOT ((int_ctrl_0_avalon_cra_waits_for_read OR int_ctrl_0_avalon_cra_waits_for_write));
  --end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra <= int_ctrl_0_avalon_cra_end_xfer AND (((NOT int_ctrl_0_avalon_cra_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --int_ctrl_0_avalon_cra_arb_share_counter arbitration counter enable, which is an e_assign
  int_ctrl_0_avalon_cra_arb_counter_enable <= ((end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra AND int_ctrl_0_avalon_cra_allgrants)) OR ((end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra AND NOT int_ctrl_0_avalon_cra_non_bursting_master_requests));
  --int_ctrl_0_avalon_cra_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      int_ctrl_0_avalon_cra_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(int_ctrl_0_avalon_cra_arb_counter_enable) = '1' then 
        int_ctrl_0_avalon_cra_arb_share_counter <= int_ctrl_0_avalon_cra_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --int_ctrl_0_avalon_cra_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      int_ctrl_0_avalon_cra_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((int_ctrl_0_avalon_cra_master_qreq_vector AND end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra)) OR ((end_xfer_arb_share_counter_term_int_ctrl_0_avalon_cra AND NOT int_ctrl_0_avalon_cra_non_bursting_master_requests)))) = '1' then 
        int_ctrl_0_avalon_cra_slavearbiterlockenable <= or_reduce(int_ctrl_0_avalon_cra_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master int_ctrl_0/avalon_cra arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= int_ctrl_0_avalon_cra_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --int_ctrl_0_avalon_cra_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_cra_slavearbiterlockenable2 <= or_reduce(int_ctrl_0_avalon_cra_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master int_ctrl_0/avalon_cra arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= int_ctrl_0_avalon_cra_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --int_ctrl_0_avalon_cra_any_continuerequest at least one master continues requesting, which is an e_assign
  int_ctrl_0_avalon_cra_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra AND NOT (((NOT(or_reduce(internal_int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra))) AND int_ctrl_0_avalon_master_write));
  --int_ctrl_0_avalon_cra_writedata mux, which is an e_mux
  int_ctrl_0_avalon_cra_writedata <= int_ctrl_0_avalon_master_dbs_write_16;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra;
  --int_ctrl_0/avalon_master saved-grant int_ctrl_0/avalon_cra, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra;
  --allow new arb cycle for int_ctrl_0/avalon_cra, which is an e_assign
  int_ctrl_0_avalon_cra_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  int_ctrl_0_avalon_cra_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  int_ctrl_0_avalon_cra_master_qreq_vector <= std_logic'('1');
  --int_ctrl_0_avalon_cra_firsttransfer first transaction, which is an e_assign
  int_ctrl_0_avalon_cra_firsttransfer <= A_WE_StdLogic((std_logic'(int_ctrl_0_avalon_cra_begins_xfer) = '1'), int_ctrl_0_avalon_cra_unreg_firsttransfer, int_ctrl_0_avalon_cra_reg_firsttransfer);
  --int_ctrl_0_avalon_cra_unreg_firsttransfer first transaction, which is an e_assign
  int_ctrl_0_avalon_cra_unreg_firsttransfer <= NOT ((int_ctrl_0_avalon_cra_slavearbiterlockenable AND int_ctrl_0_avalon_cra_any_continuerequest));
  --int_ctrl_0_avalon_cra_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      int_ctrl_0_avalon_cra_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(int_ctrl_0_avalon_cra_begins_xfer) = '1' then 
        int_ctrl_0_avalon_cra_reg_firsttransfer <= int_ctrl_0_avalon_cra_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --int_ctrl_0_avalon_cra_beginbursttransfer_internal begin burst transfer, which is an e_assign
  int_ctrl_0_avalon_cra_beginbursttransfer_internal <= int_ctrl_0_avalon_cra_begins_xfer;
  --int_ctrl_0_avalon_cra_write assignment, which is an e_mux
  int_ctrl_0_avalon_cra_write <= internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra AND int_ctrl_0_avalon_master_write;
  shifted_address_to_int_ctrl_0_avalon_cra_from_int_ctrl_0_avalon_master <= A_EXT (Std_Logic_Vector'(A_SRL(int_ctrl_0_avalon_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(int_ctrl_0_avalon_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 15);
  --int_ctrl_0_avalon_cra_address mux, which is an e_mux
  int_ctrl_0_avalon_cra_address <= A_EXT (A_SRL(shifted_address_to_int_ctrl_0_avalon_cra_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000001")), 2);
  --d1_int_ctrl_0_avalon_cra_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_int_ctrl_0_avalon_cra_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_int_ctrl_0_avalon_cra_end_xfer <= int_ctrl_0_avalon_cra_end_xfer;
    end if;

  end process;

  --int_ctrl_0_avalon_cra_waits_for_read in a cycle, which is an e_mux
  int_ctrl_0_avalon_cra_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_cra_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --int_ctrl_0_avalon_cra_in_a_read_cycle assignment, which is an e_assign
  int_ctrl_0_avalon_cra_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= int_ctrl_0_avalon_cra_in_a_read_cycle;
  --int_ctrl_0_avalon_cra_waits_for_write in a cycle, which is an e_mux
  int_ctrl_0_avalon_cra_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_cra_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --int_ctrl_0_avalon_cra_in_a_write_cycle assignment, which is an e_assign
  int_ctrl_0_avalon_cra_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= int_ctrl_0_avalon_cra_in_a_write_cycle;
  wait_for_int_ctrl_0_avalon_cra_counter <= std_logic'('0');
  --int_ctrl_0_avalon_cra_byteenable byte enable port mux, which is an e_mux
  int_ctrl_0_avalon_cra_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_1(1), int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_1(0), int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_0(1), int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_0(0)) <= int_ctrl_0_avalon_master_byteenable;
  internal_int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_0, int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra <= internal_int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra;
--synthesis translate_off
    --int_ctrl_0/avalon_cra enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity int_ctrl_0_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_slave_waitrequest : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal pipeline_bridge_0_m1_burstcount : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pipeline_bridge_0_m1_chipselect : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_dbs_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal pipeline_bridge_0_m1_dbs_write_32 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pipeline_bridge_0_m1_latency_counter : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_read : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_int_ctrl_0_avalon_slave_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_address : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                 signal int_ctrl_0_avalon_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_slave_read : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_slave_reset : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_write : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave : OUT STD_LOGIC;
                 signal pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave : OUT STD_LOGIC;
                 signal pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave : OUT STD_LOGIC;
                 signal pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave : OUT STD_LOGIC
              );
end entity int_ctrl_0_avalon_slave_arbitrator;


architecture europa of int_ctrl_0_avalon_slave_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_allgrants :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_begins_xfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_end_xfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_firsttransfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_grant_vector :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_waits_for_read :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_waits_for_write :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_slave_waitrequest_from_sa :  STD_LOGIC;
                signal internal_pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal internal_pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal pipeline_bridge_0_m1_arbiterlock :  STD_LOGIC;
                signal pipeline_bridge_0_m1_arbiterlock2 :  STD_LOGIC;
                signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_0 :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_1 :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal pipeline_bridge_0_m1_continuerequest :  STD_LOGIC;
                signal pipeline_bridge_0_m1_saved_grant_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_int_ctrl_0_avalon_slave_from_pipeline_bridge_0_m1 :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_int_ctrl_0_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT int_ctrl_0_avalon_slave_end_xfer;
    end if;

  end process;

  int_ctrl_0_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave);
  --assign int_ctrl_0_avalon_slave_readdata_from_sa = int_ctrl_0_avalon_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  int_ctrl_0_avalon_slave_readdata_from_sa <= int_ctrl_0_avalon_slave_readdata;
  internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pipeline_bridge_0_m1_chipselect)))));
  --assign int_ctrl_0_avalon_slave_waitrequest_from_sa = int_ctrl_0_avalon_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_int_ctrl_0_avalon_slave_waitrequest_from_sa <= int_ctrl_0_avalon_slave_waitrequest;
  --int_ctrl_0_avalon_slave_arb_share_counter set values, which is an e_mux
  int_ctrl_0_avalon_slave_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --int_ctrl_0_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  int_ctrl_0_avalon_slave_non_bursting_master_requests <= internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave;
  --int_ctrl_0_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  int_ctrl_0_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --int_ctrl_0_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  int_ctrl_0_avalon_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(int_ctrl_0_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (int_ctrl_0_avalon_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(int_ctrl_0_avalon_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (int_ctrl_0_avalon_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --int_ctrl_0_avalon_slave_allgrants all slave grants, which is an e_mux
  int_ctrl_0_avalon_slave_allgrants <= int_ctrl_0_avalon_slave_grant_vector;
  --int_ctrl_0_avalon_slave_end_xfer assignment, which is an e_assign
  int_ctrl_0_avalon_slave_end_xfer <= NOT ((int_ctrl_0_avalon_slave_waits_for_read OR int_ctrl_0_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave <= int_ctrl_0_avalon_slave_end_xfer AND (((NOT int_ctrl_0_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --int_ctrl_0_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  int_ctrl_0_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave AND int_ctrl_0_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave AND NOT int_ctrl_0_avalon_slave_non_bursting_master_requests));
  --int_ctrl_0_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      int_ctrl_0_avalon_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(int_ctrl_0_avalon_slave_arb_counter_enable) = '1' then 
        int_ctrl_0_avalon_slave_arb_share_counter <= int_ctrl_0_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --int_ctrl_0_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      int_ctrl_0_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((int_ctrl_0_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave)) OR ((end_xfer_arb_share_counter_term_int_ctrl_0_avalon_slave AND NOT int_ctrl_0_avalon_slave_non_bursting_master_requests)))) = '1' then 
        int_ctrl_0_avalon_slave_slavearbiterlockenable <= or_reduce(int_ctrl_0_avalon_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --pipeline_bridge_0/m1 int_ctrl_0/avalon_slave arbiterlock, which is an e_assign
  pipeline_bridge_0_m1_arbiterlock <= int_ctrl_0_avalon_slave_slavearbiterlockenable AND pipeline_bridge_0_m1_continuerequest;
  --int_ctrl_0_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_slave_slavearbiterlockenable2 <= or_reduce(int_ctrl_0_avalon_slave_arb_share_counter_next_value);
  --pipeline_bridge_0/m1 int_ctrl_0/avalon_slave arbiterlock2, which is an e_assign
  pipeline_bridge_0_m1_arbiterlock2 <= int_ctrl_0_avalon_slave_slavearbiterlockenable2 AND pipeline_bridge_0_m1_continuerequest;
  --int_ctrl_0_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  int_ctrl_0_avalon_slave_any_continuerequest <= std_logic'('1');
  --pipeline_bridge_0_m1_continuerequest continued request, which is an e_assign
  pipeline_bridge_0_m1_continuerequest <= std_logic'('1');
  internal_pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave AND NOT ((((((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect)) AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pipeline_bridge_0_m1_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))))) OR (((NOT(or_reduce(internal_pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave))) AND ((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect))))));
  --local readdatavalid pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave, which is an e_mux
  pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave <= (internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect))) AND NOT int_ctrl_0_avalon_slave_waits_for_read;
  --int_ctrl_0_avalon_slave_writedata mux, which is an e_mux
  int_ctrl_0_avalon_slave_writedata <= pipeline_bridge_0_m1_dbs_write_32;
  --master is always granted when requested
  internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave;
  --pipeline_bridge_0/m1 saved-grant int_ctrl_0/avalon_slave, which is an e_assign
  pipeline_bridge_0_m1_saved_grant_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave;
  --allow new arb cycle for int_ctrl_0/avalon_slave, which is an e_assign
  int_ctrl_0_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  int_ctrl_0_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  int_ctrl_0_avalon_slave_master_qreq_vector <= std_logic'('1');
  --~int_ctrl_0_avalon_slave_reset assignment, which is an e_assign
  int_ctrl_0_avalon_slave_reset <= NOT reset_n;
  --int_ctrl_0_avalon_slave_firsttransfer first transaction, which is an e_assign
  int_ctrl_0_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(int_ctrl_0_avalon_slave_begins_xfer) = '1'), int_ctrl_0_avalon_slave_unreg_firsttransfer, int_ctrl_0_avalon_slave_reg_firsttransfer);
  --int_ctrl_0_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  int_ctrl_0_avalon_slave_unreg_firsttransfer <= NOT ((int_ctrl_0_avalon_slave_slavearbiterlockenable AND int_ctrl_0_avalon_slave_any_continuerequest));
  --int_ctrl_0_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      int_ctrl_0_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(int_ctrl_0_avalon_slave_begins_xfer) = '1' then 
        int_ctrl_0_avalon_slave_reg_firsttransfer <= int_ctrl_0_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --int_ctrl_0_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  int_ctrl_0_avalon_slave_beginbursttransfer_internal <= int_ctrl_0_avalon_slave_begins_xfer;
  --int_ctrl_0_avalon_slave_read assignment, which is an e_mux
  int_ctrl_0_avalon_slave_read <= internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect));
  --int_ctrl_0_avalon_slave_write assignment, which is an e_mux
  int_ctrl_0_avalon_slave_write <= internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect));
  shifted_address_to_int_ctrl_0_avalon_slave_from_pipeline_bridge_0_m1 <= A_EXT (Std_Logic_Vector'(A_SRL(pipeline_bridge_0_m1_address_to_slave,std_logic_vector'("00000000000000000000000000000011")) & A_ToStdLogicVector(pipeline_bridge_0_m1_dbs_address(2)) & A_REP(std_logic'('0'), 2)), 15);
  --int_ctrl_0_avalon_slave_address mux, which is an e_mux
  int_ctrl_0_avalon_slave_address <= A_EXT (A_SRL(shifted_address_to_int_ctrl_0_avalon_slave_from_pipeline_bridge_0_m1,std_logic_vector'("00000000000000000000000000000010")), 13);
  --d1_int_ctrl_0_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_int_ctrl_0_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_int_ctrl_0_avalon_slave_end_xfer <= int_ctrl_0_avalon_slave_end_xfer;
    end if;

  end process;

  --int_ctrl_0_avalon_slave_waits_for_read in a cycle, which is an e_mux
  int_ctrl_0_avalon_slave_waits_for_read <= int_ctrl_0_avalon_slave_in_a_read_cycle AND internal_int_ctrl_0_avalon_slave_waitrequest_from_sa;
  --int_ctrl_0_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  int_ctrl_0_avalon_slave_in_a_read_cycle <= internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= int_ctrl_0_avalon_slave_in_a_read_cycle;
  --int_ctrl_0_avalon_slave_waits_for_write in a cycle, which is an e_mux
  int_ctrl_0_avalon_slave_waits_for_write <= int_ctrl_0_avalon_slave_in_a_write_cycle AND internal_int_ctrl_0_avalon_slave_waitrequest_from_sa;
  --int_ctrl_0_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  int_ctrl_0_avalon_slave_in_a_write_cycle <= internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect));
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= int_ctrl_0_avalon_slave_in_a_write_cycle;
  wait_for_int_ctrl_0_avalon_slave_counter <= std_logic'('0');
  --int_ctrl_0_avalon_slave_byteenable byte enable port mux, which is an e_mux
  int_ctrl_0_avalon_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (internal_pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  (pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_1(3), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_1(2), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_1(1), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_1(0), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_0(3), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_0(2), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_0(1), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_0(0)) <= pipeline_bridge_0_m1_byteenable;
  internal_pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pipeline_bridge_0_m1_dbs_address(2)))) = std_logic_vector'("00000000000000000000000000000000"))), pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_0, pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_slave_waitrequest_from_sa <= internal_int_ctrl_0_avalon_slave_waitrequest_from_sa;
  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave;
  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave;
  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave;
  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave <= internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave;
--synthesis translate_off
    --int_ctrl_0/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --pipeline_bridge_0/m1 non-zero burstcount assertion, which is an e_process
    process (clk)
    VARIABLE write_line7 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pipeline_bridge_0_m1_burstcount))) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("pipeline_bridge_0/m1 drove 0 on its 'burstcount' port while accessing slave int_ctrl_0/avalon_slave"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity int_ctrl_0_avalon_master_arbitrator is 
        port (
              -- inputs:
                 signal ci_bridge_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_ci_bridge_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_dvb_dma_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_dvb_dma_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_dvb_ts_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_dvb_ts_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_gpout_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_int_ctrl_0_avalon_cra_end_xfer : IN STD_LOGIC;
                 signal d1_pcie_compiler_0_Control_Register_Access_end_xfer : IN STD_LOGIC;
                 signal d1_spi_master_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_twi_master_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_twi_master_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal dvb_dma_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_dma_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal dvb_ts_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal dvb_ts_1_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal gpout_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_cra_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_waitrequest_from_sa : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal spi_master_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal spi_master_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal twi_master_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal twi_master_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal int_ctrl_0_avalon_master_address_to_slave : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_waitrequest : OUT STD_LOGIC
              );
end entity int_ctrl_0_avalon_master_arbitrator;


architecture europa of int_ctrl_0_avalon_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_address_last_time :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal int_ctrl_0_avalon_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_read_last_time :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_run :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_write_last_time :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_address_to_slave :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_waitrequest :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 OR (((int_ctrl_0_avalon_master_write AND NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0))) AND internal_int_ctrl_0_avalon_master_dbs_address(1)))) OR NOT int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT dvb_ts_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT dvb_ts_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT dvb_ts_1_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT dvb_ts_1_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")));
  --cascaded wait assignment, which is an e_assign
  int_ctrl_0_avalon_master_run <= (r_0 AND r_1) AND r_2;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 OR (((int_ctrl_0_avalon_master_write AND NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0))) AND internal_int_ctrl_0_avalon_master_dbs_address(1)))) OR NOT int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra OR (((int_ctrl_0_avalon_master_write AND NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra))) AND internal_int_ctrl_0_avalon_master_dbs_address(1)))) OR NOT int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra OR NOT int_ctrl_0_avalon_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra OR NOT int_ctrl_0_avalon_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT pcie_compiler_0_Control_Register_Access_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access OR NOT ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT pcie_compiler_0_Control_Register_Access_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 OR (((int_ctrl_0_avalon_master_write AND NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0))) AND internal_int_ctrl_0_avalon_master_dbs_address(1)))) OR NOT int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT spi_master_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT spi_master_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 OR (((int_ctrl_0_avalon_master_write AND NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0))) AND internal_int_ctrl_0_avalon_master_dbs_address(1)))) OR NOT int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 OR (((int_ctrl_0_avalon_master_write AND NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0))) AND internal_int_ctrl_0_avalon_master_dbs_address(1)))) OR NOT int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 OR NOT int_ctrl_0_avalon_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_int_ctrl_0_avalon_master_address_to_slave <= int_ctrl_0_avalon_master_address(14 DOWNTO 0);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((((((((((((((((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0))))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0)))))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra)))))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra AND int_ctrl_0_avalon_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra AND int_ctrl_0_avalon_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0)))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT spi_master_0_avalon_slave_0_waitrequest_from_sa)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT spi_master_0_avalon_slave_0_waitrequest_from_sa)))))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0)))))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0)))))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))));
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0)) = '1'), ci_bridge_0_avalon_slave_0_readdata_from_sa, A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0)) = '1'), gpout_0_avalon_slave_0_readdata_from_sa, A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra)) = '1'), int_ctrl_0_avalon_cra_readdata_from_sa, A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0)) = '1'), spi_master_0_avalon_slave_0_readdata_from_sa, A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0)) = '1'), twi_master_0_avalon_slave_0_readdata_from_sa, twi_master_1_avalon_slave_0_readdata_from_sa)))));
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_int_ctrl_0_avalon_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master readdata mux, which is an e_mux
  int_ctrl_0_avalon_master_readdata <= (((((((((((((((A_REP(NOT int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0, 32) OR Std_Logic_Vector'(ci_bridge_0_avalon_slave_0_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0, 32) OR dvb_dma_0_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0, 32) OR dvb_dma_1_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0, 32) OR dvb_ts_0_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0, 32) OR dvb_ts_1_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0, 32) OR fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0, 32) OR fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0, 32) OR fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0, 32) OR fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0, 32) OR Std_Logic_Vector'(gpout_0_avalon_slave_0_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra, 32) OR Std_Logic_Vector'(int_ctrl_0_avalon_cra_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access, 32) OR pcie_compiler_0_Control_Register_Access_readdata_from_sa))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0, 32) OR Std_Logic_Vector'(spi_master_0_avalon_slave_0_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0, 32) OR Std_Logic_Vector'(twi_master_0_avalon_slave_0_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)))) AND ((A_REP(NOT int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0, 32) OR Std_Logic_Vector'(twi_master_1_avalon_slave_0_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)));
  --mux write dbs 1, which is an e_mux
  int_ctrl_0_avalon_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_dbs_address(1))) = '1'), int_ctrl_0_avalon_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_int_ctrl_0_avalon_master_dbs_address(1)))) = '1'), int_ctrl_0_avalon_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_dbs_address(1))) = '1'), int_ctrl_0_avalon_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_int_ctrl_0_avalon_master_dbs_address(1)))) = '1'), int_ctrl_0_avalon_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_dbs_address(1))) = '1'), int_ctrl_0_avalon_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_int_ctrl_0_avalon_master_dbs_address(1)))) = '1'), int_ctrl_0_avalon_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_dbs_address(1))) = '1'), int_ctrl_0_avalon_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_int_ctrl_0_avalon_master_dbs_address(1)))) = '1'), int_ctrl_0_avalon_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_dbs_address(1))) = '1'), int_ctrl_0_avalon_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_int_ctrl_0_avalon_master_dbs_address(1)))) = '1'), int_ctrl_0_avalon_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_dbs_address(1))) = '1'), int_ctrl_0_avalon_master_writedata(31 DOWNTO 16), int_ctrl_0_avalon_master_writedata(15 DOWNTO 0))))))))))));
  --actual waitrequest port, which is an e_assign
  internal_int_ctrl_0_avalon_master_waitrequest <= NOT int_ctrl_0_avalon_master_run;
  --dbs count increment, which is an e_mux
  int_ctrl_0_avalon_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000"))))))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_int_ctrl_0_avalon_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_int_ctrl_0_avalon_master_dbs_address)) + (std_logic_vector'("0") & (int_ctrl_0_avalon_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_int_ctrl_0_avalon_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_int_ctrl_0_avalon_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_address_to_slave <= internal_int_ctrl_0_avalon_master_address_to_slave;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_dbs_address <= internal_int_ctrl_0_avalon_master_dbs_address;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_waitrequest <= internal_int_ctrl_0_avalon_master_waitrequest;
--synthesis translate_off
    --int_ctrl_0_avalon_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        int_ctrl_0_avalon_master_address_last_time <= std_logic_vector'("000000000000000");
      elsif clk'event and clk = '1' then
        int_ctrl_0_avalon_master_address_last_time <= int_ctrl_0_avalon_master_address;
      end if;

    end process;

    --int_ctrl_0/avalon_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_int_ctrl_0_avalon_master_waitrequest AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
      end if;

    end process;

    --int_ctrl_0_avalon_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((int_ctrl_0_avalon_master_address /= int_ctrl_0_avalon_master_address_last_time))))) = '1' then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("int_ctrl_0_avalon_master_address did not heed wait!!!"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --int_ctrl_0_avalon_master_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        int_ctrl_0_avalon_master_byteenable_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        int_ctrl_0_avalon_master_byteenable_last_time <= int_ctrl_0_avalon_master_byteenable;
      end if;

    end process;

    --int_ctrl_0_avalon_master_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((int_ctrl_0_avalon_master_byteenable /= int_ctrl_0_avalon_master_byteenable_last_time))))) = '1' then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("int_ctrl_0_avalon_master_byteenable did not heed wait!!!"));
          write(output, write_line9.all);
          deallocate (write_line9);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --int_ctrl_0_avalon_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        int_ctrl_0_avalon_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        int_ctrl_0_avalon_master_read_last_time <= int_ctrl_0_avalon_master_read;
      end if;

    end process;

    --int_ctrl_0_avalon_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line10 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(int_ctrl_0_avalon_master_read) /= std_logic'(int_ctrl_0_avalon_master_read_last_time)))))) = '1' then 
          write(write_line10, now);
          write(write_line10, string'(": "));
          write(write_line10, string'("int_ctrl_0_avalon_master_read did not heed wait!!!"));
          write(output, write_line10.all);
          deallocate (write_line10);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --int_ctrl_0_avalon_master_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        int_ctrl_0_avalon_master_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        int_ctrl_0_avalon_master_write_last_time <= int_ctrl_0_avalon_master_write;
      end if;

    end process;

    --int_ctrl_0_avalon_master_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line11 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(int_ctrl_0_avalon_master_write) /= std_logic'(int_ctrl_0_avalon_master_write_last_time)))))) = '1' then 
          write(write_line11, now);
          write(write_line11, string'(": "));
          write(write_line11, string'("int_ctrl_0_avalon_master_write did not heed wait!!!"));
          write(output, write_line11.all);
          deallocate (write_line11);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --int_ctrl_0_avalon_master_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        int_ctrl_0_avalon_master_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        int_ctrl_0_avalon_master_writedata_last_time <= int_ctrl_0_avalon_master_writedata;
      end if;

    end process;

    --int_ctrl_0_avalon_master_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line12 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((int_ctrl_0_avalon_master_writedata /= int_ctrl_0_avalon_master_writedata_last_time)))) AND int_ctrl_0_avalon_master_write)) = '1' then 
          write(write_line12, now);
          write(write_line12, string'(": "));
          write(write_line12, string'("int_ctrl_0_avalon_master_writedata did not heed wait!!!"));
          write(output, write_line12.all);
          deallocate (write_line12);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pcie_compiler_0_Control_Register_Access_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_pcie_compiler_0_Control_Register_Access_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                 signal pcie_compiler_0_Control_Register_Access_address : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_chipselect : OUT STD_LOGIC;
                 signal pcie_compiler_0_Control_Register_Access_read : OUT STD_LOGIC;
                 signal pcie_compiler_0_Control_Register_Access_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Control_Register_Access_waitrequest_from_sa : OUT STD_LOGIC;
                 signal pcie_compiler_0_Control_Register_Access_write : OUT STD_LOGIC;
                 signal pcie_compiler_0_Control_Register_Access_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity pcie_compiler_0_Control_Register_Access_arbitrator;


architecture europa of pcie_compiler_0_Control_Register_Access_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal internal_pcie_compiler_0_Control_Register_Access_waitrequest_from_sa :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_allgrants :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_allow_new_arb_cycle :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_any_continuerequest :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_arb_counter_enable :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_beginbursttransfer_internal :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_begins_xfer :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_end_xfer :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_firsttransfer :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_grant_vector :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_in_a_read_cycle :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_in_a_write_cycle :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_master_qreq_vector :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_non_bursting_master_requests :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_reg_firsttransfer :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_slavearbiterlockenable :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_slavearbiterlockenable2 :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_unreg_firsttransfer :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_waits_for_read :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pcie_compiler_0_Control_Register_Access_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal wait_for_pcie_compiler_0_Control_Register_Access_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pcie_compiler_0_Control_Register_Access_end_xfer;
    end if;

  end process;

  pcie_compiler_0_Control_Register_Access_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access);
  --assign pcie_compiler_0_Control_Register_Access_readdata_from_sa = pcie_compiler_0_Control_Register_Access_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pcie_compiler_0_Control_Register_Access_readdata_from_sa <= pcie_compiler_0_Control_Register_Access_readdata;
  internal_int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access <= to_std_logic(((Std_Logic_Vector'(A_ToStdLogicVector(int_ctrl_0_avalon_master_address_to_slave(14)) & std_logic_vector'("00000000000000")) = std_logic_vector'("000000000000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign pcie_compiler_0_Control_Register_Access_waitrequest_from_sa = pcie_compiler_0_Control_Register_Access_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_pcie_compiler_0_Control_Register_Access_waitrequest_from_sa <= pcie_compiler_0_Control_Register_Access_waitrequest;
  --pcie_compiler_0_Control_Register_Access_arb_share_counter set values, which is an e_mux
  pcie_compiler_0_Control_Register_Access_arb_share_set_values <= std_logic_vector'("01");
  --pcie_compiler_0_Control_Register_Access_non_bursting_master_requests mux, which is an e_mux
  pcie_compiler_0_Control_Register_Access_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access;
  --pcie_compiler_0_Control_Register_Access_any_bursting_master_saved_grant mux, which is an e_mux
  pcie_compiler_0_Control_Register_Access_any_bursting_master_saved_grant <= std_logic'('0');
  --pcie_compiler_0_Control_Register_Access_arb_share_counter_next_value assignment, which is an e_assign
  pcie_compiler_0_Control_Register_Access_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pcie_compiler_0_Control_Register_Access_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (pcie_compiler_0_Control_Register_Access_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pcie_compiler_0_Control_Register_Access_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (pcie_compiler_0_Control_Register_Access_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --pcie_compiler_0_Control_Register_Access_allgrants all slave grants, which is an e_mux
  pcie_compiler_0_Control_Register_Access_allgrants <= pcie_compiler_0_Control_Register_Access_grant_vector;
  --pcie_compiler_0_Control_Register_Access_end_xfer assignment, which is an e_assign
  pcie_compiler_0_Control_Register_Access_end_xfer <= NOT ((pcie_compiler_0_Control_Register_Access_waits_for_read OR pcie_compiler_0_Control_Register_Access_waits_for_write));
  --end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access <= pcie_compiler_0_Control_Register_Access_end_xfer AND (((NOT pcie_compiler_0_Control_Register_Access_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pcie_compiler_0_Control_Register_Access_arb_share_counter arbitration counter enable, which is an e_assign
  pcie_compiler_0_Control_Register_Access_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access AND pcie_compiler_0_Control_Register_Access_allgrants)) OR ((end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access AND NOT pcie_compiler_0_Control_Register_Access_non_bursting_master_requests));
  --pcie_compiler_0_Control_Register_Access_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Control_Register_Access_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(pcie_compiler_0_Control_Register_Access_arb_counter_enable) = '1' then 
        pcie_compiler_0_Control_Register_Access_arb_share_counter <= pcie_compiler_0_Control_Register_Access_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pcie_compiler_0_Control_Register_Access_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Control_Register_Access_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pcie_compiler_0_Control_Register_Access_master_qreq_vector AND end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access)) OR ((end_xfer_arb_share_counter_term_pcie_compiler_0_Control_Register_Access AND NOT pcie_compiler_0_Control_Register_Access_non_bursting_master_requests)))) = '1' then 
        pcie_compiler_0_Control_Register_Access_slavearbiterlockenable <= or_reduce(pcie_compiler_0_Control_Register_Access_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master pcie_compiler_0/Control_Register_Access arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= pcie_compiler_0_Control_Register_Access_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --pcie_compiler_0_Control_Register_Access_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pcie_compiler_0_Control_Register_Access_slavearbiterlockenable2 <= or_reduce(pcie_compiler_0_Control_Register_Access_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master pcie_compiler_0/Control_Register_Access arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= pcie_compiler_0_Control_Register_Access_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --pcie_compiler_0_Control_Register_Access_any_continuerequest at least one master continues requesting, which is an e_assign
  pcie_compiler_0_Control_Register_Access_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access <= internal_int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access;
  --pcie_compiler_0_Control_Register_Access_writedata mux, which is an e_mux
  pcie_compiler_0_Control_Register_Access_writedata <= int_ctrl_0_avalon_master_writedata;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access <= internal_int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access;
  --int_ctrl_0/avalon_master saved-grant pcie_compiler_0/Control_Register_Access, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_pcie_compiler_0_Control_Register_Access <= internal_int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access;
  --allow new arb cycle for pcie_compiler_0/Control_Register_Access, which is an e_assign
  pcie_compiler_0_Control_Register_Access_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pcie_compiler_0_Control_Register_Access_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pcie_compiler_0_Control_Register_Access_master_qreq_vector <= std_logic'('1');
  pcie_compiler_0_Control_Register_Access_chipselect <= internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access;
  --pcie_compiler_0_Control_Register_Access_firsttransfer first transaction, which is an e_assign
  pcie_compiler_0_Control_Register_Access_firsttransfer <= A_WE_StdLogic((std_logic'(pcie_compiler_0_Control_Register_Access_begins_xfer) = '1'), pcie_compiler_0_Control_Register_Access_unreg_firsttransfer, pcie_compiler_0_Control_Register_Access_reg_firsttransfer);
  --pcie_compiler_0_Control_Register_Access_unreg_firsttransfer first transaction, which is an e_assign
  pcie_compiler_0_Control_Register_Access_unreg_firsttransfer <= NOT ((pcie_compiler_0_Control_Register_Access_slavearbiterlockenable AND pcie_compiler_0_Control_Register_Access_any_continuerequest));
  --pcie_compiler_0_Control_Register_Access_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Control_Register_Access_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pcie_compiler_0_Control_Register_Access_begins_xfer) = '1' then 
        pcie_compiler_0_Control_Register_Access_reg_firsttransfer <= pcie_compiler_0_Control_Register_Access_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pcie_compiler_0_Control_Register_Access_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pcie_compiler_0_Control_Register_Access_beginbursttransfer_internal <= pcie_compiler_0_Control_Register_Access_begins_xfer;
  --pcie_compiler_0_Control_Register_Access_read assignment, which is an e_mux
  pcie_compiler_0_Control_Register_Access_read <= internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access AND int_ctrl_0_avalon_master_read;
  --pcie_compiler_0_Control_Register_Access_write assignment, which is an e_mux
  pcie_compiler_0_Control_Register_Access_write <= internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access AND int_ctrl_0_avalon_master_write;
  shifted_address_to_pcie_compiler_0_Control_Register_Access_from_int_ctrl_0_avalon_master <= int_ctrl_0_avalon_master_address_to_slave;
  --pcie_compiler_0_Control_Register_Access_address mux, which is an e_mux
  pcie_compiler_0_Control_Register_Access_address <= A_EXT (A_SRL(shifted_address_to_pcie_compiler_0_Control_Register_Access_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000010")), 12);
  --d1_pcie_compiler_0_Control_Register_Access_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pcie_compiler_0_Control_Register_Access_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pcie_compiler_0_Control_Register_Access_end_xfer <= pcie_compiler_0_Control_Register_Access_end_xfer;
    end if;

  end process;

  --pcie_compiler_0_Control_Register_Access_waits_for_read in a cycle, which is an e_mux
  pcie_compiler_0_Control_Register_Access_waits_for_read <= pcie_compiler_0_Control_Register_Access_in_a_read_cycle AND internal_pcie_compiler_0_Control_Register_Access_waitrequest_from_sa;
  --pcie_compiler_0_Control_Register_Access_in_a_read_cycle assignment, which is an e_assign
  pcie_compiler_0_Control_Register_Access_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pcie_compiler_0_Control_Register_Access_in_a_read_cycle;
  --pcie_compiler_0_Control_Register_Access_waits_for_write in a cycle, which is an e_mux
  pcie_compiler_0_Control_Register_Access_waits_for_write <= pcie_compiler_0_Control_Register_Access_in_a_write_cycle AND internal_pcie_compiler_0_Control_Register_Access_waitrequest_from_sa;
  --pcie_compiler_0_Control_Register_Access_in_a_write_cycle assignment, which is an e_assign
  pcie_compiler_0_Control_Register_Access_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pcie_compiler_0_Control_Register_Access_in_a_write_cycle;
  wait_for_pcie_compiler_0_Control_Register_Access_counter <= std_logic'('0');
  --pcie_compiler_0_Control_Register_Access_byteenable byte enable port mux, which is an e_mux
  pcie_compiler_0_Control_Register_Access_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (int_ctrl_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access <= internal_int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access <= internal_int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access <= internal_int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access;
  --vhdl renameroo for output signals
  pcie_compiler_0_Control_Register_Access_waitrequest_from_sa <= internal_pcie_compiler_0_Control_Register_Access_waitrequest_from_sa;
--synthesis translate_off
    --pcie_compiler_0/Control_Register_Access enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity pcie_compiler_0_Tx_Interface_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal dma_arbiter_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (30 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_burstcount : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dma_arbiter_0_avalon_master_write : IN STD_LOGIC;
                 signal dma_arbiter_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pcie_compiler_0_Tx_Interface_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pcie_compiler_0_Tx_Interface_readdatavalid : IN STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal d1_pcie_compiler_0_Tx_Interface_end_xfer : OUT STD_LOGIC;
                 signal dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface : OUT STD_LOGIC;
                 signal dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface : OUT STD_LOGIC;
                 signal dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface : OUT STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_address : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal pcie_compiler_0_Tx_Interface_burstcount : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal pcie_compiler_0_Tx_Interface_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pcie_compiler_0_Tx_Interface_chipselect : OUT STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_read : OUT STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pcie_compiler_0_Tx_Interface_readdatavalid_from_sa : OUT STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_waitrequest_from_sa : OUT STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_write : OUT STD_LOGIC;
                 signal pcie_compiler_0_Tx_Interface_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
              );
end entity pcie_compiler_0_Tx_Interface_arbitrator;


architecture europa of pcie_compiler_0_Tx_Interface_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_continuerequest :  STD_LOGIC;
                signal dma_arbiter_0_saved_grant_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal internal_dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal internal_dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal internal_pcie_compiler_0_Tx_Interface_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_pcie_compiler_0_Tx_Interface_read :  STD_LOGIC;
                signal internal_pcie_compiler_0_Tx_Interface_waitrequest_from_sa :  STD_LOGIC;
                signal internal_pcie_compiler_0_Tx_Interface_write :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_allgrants :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_allow_new_arb_cycle :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_any_continuerequest :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_arb_counter_enable :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_arb_share_counter :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_arb_share_counter_next_value :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_arb_share_set_values :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_bbt_burstcounter :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_beginbursttransfer_internal :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_begins_xfer :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_end_xfer :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_firsttransfer :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_grant_vector :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_in_a_read_cycle :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_in_a_write_cycle :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_master_qreq_vector :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_next_bbt_burstcount :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_non_bursting_master_requests :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_reg_firsttransfer :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_slavearbiterlockenable :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_slavearbiterlockenable2 :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_unreg_firsttransfer :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_waits_for_read :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pcie_compiler_0_Tx_Interface_from_dma_arbiter_0_avalon_master :  STD_LOGIC_VECTOR (30 DOWNTO 0);
                signal wait_for_pcie_compiler_0_Tx_Interface_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pcie_compiler_0_Tx_Interface_end_xfer;
    end if;

  end process;

  pcie_compiler_0_Tx_Interface_begins_xfer <= NOT d1_reasons_to_wait AND (internal_dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface);
  --assign pcie_compiler_0_Tx_Interface_readdata_from_sa = pcie_compiler_0_Tx_Interface_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pcie_compiler_0_Tx_Interface_readdata_from_sa <= pcie_compiler_0_Tx_Interface_readdata;
  internal_dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface <= Vector_To_Std_Logic(((((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((dma_arbiter_0_avalon_master_write)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(dma_arbiter_0_avalon_master_write)))));
  --assign pcie_compiler_0_Tx_Interface_waitrequest_from_sa = pcie_compiler_0_Tx_Interface_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_pcie_compiler_0_Tx_Interface_waitrequest_from_sa <= pcie_compiler_0_Tx_Interface_waitrequest;
  --pcie_compiler_0_Tx_Interface_arb_share_counter set values, which is an e_mux
  pcie_compiler_0_Tx_Interface_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface)) = '1'), (std_logic_vector'("0000000000000000000000000") & (dma_arbiter_0_avalon_master_burstcount)), std_logic_vector'("00000000000000000000000000000001")), 7);
  --pcie_compiler_0_Tx_Interface_non_bursting_master_requests mux, which is an e_mux
  pcie_compiler_0_Tx_Interface_non_bursting_master_requests <= std_logic'('0');
  --pcie_compiler_0_Tx_Interface_any_bursting_master_saved_grant mux, which is an e_mux
  pcie_compiler_0_Tx_Interface_any_bursting_master_saved_grant <= dma_arbiter_0_saved_grant_pcie_compiler_0_Tx_Interface;
  --pcie_compiler_0_Tx_Interface_arb_share_counter_next_value assignment, which is an e_assign
  pcie_compiler_0_Tx_Interface_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pcie_compiler_0_Tx_Interface_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000") & (pcie_compiler_0_Tx_Interface_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pcie_compiler_0_Tx_Interface_arb_share_counter)) = '1'), (((std_logic_vector'("00000000000000000000000000") & (pcie_compiler_0_Tx_Interface_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 7);
  --pcie_compiler_0_Tx_Interface_allgrants all slave grants, which is an e_mux
  pcie_compiler_0_Tx_Interface_allgrants <= pcie_compiler_0_Tx_Interface_grant_vector;
  --pcie_compiler_0_Tx_Interface_end_xfer assignment, which is an e_assign
  pcie_compiler_0_Tx_Interface_end_xfer <= NOT ((pcie_compiler_0_Tx_Interface_waits_for_read OR pcie_compiler_0_Tx_Interface_waits_for_write));
  --end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface <= pcie_compiler_0_Tx_Interface_end_xfer AND (((NOT pcie_compiler_0_Tx_Interface_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pcie_compiler_0_Tx_Interface_arb_share_counter arbitration counter enable, which is an e_assign
  pcie_compiler_0_Tx_Interface_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface AND pcie_compiler_0_Tx_Interface_allgrants)) OR ((end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface AND NOT pcie_compiler_0_Tx_Interface_non_bursting_master_requests));
  --pcie_compiler_0_Tx_Interface_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Tx_Interface_arb_share_counter <= std_logic_vector'("0000000");
    elsif clk'event and clk = '1' then
      if std_logic'(pcie_compiler_0_Tx_Interface_arb_counter_enable) = '1' then 
        pcie_compiler_0_Tx_Interface_arb_share_counter <= pcie_compiler_0_Tx_Interface_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pcie_compiler_0_Tx_Interface_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Tx_Interface_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pcie_compiler_0_Tx_Interface_master_qreq_vector AND end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface)) OR ((end_xfer_arb_share_counter_term_pcie_compiler_0_Tx_Interface AND NOT pcie_compiler_0_Tx_Interface_non_bursting_master_requests)))) = '1' then 
        pcie_compiler_0_Tx_Interface_slavearbiterlockenable <= or_reduce(pcie_compiler_0_Tx_Interface_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --dma_arbiter_0/avalon_master pcie_compiler_0/Tx_Interface arbiterlock, which is an e_assign
  dma_arbiter_0_avalon_master_arbiterlock <= pcie_compiler_0_Tx_Interface_slavearbiterlockenable AND dma_arbiter_0_avalon_master_continuerequest;
  --pcie_compiler_0_Tx_Interface_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pcie_compiler_0_Tx_Interface_slavearbiterlockenable2 <= or_reduce(pcie_compiler_0_Tx_Interface_arb_share_counter_next_value);
  --dma_arbiter_0/avalon_master pcie_compiler_0/Tx_Interface arbiterlock2, which is an e_assign
  dma_arbiter_0_avalon_master_arbiterlock2 <= pcie_compiler_0_Tx_Interface_slavearbiterlockenable2 AND dma_arbiter_0_avalon_master_continuerequest;
  --pcie_compiler_0_Tx_Interface_any_continuerequest at least one master continues requesting, which is an e_assign
  pcie_compiler_0_Tx_Interface_any_continuerequest <= std_logic'('1');
  --dma_arbiter_0_avalon_master_continuerequest continued request, which is an e_assign
  dma_arbiter_0_avalon_master_continuerequest <= std_logic'('1');
  internal_dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface <= internal_dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface;
  --pcie_compiler_0_Tx_Interface_writedata mux, which is an e_mux
  pcie_compiler_0_Tx_Interface_writedata <= dma_arbiter_0_avalon_master_writedata;
  --master is always granted when requested
  internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface <= internal_dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface;
  --dma_arbiter_0/avalon_master saved-grant pcie_compiler_0/Tx_Interface, which is an e_assign
  dma_arbiter_0_saved_grant_pcie_compiler_0_Tx_Interface <= internal_dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface;
  --allow new arb cycle for pcie_compiler_0/Tx_Interface, which is an e_assign
  pcie_compiler_0_Tx_Interface_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pcie_compiler_0_Tx_Interface_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pcie_compiler_0_Tx_Interface_master_qreq_vector <= std_logic'('1');
  pcie_compiler_0_Tx_Interface_chipselect <= internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface;
  --pcie_compiler_0_Tx_Interface_firsttransfer first transaction, which is an e_assign
  pcie_compiler_0_Tx_Interface_firsttransfer <= A_WE_StdLogic((std_logic'(pcie_compiler_0_Tx_Interface_begins_xfer) = '1'), pcie_compiler_0_Tx_Interface_unreg_firsttransfer, pcie_compiler_0_Tx_Interface_reg_firsttransfer);
  --pcie_compiler_0_Tx_Interface_unreg_firsttransfer first transaction, which is an e_assign
  pcie_compiler_0_Tx_Interface_unreg_firsttransfer <= NOT ((pcie_compiler_0_Tx_Interface_slavearbiterlockenable AND pcie_compiler_0_Tx_Interface_any_continuerequest));
  --pcie_compiler_0_Tx_Interface_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Tx_Interface_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pcie_compiler_0_Tx_Interface_begins_xfer) = '1' then 
        pcie_compiler_0_Tx_Interface_reg_firsttransfer <= pcie_compiler_0_Tx_Interface_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pcie_compiler_0_Tx_Interface_next_bbt_burstcount next_bbt_burstcount, which is an e_mux
  pcie_compiler_0_Tx_Interface_next_bbt_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((((internal_pcie_compiler_0_Tx_Interface_write) AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (pcie_compiler_0_Tx_Interface_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))))))) = '1'), (((std_logic_vector'("00000000000000000000000") & (internal_pcie_compiler_0_Tx_Interface_burstcount)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'((((internal_pcie_compiler_0_Tx_Interface_read) AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (pcie_compiler_0_Tx_Interface_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))))))) = '1'), std_logic_vector'("000000000000000000000000000000000"), (((std_logic_vector'("000000000000000000000000") & (pcie_compiler_0_Tx_Interface_bbt_burstcounter)) - std_logic_vector'("000000000000000000000000000000001"))))), 9);
  --pcie_compiler_0_Tx_Interface_bbt_burstcounter bbt_burstcounter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Tx_Interface_bbt_burstcounter <= std_logic_vector'("000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(pcie_compiler_0_Tx_Interface_begins_xfer) = '1' then 
        pcie_compiler_0_Tx_Interface_bbt_burstcounter <= pcie_compiler_0_Tx_Interface_next_bbt_burstcount;
      end if;
    end if;

  end process;

  --pcie_compiler_0_Tx_Interface_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pcie_compiler_0_Tx_Interface_beginbursttransfer_internal <= pcie_compiler_0_Tx_Interface_begins_xfer AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (pcie_compiler_0_Tx_Interface_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))));
  --pcie_compiler_0_Tx_Interface_read assignment, which is an e_mux
  internal_pcie_compiler_0_Tx_Interface_read <= std_logic'('0');
  --pcie_compiler_0_Tx_Interface_write assignment, which is an e_mux
  internal_pcie_compiler_0_Tx_Interface_write <= internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface AND dma_arbiter_0_avalon_master_write;
  shifted_address_to_pcie_compiler_0_Tx_Interface_from_dma_arbiter_0_avalon_master <= dma_arbiter_0_avalon_master_address_to_slave;
  --pcie_compiler_0_Tx_Interface_address mux, which is an e_mux
  pcie_compiler_0_Tx_Interface_address <= A_EXT (A_SRL(shifted_address_to_pcie_compiler_0_Tx_Interface_from_dma_arbiter_0_avalon_master,std_logic_vector'("00000000000000000000000000000011")), 28);
  --d1_pcie_compiler_0_Tx_Interface_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pcie_compiler_0_Tx_Interface_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pcie_compiler_0_Tx_Interface_end_xfer <= pcie_compiler_0_Tx_Interface_end_xfer;
    end if;

  end process;

  --pcie_compiler_0_Tx_Interface_waits_for_read in a cycle, which is an e_mux
  pcie_compiler_0_Tx_Interface_waits_for_read <= pcie_compiler_0_Tx_Interface_in_a_read_cycle AND internal_pcie_compiler_0_Tx_Interface_waitrequest_from_sa;
  --pcie_compiler_0_Tx_Interface_in_a_read_cycle assignment, which is an e_assign
  pcie_compiler_0_Tx_Interface_in_a_read_cycle <= std_logic'('0');
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pcie_compiler_0_Tx_Interface_in_a_read_cycle;
  --pcie_compiler_0_Tx_Interface_waits_for_write in a cycle, which is an e_mux
  pcie_compiler_0_Tx_Interface_waits_for_write <= pcie_compiler_0_Tx_Interface_in_a_write_cycle AND internal_pcie_compiler_0_Tx_Interface_waitrequest_from_sa;
  --assign pcie_compiler_0_Tx_Interface_readdatavalid_from_sa = pcie_compiler_0_Tx_Interface_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  pcie_compiler_0_Tx_Interface_readdatavalid_from_sa <= pcie_compiler_0_Tx_Interface_readdatavalid;
  --pcie_compiler_0_Tx_Interface_in_a_write_cycle assignment, which is an e_assign
  pcie_compiler_0_Tx_Interface_in_a_write_cycle <= internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface AND dma_arbiter_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pcie_compiler_0_Tx_Interface_in_a_write_cycle;
  wait_for_pcie_compiler_0_Tx_Interface_counter <= std_logic'('0');
  --pcie_compiler_0_Tx_Interface_byteenable byte enable port mux, which is an e_mux
  pcie_compiler_0_Tx_Interface_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface)) = '1'), (std_logic_vector'("000000000000000000000000") & (dma_arbiter_0_avalon_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 8);
  --burstcount mux, which is an e_mux
  internal_pcie_compiler_0_Tx_Interface_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface)) = '1'), (std_logic_vector'("0000000000000000000000000") & (dma_arbiter_0_avalon_master_burstcount)), std_logic_vector'("00000000000000000000000000000001")), 10);
  --vhdl renameroo for output signals
  dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface <= internal_dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface;
  --vhdl renameroo for output signals
  dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface <= internal_dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface;
  --vhdl renameroo for output signals
  dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface <= internal_dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface;
  --vhdl renameroo for output signals
  pcie_compiler_0_Tx_Interface_burstcount <= internal_pcie_compiler_0_Tx_Interface_burstcount;
  --vhdl renameroo for output signals
  pcie_compiler_0_Tx_Interface_read <= internal_pcie_compiler_0_Tx_Interface_read;
  --vhdl renameroo for output signals
  pcie_compiler_0_Tx_Interface_waitrequest_from_sa <= internal_pcie_compiler_0_Tx_Interface_waitrequest_from_sa;
  --vhdl renameroo for output signals
  pcie_compiler_0_Tx_Interface_write <= internal_pcie_compiler_0_Tx_Interface_write;
--synthesis translate_off
    --pcie_compiler_0/Tx_Interface enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --dma_arbiter_0/avalon_master non-zero burstcount assertion, which is an e_process
    process (clk)
    VARIABLE write_line13 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface AND to_std_logic((((std_logic_vector'("0000000000000000000000000") & (dma_arbiter_0_avalon_master_burstcount)) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line13, now);
          write(write_line13, string'(": "));
          write(write_line13, string'("dma_arbiter_0/avalon_master drove 0 on its 'burstcount' port while accessing slave pcie_compiler_0/Tx_Interface"));
          write(output, write_line13.all);
          deallocate (write_line13);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity pcie_compiler_0_Rx_Interface_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal d1_unici_core_burst_0_upstream_end_xfer : IN STD_LOGIC;
                 signal d1_unici_core_burst_1_upstream_end_xfer : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_address : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_write : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_0_upstream_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_0_upstream_waitrequest_from_sa : IN STD_LOGIC;
                 signal unici_core_burst_1_upstream_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_1_upstream_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal pcie_compiler_0_Rx_Interface_address_to_slave : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_latency_counter : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_readdatavalid : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_reset_n : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_waitrequest : OUT STD_LOGIC
              );
end entity pcie_compiler_0_Rx_Interface_arbitrator;


architecture europa of pcie_compiler_0_Rx_Interface_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_address_to_slave :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_pcie_compiler_0_Rx_Interface_latency_counter :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC;
                signal p1_pcie_compiler_0_Rx_Interface_latency_counter :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_address_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_burstcount_last_time :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_byteenable_last_time :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_is_granted_some_slave :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read_but_no_slave_selected :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read_last_time :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_run :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_write_last_time :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_writedata_last_time :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pre_flush_pcie_compiler_0_Rx_Interface_readdatavalid :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;

begin

  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream OR NOT pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream OR NOT ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT unici_core_burst_0_upstream_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream OR NOT ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT unici_core_burst_0_upstream_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream OR NOT pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream OR NOT ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT unici_core_burst_1_upstream_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream OR NOT ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT unici_core_burst_1_upstream_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  pcie_compiler_0_Rx_Interface_run <= r_2;
  --pcie_compiler_0_Rx_Interface_reset_n assignment, which is an e_assign
  pcie_compiler_0_Rx_Interface_reset_n <= reset_n;
  --optimize select-logic by passing only those address bits which matter.
  internal_pcie_compiler_0_Rx_Interface_address_to_slave <= Std_Logic_Vector'(std_logic_vector'("0000000000000") & pcie_compiler_0_Rx_Interface_address(18 DOWNTO 0));
  --pcie_compiler_0_Rx_Interface_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pcie_compiler_0_Rx_Interface_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      pcie_compiler_0_Rx_Interface_read_but_no_slave_selected <= (pcie_compiler_0_Rx_Interface_read AND pcie_compiler_0_Rx_Interface_run) AND NOT pcie_compiler_0_Rx_Interface_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  pcie_compiler_0_Rx_Interface_is_granted_some_slave <= pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream OR pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_pcie_compiler_0_Rx_Interface_readdatavalid <= pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream OR pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream;
  --latent slave read data valid which is not flushed, which is an e_mux
  pcie_compiler_0_Rx_Interface_readdatavalid <= ((pcie_compiler_0_Rx_Interface_read_but_no_slave_selected OR pre_flush_pcie_compiler_0_Rx_Interface_readdatavalid) OR pcie_compiler_0_Rx_Interface_read_but_no_slave_selected) OR pre_flush_pcie_compiler_0_Rx_Interface_readdatavalid;
  --pcie_compiler_0/Rx_Interface readdata mux, which is an e_mux
  pcie_compiler_0_Rx_Interface_readdata <= ((A_REP(NOT pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream, 64) OR unici_core_burst_0_upstream_readdata_from_sa)) AND ((A_REP(NOT pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream, 64) OR unici_core_burst_1_upstream_readdata_from_sa));
  --actual waitrequest port, which is an e_assign
  internal_pcie_compiler_0_Rx_Interface_waitrequest <= NOT pcie_compiler_0_Rx_Interface_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_pcie_compiler_0_Rx_Interface_latency_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_pcie_compiler_0_Rx_Interface_latency_counter <= p1_pcie_compiler_0_Rx_Interface_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_pcie_compiler_0_Rx_Interface_latency_counter <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((pcie_compiler_0_Rx_Interface_run AND pcie_compiler_0_Rx_Interface_read))) = '1'), (std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(latency_load_value))), A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_latency_counter)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_pcie_compiler_0_Rx_Interface_latency_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  --read latency load values, which is an e_mux
  latency_load_value <= std_logic'('0');
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_address_to_slave <= internal_pcie_compiler_0_Rx_Interface_address_to_slave;
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_latency_counter <= internal_pcie_compiler_0_Rx_Interface_latency_counter;
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_waitrequest <= internal_pcie_compiler_0_Rx_Interface_waitrequest;
--synthesis translate_off
    --pcie_compiler_0_Rx_Interface_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pcie_compiler_0_Rx_Interface_address_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        pcie_compiler_0_Rx_Interface_address_last_time <= pcie_compiler_0_Rx_Interface_address;
      end if;

    end process;

    --pcie_compiler_0/Rx_Interface waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_pcie_compiler_0_Rx_Interface_waitrequest AND ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write));
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line14 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((pcie_compiler_0_Rx_Interface_address /= pcie_compiler_0_Rx_Interface_address_last_time))))) = '1' then 
          write(write_line14, now);
          write(write_line14, string'(": "));
          write(write_line14, string'("pcie_compiler_0_Rx_Interface_address did not heed wait!!!"));
          write(output, write_line14.all);
          deallocate (write_line14);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_burstcount check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pcie_compiler_0_Rx_Interface_burstcount_last_time <= std_logic_vector'("0000000000");
      elsif clk'event and clk = '1' then
        pcie_compiler_0_Rx_Interface_burstcount_last_time <= pcie_compiler_0_Rx_Interface_burstcount;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_burstcount matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line15 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((pcie_compiler_0_Rx_Interface_burstcount /= pcie_compiler_0_Rx_Interface_burstcount_last_time))))) = '1' then 
          write(write_line15, now);
          write(write_line15, string'(": "));
          write(write_line15, string'("pcie_compiler_0_Rx_Interface_burstcount did not heed wait!!!"));
          write(output, write_line15.all);
          deallocate (write_line15);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pcie_compiler_0_Rx_Interface_byteenable_last_time <= std_logic_vector'("00000000");
      elsif clk'event and clk = '1' then
        pcie_compiler_0_Rx_Interface_byteenable_last_time <= pcie_compiler_0_Rx_Interface_byteenable;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line16 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((pcie_compiler_0_Rx_Interface_byteenable /= pcie_compiler_0_Rx_Interface_byteenable_last_time))))) = '1' then 
          write(write_line16, now);
          write(write_line16, string'(": "));
          write(write_line16, string'("pcie_compiler_0_Rx_Interface_byteenable did not heed wait!!!"));
          write(output, write_line16.all);
          deallocate (write_line16);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pcie_compiler_0_Rx_Interface_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        pcie_compiler_0_Rx_Interface_read_last_time <= pcie_compiler_0_Rx_Interface_read;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line17 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(pcie_compiler_0_Rx_Interface_read) /= std_logic'(pcie_compiler_0_Rx_Interface_read_last_time)))))) = '1' then 
          write(write_line17, now);
          write(write_line17, string'(": "));
          write(write_line17, string'("pcie_compiler_0_Rx_Interface_read did not heed wait!!!"));
          write(output, write_line17.all);
          deallocate (write_line17);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pcie_compiler_0_Rx_Interface_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        pcie_compiler_0_Rx_Interface_write_last_time <= pcie_compiler_0_Rx_Interface_write;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line18 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(pcie_compiler_0_Rx_Interface_write) /= std_logic'(pcie_compiler_0_Rx_Interface_write_last_time)))))) = '1' then 
          write(write_line18, now);
          write(write_line18, string'(": "));
          write(write_line18, string'("pcie_compiler_0_Rx_Interface_write did not heed wait!!!"));
          write(output, write_line18.all);
          deallocate (write_line18);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pcie_compiler_0_Rx_Interface_writedata_last_time <= std_logic_vector'("0000000000000000000000000000000000000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        pcie_compiler_0_Rx_Interface_writedata_last_time <= pcie_compiler_0_Rx_Interface_writedata;
      end if;

    end process;

    --pcie_compiler_0_Rx_Interface_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line19 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((pcie_compiler_0_Rx_Interface_writedata /= pcie_compiler_0_Rx_Interface_writedata_last_time)))) AND pcie_compiler_0_Rx_Interface_write)) = '1' then 
          write(write_line19, now);
          write(write_line19, string'(": "));
          write(write_line19, string'("pcie_compiler_0_Rx_Interface_writedata did not heed wait!!!"));
          write(output, write_line19.all);
          deallocate (write_line19);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1_module;


architecture europa of rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (2 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_2;
  empty <= NOT(full_0);
  full_3 <= std_logic'('0');
  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 3);
  one_count_minus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 3);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("00000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("00") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 3);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity pipeline_bridge_0_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal pipeline_bridge_0_s1_endofpacket : IN STD_LOGIC;
                 signal pipeline_bridge_0_s1_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pipeline_bridge_0_s1_readdatavalid : IN STD_LOGIC;
                 signal pipeline_bridge_0_s1_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal unici_core_burst_0_downstream_arbitrationshare : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal unici_core_burst_0_downstream_burstcount : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal unici_core_burst_0_downstream_debugaccess : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_latency_counter : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_nativeaddress : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal unici_core_burst_0_downstream_read : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_write : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

              -- outputs:
                 signal d1_pipeline_bridge_0_s1_end_xfer : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_address : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal pipeline_bridge_0_s1_arbiterlock : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_arbiterlock2 : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_burstcount : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pipeline_bridge_0_s1_chipselect : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_debugaccess : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_endofpacket_from_sa : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_nativeaddress : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal pipeline_bridge_0_s1_read : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pipeline_bridge_0_s1_reset_n : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_write : OUT STD_LOGIC;
                 signal pipeline_bridge_0_s1_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 : OUT STD_LOGIC
              );
end entity pipeline_bridge_0_s1_arbitrator;


architecture europa of pipeline_bridge_0_s1_arbitrator is
component rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1_module;

                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_pipeline_bridge_0_s1_waitrequest_from_sa :  STD_LOGIC;
                signal internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal internal_unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal pipeline_bridge_0_s1_allgrants :  STD_LOGIC;
                signal pipeline_bridge_0_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal pipeline_bridge_0_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pipeline_bridge_0_s1_any_continuerequest :  STD_LOGIC;
                signal pipeline_bridge_0_s1_arb_counter_enable :  STD_LOGIC;
                signal pipeline_bridge_0_s1_arb_share_counter :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal pipeline_bridge_0_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal pipeline_bridge_0_s1_arb_share_set_values :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal pipeline_bridge_0_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal pipeline_bridge_0_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal pipeline_bridge_0_s1_begins_xfer :  STD_LOGIC;
                signal pipeline_bridge_0_s1_end_xfer :  STD_LOGIC;
                signal pipeline_bridge_0_s1_firsttransfer :  STD_LOGIC;
                signal pipeline_bridge_0_s1_grant_vector :  STD_LOGIC;
                signal pipeline_bridge_0_s1_in_a_read_cycle :  STD_LOGIC;
                signal pipeline_bridge_0_s1_in_a_write_cycle :  STD_LOGIC;
                signal pipeline_bridge_0_s1_master_qreq_vector :  STD_LOGIC;
                signal pipeline_bridge_0_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal pipeline_bridge_0_s1_non_bursting_master_requests :  STD_LOGIC;
                signal pipeline_bridge_0_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal pipeline_bridge_0_s1_reg_firsttransfer :  STD_LOGIC;
                signal pipeline_bridge_0_s1_slavearbiterlockenable :  STD_LOGIC;
                signal pipeline_bridge_0_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal pipeline_bridge_0_s1_unreg_firsttransfer :  STD_LOGIC;
                signal pipeline_bridge_0_s1_waits_for_read :  STD_LOGIC;
                signal pipeline_bridge_0_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pipeline_bridge_0_s1_from_unici_core_burst_0_downstream :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal unici_core_burst_0_downstream_arbiterlock :  STD_LOGIC;
                signal unici_core_burst_0_downstream_arbiterlock2 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_continuerequest :  STD_LOGIC;
                signal unici_core_burst_0_downstream_rdv_fifo_empty_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_rdv_fifo_output_from_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_saved_grant_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal wait_for_pipeline_bridge_0_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pipeline_bridge_0_s1_end_xfer;
    end if;

  end process;

  pipeline_bridge_0_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1);
  --assign pipeline_bridge_0_s1_readdata_from_sa = pipeline_bridge_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pipeline_bridge_0_s1_readdata_from_sa <= pipeline_bridge_0_s1_readdata;
  internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_0_downstream_read OR unici_core_burst_0_downstream_write)))))));
  --assign pipeline_bridge_0_s1_waitrequest_from_sa = pipeline_bridge_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_pipeline_bridge_0_s1_waitrequest_from_sa <= pipeline_bridge_0_s1_waitrequest;
  --assign pipeline_bridge_0_s1_readdatavalid_from_sa = pipeline_bridge_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  pipeline_bridge_0_s1_readdatavalid_from_sa <= pipeline_bridge_0_s1_readdatavalid;
  --pipeline_bridge_0_s1_arb_share_counter set values, which is an e_mux
  pipeline_bridge_0_s1_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1)) = '1'), (std_logic_vector'("0000000000000000000000") & (unici_core_burst_0_downstream_arbitrationshare)), A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1)) = '1'), (std_logic_vector'("0000000000000000000000") & (unici_core_burst_0_downstream_arbitrationshare)), std_logic_vector'("00000000000000000000000000000001"))), 10);
  --pipeline_bridge_0_s1_non_bursting_master_requests mux, which is an e_mux
  pipeline_bridge_0_s1_non_bursting_master_requests <= std_logic'('0');
  --pipeline_bridge_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  pipeline_bridge_0_s1_any_bursting_master_saved_grant <= unici_core_burst_0_downstream_saved_grant_pipeline_bridge_0_s1 OR unici_core_burst_0_downstream_saved_grant_pipeline_bridge_0_s1;
  --pipeline_bridge_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  pipeline_bridge_0_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pipeline_bridge_0_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000") & (pipeline_bridge_0_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pipeline_bridge_0_s1_arb_share_counter)) = '1'), (((std_logic_vector'("00000000000000000000000") & (pipeline_bridge_0_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 10);
  --pipeline_bridge_0_s1_allgrants all slave grants, which is an e_mux
  pipeline_bridge_0_s1_allgrants <= (pipeline_bridge_0_s1_grant_vector) OR (pipeline_bridge_0_s1_grant_vector);
  --pipeline_bridge_0_s1_end_xfer assignment, which is an e_assign
  pipeline_bridge_0_s1_end_xfer <= NOT ((pipeline_bridge_0_s1_waits_for_read OR pipeline_bridge_0_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_pipeline_bridge_0_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pipeline_bridge_0_s1 <= pipeline_bridge_0_s1_end_xfer AND (((NOT pipeline_bridge_0_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pipeline_bridge_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  pipeline_bridge_0_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pipeline_bridge_0_s1 AND pipeline_bridge_0_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_pipeline_bridge_0_s1 AND NOT pipeline_bridge_0_s1_non_bursting_master_requests));
  --pipeline_bridge_0_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pipeline_bridge_0_s1_arb_share_counter <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(pipeline_bridge_0_s1_arb_counter_enable) = '1' then 
        pipeline_bridge_0_s1_arb_share_counter <= pipeline_bridge_0_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pipeline_bridge_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pipeline_bridge_0_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pipeline_bridge_0_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_pipeline_bridge_0_s1)) OR ((end_xfer_arb_share_counter_term_pipeline_bridge_0_s1 AND NOT pipeline_bridge_0_s1_non_bursting_master_requests)))) = '1' then 
        pipeline_bridge_0_s1_slavearbiterlockenable <= or_reduce(pipeline_bridge_0_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --unici_core_burst_0/downstream pipeline_bridge_0/s1 arbiterlock, which is an e_assign
  unici_core_burst_0_downstream_arbiterlock <= pipeline_bridge_0_s1_slavearbiterlockenable AND unici_core_burst_0_downstream_continuerequest;
  --pipeline_bridge_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pipeline_bridge_0_s1_slavearbiterlockenable2 <= or_reduce(pipeline_bridge_0_s1_arb_share_counter_next_value);
  --unici_core_burst_0/downstream pipeline_bridge_0/s1 arbiterlock2, which is an e_assign
  unici_core_burst_0_downstream_arbiterlock2 <= pipeline_bridge_0_s1_slavearbiterlockenable2 AND unici_core_burst_0_downstream_continuerequest;
  --pipeline_bridge_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  pipeline_bridge_0_s1_any_continuerequest <= std_logic'('1');
  --unici_core_burst_0_downstream_continuerequest continued request, which is an e_assign
  unici_core_burst_0_downstream_continuerequest <= std_logic'('1');
  internal_unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 <= internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 AND NOT ((unici_core_burst_0_downstream_read AND to_std_logic((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_0_downstream_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_0_downstream_latency_counter))))))))));
  --unique name for pipeline_bridge_0_s1_move_on_to_next_transaction, which is an e_assign
  pipeline_bridge_0_s1_move_on_to_next_transaction <= pipeline_bridge_0_s1_readdatavalid_from_sa;
  --rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1 : rdv_fifo_for_unici_core_burst_0_downstream_to_pipeline_bridge_0_s1_module
    port map(
      data_out => unici_core_burst_0_downstream_rdv_fifo_output_from_pipeline_bridge_0_s1,
      empty => open,
      fifo_contains_ones_n => unici_core_burst_0_downstream_rdv_fifo_empty_pipeline_bridge_0_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1,
      read => pipeline_bridge_0_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT pipeline_bridge_0_s1_waits_for_read;

  unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register <= NOT unici_core_burst_0_downstream_rdv_fifo_empty_pipeline_bridge_0_s1;
  --local readdatavalid unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1, which is an e_mux
  unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 <= pipeline_bridge_0_s1_readdatavalid_from_sa;
  --pipeline_bridge_0_s1_writedata mux, which is an e_mux
  pipeline_bridge_0_s1_writedata <= unici_core_burst_0_downstream_writedata;
  --assign pipeline_bridge_0_s1_endofpacket_from_sa = pipeline_bridge_0_s1_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  pipeline_bridge_0_s1_endofpacket_from_sa <= pipeline_bridge_0_s1_endofpacket;
  --master is always granted when requested
  internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 <= internal_unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1;
  --unici_core_burst_0/downstream saved-grant pipeline_bridge_0/s1, which is an e_assign
  unici_core_burst_0_downstream_saved_grant_pipeline_bridge_0_s1 <= internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1;
  --allow new arb cycle for pipeline_bridge_0/s1, which is an e_assign
  pipeline_bridge_0_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pipeline_bridge_0_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pipeline_bridge_0_s1_master_qreq_vector <= std_logic'('1');
  --pipeline_bridge_0_s1_reset_n assignment, which is an e_assign
  pipeline_bridge_0_s1_reset_n <= reset_n;
  pipeline_bridge_0_s1_chipselect <= internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1;
  --pipeline_bridge_0_s1_firsttransfer first transaction, which is an e_assign
  pipeline_bridge_0_s1_firsttransfer <= A_WE_StdLogic((std_logic'(pipeline_bridge_0_s1_begins_xfer) = '1'), pipeline_bridge_0_s1_unreg_firsttransfer, pipeline_bridge_0_s1_reg_firsttransfer);
  --pipeline_bridge_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  pipeline_bridge_0_s1_unreg_firsttransfer <= NOT ((pipeline_bridge_0_s1_slavearbiterlockenable AND pipeline_bridge_0_s1_any_continuerequest));
  --pipeline_bridge_0_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pipeline_bridge_0_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pipeline_bridge_0_s1_begins_xfer) = '1' then 
        pipeline_bridge_0_s1_reg_firsttransfer <= pipeline_bridge_0_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pipeline_bridge_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pipeline_bridge_0_s1_beginbursttransfer_internal <= pipeline_bridge_0_s1_begins_xfer;
  --pipeline_bridge_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  pipeline_bridge_0_s1_arbitration_holdoff_internal <= pipeline_bridge_0_s1_begins_xfer AND pipeline_bridge_0_s1_firsttransfer;
  --pipeline_bridge_0_s1_read assignment, which is an e_mux
  pipeline_bridge_0_s1_read <= internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 AND unici_core_burst_0_downstream_read;
  --pipeline_bridge_0_s1_write assignment, which is an e_mux
  pipeline_bridge_0_s1_write <= internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 AND unici_core_burst_0_downstream_write;
  shifted_address_to_pipeline_bridge_0_s1_from_unici_core_burst_0_downstream <= unici_core_burst_0_downstream_address_to_slave;
  --pipeline_bridge_0_s1_address mux, which is an e_mux
  pipeline_bridge_0_s1_address <= A_EXT (A_SRL(shifted_address_to_pipeline_bridge_0_s1_from_unici_core_burst_0_downstream,std_logic_vector'("00000000000000000000000000000011")), 12);
  --slaveid pipeline_bridge_0_s1_nativeaddress nativeaddress mux, which is an e_mux
  pipeline_bridge_0_s1_nativeaddress <= unici_core_burst_0_downstream_nativeaddress (11 DOWNTO 0);
  --d1_pipeline_bridge_0_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pipeline_bridge_0_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pipeline_bridge_0_s1_end_xfer <= pipeline_bridge_0_s1_end_xfer;
    end if;

  end process;

  --pipeline_bridge_0_s1_waits_for_read in a cycle, which is an e_mux
  pipeline_bridge_0_s1_waits_for_read <= pipeline_bridge_0_s1_in_a_read_cycle AND internal_pipeline_bridge_0_s1_waitrequest_from_sa;
  --pipeline_bridge_0_s1_in_a_read_cycle assignment, which is an e_assign
  pipeline_bridge_0_s1_in_a_read_cycle <= internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 AND unici_core_burst_0_downstream_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pipeline_bridge_0_s1_in_a_read_cycle;
  --pipeline_bridge_0_s1_waits_for_write in a cycle, which is an e_mux
  pipeline_bridge_0_s1_waits_for_write <= pipeline_bridge_0_s1_in_a_write_cycle AND internal_pipeline_bridge_0_s1_waitrequest_from_sa;
  --pipeline_bridge_0_s1_in_a_write_cycle assignment, which is an e_assign
  pipeline_bridge_0_s1_in_a_write_cycle <= internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 AND unici_core_burst_0_downstream_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pipeline_bridge_0_s1_in_a_write_cycle;
  wait_for_pipeline_bridge_0_s1_counter <= std_logic'('0');
  --pipeline_bridge_0_s1_byteenable byte enable port mux, which is an e_mux
  pipeline_bridge_0_s1_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1)) = '1'), (std_logic_vector'("000000000000000000000000") & (unici_core_burst_0_downstream_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 8);
  --burstcount mux, which is an e_mux
  pipeline_bridge_0_s1_burstcount <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_0_downstream_burstcount))), std_logic_vector'("00000000000000000000000000000001")));
  --pipeline_bridge_0/s1 arbiterlock assigned from _handle_arbiterlock, which is an e_mux
  pipeline_bridge_0_s1_arbiterlock <= unici_core_burst_0_downstream_arbiterlock;
  --pipeline_bridge_0/s1 arbiterlock2 assigned from _handle_arbiterlock2, which is an e_mux
  pipeline_bridge_0_s1_arbiterlock2 <= unici_core_burst_0_downstream_arbiterlock2;
  --debugaccess mux, which is an e_mux
  pipeline_bridge_0_s1_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_0_downstream_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  pipeline_bridge_0_s1_waitrequest_from_sa <= internal_pipeline_bridge_0_s1_waitrequest_from_sa;
  --vhdl renameroo for output signals
  unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 <= internal_unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1;
  --vhdl renameroo for output signals
  unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 <= internal_unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1;
  --vhdl renameroo for output signals
  unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 <= internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1;
--synthesis translate_off
    --pipeline_bridge_0/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --unici_core_burst_0/downstream non-zero arbitrationshare assertion, which is an e_process
    process (clk)
    VARIABLE write_line20 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 AND to_std_logic((((std_logic_vector'("0000000000000000000000") & (unici_core_burst_0_downstream_arbitrationshare)) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line20, now);
          write(write_line20, string'(": "));
          write(write_line20, string'("unici_core_burst_0/downstream drove 0 on its 'arbitrationshare' port while accessing slave pipeline_bridge_0/s1"));
          write(output, write_line20.all);
          deallocate (write_line20);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_0/downstream non-zero burstcount assertion, which is an e_process
    process (clk)
    VARIABLE write_line21 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_0_downstream_burstcount))) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line21, now);
          write(write_line21, string'(": "));
          write(write_line21, string'("unici_core_burst_0/downstream drove 0 on its 'burstcount' port while accessing slave pipeline_bridge_0/s1"));
          write(output, write_line21.all);
          deallocate (write_line21);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity pipeline_bridge_0_m1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal d1_int_ctrl_0_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal int_ctrl_0_avalon_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal pipeline_bridge_0_m1_burstcount : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal pipeline_bridge_0_m1_chipselect : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_read : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_write : IN STD_LOGIC;
                 signal pipeline_bridge_0_m1_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal pipeline_bridge_0_m1_address_to_slave : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal pipeline_bridge_0_m1_dbs_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal pipeline_bridge_0_m1_dbs_write_32 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pipeline_bridge_0_m1_latency_counter : OUT STD_LOGIC;
                 signal pipeline_bridge_0_m1_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pipeline_bridge_0_m1_readdatavalid : OUT STD_LOGIC;
                 signal pipeline_bridge_0_m1_waitrequest : OUT STD_LOGIC
              );
end entity pipeline_bridge_0_m1_arbitrator;


architecture europa of pipeline_bridge_0_m1_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal dbs_32_reg_segment_0 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_pipeline_bridge_0_m1_address_to_slave :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal internal_pipeline_bridge_0_m1_dbs_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal internal_pipeline_bridge_0_m1_waitrequest :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal p1_dbs_32_reg_segment_0 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pipeline_bridge_0_m1_address_last_time :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal pipeline_bridge_0_m1_burstcount_last_time :  STD_LOGIC;
                signal pipeline_bridge_0_m1_byteenable_last_time :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pipeline_bridge_0_m1_chipselect_last_time :  STD_LOGIC;
                signal pipeline_bridge_0_m1_dbs_increment :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pipeline_bridge_0_m1_read_last_time :  STD_LOGIC;
                signal pipeline_bridge_0_m1_run :  STD_LOGIC;
                signal pipeline_bridge_0_m1_write_last_time :  STD_LOGIC;
                signal pipeline_bridge_0_m1_writedata_last_time :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_pipeline_bridge_0_m1_readdatavalid :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave OR (((((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect)) AND NOT(or_reduce(pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave))) AND internal_pipeline_bridge_0_m1_dbs_address(2)))) OR NOT pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave OR NOT ((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect)))))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT int_ctrl_0_avalon_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_pipeline_bridge_0_m1_dbs_address(2)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave OR NOT ((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect)))))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT int_ctrl_0_avalon_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_pipeline_bridge_0_m1_dbs_address(2)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect)))))))))));
  --cascaded wait assignment, which is an e_assign
  pipeline_bridge_0_m1_run <= r_1;
  --optimize select-logic by passing only those address bits which matter.
  internal_pipeline_bridge_0_m1_address_to_slave <= pipeline_bridge_0_m1_address(14 DOWNTO 0);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic((((((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_read AND pipeline_bridge_0_m1_chipselect)))))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT int_ctrl_0_avalon_slave_waitrequest_from_sa)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave AND ((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect)))))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT int_ctrl_0_avalon_slave_waitrequest_from_sa)))))));
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_pipeline_bridge_0_m1_readdatavalid <= std_logic'('0');
  --latent slave read data valid which is not flushed, which is an e_mux
  pipeline_bridge_0_m1_readdatavalid <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000000") OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pre_flush_pipeline_bridge_0_m1_readdatavalid)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave AND dbs_counter_overflow)))))));
  --input to dbs-32 stored 0, which is an e_mux
  p1_dbs_32_reg_segment_0 <= int_ctrl_0_avalon_slave_readdata_from_sa;
  --dbs register for dbs-32 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_32_reg_segment_0 <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_pipeline_bridge_0_m1_dbs_address(2))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_32_reg_segment_0 <= p1_dbs_32_reg_segment_0;
      end if;
    end if;

  end process;

  --pipeline_bridge_0/m1 readdata mux, which is an e_mux
  pipeline_bridge_0_m1_readdata <= Std_Logic_Vector'(int_ctrl_0_avalon_slave_readdata_from_sa(31 DOWNTO 0) & dbs_32_reg_segment_0);
  --mux write dbs 1, which is an e_mux
  pipeline_bridge_0_m1_dbs_write_32 <= A_WE_StdLogicVector((std_logic'((internal_pipeline_bridge_0_m1_dbs_address(2))) = '1'), pipeline_bridge_0_m1_writedata(63 DOWNTO 32), pipeline_bridge_0_m1_writedata(31 DOWNTO 0));
  --actual waitrequest port, which is an e_assign
  internal_pipeline_bridge_0_m1_waitrequest <= NOT pipeline_bridge_0_m1_run;
  --latent max counter, which is an e_assign
  pipeline_bridge_0_m1_latency_counter <= std_logic'('0');
  --dbs count increment, which is an e_mux
  pipeline_bridge_0_m1_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave)) = '1'), std_logic_vector'("00000000000000000000000000000100"), std_logic_vector'("00000000000000000000000000000000")), 3);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_pipeline_bridge_0_m1_dbs_address(2) AND NOT((next_dbs_address(2)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_pipeline_bridge_0_m1_dbs_address)) + (std_logic_vector'("0") & (pipeline_bridge_0_m1_dbs_increment))), 3);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_pipeline_bridge_0_m1_dbs_address <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_pipeline_bridge_0_m1_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_address_to_slave <= internal_pipeline_bridge_0_m1_address_to_slave;
  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_dbs_address <= internal_pipeline_bridge_0_m1_dbs_address;
  --vhdl renameroo for output signals
  pipeline_bridge_0_m1_waitrequest <= internal_pipeline_bridge_0_m1_waitrequest;
--synthesis translate_off
    --pipeline_bridge_0_m1_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_address_last_time <= std_logic_vector'("000000000000000");
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_address_last_time <= pipeline_bridge_0_m1_address;
      end if;

    end process;

    --pipeline_bridge_0/m1 waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_pipeline_bridge_0_m1_waitrequest AND pipeline_bridge_0_m1_chipselect;
      end if;

    end process;

    --pipeline_bridge_0_m1_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line22 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((pipeline_bridge_0_m1_address /= pipeline_bridge_0_m1_address_last_time))))) = '1' then 
          write(write_line22, now);
          write(write_line22, string'(": "));
          write(write_line22, string'("pipeline_bridge_0_m1_address did not heed wait!!!"));
          write(output, write_line22.all);
          deallocate (write_line22);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pipeline_bridge_0_m1_chipselect check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_chipselect_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_chipselect_last_time <= pipeline_bridge_0_m1_chipselect;
      end if;

    end process;

    --pipeline_bridge_0_m1_chipselect matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line23 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(pipeline_bridge_0_m1_chipselect) /= std_logic'(pipeline_bridge_0_m1_chipselect_last_time)))))) = '1' then 
          write(write_line23, now);
          write(write_line23, string'(": "));
          write(write_line23, string'("pipeline_bridge_0_m1_chipselect did not heed wait!!!"));
          write(output, write_line23.all);
          deallocate (write_line23);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pipeline_bridge_0_m1_burstcount check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_burstcount_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_burstcount_last_time <= pipeline_bridge_0_m1_burstcount;
      end if;

    end process;

    --pipeline_bridge_0_m1_burstcount matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line24 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(pipeline_bridge_0_m1_burstcount) /= std_logic'(pipeline_bridge_0_m1_burstcount_last_time)))))) = '1' then 
          write(write_line24, now);
          write(write_line24, string'(": "));
          write(write_line24, string'("pipeline_bridge_0_m1_burstcount did not heed wait!!!"));
          write(output, write_line24.all);
          deallocate (write_line24);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pipeline_bridge_0_m1_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_byteenable_last_time <= std_logic_vector'("00000000");
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_byteenable_last_time <= pipeline_bridge_0_m1_byteenable;
      end if;

    end process;

    --pipeline_bridge_0_m1_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line25 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((pipeline_bridge_0_m1_byteenable /= pipeline_bridge_0_m1_byteenable_last_time))))) = '1' then 
          write(write_line25, now);
          write(write_line25, string'(": "));
          write(write_line25, string'("pipeline_bridge_0_m1_byteenable did not heed wait!!!"));
          write(output, write_line25.all);
          deallocate (write_line25);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pipeline_bridge_0_m1_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_read_last_time <= pipeline_bridge_0_m1_read;
      end if;

    end process;

    --pipeline_bridge_0_m1_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line26 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(pipeline_bridge_0_m1_read) /= std_logic'(pipeline_bridge_0_m1_read_last_time)))))) = '1' then 
          write(write_line26, now);
          write(write_line26, string'(": "));
          write(write_line26, string'("pipeline_bridge_0_m1_read did not heed wait!!!"));
          write(output, write_line26.all);
          deallocate (write_line26);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pipeline_bridge_0_m1_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_write_last_time <= pipeline_bridge_0_m1_write;
      end if;

    end process;

    --pipeline_bridge_0_m1_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line27 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(pipeline_bridge_0_m1_write) /= std_logic'(pipeline_bridge_0_m1_write_last_time)))))) = '1' then 
          write(write_line27, now);
          write(write_line27, string'(": "));
          write(write_line27, string'("pipeline_bridge_0_m1_write did not heed wait!!!"));
          write(output, write_line27.all);
          deallocate (write_line27);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --pipeline_bridge_0_m1_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        pipeline_bridge_0_m1_writedata_last_time <= std_logic_vector'("0000000000000000000000000000000000000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        pipeline_bridge_0_m1_writedata_last_time <= pipeline_bridge_0_m1_writedata;
      end if;

    end process;

    --pipeline_bridge_0_m1_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line28 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((pipeline_bridge_0_m1_writedata /= pipeline_bridge_0_m1_writedata_last_time)))) AND ((pipeline_bridge_0_m1_write AND pipeline_bridge_0_m1_chipselect)))) = '1' then 
          write(write_line28, now);
          write(write_line28, string'(": "));
          write(write_line28, string'("pipeline_bridge_0_m1_writedata did not heed wait!!!"));
          write(output, write_line28.all);
          deallocate (write_line28);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pipeline_bridge_0_bridge_arbitrator is 
end entity pipeline_bridge_0_bridge_arbitrator;


architecture europa of pipeline_bridge_0_bridge_arbitrator is

begin


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity spi_master_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal spi_master_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal spi_master_0_avalon_slave_0_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal d1_spi_master_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal spi_master_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal spi_master_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal spi_master_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal spi_master_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal spi_master_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal spi_master_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal spi_master_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity spi_master_0_avalon_slave_0_arbitrator;


architecture europa of spi_master_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_spi_master_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal shifted_address_to_spi_master_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal wait_for_spi_master_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT spi_master_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  spi_master_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0);
  --assign spi_master_0_avalon_slave_0_readdata_from_sa = spi_master_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  spi_master_0_avalon_slave_0_readdata_from_sa <= spi_master_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --assign spi_master_0_avalon_slave_0_waitrequest_from_sa = spi_master_0_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_spi_master_0_avalon_slave_0_waitrequest_from_sa <= spi_master_0_avalon_slave_0_waitrequest;
  --spi_master_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  spi_master_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --spi_master_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  spi_master_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0;
  --spi_master_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  spi_master_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --spi_master_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  spi_master_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(spi_master_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (spi_master_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(spi_master_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (spi_master_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --spi_master_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  spi_master_0_avalon_slave_0_allgrants <= spi_master_0_avalon_slave_0_grant_vector;
  --spi_master_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  spi_master_0_avalon_slave_0_end_xfer <= NOT ((spi_master_0_avalon_slave_0_waits_for_read OR spi_master_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0 <= spi_master_0_avalon_slave_0_end_xfer AND (((NOT spi_master_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --spi_master_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  spi_master_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0 AND spi_master_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0 AND NOT spi_master_0_avalon_slave_0_non_bursting_master_requests));
  --spi_master_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      spi_master_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(spi_master_0_avalon_slave_0_arb_counter_enable) = '1' then 
        spi_master_0_avalon_slave_0_arb_share_counter <= spi_master_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --spi_master_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      spi_master_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((spi_master_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_spi_master_0_avalon_slave_0 AND NOT spi_master_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        spi_master_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(spi_master_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master spi_master_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= spi_master_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --spi_master_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  spi_master_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(spi_master_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master spi_master_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= spi_master_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --spi_master_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  spi_master_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 AND NOT (((NOT(or_reduce(internal_int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0))) AND int_ctrl_0_avalon_master_write));
  --spi_master_0_avalon_slave_0_writedata mux, which is an e_mux
  spi_master_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_dbs_write_16;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant spi_master_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0;
  --allow new arb cycle for spi_master_0/avalon_slave_0, which is an e_assign
  spi_master_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  spi_master_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  spi_master_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~spi_master_0_avalon_slave_0_reset assignment, which is an e_assign
  spi_master_0_avalon_slave_0_reset <= NOT reset_n;
  --spi_master_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  spi_master_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(spi_master_0_avalon_slave_0_begins_xfer) = '1'), spi_master_0_avalon_slave_0_unreg_firsttransfer, spi_master_0_avalon_slave_0_reg_firsttransfer);
  --spi_master_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  spi_master_0_avalon_slave_0_unreg_firsttransfer <= NOT ((spi_master_0_avalon_slave_0_slavearbiterlockenable AND spi_master_0_avalon_slave_0_any_continuerequest));
  --spi_master_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      spi_master_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(spi_master_0_avalon_slave_0_begins_xfer) = '1' then 
        spi_master_0_avalon_slave_0_reg_firsttransfer <= spi_master_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --spi_master_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  spi_master_0_avalon_slave_0_beginbursttransfer_internal <= spi_master_0_avalon_slave_0_begins_xfer;
  --spi_master_0_avalon_slave_0_write assignment, which is an e_mux
  spi_master_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_spi_master_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= A_EXT (Std_Logic_Vector'(A_SRL(int_ctrl_0_avalon_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(int_ctrl_0_avalon_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 15);
  --spi_master_0_avalon_slave_0_address mux, which is an e_mux
  spi_master_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_spi_master_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000001")), 10);
  --d1_spi_master_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_spi_master_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_spi_master_0_avalon_slave_0_end_xfer <= spi_master_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --spi_master_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  spi_master_0_avalon_slave_0_waits_for_read <= spi_master_0_avalon_slave_0_in_a_read_cycle AND internal_spi_master_0_avalon_slave_0_waitrequest_from_sa;
  --spi_master_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  spi_master_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= spi_master_0_avalon_slave_0_in_a_read_cycle;
  --spi_master_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  spi_master_0_avalon_slave_0_waits_for_write <= spi_master_0_avalon_slave_0_in_a_write_cycle AND internal_spi_master_0_avalon_slave_0_waitrequest_from_sa;
  --spi_master_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  spi_master_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= spi_master_0_avalon_slave_0_in_a_write_cycle;
  wait_for_spi_master_0_avalon_slave_0_counter <= std_logic'('0');
  --spi_master_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  spi_master_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_1(1), int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_1(0), int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_0(1), int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_0(0)) <= int_ctrl_0_avalon_master_byteenable;
  internal_int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_0, int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  spi_master_0_avalon_slave_0_waitrequest_from_sa <= internal_spi_master_0_avalon_slave_0_waitrequest_from_sa;
--synthesis translate_off
    --spi_master_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twi_master_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal d1_twi_master_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal twi_master_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal twi_master_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal twi_master_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal twi_master_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal twi_master_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal twi_master_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity twi_master_0_avalon_slave_0_arbitrator;


architecture europa of twi_master_0_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_twi_master_0_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal wait_for_twi_master_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT twi_master_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  twi_master_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0);
  --assign twi_master_0_avalon_slave_0_readdata_from_sa = twi_master_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  twi_master_0_avalon_slave_0_readdata_from_sa <= twi_master_0_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100100000000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --twi_master_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  twi_master_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --twi_master_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  twi_master_0_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0;
  --twi_master_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  twi_master_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --twi_master_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  twi_master_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(twi_master_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (twi_master_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(twi_master_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (twi_master_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --twi_master_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  twi_master_0_avalon_slave_0_allgrants <= twi_master_0_avalon_slave_0_grant_vector;
  --twi_master_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  twi_master_0_avalon_slave_0_end_xfer <= NOT ((twi_master_0_avalon_slave_0_waits_for_read OR twi_master_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0 <= twi_master_0_avalon_slave_0_end_xfer AND (((NOT twi_master_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --twi_master_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  twi_master_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0 AND twi_master_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0 AND NOT twi_master_0_avalon_slave_0_non_bursting_master_requests));
  --twi_master_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      twi_master_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(twi_master_0_avalon_slave_0_arb_counter_enable) = '1' then 
        twi_master_0_avalon_slave_0_arb_share_counter <= twi_master_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --twi_master_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      twi_master_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((twi_master_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_twi_master_0_avalon_slave_0 AND NOT twi_master_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        twi_master_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(twi_master_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master twi_master_0/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= twi_master_0_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --twi_master_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  twi_master_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(twi_master_0_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master twi_master_0/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= twi_master_0_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --twi_master_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  twi_master_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 AND NOT (((NOT(or_reduce(internal_int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0))) AND int_ctrl_0_avalon_master_write));
  --twi_master_0_avalon_slave_0_writedata mux, which is an e_mux
  twi_master_0_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_dbs_write_16;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant twi_master_0/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0;
  --allow new arb cycle for twi_master_0/avalon_slave_0, which is an e_assign
  twi_master_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  twi_master_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  twi_master_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~twi_master_0_avalon_slave_0_reset assignment, which is an e_assign
  twi_master_0_avalon_slave_0_reset <= NOT reset_n;
  --twi_master_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  twi_master_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(twi_master_0_avalon_slave_0_begins_xfer) = '1'), twi_master_0_avalon_slave_0_unreg_firsttransfer, twi_master_0_avalon_slave_0_reg_firsttransfer);
  --twi_master_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  twi_master_0_avalon_slave_0_unreg_firsttransfer <= NOT ((twi_master_0_avalon_slave_0_slavearbiterlockenable AND twi_master_0_avalon_slave_0_any_continuerequest));
  --twi_master_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      twi_master_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(twi_master_0_avalon_slave_0_begins_xfer) = '1' then 
        twi_master_0_avalon_slave_0_reg_firsttransfer <= twi_master_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --twi_master_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  twi_master_0_avalon_slave_0_beginbursttransfer_internal <= twi_master_0_avalon_slave_0_begins_xfer;
  --twi_master_0_avalon_slave_0_write assignment, which is an e_mux
  twi_master_0_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_twi_master_0_avalon_slave_0_from_int_ctrl_0_avalon_master <= A_EXT (Std_Logic_Vector'(A_SRL(int_ctrl_0_avalon_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(int_ctrl_0_avalon_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 15);
  --twi_master_0_avalon_slave_0_address mux, which is an e_mux
  twi_master_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_twi_master_0_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000001")), 2);
  --d1_twi_master_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_twi_master_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_twi_master_0_avalon_slave_0_end_xfer <= twi_master_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --twi_master_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  twi_master_0_avalon_slave_0_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(twi_master_0_avalon_slave_0_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --twi_master_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  twi_master_0_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= twi_master_0_avalon_slave_0_in_a_read_cycle;
  --twi_master_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  twi_master_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(twi_master_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --twi_master_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  twi_master_0_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= twi_master_0_avalon_slave_0_in_a_write_cycle;
  wait_for_twi_master_0_avalon_slave_0_counter <= std_logic'('0');
  --twi_master_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  twi_master_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_1(1), int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_1(0), int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_0(1), int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_0(0)) <= int_ctrl_0_avalon_master_byteenable;
  internal_int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_0, int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0;
--synthesis translate_off
    --twi_master_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twi_master_0_avalon_streaming_sink_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_out_8b_sync_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal fifo_out_8b_sync_0_avalon_streaming_source_valid : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_0_avalon_streaming_sink_ready : IN STD_LOGIC;

              -- outputs:
                 signal twi_master_0_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal twi_master_0_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                 signal twi_master_0_avalon_streaming_sink_valid : OUT STD_LOGIC
              );
end entity twi_master_0_avalon_streaming_sink_arbitrator;


architecture europa of twi_master_0_avalon_streaming_sink_arbitrator is

begin

  --mux twi_master_0_avalon_streaming_sink_data, which is an e_mux
  twi_master_0_avalon_streaming_sink_data <= fifo_out_8b_sync_0_avalon_streaming_source_data;
  --assign twi_master_0_avalon_streaming_sink_ready_from_sa = twi_master_0_avalon_streaming_sink_ready so that symbol knows where to group signals which may go to master only, which is an e_assign
  twi_master_0_avalon_streaming_sink_ready_from_sa <= twi_master_0_avalon_streaming_sink_ready;
  --mux twi_master_0_avalon_streaming_sink_valid, which is an e_mux
  twi_master_0_avalon_streaming_sink_valid <= fifo_out_8b_sync_0_avalon_streaming_source_valid;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twi_master_0_avalon_streaming_source_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal twi_master_0_avalon_streaming_source_valid : IN STD_LOGIC;

              -- outputs:
                 signal twi_master_0_avalon_streaming_source_ready : OUT STD_LOGIC
              );
end entity twi_master_0_avalon_streaming_source_arbitrator;


architecture europa of twi_master_0_avalon_streaming_source_arbitrator is

begin

  --mux twi_master_0_avalon_streaming_source_ready, which is an e_mux
  twi_master_0_avalon_streaming_source_ready <= fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twi_master_1_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                 signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal d1_twi_master_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                 signal twi_master_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal twi_master_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal twi_master_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal twi_master_1_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal twi_master_1_avalon_slave_0_write : OUT STD_LOGIC;
                 signal twi_master_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity twi_master_1_avalon_slave_0_arbitrator;


architecture europa of twi_master_1_avalon_slave_0_arbitrator is
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_arbiterlock2 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_continuerequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_saved_grant_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal internal_int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_twi_master_1_avalon_slave_0_from_int_ctrl_0_avalon_master :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_allgrants :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal wait_for_twi_master_1_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT twi_master_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  twi_master_1_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0);
  --assign twi_master_1_avalon_slave_0_readdata_from_sa = twi_master_1_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  twi_master_1_avalon_slave_0_readdata_from_sa <= twi_master_1_avalon_slave_0_readdata;
  internal_int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(int_ctrl_0_avalon_master_address_to_slave(14 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100100001000000")))) AND ((int_ctrl_0_avalon_master_read OR int_ctrl_0_avalon_master_write));
  --twi_master_1_avalon_slave_0_arb_share_counter set values, which is an e_mux
  twi_master_1_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --twi_master_1_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  twi_master_1_avalon_slave_0_non_bursting_master_requests <= internal_int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0;
  --twi_master_1_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  twi_master_1_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --twi_master_1_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  twi_master_1_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(twi_master_1_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (twi_master_1_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(twi_master_1_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (twi_master_1_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --twi_master_1_avalon_slave_0_allgrants all slave grants, which is an e_mux
  twi_master_1_avalon_slave_0_allgrants <= twi_master_1_avalon_slave_0_grant_vector;
  --twi_master_1_avalon_slave_0_end_xfer assignment, which is an e_assign
  twi_master_1_avalon_slave_0_end_xfer <= NOT ((twi_master_1_avalon_slave_0_waits_for_read OR twi_master_1_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0 <= twi_master_1_avalon_slave_0_end_xfer AND (((NOT twi_master_1_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --twi_master_1_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  twi_master_1_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0 AND twi_master_1_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0 AND NOT twi_master_1_avalon_slave_0_non_bursting_master_requests));
  --twi_master_1_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      twi_master_1_avalon_slave_0_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(twi_master_1_avalon_slave_0_arb_counter_enable) = '1' then 
        twi_master_1_avalon_slave_0_arb_share_counter <= twi_master_1_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --twi_master_1_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      twi_master_1_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((twi_master_1_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_twi_master_1_avalon_slave_0 AND NOT twi_master_1_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        twi_master_1_avalon_slave_0_slavearbiterlockenable <= or_reduce(twi_master_1_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --int_ctrl_0/avalon_master twi_master_1/avalon_slave_0 arbiterlock, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock <= twi_master_1_avalon_slave_0_slavearbiterlockenable AND int_ctrl_0_avalon_master_continuerequest;
  --twi_master_1_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  twi_master_1_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(twi_master_1_avalon_slave_0_arb_share_counter_next_value);
  --int_ctrl_0/avalon_master twi_master_1/avalon_slave_0 arbiterlock2, which is an e_assign
  int_ctrl_0_avalon_master_arbiterlock2 <= twi_master_1_avalon_slave_0_slavearbiterlockenable2 AND int_ctrl_0_avalon_master_continuerequest;
  --twi_master_1_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  twi_master_1_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --int_ctrl_0_avalon_master_continuerequest continued request, which is an e_assign
  int_ctrl_0_avalon_master_continuerequest <= std_logic'('1');
  internal_int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 AND NOT (((NOT(or_reduce(internal_int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0))) AND int_ctrl_0_avalon_master_write));
  --twi_master_1_avalon_slave_0_writedata mux, which is an e_mux
  twi_master_1_avalon_slave_0_writedata <= int_ctrl_0_avalon_master_dbs_write_16;
  --master is always granted when requested
  internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0;
  --int_ctrl_0/avalon_master saved-grant twi_master_1/avalon_slave_0, which is an e_assign
  int_ctrl_0_avalon_master_saved_grant_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0;
  --allow new arb cycle for twi_master_1/avalon_slave_0, which is an e_assign
  twi_master_1_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  twi_master_1_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  twi_master_1_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~twi_master_1_avalon_slave_0_reset assignment, which is an e_assign
  twi_master_1_avalon_slave_0_reset <= NOT reset_n;
  --twi_master_1_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  twi_master_1_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(twi_master_1_avalon_slave_0_begins_xfer) = '1'), twi_master_1_avalon_slave_0_unreg_firsttransfer, twi_master_1_avalon_slave_0_reg_firsttransfer);
  --twi_master_1_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  twi_master_1_avalon_slave_0_unreg_firsttransfer <= NOT ((twi_master_1_avalon_slave_0_slavearbiterlockenable AND twi_master_1_avalon_slave_0_any_continuerequest));
  --twi_master_1_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      twi_master_1_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(twi_master_1_avalon_slave_0_begins_xfer) = '1' then 
        twi_master_1_avalon_slave_0_reg_firsttransfer <= twi_master_1_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --twi_master_1_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  twi_master_1_avalon_slave_0_beginbursttransfer_internal <= twi_master_1_avalon_slave_0_begins_xfer;
  --twi_master_1_avalon_slave_0_write assignment, which is an e_mux
  twi_master_1_avalon_slave_0_write <= internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  shifted_address_to_twi_master_1_avalon_slave_0_from_int_ctrl_0_avalon_master <= A_EXT (Std_Logic_Vector'(A_SRL(int_ctrl_0_avalon_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(int_ctrl_0_avalon_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 15);
  --twi_master_1_avalon_slave_0_address mux, which is an e_mux
  twi_master_1_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_twi_master_1_avalon_slave_0_from_int_ctrl_0_avalon_master,std_logic_vector'("00000000000000000000000000000001")), 2);
  --d1_twi_master_1_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_twi_master_1_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_twi_master_1_avalon_slave_0_end_xfer <= twi_master_1_avalon_slave_0_end_xfer;
    end if;

  end process;

  --twi_master_1_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  twi_master_1_avalon_slave_0_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(twi_master_1_avalon_slave_0_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --twi_master_1_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  twi_master_1_avalon_slave_0_in_a_read_cycle <= internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 AND int_ctrl_0_avalon_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= twi_master_1_avalon_slave_0_in_a_read_cycle;
  --twi_master_1_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  twi_master_1_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(twi_master_1_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --twi_master_1_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  twi_master_1_avalon_slave_0_in_a_write_cycle <= internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 AND int_ctrl_0_avalon_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= twi_master_1_avalon_slave_0_in_a_write_cycle;
  wait_for_twi_master_1_avalon_slave_0_counter <= std_logic'('0');
  --twi_master_1_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  twi_master_1_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_1(1), int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_1(0), int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_0(1), int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_0(0)) <= int_ctrl_0_avalon_master_byteenable;
  internal_int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(int_ctrl_0_avalon_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_0, int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0_segment_1);
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0;
  --vhdl renameroo for output signals
  int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 <= internal_int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0;
--synthesis translate_off
    --twi_master_1/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twi_master_1_avalon_streaming_sink_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_out_8b_sync_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal fifo_out_8b_sync_1_avalon_streaming_source_valid : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_1_avalon_streaming_sink_ready : IN STD_LOGIC;

              -- outputs:
                 signal twi_master_1_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal twi_master_1_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                 signal twi_master_1_avalon_streaming_sink_valid : OUT STD_LOGIC
              );
end entity twi_master_1_avalon_streaming_sink_arbitrator;


architecture europa of twi_master_1_avalon_streaming_sink_arbitrator is

begin

  --mux twi_master_1_avalon_streaming_sink_data, which is an e_mux
  twi_master_1_avalon_streaming_sink_data <= fifo_out_8b_sync_1_avalon_streaming_source_data;
  --assign twi_master_1_avalon_streaming_sink_ready_from_sa = twi_master_1_avalon_streaming_sink_ready so that symbol knows where to group signals which may go to master only, which is an e_assign
  twi_master_1_avalon_streaming_sink_ready_from_sa <= twi_master_1_avalon_streaming_sink_ready;
  --mux twi_master_1_avalon_streaming_sink_valid, which is an e_mux
  twi_master_1_avalon_streaming_sink_valid <= fifo_out_8b_sync_1_avalon_streaming_source_valid;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twi_master_1_avalon_streaming_source_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal twi_master_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal twi_master_1_avalon_streaming_source_valid : IN STD_LOGIC;

              -- outputs:
                 signal twi_master_1_avalon_streaming_source_ready : OUT STD_LOGIC
              );
end entity twi_master_1_avalon_streaming_source_arbitrator;


architecture europa of twi_master_1_avalon_streaming_source_arbitrator is

begin

  --mux twi_master_1_avalon_streaming_source_ready, which is an e_mux
  twi_master_1_avalon_streaming_source_ready <= fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity burstcount_fifo_for_unici_core_burst_0_upstream_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity burstcount_fifo_for_unici_core_burst_0_upstream_module;


architecture europa of burstcount_fifo_for_unici_core_burst_0_upstream_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_0 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_1 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_2 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_3 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_4 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_4;
  empty <= NOT(full_0);
  full_5 <= std_logic'('0');
  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic_vector'("0000000000");
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic_vector'("0000000000");
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic_vector'("0000000000");
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic_vector'("0000000000");
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic_vector'("0000000000");
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(or_reduce(data_in)))), A_WE_StdLogicVector((std_logic'(((((read AND (or_reduce(data_in))) AND write) AND (or_reduce(stage_0))))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (or_reduce(data_in))))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (or_reduce(stage_0))))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream_module;


architecture europa of rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_4;
  empty <= NOT(full_0);
  full_5 <= std_logic'('0');
  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity unici_core_burst_0_upstream_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_address_to_slave : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_latency_counter : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_write : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_0_upstream_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_0_upstream_readdatavalid : IN STD_LOGIC;
                 signal unici_core_burst_0_upstream_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal d1_unici_core_burst_0_upstream_end_xfer : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream : OUT STD_LOGIC;
                 signal unici_core_burst_0_upstream_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal unici_core_burst_0_upstream_burstcount : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal unici_core_burst_0_upstream_byteaddress : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal unici_core_burst_0_upstream_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal unici_core_burst_0_upstream_debugaccess : OUT STD_LOGIC;
                 signal unici_core_burst_0_upstream_read : OUT STD_LOGIC;
                 signal unici_core_burst_0_upstream_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_0_upstream_waitrequest_from_sa : OUT STD_LOGIC;
                 signal unici_core_burst_0_upstream_write : OUT STD_LOGIC;
                 signal unici_core_burst_0_upstream_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
              );
end entity unici_core_burst_0_upstream_arbitrator;


architecture europa of unici_core_burst_0_upstream_arbitrator is
component burstcount_fifo_for_unici_core_burst_0_upstream_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component burstcount_fifo_for_unici_core_burst_0_upstream_module;

component rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream_module;

                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_unici_core_burst_0_upstream :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream :  STD_LOGIC;
                signal internal_unici_core_burst_0_upstream_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_unici_core_burst_0_upstream_read :  STD_LOGIC;
                signal internal_unici_core_burst_0_upstream_waitrequest_from_sa :  STD_LOGIC;
                signal internal_unici_core_burst_0_upstream_write :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal module_input6 :  STD_LOGIC;
                signal module_input7 :  STD_LOGIC;
                signal module_input8 :  STD_LOGIC;
                signal p0_unici_core_burst_0_upstream_load_fifo :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_arbiterlock :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_arbiterlock2 :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_continuerequest :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_rdv_fifo_empty_unici_core_burst_0_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_rdv_fifo_output_from_unici_core_burst_0_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_saved_grant_unici_core_burst_0_upstream :  STD_LOGIC;
                signal unici_core_burst_0_upstream_allgrants :  STD_LOGIC;
                signal unici_core_burst_0_upstream_allow_new_arb_cycle :  STD_LOGIC;
                signal unici_core_burst_0_upstream_any_bursting_master_saved_grant :  STD_LOGIC;
                signal unici_core_burst_0_upstream_any_continuerequest :  STD_LOGIC;
                signal unici_core_burst_0_upstream_arb_counter_enable :  STD_LOGIC;
                signal unici_core_burst_0_upstream_arb_share_counter :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_arb_share_counter_next_value :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_arb_share_set_values :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_bbt_burstcounter :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal unici_core_burst_0_upstream_beginbursttransfer_internal :  STD_LOGIC;
                signal unici_core_burst_0_upstream_begins_xfer :  STD_LOGIC;
                signal unici_core_burst_0_upstream_burstcount_fifo_empty :  STD_LOGIC;
                signal unici_core_burst_0_upstream_current_burst :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_current_burst_minus_one :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_end_xfer :  STD_LOGIC;
                signal unici_core_burst_0_upstream_firsttransfer :  STD_LOGIC;
                signal unici_core_burst_0_upstream_grant_vector :  STD_LOGIC;
                signal unici_core_burst_0_upstream_in_a_read_cycle :  STD_LOGIC;
                signal unici_core_burst_0_upstream_in_a_write_cycle :  STD_LOGIC;
                signal unici_core_burst_0_upstream_load_fifo :  STD_LOGIC;
                signal unici_core_burst_0_upstream_master_qreq_vector :  STD_LOGIC;
                signal unici_core_burst_0_upstream_move_on_to_next_transaction :  STD_LOGIC;
                signal unici_core_burst_0_upstream_next_bbt_burstcount :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal unici_core_burst_0_upstream_next_burst_count :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_non_bursting_master_requests :  STD_LOGIC;
                signal unici_core_burst_0_upstream_readdatavalid_from_sa :  STD_LOGIC;
                signal unici_core_burst_0_upstream_reg_firsttransfer :  STD_LOGIC;
                signal unici_core_burst_0_upstream_selected_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_slavearbiterlockenable :  STD_LOGIC;
                signal unici_core_burst_0_upstream_slavearbiterlockenable2 :  STD_LOGIC;
                signal unici_core_burst_0_upstream_this_cycle_is_the_last_burst :  STD_LOGIC;
                signal unici_core_burst_0_upstream_transaction_burst_count :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_unreg_firsttransfer :  STD_LOGIC;
                signal unici_core_burst_0_upstream_waits_for_read :  STD_LOGIC;
                signal unici_core_burst_0_upstream_waits_for_write :  STD_LOGIC;
                signal wait_for_unici_core_burst_0_upstream_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT unici_core_burst_0_upstream_end_xfer;
    end if;

  end process;

  unici_core_burst_0_upstream_begins_xfer <= NOT d1_reasons_to_wait AND (internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream);
  --assign unici_core_burst_0_upstream_readdata_from_sa = unici_core_burst_0_upstream_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  unici_core_burst_0_upstream_readdata_from_sa <= unici_core_burst_0_upstream_readdata;
  internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream <= to_std_logic(((Std_Logic_Vector'(pcie_compiler_0_Rx_Interface_address_to_slave(31 DOWNTO 15) & std_logic_vector'("000000000000000")) = std_logic_vector'("00000000000000000000000000000000")))) AND ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write));
  --assign unici_core_burst_0_upstream_waitrequest_from_sa = unici_core_burst_0_upstream_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_unici_core_burst_0_upstream_waitrequest_from_sa <= unici_core_burst_0_upstream_waitrequest;
  --assign unici_core_burst_0_upstream_readdatavalid_from_sa = unici_core_burst_0_upstream_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  unici_core_burst_0_upstream_readdatavalid_from_sa <= unici_core_burst_0_upstream_readdatavalid;
  --unici_core_burst_0_upstream_arb_share_counter set values, which is an e_mux
  unici_core_burst_0_upstream_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream)) = '1'), (A_WE_StdLogicVector((std_logic'((pcie_compiler_0_Rx_Interface_write)) = '1'), (std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)), std_logic_vector'("00000000000000000000000000000001"))), std_logic_vector'("00000000000000000000000000000001")), 10);
  --unici_core_burst_0_upstream_non_bursting_master_requests mux, which is an e_mux
  unici_core_burst_0_upstream_non_bursting_master_requests <= std_logic'('0');
  --unici_core_burst_0_upstream_any_bursting_master_saved_grant mux, which is an e_mux
  unici_core_burst_0_upstream_any_bursting_master_saved_grant <= pcie_compiler_0_Rx_Interface_saved_grant_unici_core_burst_0_upstream;
  --unici_core_burst_0_upstream_arb_share_counter_next_value assignment, which is an e_assign
  unici_core_burst_0_upstream_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(unici_core_burst_0_upstream_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000") & (unici_core_burst_0_upstream_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(unici_core_burst_0_upstream_arb_share_counter)) = '1'), (((std_logic_vector'("00000000000000000000000") & (unici_core_burst_0_upstream_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 10);
  --unici_core_burst_0_upstream_allgrants all slave grants, which is an e_mux
  unici_core_burst_0_upstream_allgrants <= unici_core_burst_0_upstream_grant_vector;
  --unici_core_burst_0_upstream_end_xfer assignment, which is an e_assign
  unici_core_burst_0_upstream_end_xfer <= NOT ((unici_core_burst_0_upstream_waits_for_read OR unici_core_burst_0_upstream_waits_for_write));
  --end_xfer_arb_share_counter_term_unici_core_burst_0_upstream arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_unici_core_burst_0_upstream <= unici_core_burst_0_upstream_end_xfer AND (((NOT unici_core_burst_0_upstream_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --unici_core_burst_0_upstream_arb_share_counter arbitration counter enable, which is an e_assign
  unici_core_burst_0_upstream_arb_counter_enable <= ((end_xfer_arb_share_counter_term_unici_core_burst_0_upstream AND unici_core_burst_0_upstream_allgrants)) OR ((end_xfer_arb_share_counter_term_unici_core_burst_0_upstream AND NOT unici_core_burst_0_upstream_non_bursting_master_requests));
  --unici_core_burst_0_upstream_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_0_upstream_arb_share_counter <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(unici_core_burst_0_upstream_arb_counter_enable) = '1' then 
        unici_core_burst_0_upstream_arb_share_counter <= unici_core_burst_0_upstream_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --unici_core_burst_0_upstream_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_0_upstream_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((unici_core_burst_0_upstream_master_qreq_vector AND end_xfer_arb_share_counter_term_unici_core_burst_0_upstream)) OR ((end_xfer_arb_share_counter_term_unici_core_burst_0_upstream AND NOT unici_core_burst_0_upstream_non_bursting_master_requests)))) = '1' then 
        unici_core_burst_0_upstream_slavearbiterlockenable <= or_reduce(unici_core_burst_0_upstream_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --pcie_compiler_0/Rx_Interface unici_core_burst_0/upstream arbiterlock, which is an e_assign
  pcie_compiler_0_Rx_Interface_arbiterlock <= unici_core_burst_0_upstream_slavearbiterlockenable AND pcie_compiler_0_Rx_Interface_continuerequest;
  --unici_core_burst_0_upstream_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  unici_core_burst_0_upstream_slavearbiterlockenable2 <= or_reduce(unici_core_burst_0_upstream_arb_share_counter_next_value);
  --pcie_compiler_0/Rx_Interface unici_core_burst_0/upstream arbiterlock2, which is an e_assign
  pcie_compiler_0_Rx_Interface_arbiterlock2 <= unici_core_burst_0_upstream_slavearbiterlockenable2 AND pcie_compiler_0_Rx_Interface_continuerequest;
  --unici_core_burst_0_upstream_any_continuerequest at least one master continues requesting, which is an e_assign
  unici_core_burst_0_upstream_any_continuerequest <= std_logic'('1');
  --pcie_compiler_0_Rx_Interface_continuerequest continued request, which is an e_assign
  pcie_compiler_0_Rx_Interface_continuerequest <= std_logic'('1');
  internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream <= internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream AND NOT ((pcie_compiler_0_Rx_Interface_read AND ((to_std_logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_latency_counter))))))) OR (pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register)))));
  --unique name for unici_core_burst_0_upstream_move_on_to_next_transaction, which is an e_assign
  unici_core_burst_0_upstream_move_on_to_next_transaction <= unici_core_burst_0_upstream_this_cycle_is_the_last_burst AND unici_core_burst_0_upstream_load_fifo;
  --the currently selected burstcount for unici_core_burst_0_upstream, which is an e_mux
  unici_core_burst_0_upstream_selected_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream)) = '1'), (std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)), std_logic_vector'("00000000000000000000000000000001")), 10);
  --burstcount_fifo_for_unici_core_burst_0_upstream, which is an e_fifo_with_registered_outputs
  burstcount_fifo_for_unici_core_burst_0_upstream : burstcount_fifo_for_unici_core_burst_0_upstream_module
    port map(
      data_out => unici_core_burst_0_upstream_transaction_burst_count,
      empty => unici_core_burst_0_upstream_burstcount_fifo_empty,
      fifo_contains_ones_n => open,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => unici_core_burst_0_upstream_selected_burstcount,
      read => unici_core_burst_0_upstream_this_cycle_is_the_last_burst,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= ((in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read) AND unici_core_burst_0_upstream_load_fifo) AND NOT ((unici_core_burst_0_upstream_this_cycle_is_the_last_burst AND unici_core_burst_0_upstream_burstcount_fifo_empty));

  --unici_core_burst_0_upstream current burst minus one, which is an e_assign
  unici_core_burst_0_upstream_current_burst_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000") & (unici_core_burst_0_upstream_current_burst)) - std_logic_vector'("000000000000000000000000000000001")), 10);
  --what to load in current_burst, for unici_core_burst_0_upstream, which is an e_mux
  unici_core_burst_0_upstream_next_burst_count <= A_WE_StdLogicVector((std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read)) AND NOT unici_core_burst_0_upstream_load_fifo))) = '1'), unici_core_burst_0_upstream_selected_burstcount, A_WE_StdLogicVector((std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read) AND unici_core_burst_0_upstream_this_cycle_is_the_last_burst) AND unici_core_burst_0_upstream_burstcount_fifo_empty))) = '1'), unici_core_burst_0_upstream_selected_burstcount, A_WE_StdLogicVector((std_logic'((unici_core_burst_0_upstream_this_cycle_is_the_last_burst)) = '1'), unici_core_burst_0_upstream_transaction_burst_count, unici_core_burst_0_upstream_current_burst_minus_one)));
  --the current burst count for unici_core_burst_0_upstream, to be decremented, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_0_upstream_current_burst <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((unici_core_burst_0_upstream_readdatavalid_from_sa OR ((NOT unici_core_burst_0_upstream_load_fifo AND ((in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read)))))) = '1' then 
        unici_core_burst_0_upstream_current_burst <= unici_core_burst_0_upstream_next_burst_count;
      end if;
    end if;

  end process;

  --a 1 or burstcount fifo empty, to initialize the counter, which is an e_mux
  p0_unici_core_burst_0_upstream_load_fifo <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((NOT unici_core_burst_0_upstream_load_fifo)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read)) AND unici_core_burst_0_upstream_load_fifo))) = '1'), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT unici_core_burst_0_upstream_burstcount_fifo_empty))))));
  --whether to load directly to the counter or to the fifo, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_0_upstream_load_fifo <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read)) AND NOT unici_core_burst_0_upstream_load_fifo) OR unici_core_burst_0_upstream_this_cycle_is_the_last_burst)) = '1' then 
        unici_core_burst_0_upstream_load_fifo <= p0_unici_core_burst_0_upstream_load_fifo;
      end if;
    end if;

  end process;

  --the last cycle in the burst for unici_core_burst_0_upstream, which is an e_assign
  unici_core_burst_0_upstream_this_cycle_is_the_last_burst <= NOT (or_reduce(unici_core_burst_0_upstream_current_burst_minus_one)) AND unici_core_burst_0_upstream_readdatavalid_from_sa;
  --rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream : rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_0_upstream_module
    port map(
      data_out => pcie_compiler_0_Rx_Interface_rdv_fifo_output_from_unici_core_burst_0_upstream,
      empty => open,
      fifo_contains_ones_n => pcie_compiler_0_Rx_Interface_rdv_fifo_empty_unici_core_burst_0_upstream,
      full => open,
      clear_fifo => module_input6,
      clk => clk,
      data_in => internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream,
      read => unici_core_burst_0_upstream_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input7,
      write => module_input8
    );

  module_input6 <= std_logic'('0');
  module_input7 <= std_logic'('0');
  module_input8 <= in_a_read_cycle AND NOT unici_core_burst_0_upstream_waits_for_read;

  pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register <= NOT pcie_compiler_0_Rx_Interface_rdv_fifo_empty_unici_core_burst_0_upstream;
  --local readdatavalid pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream, which is an e_mux
  pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream <= unici_core_burst_0_upstream_readdatavalid_from_sa;
  --unici_core_burst_0_upstream_writedata mux, which is an e_mux
  unici_core_burst_0_upstream_writedata <= pcie_compiler_0_Rx_Interface_writedata;
  --byteaddress mux for unici_core_burst_0/upstream, which is an e_mux
  unici_core_burst_0_upstream_byteaddress <= pcie_compiler_0_Rx_Interface_address_to_slave (17 DOWNTO 0);
  --master is always granted when requested
  internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream <= internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream;
  --pcie_compiler_0/Rx_Interface saved-grant unici_core_burst_0/upstream, which is an e_assign
  pcie_compiler_0_Rx_Interface_saved_grant_unici_core_burst_0_upstream <= internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream;
  --allow new arb cycle for unici_core_burst_0/upstream, which is an e_assign
  unici_core_burst_0_upstream_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  unici_core_burst_0_upstream_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  unici_core_burst_0_upstream_master_qreq_vector <= std_logic'('1');
  --unici_core_burst_0_upstream_firsttransfer first transaction, which is an e_assign
  unici_core_burst_0_upstream_firsttransfer <= A_WE_StdLogic((std_logic'(unici_core_burst_0_upstream_begins_xfer) = '1'), unici_core_burst_0_upstream_unreg_firsttransfer, unici_core_burst_0_upstream_reg_firsttransfer);
  --unici_core_burst_0_upstream_unreg_firsttransfer first transaction, which is an e_assign
  unici_core_burst_0_upstream_unreg_firsttransfer <= NOT ((unici_core_burst_0_upstream_slavearbiterlockenable AND unici_core_burst_0_upstream_any_continuerequest));
  --unici_core_burst_0_upstream_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_0_upstream_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(unici_core_burst_0_upstream_begins_xfer) = '1' then 
        unici_core_burst_0_upstream_reg_firsttransfer <= unici_core_burst_0_upstream_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --unici_core_burst_0_upstream_next_bbt_burstcount next_bbt_burstcount, which is an e_mux
  unici_core_burst_0_upstream_next_bbt_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((((internal_unici_core_burst_0_upstream_write) AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (unici_core_burst_0_upstream_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))))))) = '1'), (((std_logic_vector'("00000000000000000000000") & (internal_unici_core_burst_0_upstream_burstcount)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'((((internal_unici_core_burst_0_upstream_read) AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (unici_core_burst_0_upstream_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))))))) = '1'), std_logic_vector'("000000000000000000000000000000000"), (((std_logic_vector'("000000000000000000000000") & (unici_core_burst_0_upstream_bbt_burstcounter)) - std_logic_vector'("000000000000000000000000000000001"))))), 9);
  --unici_core_burst_0_upstream_bbt_burstcounter bbt_burstcounter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_0_upstream_bbt_burstcounter <= std_logic_vector'("000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(unici_core_burst_0_upstream_begins_xfer) = '1' then 
        unici_core_burst_0_upstream_bbt_burstcounter <= unici_core_burst_0_upstream_next_bbt_burstcount;
      end if;
    end if;

  end process;

  --unici_core_burst_0_upstream_beginbursttransfer_internal begin burst transfer, which is an e_assign
  unici_core_burst_0_upstream_beginbursttransfer_internal <= unici_core_burst_0_upstream_begins_xfer AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (unici_core_burst_0_upstream_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))));
  --unici_core_burst_0_upstream_read assignment, which is an e_mux
  internal_unici_core_burst_0_upstream_read <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream AND pcie_compiler_0_Rx_Interface_read;
  --unici_core_burst_0_upstream_write assignment, which is an e_mux
  internal_unici_core_burst_0_upstream_write <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream AND pcie_compiler_0_Rx_Interface_write;
  --unici_core_burst_0_upstream_address mux, which is an e_mux
  unici_core_burst_0_upstream_address <= pcie_compiler_0_Rx_Interface_address_to_slave (14 DOWNTO 0);
  --d1_unici_core_burst_0_upstream_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_unici_core_burst_0_upstream_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_unici_core_burst_0_upstream_end_xfer <= unici_core_burst_0_upstream_end_xfer;
    end if;

  end process;

  --unici_core_burst_0_upstream_waits_for_read in a cycle, which is an e_mux
  unici_core_burst_0_upstream_waits_for_read <= unici_core_burst_0_upstream_in_a_read_cycle AND internal_unici_core_burst_0_upstream_waitrequest_from_sa;
  --unici_core_burst_0_upstream_in_a_read_cycle assignment, which is an e_assign
  unici_core_burst_0_upstream_in_a_read_cycle <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream AND pcie_compiler_0_Rx_Interface_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= unici_core_burst_0_upstream_in_a_read_cycle;
  --unici_core_burst_0_upstream_waits_for_write in a cycle, which is an e_mux
  unici_core_burst_0_upstream_waits_for_write <= unici_core_burst_0_upstream_in_a_write_cycle AND internal_unici_core_burst_0_upstream_waitrequest_from_sa;
  --unici_core_burst_0_upstream_in_a_write_cycle assignment, which is an e_assign
  unici_core_burst_0_upstream_in_a_write_cycle <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream AND pcie_compiler_0_Rx_Interface_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= unici_core_burst_0_upstream_in_a_write_cycle;
  wait_for_unici_core_burst_0_upstream_counter <= std_logic'('0');
  --unici_core_burst_0_upstream_byteenable byte enable port mux, which is an e_mux
  unici_core_burst_0_upstream_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream)) = '1'), (std_logic_vector'("000000000000000000000000") & (pcie_compiler_0_Rx_Interface_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 8);
  --burstcount mux, which is an e_mux
  internal_unici_core_burst_0_upstream_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream)) = '1'), (std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)), std_logic_vector'("00000000000000000000000000000001")), 10);
  --debugaccess mux, which is an e_mux
  unici_core_burst_0_upstream_debugaccess <= std_logic'('0');
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream;
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream <= internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream;
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream <= internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream;
  --vhdl renameroo for output signals
  unici_core_burst_0_upstream_burstcount <= internal_unici_core_burst_0_upstream_burstcount;
  --vhdl renameroo for output signals
  unici_core_burst_0_upstream_read <= internal_unici_core_burst_0_upstream_read;
  --vhdl renameroo for output signals
  unici_core_burst_0_upstream_waitrequest_from_sa <= internal_unici_core_burst_0_upstream_waitrequest_from_sa;
  --vhdl renameroo for output signals
  unici_core_burst_0_upstream_write <= internal_unici_core_burst_0_upstream_write;
--synthesis translate_off
    --unici_core_burst_0/upstream enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --pcie_compiler_0/Rx_Interface non-zero burstcount assertion, which is an e_process
    process (clk)
    VARIABLE write_line29 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream AND to_std_logic((((std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line29, now);
          write(write_line29, string'(": "));
          write(write_line29, string'("pcie_compiler_0/Rx_Interface drove 0 on its 'burstcount' port while accessing slave unici_core_burst_0/upstream"));
          write(output, write_line29.all);
          deallocate (write_line29);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity unici_core_burst_0_downstream_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal d1_pipeline_bridge_0_s1_end_xfer : IN STD_LOGIC;
                 signal pipeline_bridge_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal pipeline_bridge_0_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal unici_core_burst_0_downstream_burstcount : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_read : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_write : IN STD_LOGIC;
                 signal unici_core_burst_0_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

              -- outputs:
                 signal unici_core_burst_0_downstream_address_to_slave : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal unici_core_burst_0_downstream_latency_counter : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_0_downstream_readdatavalid : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_reset_n : OUT STD_LOGIC;
                 signal unici_core_burst_0_downstream_waitrequest : OUT STD_LOGIC
              );
end entity unici_core_burst_0_downstream_arbitrator;


architecture europa of unici_core_burst_0_downstream_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_unici_core_burst_0_downstream_address_to_slave :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal internal_unici_core_burst_0_downstream_waitrequest :  STD_LOGIC;
                signal pre_flush_unici_core_burst_0_downstream_readdatavalid :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_address_last_time :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal unici_core_burst_0_downstream_burstcount_last_time :  STD_LOGIC;
                signal unici_core_burst_0_downstream_byteenable_last_time :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal unici_core_burst_0_downstream_read_last_time :  STD_LOGIC;
                signal unici_core_burst_0_downstream_run :  STD_LOGIC;
                signal unici_core_burst_0_downstream_write_last_time :  STD_LOGIC;
                signal unici_core_burst_0_downstream_writedata_last_time :  STD_LOGIC_VECTOR (63 DOWNTO 0);

begin

  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 OR NOT unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 OR NOT ((unici_core_burst_0_downstream_read OR unici_core_burst_0_downstream_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT pipeline_bridge_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_0_downstream_read OR unici_core_burst_0_downstream_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 OR NOT ((unici_core_burst_0_downstream_read OR unici_core_burst_0_downstream_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT pipeline_bridge_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_0_downstream_read OR unici_core_burst_0_downstream_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  unici_core_burst_0_downstream_run <= r_1;
  --optimize select-logic by passing only those address bits which matter.
  internal_unici_core_burst_0_downstream_address_to_slave <= unici_core_burst_0_downstream_address;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_unici_core_burst_0_downstream_readdatavalid <= unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1;
  --latent slave read data valid which is not flushed, which is an e_mux
  unici_core_burst_0_downstream_readdatavalid <= Vector_To_Std_Logic((std_logic_vector'("00000000000000000000000000000000") OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pre_flush_unici_core_burst_0_downstream_readdatavalid)))));
  --unici_core_burst_0/downstream readdata mux, which is an e_mux
  unici_core_burst_0_downstream_readdata <= pipeline_bridge_0_s1_readdata_from_sa;
  --actual waitrequest port, which is an e_assign
  internal_unici_core_burst_0_downstream_waitrequest <= NOT unici_core_burst_0_downstream_run;
  --latent max counter, which is an e_assign
  unici_core_burst_0_downstream_latency_counter <= std_logic'('0');
  --unici_core_burst_0_downstream_reset_n assignment, which is an e_assign
  unici_core_burst_0_downstream_reset_n <= reset_n;
  --vhdl renameroo for output signals
  unici_core_burst_0_downstream_address_to_slave <= internal_unici_core_burst_0_downstream_address_to_slave;
  --vhdl renameroo for output signals
  unici_core_burst_0_downstream_waitrequest <= internal_unici_core_burst_0_downstream_waitrequest;
--synthesis translate_off
    --unici_core_burst_0_downstream_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_0_downstream_address_last_time <= std_logic_vector'("000000000000000");
      elsif clk'event and clk = '1' then
        unici_core_burst_0_downstream_address_last_time <= unici_core_burst_0_downstream_address;
      end if;

    end process;

    --unici_core_burst_0/downstream waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_unici_core_burst_0_downstream_waitrequest AND ((unici_core_burst_0_downstream_read OR unici_core_burst_0_downstream_write));
      end if;

    end process;

    --unici_core_burst_0_downstream_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line30 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((unici_core_burst_0_downstream_address /= unici_core_burst_0_downstream_address_last_time))))) = '1' then 
          write(write_line30, now);
          write(write_line30, string'(": "));
          write(write_line30, string'("unici_core_burst_0_downstream_address did not heed wait!!!"));
          write(output, write_line30.all);
          deallocate (write_line30);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_0_downstream_burstcount check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_0_downstream_burstcount_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        unici_core_burst_0_downstream_burstcount_last_time <= unici_core_burst_0_downstream_burstcount;
      end if;

    end process;

    --unici_core_burst_0_downstream_burstcount matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line31 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(unici_core_burst_0_downstream_burstcount) /= std_logic'(unici_core_burst_0_downstream_burstcount_last_time)))))) = '1' then 
          write(write_line31, now);
          write(write_line31, string'(": "));
          write(write_line31, string'("unici_core_burst_0_downstream_burstcount did not heed wait!!!"));
          write(output, write_line31.all);
          deallocate (write_line31);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_0_downstream_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_0_downstream_byteenable_last_time <= std_logic_vector'("00000000");
      elsif clk'event and clk = '1' then
        unici_core_burst_0_downstream_byteenable_last_time <= unici_core_burst_0_downstream_byteenable;
      end if;

    end process;

    --unici_core_burst_0_downstream_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line32 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((unici_core_burst_0_downstream_byteenable /= unici_core_burst_0_downstream_byteenable_last_time))))) = '1' then 
          write(write_line32, now);
          write(write_line32, string'(": "));
          write(write_line32, string'("unici_core_burst_0_downstream_byteenable did not heed wait!!!"));
          write(output, write_line32.all);
          deallocate (write_line32);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_0_downstream_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_0_downstream_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        unici_core_burst_0_downstream_read_last_time <= unici_core_burst_0_downstream_read;
      end if;

    end process;

    --unici_core_burst_0_downstream_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line33 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(unici_core_burst_0_downstream_read) /= std_logic'(unici_core_burst_0_downstream_read_last_time)))))) = '1' then 
          write(write_line33, now);
          write(write_line33, string'(": "));
          write(write_line33, string'("unici_core_burst_0_downstream_read did not heed wait!!!"));
          write(output, write_line33.all);
          deallocate (write_line33);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_0_downstream_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_0_downstream_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        unici_core_burst_0_downstream_write_last_time <= unici_core_burst_0_downstream_write;
      end if;

    end process;

    --unici_core_burst_0_downstream_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line34 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(unici_core_burst_0_downstream_write) /= std_logic'(unici_core_burst_0_downstream_write_last_time)))))) = '1' then 
          write(write_line34, now);
          write(write_line34, string'(": "));
          write(write_line34, string'("unici_core_burst_0_downstream_write did not heed wait!!!"));
          write(output, write_line34.all);
          deallocate (write_line34);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_0_downstream_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_0_downstream_writedata_last_time <= std_logic_vector'("0000000000000000000000000000000000000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        unici_core_burst_0_downstream_writedata_last_time <= unici_core_burst_0_downstream_writedata;
      end if;

    end process;

    --unici_core_burst_0_downstream_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line35 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((unici_core_burst_0_downstream_writedata /= unici_core_burst_0_downstream_writedata_last_time)))) AND unici_core_burst_0_downstream_write)) = '1' then 
          write(write_line35, now);
          write(write_line35, string'(": "));
          write(write_line35, string'("unici_core_burst_0_downstream_writedata did not heed wait!!!"));
          write(output, write_line35.all);
          deallocate (write_line35);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity burstcount_fifo_for_unici_core_burst_1_upstream_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity burstcount_fifo_for_unici_core_burst_1_upstream_module;


architecture europa of burstcount_fifo_for_unici_core_burst_1_upstream_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_0 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal stage_1 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal updated_one_count :  STD_LOGIC_VECTOR (2 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_1;
  empty <= NOT(full_0);
  full_2 <= std_logic'('0');
  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic_vector'("0000000000");
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_0))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic_vector'("0000000000");
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 3);
  one_count_minus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 3);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("00000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("00") & (A_TOSTDLOGICVECTOR(or_reduce(data_in)))), A_WE_StdLogicVector((std_logic'(((((read AND (or_reduce(data_in))) AND write) AND (or_reduce(stage_0))))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (or_reduce(data_in))))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (or_reduce(stage_0))))) = '1'), one_count_minus_one, how_many_ones))))))), 3);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream_module;


architecture europa of rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (2 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_1;
  empty <= NOT(full_0);
  full_2 <= std_logic'('0');
  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_0))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 3);
  one_count_minus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 3);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("00000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("00") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 3);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity unici_core_burst_1_upstream_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_address_to_slave : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal pcie_compiler_0_Rx_Interface_latency_counter : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_write : IN STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_1_upstream_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_1_upstream_readdatavalid : IN STD_LOGIC;
                 signal unici_core_burst_1_upstream_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal d1_unici_core_burst_1_upstream_end_xfer : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register : OUT STD_LOGIC;
                 signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream : OUT STD_LOGIC;
                 signal unici_core_burst_1_upstream_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal unici_core_burst_1_upstream_burstcount : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal unici_core_burst_1_upstream_byteaddress : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal unici_core_burst_1_upstream_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal unici_core_burst_1_upstream_debugaccess : OUT STD_LOGIC;
                 signal unici_core_burst_1_upstream_read : OUT STD_LOGIC;
                 signal unici_core_burst_1_upstream_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_1_upstream_waitrequest_from_sa : OUT STD_LOGIC;
                 signal unici_core_burst_1_upstream_write : OUT STD_LOGIC;
                 signal unici_core_burst_1_upstream_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
              );
end entity unici_core_burst_1_upstream_arbitrator;


architecture europa of unici_core_burst_1_upstream_arbitrator is
component burstcount_fifo_for_unici_core_burst_1_upstream_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component burstcount_fifo_for_unici_core_burst_1_upstream_module;

component rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream_module;

                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_unici_core_burst_1_upstream :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream :  STD_LOGIC;
                signal internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream :  STD_LOGIC;
                signal internal_unici_core_burst_1_upstream_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_unici_core_burst_1_upstream_read :  STD_LOGIC;
                signal internal_unici_core_burst_1_upstream_waitrequest_from_sa :  STD_LOGIC;
                signal internal_unici_core_burst_1_upstream_write :  STD_LOGIC;
                signal module_input10 :  STD_LOGIC;
                signal module_input11 :  STD_LOGIC;
                signal module_input12 :  STD_LOGIC;
                signal module_input13 :  STD_LOGIC;
                signal module_input14 :  STD_LOGIC;
                signal module_input9 :  STD_LOGIC;
                signal p0_unici_core_burst_1_upstream_load_fifo :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_arbiterlock :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_arbiterlock2 :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_continuerequest :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_rdv_fifo_empty_unici_core_burst_1_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_rdv_fifo_output_from_unici_core_burst_1_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_saved_grant_unici_core_burst_1_upstream :  STD_LOGIC;
                signal unici_core_burst_1_upstream_allgrants :  STD_LOGIC;
                signal unici_core_burst_1_upstream_allow_new_arb_cycle :  STD_LOGIC;
                signal unici_core_burst_1_upstream_any_bursting_master_saved_grant :  STD_LOGIC;
                signal unici_core_burst_1_upstream_any_continuerequest :  STD_LOGIC;
                signal unici_core_burst_1_upstream_arb_counter_enable :  STD_LOGIC;
                signal unici_core_burst_1_upstream_arb_share_counter :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_arb_share_counter_next_value :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_arb_share_set_values :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_bbt_burstcounter :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal unici_core_burst_1_upstream_beginbursttransfer_internal :  STD_LOGIC;
                signal unici_core_burst_1_upstream_begins_xfer :  STD_LOGIC;
                signal unici_core_burst_1_upstream_burstcount_fifo_empty :  STD_LOGIC;
                signal unici_core_burst_1_upstream_current_burst :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_current_burst_minus_one :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_end_xfer :  STD_LOGIC;
                signal unici_core_burst_1_upstream_firsttransfer :  STD_LOGIC;
                signal unici_core_burst_1_upstream_grant_vector :  STD_LOGIC;
                signal unici_core_burst_1_upstream_in_a_read_cycle :  STD_LOGIC;
                signal unici_core_burst_1_upstream_in_a_write_cycle :  STD_LOGIC;
                signal unici_core_burst_1_upstream_load_fifo :  STD_LOGIC;
                signal unici_core_burst_1_upstream_master_qreq_vector :  STD_LOGIC;
                signal unici_core_burst_1_upstream_move_on_to_next_transaction :  STD_LOGIC;
                signal unici_core_burst_1_upstream_next_bbt_burstcount :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal unici_core_burst_1_upstream_next_burst_count :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_non_bursting_master_requests :  STD_LOGIC;
                signal unici_core_burst_1_upstream_readdatavalid_from_sa :  STD_LOGIC;
                signal unici_core_burst_1_upstream_reg_firsttransfer :  STD_LOGIC;
                signal unici_core_burst_1_upstream_selected_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_slavearbiterlockenable :  STD_LOGIC;
                signal unici_core_burst_1_upstream_slavearbiterlockenable2 :  STD_LOGIC;
                signal unici_core_burst_1_upstream_this_cycle_is_the_last_burst :  STD_LOGIC;
                signal unici_core_burst_1_upstream_transaction_burst_count :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_unreg_firsttransfer :  STD_LOGIC;
                signal unici_core_burst_1_upstream_waits_for_read :  STD_LOGIC;
                signal unici_core_burst_1_upstream_waits_for_write :  STD_LOGIC;
                signal wait_for_unici_core_burst_1_upstream_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT unici_core_burst_1_upstream_end_xfer;
    end if;

  end process;

  unici_core_burst_1_upstream_begins_xfer <= NOT d1_reasons_to_wait AND (internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream);
  --assign unici_core_burst_1_upstream_readdatavalid_from_sa = unici_core_burst_1_upstream_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  unici_core_burst_1_upstream_readdatavalid_from_sa <= unici_core_burst_1_upstream_readdatavalid;
  --assign unici_core_burst_1_upstream_readdata_from_sa = unici_core_burst_1_upstream_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  unici_core_burst_1_upstream_readdata_from_sa <= unici_core_burst_1_upstream_readdata;
  internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream <= to_std_logic(((Std_Logic_Vector'(pcie_compiler_0_Rx_Interface_address_to_slave(31 DOWNTO 18) & std_logic_vector'("000000000000000000")) = std_logic_vector'("00000000000001000000000000000000")))) AND ((pcie_compiler_0_Rx_Interface_read OR pcie_compiler_0_Rx_Interface_write));
  --assign unici_core_burst_1_upstream_waitrequest_from_sa = unici_core_burst_1_upstream_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_unici_core_burst_1_upstream_waitrequest_from_sa <= unici_core_burst_1_upstream_waitrequest;
  --unici_core_burst_1_upstream_arb_share_counter set values, which is an e_mux
  unici_core_burst_1_upstream_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream)) = '1'), (A_WE_StdLogicVector((std_logic'((pcie_compiler_0_Rx_Interface_write)) = '1'), (std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)), std_logic_vector'("00000000000000000000000000000001"))), std_logic_vector'("00000000000000000000000000000001")), 10);
  --unici_core_burst_1_upstream_non_bursting_master_requests mux, which is an e_mux
  unici_core_burst_1_upstream_non_bursting_master_requests <= std_logic'('0');
  --unici_core_burst_1_upstream_any_bursting_master_saved_grant mux, which is an e_mux
  unici_core_burst_1_upstream_any_bursting_master_saved_grant <= pcie_compiler_0_Rx_Interface_saved_grant_unici_core_burst_1_upstream;
  --unici_core_burst_1_upstream_arb_share_counter_next_value assignment, which is an e_assign
  unici_core_burst_1_upstream_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(unici_core_burst_1_upstream_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000") & (unici_core_burst_1_upstream_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(unici_core_burst_1_upstream_arb_share_counter)) = '1'), (((std_logic_vector'("00000000000000000000000") & (unici_core_burst_1_upstream_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 10);
  --unici_core_burst_1_upstream_allgrants all slave grants, which is an e_mux
  unici_core_burst_1_upstream_allgrants <= unici_core_burst_1_upstream_grant_vector;
  --unici_core_burst_1_upstream_end_xfer assignment, which is an e_assign
  unici_core_burst_1_upstream_end_xfer <= NOT ((unici_core_burst_1_upstream_waits_for_read OR unici_core_burst_1_upstream_waits_for_write));
  --end_xfer_arb_share_counter_term_unici_core_burst_1_upstream arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_unici_core_burst_1_upstream <= unici_core_burst_1_upstream_end_xfer AND (((NOT unici_core_burst_1_upstream_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --unici_core_burst_1_upstream_arb_share_counter arbitration counter enable, which is an e_assign
  unici_core_burst_1_upstream_arb_counter_enable <= ((end_xfer_arb_share_counter_term_unici_core_burst_1_upstream AND unici_core_burst_1_upstream_allgrants)) OR ((end_xfer_arb_share_counter_term_unici_core_burst_1_upstream AND NOT unici_core_burst_1_upstream_non_bursting_master_requests));
  --unici_core_burst_1_upstream_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_1_upstream_arb_share_counter <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(unici_core_burst_1_upstream_arb_counter_enable) = '1' then 
        unici_core_burst_1_upstream_arb_share_counter <= unici_core_burst_1_upstream_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --unici_core_burst_1_upstream_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_1_upstream_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((unici_core_burst_1_upstream_master_qreq_vector AND end_xfer_arb_share_counter_term_unici_core_burst_1_upstream)) OR ((end_xfer_arb_share_counter_term_unici_core_burst_1_upstream AND NOT unici_core_burst_1_upstream_non_bursting_master_requests)))) = '1' then 
        unici_core_burst_1_upstream_slavearbiterlockenable <= or_reduce(unici_core_burst_1_upstream_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --pcie_compiler_0/Rx_Interface unici_core_burst_1/upstream arbiterlock, which is an e_assign
  pcie_compiler_0_Rx_Interface_arbiterlock <= unici_core_burst_1_upstream_slavearbiterlockenable AND pcie_compiler_0_Rx_Interface_continuerequest;
  --unici_core_burst_1_upstream_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  unici_core_burst_1_upstream_slavearbiterlockenable2 <= or_reduce(unici_core_burst_1_upstream_arb_share_counter_next_value);
  --pcie_compiler_0/Rx_Interface unici_core_burst_1/upstream arbiterlock2, which is an e_assign
  pcie_compiler_0_Rx_Interface_arbiterlock2 <= unici_core_burst_1_upstream_slavearbiterlockenable2 AND pcie_compiler_0_Rx_Interface_continuerequest;
  --unici_core_burst_1_upstream_any_continuerequest at least one master continues requesting, which is an e_assign
  unici_core_burst_1_upstream_any_continuerequest <= std_logic'('1');
  --pcie_compiler_0_Rx_Interface_continuerequest continued request, which is an e_assign
  pcie_compiler_0_Rx_Interface_continuerequest <= std_logic'('1');
  internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream <= internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream AND NOT ((pcie_compiler_0_Rx_Interface_read AND ((to_std_logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_latency_counter))))))) OR (pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register)))));
  --unique name for unici_core_burst_1_upstream_move_on_to_next_transaction, which is an e_assign
  unici_core_burst_1_upstream_move_on_to_next_transaction <= unici_core_burst_1_upstream_this_cycle_is_the_last_burst AND unici_core_burst_1_upstream_load_fifo;
  --the currently selected burstcount for unici_core_burst_1_upstream, which is an e_mux
  unici_core_burst_1_upstream_selected_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream)) = '1'), (std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)), std_logic_vector'("00000000000000000000000000000001")), 10);
  --burstcount_fifo_for_unici_core_burst_1_upstream, which is an e_fifo_with_registered_outputs
  burstcount_fifo_for_unici_core_burst_1_upstream : burstcount_fifo_for_unici_core_burst_1_upstream_module
    port map(
      data_out => unici_core_burst_1_upstream_transaction_burst_count,
      empty => unici_core_burst_1_upstream_burstcount_fifo_empty,
      fifo_contains_ones_n => open,
      full => open,
      clear_fifo => module_input9,
      clk => clk,
      data_in => unici_core_burst_1_upstream_selected_burstcount,
      read => unici_core_burst_1_upstream_this_cycle_is_the_last_burst,
      reset_n => reset_n,
      sync_reset => module_input10,
      write => module_input11
    );

  module_input9 <= std_logic'('0');
  module_input10 <= std_logic'('0');
  module_input11 <= ((in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read) AND unici_core_burst_1_upstream_load_fifo) AND NOT ((unici_core_burst_1_upstream_this_cycle_is_the_last_burst AND unici_core_burst_1_upstream_burstcount_fifo_empty));

  --unici_core_burst_1_upstream current burst minus one, which is an e_assign
  unici_core_burst_1_upstream_current_burst_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000") & (unici_core_burst_1_upstream_current_burst)) - std_logic_vector'("000000000000000000000000000000001")), 10);
  --what to load in current_burst, for unici_core_burst_1_upstream, which is an e_mux
  unici_core_burst_1_upstream_next_burst_count <= A_WE_StdLogicVector((std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read)) AND NOT unici_core_burst_1_upstream_load_fifo))) = '1'), unici_core_burst_1_upstream_selected_burstcount, A_WE_StdLogicVector((std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read) AND unici_core_burst_1_upstream_this_cycle_is_the_last_burst) AND unici_core_burst_1_upstream_burstcount_fifo_empty))) = '1'), unici_core_burst_1_upstream_selected_burstcount, A_WE_StdLogicVector((std_logic'((unici_core_burst_1_upstream_this_cycle_is_the_last_burst)) = '1'), unici_core_burst_1_upstream_transaction_burst_count, unici_core_burst_1_upstream_current_burst_minus_one)));
  --the current burst count for unici_core_burst_1_upstream, to be decremented, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_1_upstream_current_burst <= std_logic_vector'("0000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((unici_core_burst_1_upstream_readdatavalid_from_sa OR ((NOT unici_core_burst_1_upstream_load_fifo AND ((in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read)))))) = '1' then 
        unici_core_burst_1_upstream_current_burst <= unici_core_burst_1_upstream_next_burst_count;
      end if;
    end if;

  end process;

  --a 1 or burstcount fifo empty, to initialize the counter, which is an e_mux
  p0_unici_core_burst_1_upstream_load_fifo <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((NOT unici_core_burst_1_upstream_load_fifo)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read)) AND unici_core_burst_1_upstream_load_fifo))) = '1'), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT unici_core_burst_1_upstream_burstcount_fifo_empty))))));
  --whether to load directly to the counter or to the fifo, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_1_upstream_load_fifo <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((((in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read)) AND NOT unici_core_burst_1_upstream_load_fifo) OR unici_core_burst_1_upstream_this_cycle_is_the_last_burst)) = '1' then 
        unici_core_burst_1_upstream_load_fifo <= p0_unici_core_burst_1_upstream_load_fifo;
      end if;
    end if;

  end process;

  --the last cycle in the burst for unici_core_burst_1_upstream, which is an e_assign
  unici_core_burst_1_upstream_this_cycle_is_the_last_burst <= NOT (or_reduce(unici_core_burst_1_upstream_current_burst_minus_one)) AND unici_core_burst_1_upstream_readdatavalid_from_sa;
  --rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream : rdv_fifo_for_pcie_compiler_0_Rx_Interface_to_unici_core_burst_1_upstream_module
    port map(
      data_out => pcie_compiler_0_Rx_Interface_rdv_fifo_output_from_unici_core_burst_1_upstream,
      empty => open,
      fifo_contains_ones_n => pcie_compiler_0_Rx_Interface_rdv_fifo_empty_unici_core_burst_1_upstream,
      full => open,
      clear_fifo => module_input12,
      clk => clk,
      data_in => internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream,
      read => unici_core_burst_1_upstream_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input13,
      write => module_input14
    );

  module_input12 <= std_logic'('0');
  module_input13 <= std_logic'('0');
  module_input14 <= in_a_read_cycle AND NOT unici_core_burst_1_upstream_waits_for_read;

  pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register <= NOT pcie_compiler_0_Rx_Interface_rdv_fifo_empty_unici_core_burst_1_upstream;
  --local readdatavalid pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream, which is an e_mux
  pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream <= unici_core_burst_1_upstream_readdatavalid_from_sa;
  --unici_core_burst_1_upstream_writedata mux, which is an e_mux
  unici_core_burst_1_upstream_writedata <= pcie_compiler_0_Rx_Interface_writedata;
  --byteaddress mux for unici_core_burst_1/upstream, which is an e_mux
  unici_core_burst_1_upstream_byteaddress <= pcie_compiler_0_Rx_Interface_address_to_slave (20 DOWNTO 0);
  --master is always granted when requested
  internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream <= internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream;
  --pcie_compiler_0/Rx_Interface saved-grant unici_core_burst_1/upstream, which is an e_assign
  pcie_compiler_0_Rx_Interface_saved_grant_unici_core_burst_1_upstream <= internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream;
  --allow new arb cycle for unici_core_burst_1/upstream, which is an e_assign
  unici_core_burst_1_upstream_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  unici_core_burst_1_upstream_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  unici_core_burst_1_upstream_master_qreq_vector <= std_logic'('1');
  --unici_core_burst_1_upstream_firsttransfer first transaction, which is an e_assign
  unici_core_burst_1_upstream_firsttransfer <= A_WE_StdLogic((std_logic'(unici_core_burst_1_upstream_begins_xfer) = '1'), unici_core_burst_1_upstream_unreg_firsttransfer, unici_core_burst_1_upstream_reg_firsttransfer);
  --unici_core_burst_1_upstream_unreg_firsttransfer first transaction, which is an e_assign
  unici_core_burst_1_upstream_unreg_firsttransfer <= NOT ((unici_core_burst_1_upstream_slavearbiterlockenable AND unici_core_burst_1_upstream_any_continuerequest));
  --unici_core_burst_1_upstream_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_1_upstream_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(unici_core_burst_1_upstream_begins_xfer) = '1' then 
        unici_core_burst_1_upstream_reg_firsttransfer <= unici_core_burst_1_upstream_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --unici_core_burst_1_upstream_next_bbt_burstcount next_bbt_burstcount, which is an e_mux
  unici_core_burst_1_upstream_next_bbt_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((((internal_unici_core_burst_1_upstream_write) AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (unici_core_burst_1_upstream_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))))))) = '1'), (((std_logic_vector'("00000000000000000000000") & (internal_unici_core_burst_1_upstream_burstcount)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'((((internal_unici_core_burst_1_upstream_read) AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (unici_core_burst_1_upstream_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))))))) = '1'), std_logic_vector'("000000000000000000000000000000000"), (((std_logic_vector'("000000000000000000000000") & (unici_core_burst_1_upstream_bbt_burstcounter)) - std_logic_vector'("000000000000000000000000000000001"))))), 9);
  --unici_core_burst_1_upstream_bbt_burstcounter bbt_burstcounter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      unici_core_burst_1_upstream_bbt_burstcounter <= std_logic_vector'("000000000");
    elsif clk'event and clk = '1' then
      if std_logic'(unici_core_burst_1_upstream_begins_xfer) = '1' then 
        unici_core_burst_1_upstream_bbt_burstcounter <= unici_core_burst_1_upstream_next_bbt_burstcount;
      end if;
    end if;

  end process;

  --unici_core_burst_1_upstream_beginbursttransfer_internal begin burst transfer, which is an e_assign
  unici_core_burst_1_upstream_beginbursttransfer_internal <= unici_core_burst_1_upstream_begins_xfer AND to_std_logic((((std_logic_vector'("00000000000000000000000") & (unici_core_burst_1_upstream_bbt_burstcounter)) = std_logic_vector'("00000000000000000000000000000000"))));
  --unici_core_burst_1_upstream_read assignment, which is an e_mux
  internal_unici_core_burst_1_upstream_read <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream AND pcie_compiler_0_Rx_Interface_read;
  --unici_core_burst_1_upstream_write assignment, which is an e_mux
  internal_unici_core_burst_1_upstream_write <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream AND pcie_compiler_0_Rx_Interface_write;
  --unici_core_burst_1_upstream_address mux, which is an e_mux
  unici_core_burst_1_upstream_address <= pcie_compiler_0_Rx_Interface_address_to_slave (17 DOWNTO 0);
  --d1_unici_core_burst_1_upstream_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_unici_core_burst_1_upstream_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_unici_core_burst_1_upstream_end_xfer <= unici_core_burst_1_upstream_end_xfer;
    end if;

  end process;

  --unici_core_burst_1_upstream_waits_for_read in a cycle, which is an e_mux
  unici_core_burst_1_upstream_waits_for_read <= unici_core_burst_1_upstream_in_a_read_cycle AND internal_unici_core_burst_1_upstream_waitrequest_from_sa;
  --unici_core_burst_1_upstream_in_a_read_cycle assignment, which is an e_assign
  unici_core_burst_1_upstream_in_a_read_cycle <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream AND pcie_compiler_0_Rx_Interface_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= unici_core_burst_1_upstream_in_a_read_cycle;
  --unici_core_burst_1_upstream_waits_for_write in a cycle, which is an e_mux
  unici_core_burst_1_upstream_waits_for_write <= unici_core_burst_1_upstream_in_a_write_cycle AND internal_unici_core_burst_1_upstream_waitrequest_from_sa;
  --unici_core_burst_1_upstream_in_a_write_cycle assignment, which is an e_assign
  unici_core_burst_1_upstream_in_a_write_cycle <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream AND pcie_compiler_0_Rx_Interface_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= unici_core_burst_1_upstream_in_a_write_cycle;
  wait_for_unici_core_burst_1_upstream_counter <= std_logic'('0');
  --unici_core_burst_1_upstream_byteenable byte enable port mux, which is an e_mux
  unici_core_burst_1_upstream_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream)) = '1'), (std_logic_vector'("000000000000000000000000") & (pcie_compiler_0_Rx_Interface_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 8);
  --burstcount mux, which is an e_mux
  internal_unici_core_burst_1_upstream_burstcount <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream)) = '1'), (std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)), std_logic_vector'("00000000000000000000000000000001")), 10);
  --debugaccess mux, which is an e_mux
  unici_core_burst_1_upstream_debugaccess <= std_logic'('0');
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream <= internal_pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream;
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream <= internal_pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream;
  --vhdl renameroo for output signals
  pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream <= internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream;
  --vhdl renameroo for output signals
  unici_core_burst_1_upstream_burstcount <= internal_unici_core_burst_1_upstream_burstcount;
  --vhdl renameroo for output signals
  unici_core_burst_1_upstream_read <= internal_unici_core_burst_1_upstream_read;
  --vhdl renameroo for output signals
  unici_core_burst_1_upstream_waitrequest_from_sa <= internal_unici_core_burst_1_upstream_waitrequest_from_sa;
  --vhdl renameroo for output signals
  unici_core_burst_1_upstream_write <= internal_unici_core_burst_1_upstream_write;
--synthesis translate_off
    --unici_core_burst_1/upstream enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --pcie_compiler_0/Rx_Interface non-zero burstcount assertion, which is an e_process
    process (clk)
    VARIABLE write_line36 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((internal_pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream AND to_std_logic((((std_logic_vector'("0000000000000000000000") & (pcie_compiler_0_Rx_Interface_burstcount)) = std_logic_vector'("00000000000000000000000000000000"))))) AND enable_nonzero_assertions)) = '1' then 
          write(write_line36, now);
          write(write_line36, string'(": "));
          write(write_line36, string'("pcie_compiler_0/Rx_Interface drove 0 on its 'burstcount' port while accessing slave unici_core_burst_1/upstream"));
          write(output, write_line36.all);
          deallocate (write_line36);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity unici_core_burst_1_downstream_arbitrator is 
        port (
              -- inputs:
                 signal avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal unici_core_burst_1_downstream_burstcount : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_read : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_write : IN STD_LOGIC;
                 signal unici_core_burst_1_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

              -- outputs:
                 signal unici_core_burst_1_downstream_address_to_slave : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal unici_core_burst_1_downstream_latency_counter : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal unici_core_burst_1_downstream_readdatavalid : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_reset_n : OUT STD_LOGIC;
                 signal unici_core_burst_1_downstream_waitrequest : OUT STD_LOGIC
              );
end entity unici_core_burst_1_downstream_arbitrator;


architecture europa of unici_core_burst_1_downstream_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_unici_core_burst_1_downstream_address_to_slave :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_unici_core_burst_1_downstream_waitrequest :  STD_LOGIC;
                signal pre_flush_unici_core_burst_1_downstream_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_address_last_time :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_1_downstream_burstcount_last_time :  STD_LOGIC;
                signal unici_core_burst_1_downstream_byteenable_last_time :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal unici_core_burst_1_downstream_read_last_time :  STD_LOGIC;
                signal unici_core_burst_1_downstream_run :  STD_LOGIC;
                signal unici_core_burst_1_downstream_write_last_time :  STD_LOGIC;
                signal unici_core_burst_1_downstream_writedata_last_time :  STD_LOGIC_VECTOR (63 DOWNTO 0);

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 OR NOT unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 OR NOT ((unici_core_burst_1_downstream_read OR unici_core_burst_1_downstream_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_1_downstream_read OR unici_core_burst_1_downstream_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 OR NOT ((unici_core_burst_1_downstream_read OR unici_core_burst_1_downstream_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((unici_core_burst_1_downstream_read OR unici_core_burst_1_downstream_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  unici_core_burst_1_downstream_run <= r_0;
  --optimize select-logic by passing only those address bits which matter.
  internal_unici_core_burst_1_downstream_address_to_slave <= unici_core_burst_1_downstream_address;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_unici_core_burst_1_downstream_readdatavalid <= std_logic'('0');
  --latent slave read data valid which is not flushed, which is an e_mux
  unici_core_burst_1_downstream_readdatavalid <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000000") OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pre_flush_unici_core_burst_1_downstream_readdatavalid)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0)))));
  --unici_core_burst_1/downstream readdata mux, which is an e_mux
  unici_core_burst_1_downstream_readdata <= avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa;
  --actual waitrequest port, which is an e_assign
  internal_unici_core_burst_1_downstream_waitrequest <= NOT unici_core_burst_1_downstream_run;
  --latent max counter, which is an e_assign
  unici_core_burst_1_downstream_latency_counter <= std_logic'('0');
  --unici_core_burst_1_downstream_reset_n assignment, which is an e_assign
  unici_core_burst_1_downstream_reset_n <= reset_n;
  --vhdl renameroo for output signals
  unici_core_burst_1_downstream_address_to_slave <= internal_unici_core_burst_1_downstream_address_to_slave;
  --vhdl renameroo for output signals
  unici_core_burst_1_downstream_waitrequest <= internal_unici_core_burst_1_downstream_waitrequest;
--synthesis translate_off
    --unici_core_burst_1_downstream_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_1_downstream_address_last_time <= std_logic_vector'("000000000000000000");
      elsif clk'event and clk = '1' then
        unici_core_burst_1_downstream_address_last_time <= unici_core_burst_1_downstream_address;
      end if;

    end process;

    --unici_core_burst_1/downstream waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_unici_core_burst_1_downstream_waitrequest AND ((unici_core_burst_1_downstream_read OR unici_core_burst_1_downstream_write));
      end if;

    end process;

    --unici_core_burst_1_downstream_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line37 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((unici_core_burst_1_downstream_address /= unici_core_burst_1_downstream_address_last_time))))) = '1' then 
          write(write_line37, now);
          write(write_line37, string'(": "));
          write(write_line37, string'("unici_core_burst_1_downstream_address did not heed wait!!!"));
          write(output, write_line37.all);
          deallocate (write_line37);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_1_downstream_burstcount check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_1_downstream_burstcount_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        unici_core_burst_1_downstream_burstcount_last_time <= unici_core_burst_1_downstream_burstcount;
      end if;

    end process;

    --unici_core_burst_1_downstream_burstcount matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line38 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(unici_core_burst_1_downstream_burstcount) /= std_logic'(unici_core_burst_1_downstream_burstcount_last_time)))))) = '1' then 
          write(write_line38, now);
          write(write_line38, string'(": "));
          write(write_line38, string'("unici_core_burst_1_downstream_burstcount did not heed wait!!!"));
          write(output, write_line38.all);
          deallocate (write_line38);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_1_downstream_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_1_downstream_byteenable_last_time <= std_logic_vector'("00000000");
      elsif clk'event and clk = '1' then
        unici_core_burst_1_downstream_byteenable_last_time <= unici_core_burst_1_downstream_byteenable;
      end if;

    end process;

    --unici_core_burst_1_downstream_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line39 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((unici_core_burst_1_downstream_byteenable /= unici_core_burst_1_downstream_byteenable_last_time))))) = '1' then 
          write(write_line39, now);
          write(write_line39, string'(": "));
          write(write_line39, string'("unici_core_burst_1_downstream_byteenable did not heed wait!!!"));
          write(output, write_line39.all);
          deallocate (write_line39);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_1_downstream_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_1_downstream_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        unici_core_burst_1_downstream_read_last_time <= unici_core_burst_1_downstream_read;
      end if;

    end process;

    --unici_core_burst_1_downstream_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line40 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(unici_core_burst_1_downstream_read) /= std_logic'(unici_core_burst_1_downstream_read_last_time)))))) = '1' then 
          write(write_line40, now);
          write(write_line40, string'(": "));
          write(write_line40, string'("unici_core_burst_1_downstream_read did not heed wait!!!"));
          write(output, write_line40.all);
          deallocate (write_line40);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_1_downstream_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_1_downstream_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        unici_core_burst_1_downstream_write_last_time <= unici_core_burst_1_downstream_write;
      end if;

    end process;

    --unici_core_burst_1_downstream_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line41 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(unici_core_burst_1_downstream_write) /= std_logic'(unici_core_burst_1_downstream_write_last_time)))))) = '1' then 
          write(write_line41, now);
          write(write_line41, string'(": "));
          write(write_line41, string'("unici_core_burst_1_downstream_write did not heed wait!!!"));
          write(output, write_line41.all);
          deallocate (write_line41);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --unici_core_burst_1_downstream_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        unici_core_burst_1_downstream_writedata_last_time <= std_logic_vector'("0000000000000000000000000000000000000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        unici_core_burst_1_downstream_writedata_last_time <= unici_core_burst_1_downstream_writedata;
      end if;

    end process;

    --unici_core_burst_1_downstream_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line42 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((unici_core_burst_1_downstream_writedata /= unici_core_burst_1_downstream_writedata_last_time)))) AND unici_core_burst_1_downstream_write)) = '1' then 
          write(write_line42, now);
          write(write_line42, string'(": "));
          write(write_line42, string'("unici_core_burst_1_downstream_writedata did not heed wait!!!"));
          write(output, write_line42.all);
          deallocate (write_line42);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch_module;


architecture europa of unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity unici_core is 
        port (
              -- 1) global signals:
                 signal pcie_compiler_0_pcie_core_clk_out : OUT STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_avalon64_to_avalon8_0
                 signal out_address_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal out_read_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC;
                 signal out_readdata_to_the_avalon64_to_avalon8_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal out_waitrequest_to_the_avalon64_to_avalon8_0 : IN STD_LOGIC;
                 signal out_write_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC;
                 signal out_writedata_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- the_ci_bridge_0
                 signal cam0_bypass_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam0_fail_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam0_ready_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam1_bypass_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam1_fail_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam1_ready_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam_address_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal cam_interrupts_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cam_read_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cam_readdata_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cam_waitreq_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cam_write_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cam_writedata_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal ci_a_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                 signal ci_bus_dir_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal ci_d_en_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal ci_d_in_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal ci_d_out_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal ci_iord_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal ci_iowr_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal ci_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal ci_reg_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal ci_we_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cia_cd_n_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cia_ce_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cia_data_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cia_ireq_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cia_overcurrent_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cia_reset_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cia_reset_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cia_wait_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cib_cd_n_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cib_ce_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cib_data_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cib_ireq_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cib_overcurrent_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal cib_reset_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cib_reset_from_the_ci_bridge_0 : OUT STD_LOGIC;
                 signal cib_wait_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                 signal interrupt_from_the_ci_bridge_0 : OUT STD_LOGIC;

              -- the_dma_arbiter_0
                 signal dma0_addr_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (60 DOWNTO 0);
                 signal dma0_byteen_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dma0_size_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal dma0_wait_from_the_dma_arbiter_0 : OUT STD_LOGIC;
                 signal dma0_wrdata_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal dma0_write_to_the_dma_arbiter_0 : IN STD_LOGIC;
                 signal dma1_addr_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (60 DOWNTO 0);
                 signal dma1_byteen_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dma1_size_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal dma1_wait_from_the_dma_arbiter_0 : OUT STD_LOGIC;
                 signal dma1_wrdata_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal dma1_write_to_the_dma_arbiter_0 : IN STD_LOGIC;

              -- the_dvb_dma_0
                 signal dvb_data_to_the_dvb_dma_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_dval_to_the_dvb_dma_0 : IN STD_LOGIC;
                 signal dvb_sop_to_the_dvb_dma_0 : IN STD_LOGIC;
                 signal interrupt_from_the_dvb_dma_0 : OUT STD_LOGIC;
                 signal mem_addr_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (60 DOWNTO 0);
                 signal mem_byteen_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal mem_size_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal mem_waitreq_to_the_dvb_dma_0 : IN STD_LOGIC;
                 signal mem_wrdata_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal mem_write_from_the_dvb_dma_0 : OUT STD_LOGIC;

              -- the_dvb_dma_1
                 signal dvb_data_to_the_dvb_dma_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_dval_to_the_dvb_dma_1 : IN STD_LOGIC;
                 signal dvb_sop_to_the_dvb_dma_1 : IN STD_LOGIC;
                 signal interrupt_from_the_dvb_dma_1 : OUT STD_LOGIC;
                 signal mem_addr_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (60 DOWNTO 0);
                 signal mem_byteen_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal mem_size_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal mem_waitreq_to_the_dvb_dma_1 : IN STD_LOGIC;
                 signal mem_wrdata_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal mem_write_from_the_dvb_dma_1 : OUT STD_LOGIC;

              -- the_dvb_ts_0
                 signal cam_baseclk_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal cam_bypass_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal cam_mclki_from_the_dvb_ts_0 : OUT STD_LOGIC;
                 signal cam_mclko_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal cam_mdi_from_the_dvb_ts_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cam_mdo_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cam_mistrt_from_the_dvb_ts_0 : OUT STD_LOGIC;
                 signal cam_mival_from_the_dvb_ts_0 : OUT STD_LOGIC;
                 signal cam_mostrt_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal cam_moval_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_in0_data_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_in0_dsop_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_in0_dval_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_in1_data_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_in1_dsop_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_in1_dval_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_in2_data_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_in2_dsop_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_in2_dval_to_the_dvb_ts_0 : IN STD_LOGIC;
                 signal dvb_out_data_from_the_dvb_ts_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_out_dsop_from_the_dvb_ts_0 : OUT STD_LOGIC;
                 signal dvb_out_dval_from_the_dvb_ts_0 : OUT STD_LOGIC;
                 signal interrupt_from_the_dvb_ts_0 : OUT STD_LOGIC;

              -- the_dvb_ts_1
                 signal cam_baseclk_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal cam_bypass_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal cam_mclki_from_the_dvb_ts_1 : OUT STD_LOGIC;
                 signal cam_mclko_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal cam_mdi_from_the_dvb_ts_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cam_mdo_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cam_mistrt_from_the_dvb_ts_1 : OUT STD_LOGIC;
                 signal cam_mival_from_the_dvb_ts_1 : OUT STD_LOGIC;
                 signal cam_mostrt_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal cam_moval_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_in0_data_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_in0_dsop_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_in0_dval_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_in1_data_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_in1_dsop_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_in1_dval_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_in2_data_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_in2_dsop_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_in2_dval_to_the_dvb_ts_1 : IN STD_LOGIC;
                 signal dvb_out_data_from_the_dvb_ts_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal dvb_out_dsop_from_the_dvb_ts_1 : OUT STD_LOGIC;
                 signal dvb_out_dval_from_the_dvb_ts_1 : OUT STD_LOGIC;
                 signal interrupt_from_the_dvb_ts_1 : OUT STD_LOGIC;

              -- the_fifo_in_8b_sync_0
                 signal irq_from_the_fifo_in_8b_sync_0 : OUT STD_LOGIC;

              -- the_fifo_in_8b_sync_1
                 signal irq_from_the_fifo_in_8b_sync_1 : OUT STD_LOGIC;

              -- the_fifo_out_8b_sync_0
                 signal irq_from_the_fifo_out_8b_sync_0 : OUT STD_LOGIC;

              -- the_fifo_out_8b_sync_1
                 signal irq_from_the_fifo_out_8b_sync_1 : OUT STD_LOGIC;

              -- the_gpout_0
                 signal pins_from_the_gpout_0 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_int_ctrl_0
                 signal avlm_irq_to_the_int_ctrl_0 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_pcie_compiler_0
                 signal busy_altgxb_reconfig_pcie_compiler_0 : IN STD_LOGIC;
                 signal clk125_out_pcie_compiler_0 : OUT STD_LOGIC;
                 signal clk250_out_pcie_compiler_0 : OUT STD_LOGIC;
                 signal clk500_out_pcie_compiler_0 : OUT STD_LOGIC;
                 signal fixedclk_serdes_pcie_compiler_0 : IN STD_LOGIC;
                 signal gxb_powerdown_pcie_compiler_0 : IN STD_LOGIC;
                 signal pcie_rstn_pcie_compiler_0 : IN STD_LOGIC;
                 signal phystatus_ext_pcie_compiler_0 : IN STD_LOGIC;
                 signal pipe_mode_pcie_compiler_0 : IN STD_LOGIC;
                 signal pll_powerdown_pcie_compiler_0 : IN STD_LOGIC;
                 signal powerdown_ext_pcie_compiler_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal rate_ext_pcie_compiler_0 : OUT STD_LOGIC;
                 signal reconfig_clk_pcie_compiler_0 : IN STD_LOGIC;
                 signal reconfig_fromgxb_pcie_compiler_0 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                 signal reconfig_togxb_pcie_compiler_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal refclk_pcie_compiler_0 : IN STD_LOGIC;
                 signal rx_in0_pcie_compiler_0 : IN STD_LOGIC;
                 signal rxdata0_ext_pcie_compiler_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rxdatak0_ext_pcie_compiler_0 : IN STD_LOGIC;
                 signal rxelecidle0_ext_pcie_compiler_0 : IN STD_LOGIC;
                 signal rxpolarity0_ext_pcie_compiler_0 : OUT STD_LOGIC;
                 signal rxstatus0_ext_pcie_compiler_0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal rxvalid0_ext_pcie_compiler_0 : IN STD_LOGIC;
                 signal test_in_pcie_compiler_0 : IN STD_LOGIC_VECTOR (39 DOWNTO 0);
                 signal tx_out0_pcie_compiler_0 : OUT STD_LOGIC;
                 signal txcompl0_ext_pcie_compiler_0 : OUT STD_LOGIC;
                 signal txdata0_ext_pcie_compiler_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal txdatak0_ext_pcie_compiler_0 : OUT STD_LOGIC;
                 signal txdetectrx_ext_pcie_compiler_0 : OUT STD_LOGIC;
                 signal txelecidle0_ext_pcie_compiler_0 : OUT STD_LOGIC;

              -- the_spi_master_0
                 signal cs_n_from_the_spi_master_0 : OUT STD_LOGIC;
                 signal irq_from_the_spi_master_0 : OUT STD_LOGIC;
                 signal miso_to_the_spi_master_0 : IN STD_LOGIC;
                 signal mosi_from_the_spi_master_0 : OUT STD_LOGIC;
                 signal sclk_from_the_spi_master_0 : OUT STD_LOGIC;

              -- the_twi_master_0
                 signal irq_from_the_twi_master_0 : OUT STD_LOGIC;
                 signal scl_act_from_the_twi_master_0 : OUT STD_LOGIC;
                 signal scl_in_to_the_twi_master_0 : IN STD_LOGIC;
                 signal sda_act_from_the_twi_master_0 : OUT STD_LOGIC;
                 signal sda_in_to_the_twi_master_0 : IN STD_LOGIC;
                 signal sink_irq_to_the_twi_master_0 : IN STD_LOGIC;
                 signal source_irq_to_the_twi_master_0 : IN STD_LOGIC;

              -- the_twi_master_1
                 signal irq_from_the_twi_master_1 : OUT STD_LOGIC;
                 signal scl_act_from_the_twi_master_1 : OUT STD_LOGIC;
                 signal scl_in_to_the_twi_master_1 : IN STD_LOGIC;
                 signal sda_act_from_the_twi_master_1 : OUT STD_LOGIC;
                 signal sda_in_to_the_twi_master_1 : IN STD_LOGIC;
                 signal sink_irq_to_the_twi_master_1 : IN STD_LOGIC;
                 signal source_irq_to_the_twi_master_1 : IN STD_LOGIC
              );
end entity unici_core;


architecture europa of unici_core is
component avalon64_to_avalon8_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal avalon64_to_avalon8_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal unici_core_burst_1_downstream_arbitrationshare : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal unici_core_burst_1_downstream_burstcount : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal unici_core_burst_1_downstream_latency_counter : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_read : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_write : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal avalon64_to_avalon8_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal avalon64_to_avalon8_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal avalon64_to_avalon8_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal avalon64_to_avalon8_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal avalon64_to_avalon8_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal avalon64_to_avalon8_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component avalon64_to_avalon8_0_avalon_slave_0_arbitrator;

component avalon64_to_avalon8_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal out_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal out_waitrequest : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal out_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal out_read : OUT STD_LOGIC;
                    signal out_write : OUT STD_LOGIC;
                    signal out_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal waitrequest : OUT STD_LOGIC
                 );
end component avalon64_to_avalon8_0;

component ci_bridge_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal ci_bridge_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal ci_bridge_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal ci_bridge_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal ci_bridge_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal ci_bridge_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal ci_bridge_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal ci_bridge_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal d1_ci_bridge_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component ci_bridge_0_avalon_slave_0_arbitrator;

component ci_bridge_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cam_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal cam_read : IN STD_LOGIC;
                    signal cam_write : IN STD_LOGIC;
                    signal cam_writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal ci_d_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cia_cd_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cia_ireq_n : IN STD_LOGIC;
                    signal cia_overcurrent_n : IN STD_LOGIC;
                    signal cia_wait_n : IN STD_LOGIC;
                    signal cib_cd_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cib_ireq_n : IN STD_LOGIC;
                    signal cib_overcurrent_n : IN STD_LOGIC;
                    signal cib_wait_n : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cam0_bypass : OUT STD_LOGIC;
                    signal cam0_fail : OUT STD_LOGIC;
                    signal cam0_ready : OUT STD_LOGIC;
                    signal cam1_bypass : OUT STD_LOGIC;
                    signal cam1_fail : OUT STD_LOGIC;
                    signal cam1_ready : OUT STD_LOGIC;
                    signal cam_interrupts : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cam_readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_waitreq : OUT STD_LOGIC;
                    signal ci_a : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal ci_bus_dir : OUT STD_LOGIC;
                    signal ci_d_en : OUT STD_LOGIC;
                    signal ci_d_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal ci_iord_n : OUT STD_LOGIC;
                    signal ci_iowr_n : OUT STD_LOGIC;
                    signal ci_oe_n : OUT STD_LOGIC;
                    signal ci_reg_n : OUT STD_LOGIC;
                    signal ci_we_n : OUT STD_LOGIC;
                    signal cia_ce_n : OUT STD_LOGIC;
                    signal cia_data_buf_oe_n : OUT STD_LOGIC;
                    signal cia_reset : OUT STD_LOGIC;
                    signal cia_reset_buf_oe_n : OUT STD_LOGIC;
                    signal cib_ce_n : OUT STD_LOGIC;
                    signal cib_data_buf_oe_n : OUT STD_LOGIC;
                    signal cib_reset : OUT STD_LOGIC;
                    signal cib_reset_buf_oe_n : OUT STD_LOGIC;
                    signal interrupt : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component ci_bridge_0;

component dma_arbiter_0_avalon_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d1_pcie_compiler_0_Tx_Interface_end_xfer : IN STD_LOGIC;
                    signal dma_arbiter_0_avalon_master_address : IN STD_LOGIC_VECTOR (30 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_burstcount : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_write : IN STD_LOGIC;
                    signal dma_arbiter_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface : IN STD_LOGIC;
                    signal dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface : IN STD_LOGIC;
                    signal dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface : IN STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_waitrequest_from_sa : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal dma_arbiter_0_avalon_master_address_to_slave : OUT STD_LOGIC_VECTOR (30 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_reset : OUT STD_LOGIC;
                    signal dma_arbiter_0_avalon_master_waitrequest : OUT STD_LOGIC
                 );
end component dma_arbiter_0_avalon_master_arbitrator;

component dma_arbiter_0 is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal dma0_addr : IN STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal dma0_byteen : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dma0_size : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal dma0_wrdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal dma0_write : IN STD_LOGIC;
                    signal dma1_addr : IN STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal dma1_byteen : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dma1_size : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal dma1_wrdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal dma1_write : IN STD_LOGIC;
                    signal mem_waitreq : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;

                 -- outputs:
                    signal dma0_wait : OUT STD_LOGIC;
                    signal dma1_wait : OUT STD_LOGIC;
                    signal mem_addr : OUT STD_LOGIC_VECTOR (30 DOWNTO 0);
                    signal mem_byteen : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal mem_size : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal mem_wrdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal mem_write : OUT STD_LOGIC
                 );
end component dma_arbiter_0;

component dvb_dma_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal dvb_dma_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_dvb_dma_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal dvb_dma_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal dvb_dma_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal dvb_dma_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_dma_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal dvb_dma_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal dvb_dma_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component dvb_dma_0_avalon_slave_0_arbitrator;

component dvb_dma_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal dvb_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_dval : IN STD_LOGIC;
                    signal dvb_sop : IN STD_LOGIC;
                    signal mem_waitreq : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal interrupt : OUT STD_LOGIC;
                    signal mem_addr : OUT STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal mem_byteen : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal mem_size : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal mem_wrdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal mem_write : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component dvb_dma_0;

component dvb_dma_1_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal dvb_dma_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_dvb_dma_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal dvb_dma_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal dvb_dma_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal dvb_dma_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_dma_1_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal dvb_dma_1_avalon_slave_0_write : OUT STD_LOGIC;
                    signal dvb_dma_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 : OUT STD_LOGIC
                 );
end component dvb_dma_1_avalon_slave_0_arbitrator;

component dvb_dma_1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal dvb_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_dval : IN STD_LOGIC;
                    signal dvb_sop : IN STD_LOGIC;
                    signal mem_waitreq : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal interrupt : OUT STD_LOGIC;
                    signal mem_addr : OUT STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal mem_byteen : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal mem_size : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal mem_wrdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal mem_write : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component dvb_dma_1;

component dvb_ts_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal dvb_ts_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_dvb_ts_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal dvb_ts_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal dvb_ts_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal dvb_ts_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal dvb_ts_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal dvb_ts_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal dvb_ts_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal dvb_ts_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component dvb_ts_0_avalon_slave_0_arbitrator;

component dvb_ts_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cam_baseclk : IN STD_LOGIC;
                    signal cam_bypass : IN STD_LOGIC;
                    signal cam_mclko : IN STD_LOGIC;
                    signal cam_mdo : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mostrt : IN STD_LOGIC;
                    signal cam_moval : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal dvb_in0_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in0_dsop : IN STD_LOGIC;
                    signal dvb_in0_dval : IN STD_LOGIC;
                    signal dvb_in1_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in1_dsop : IN STD_LOGIC;
                    signal dvb_in1_dval : IN STD_LOGIC;
                    signal dvb_in2_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in2_dsop : IN STD_LOGIC;
                    signal dvb_in2_dval : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cam_mclki : OUT STD_LOGIC;
                    signal cam_mdi : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mistrt : OUT STD_LOGIC;
                    signal cam_mival : OUT STD_LOGIC;
                    signal dvb_out_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_out_dsop : OUT STD_LOGIC;
                    signal dvb_out_dval : OUT STD_LOGIC;
                    signal interrupt : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal waitrequest : OUT STD_LOGIC
                 );
end component dvb_ts_0;

component dvb_ts_1_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_1_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_dvb_ts_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal dvb_ts_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal dvb_ts_1_avalon_slave_0_read : OUT STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_1_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_write : OUT STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 : OUT STD_LOGIC
                 );
end component dvb_ts_1_avalon_slave_0_arbitrator;

component dvb_ts_1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cam_baseclk : IN STD_LOGIC;
                    signal cam_bypass : IN STD_LOGIC;
                    signal cam_mclko : IN STD_LOGIC;
                    signal cam_mdo : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mostrt : IN STD_LOGIC;
                    signal cam_moval : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal dvb_in0_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in0_dsop : IN STD_LOGIC;
                    signal dvb_in0_dval : IN STD_LOGIC;
                    signal dvb_in1_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in1_dsop : IN STD_LOGIC;
                    signal dvb_in1_dval : IN STD_LOGIC;
                    signal dvb_in2_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in2_dsop : IN STD_LOGIC;
                    signal dvb_in2_dval : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cam_mclki : OUT STD_LOGIC;
                    signal cam_mdi : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mistrt : OUT STD_LOGIC;
                    signal cam_mival : OUT STD_LOGIC;
                    signal dvb_out_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_out_dsop : OUT STD_LOGIC;
                    signal dvb_out_dval : OUT STD_LOGIC;
                    signal interrupt : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal waitrequest : OUT STD_LOGIC
                 );
end component dvb_ts_1;

component fifo_in_8b_sync_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal fifo_in_8b_sync_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal fifo_in_8b_sync_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_in_8b_sync_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component fifo_in_8b_sync_0_avalon_slave_0_arbitrator;

component fifo_in_8b_sync_0_avalon_streaming_sink_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_streaming_sink_ready : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal twi_master_0_avalon_streaming_source_valid : IN STD_LOGIC;

                 -- outputs:
                    signal fifo_in_8b_sync_0_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_streaming_sink_valid : OUT STD_LOGIC
                 );
end component fifo_in_8b_sync_0_avalon_streaming_sink_arbitrator;

component fifo_in_8b_sync_0 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal rd_en : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal st_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal st_valid : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal st_ready : OUT STD_LOGIC;
                    signal wait_req : OUT STD_LOGIC
                 );
end component fifo_in_8b_sync_0;

component fifo_in_8b_sync_1_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal fifo_in_8b_sync_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal fifo_in_8b_sync_1_avalon_slave_0_read : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_in_8b_sync_1_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_write : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC
                 );
end component fifo_in_8b_sync_1_avalon_slave_0_arbitrator;

component fifo_in_8b_sync_1_avalon_streaming_sink_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_streaming_sink_ready : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal twi_master_1_avalon_streaming_source_valid : IN STD_LOGIC;

                 -- outputs:
                    signal fifo_in_8b_sync_1_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_streaming_sink_valid : OUT STD_LOGIC
                 );
end component fifo_in_8b_sync_1_avalon_streaming_sink_arbitrator;

component fifo_in_8b_sync_1 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal rd_en : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal st_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal st_valid : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal st_ready : OUT STD_LOGIC;
                    signal wait_req : OUT STD_LOGIC
                 );
end component fifo_in_8b_sync_1;

component fifo_out_8b_sync_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component fifo_out_8b_sync_0_avalon_slave_0_arbitrator;

component fifo_out_8b_sync_0_avalon_streaming_source_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_streaming_source_valid : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_0_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal fifo_out_8b_sync_0_avalon_streaming_source_ready : OUT STD_LOGIC
                 );
end component fifo_out_8b_sync_0_avalon_streaming_source_arbitrator;

component fifo_out_8b_sync_0 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal rst : IN STD_LOGIC;
                    signal st_ready : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal st_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal st_valid : OUT STD_LOGIC;
                    signal wait_req : OUT STD_LOGIC
                 );
end component fifo_out_8b_sync_0;

component fifo_out_8b_sync_1_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_slave_0_write : OUT STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 : OUT STD_LOGIC
                 );
end component fifo_out_8b_sync_1_avalon_slave_0_arbitrator;

component fifo_out_8b_sync_1_avalon_streaming_source_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_streaming_source_valid : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_1_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal fifo_out_8b_sync_1_avalon_streaming_source_ready : OUT STD_LOGIC
                 );
end component fifo_out_8b_sync_1_avalon_streaming_source_arbitrator;

component fifo_out_8b_sync_1 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal rst : IN STD_LOGIC;
                    signal st_ready : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal st_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal st_valid : OUT STD_LOGIC;
                    signal wait_req : OUT STD_LOGIC
                 );
end component fifo_out_8b_sync_1;

component gpout_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal gpout_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_gpout_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal gpout_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal gpout_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal gpout_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal gpout_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal gpout_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal gpout_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 : OUT STD_LOGIC
                 );
end component gpout_0_avalon_slave_0_arbitrator;

component gpout_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal pins : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component gpout_0;

component int_ctrl_0_avalon_cra_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_cra_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_int_ctrl_0_avalon_cra_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_cra_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_cra_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_cra_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_cra_write : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_cra_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra : OUT STD_LOGIC
                 );
end component int_ctrl_0_avalon_cra_arbitrator;

component int_ctrl_0_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_slave_waitrequest : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal pipeline_bridge_0_m1_burstcount : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pipeline_bridge_0_m1_chipselect : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_dbs_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal pipeline_bridge_0_m1_dbs_write_32 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pipeline_bridge_0_m1_latency_counter : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_read : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_int_ctrl_0_avalon_slave_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_address : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                    signal int_ctrl_0_avalon_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_slave_read : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_slave_reset : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_write : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave : OUT STD_LOGIC;
                    signal pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave : OUT STD_LOGIC;
                    signal pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave : OUT STD_LOGIC;
                    signal pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave : OUT STD_LOGIC
                 );
end component int_ctrl_0_avalon_slave_arbitrator;

component int_ctrl_0_avalon_master_arbitrator is 
           port (
                 -- inputs:
                    signal ci_bridge_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_ci_bridge_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_dvb_dma_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_dvb_dma_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_dvb_ts_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_dvb_ts_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_gpout_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_int_ctrl_0_avalon_cra_end_xfer : IN STD_LOGIC;
                    signal d1_pcie_compiler_0_Control_Register_Access_end_xfer : IN STD_LOGIC;
                    signal d1_spi_master_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_twi_master_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_twi_master_1_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal dvb_dma_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_dma_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal dvb_ts_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal dvb_ts_1_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal gpout_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_cra_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_waitrequest_from_sa : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal spi_master_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal spi_master_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal twi_master_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal twi_master_1_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal int_ctrl_0_avalon_master_address_to_slave : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_waitrequest : OUT STD_LOGIC
                 );
end component int_ctrl_0_avalon_master_arbitrator;

component int_ctrl_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal avlm_irq : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal avlm_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal avlm_waitrequest : IN STD_LOGIC;
                    signal avls_address : IN STD_LOGIC_VECTOR (12 DOWNTO 0);
                    signal avls_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal avls_read : IN STD_LOGIC;
                    signal avls_write : IN STD_LOGIC;
                    signal avls_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal avlm_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal avlm_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal avlm_read : OUT STD_LOGIC;
                    signal avlm_write : OUT STD_LOGIC;
                    signal avlm_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal avls_irq : OUT STD_LOGIC;
                    signal avls_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal avls_waitrequest : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component int_ctrl_0;

component pcie_compiler_0_Control_Register_Access_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_pcie_compiler_0_Control_Register_Access_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access : OUT STD_LOGIC;
                    signal pcie_compiler_0_Control_Register_Access_address : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_chipselect : OUT STD_LOGIC;
                    signal pcie_compiler_0_Control_Register_Access_read : OUT STD_LOGIC;
                    signal pcie_compiler_0_Control_Register_Access_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Control_Register_Access_waitrequest_from_sa : OUT STD_LOGIC;
                    signal pcie_compiler_0_Control_Register_Access_write : OUT STD_LOGIC;
                    signal pcie_compiler_0_Control_Register_Access_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pcie_compiler_0_Control_Register_Access_arbitrator;

component pcie_compiler_0_Tx_Interface_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal dma_arbiter_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (30 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_burstcount : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dma_arbiter_0_avalon_master_write : IN STD_LOGIC;
                    signal dma_arbiter_0_avalon_master_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pcie_compiler_0_Tx_Interface_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pcie_compiler_0_Tx_Interface_readdatavalid : IN STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d1_pcie_compiler_0_Tx_Interface_end_xfer : OUT STD_LOGIC;
                    signal dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface : OUT STD_LOGIC;
                    signal dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface : OUT STD_LOGIC;
                    signal dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface : OUT STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_address : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal pcie_compiler_0_Tx_Interface_burstcount : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal pcie_compiler_0_Tx_Interface_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pcie_compiler_0_Tx_Interface_chipselect : OUT STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_read : OUT STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pcie_compiler_0_Tx_Interface_readdatavalid_from_sa : OUT STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_waitrequest_from_sa : OUT STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_write : OUT STD_LOGIC;
                    signal pcie_compiler_0_Tx_Interface_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
                 );
end component pcie_compiler_0_Tx_Interface_arbitrator;

component pcie_compiler_0_Rx_Interface_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d1_unici_core_burst_0_upstream_end_xfer : IN STD_LOGIC;
                    signal d1_unici_core_burst_1_upstream_end_xfer : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_address : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_write : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_0_upstream_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_0_upstream_waitrequest_from_sa : IN STD_LOGIC;
                    signal unici_core_burst_1_upstream_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_1_upstream_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal pcie_compiler_0_Rx_Interface_address_to_slave : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_latency_counter : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_readdatavalid : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_reset_n : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_waitrequest : OUT STD_LOGIC
                 );
end component pcie_compiler_0_Rx_Interface_arbitrator;

component pcie_compiler_0 is 
           port (
                 -- inputs:
                    signal AvlClk_i : IN STD_LOGIC;
                    signal CraAddress_i : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal CraByteEnable_i : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CraChipSelect_i : IN STD_LOGIC;
                    signal CraRead : IN STD_LOGIC;
                    signal CraWrite : IN STD_LOGIC;
                    signal CraWriteData_i : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RxmIrqNum_i : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal RxmIrq_i : IN STD_LOGIC;
                    signal RxmReadDataValid_i : IN STD_LOGIC;
                    signal RxmReadData_i : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal RxmWaitRequest_i : IN STD_LOGIC;
                    signal TxsAddress_i : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal TxsBurstCount_i : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal TxsByteEnable_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal TxsChipSelect_i : IN STD_LOGIC;
                    signal TxsRead_i : IN STD_LOGIC;
                    signal TxsWriteData_i : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal TxsWrite_i : IN STD_LOGIC;
                    signal busy_altgxb_reconfig : IN STD_LOGIC;
                    signal cal_blk_clk : IN STD_LOGIC;
                    signal fixedclk_serdes : IN STD_LOGIC;
                    signal gxb_powerdown : IN STD_LOGIC;
                    signal pcie_rstn : IN STD_LOGIC;
                    signal phystatus_ext : IN STD_LOGIC;
                    signal pipe_mode : IN STD_LOGIC;
                    signal pll_powerdown : IN STD_LOGIC;
                    signal reconfig_clk : IN STD_LOGIC;
                    signal reconfig_togxb : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal refclk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rx_in0 : IN STD_LOGIC;
                    signal rxdata0_ext : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rxdatak0_ext : IN STD_LOGIC;
                    signal rxelecidle0_ext : IN STD_LOGIC;
                    signal rxstatus0_ext : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal rxvalid0_ext : IN STD_LOGIC;
                    signal test_in : IN STD_LOGIC_VECTOR (39 DOWNTO 0);

                 -- outputs:
                    signal CraIrq_o : OUT STD_LOGIC;
                    signal CraReadData_o : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CraWaitRequest_o : OUT STD_LOGIC;
                    signal RxmAddress_o : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RxmBurstCount_o : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal RxmByteEnable_o : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal RxmRead_o : OUT STD_LOGIC;
                    signal RxmResetRequest_o : OUT STD_LOGIC;
                    signal RxmWriteData_o : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal RxmWrite_o : OUT STD_LOGIC;
                    signal TxsReadDataValid_o : OUT STD_LOGIC;
                    signal TxsReadData_o : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal TxsWaitRequest_o : OUT STD_LOGIC;
                    signal clk125_out : OUT STD_LOGIC;
                    signal clk250_out : OUT STD_LOGIC;
                    signal clk500_out : OUT STD_LOGIC;
                    signal pcie_core_clk : OUT STD_LOGIC;
                    signal powerdown_ext : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal rate_ext : OUT STD_LOGIC;
                    signal reconfig_fromgxb : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal rxpolarity0_ext : OUT STD_LOGIC;
                    signal tx_out0 : OUT STD_LOGIC;
                    signal txcompl0_ext : OUT STD_LOGIC;
                    signal txdata0_ext : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal txdatak0_ext : OUT STD_LOGIC;
                    signal txdetectrx_ext : OUT STD_LOGIC;
                    signal txelecidle0_ext : OUT STD_LOGIC
                 );
end component pcie_compiler_0;

component pipeline_bridge_0_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal pipeline_bridge_0_s1_endofpacket : IN STD_LOGIC;
                    signal pipeline_bridge_0_s1_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pipeline_bridge_0_s1_readdatavalid : IN STD_LOGIC;
                    signal pipeline_bridge_0_s1_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal unici_core_burst_0_downstream_arbitrationshare : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal unici_core_burst_0_downstream_burstcount : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal unici_core_burst_0_downstream_debugaccess : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_latency_counter : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_nativeaddress : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal unici_core_burst_0_downstream_read : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_write : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal d1_pipeline_bridge_0_s1_end_xfer : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_address : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal pipeline_bridge_0_s1_arbiterlock : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_arbiterlock2 : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_burstcount : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pipeline_bridge_0_s1_chipselect : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_debugaccess : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_endofpacket_from_sa : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_nativeaddress : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal pipeline_bridge_0_s1_read : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pipeline_bridge_0_s1_reset_n : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_write : OUT STD_LOGIC;
                    signal pipeline_bridge_0_s1_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 : OUT STD_LOGIC
                 );
end component pipeline_bridge_0_s1_arbitrator;

component pipeline_bridge_0_m1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d1_int_ctrl_0_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal int_ctrl_0_avalon_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal pipeline_bridge_0_m1_burstcount : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal pipeline_bridge_0_m1_chipselect : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_read : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_write : IN STD_LOGIC;
                    signal pipeline_bridge_0_m1_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal pipeline_bridge_0_m1_address_to_slave : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal pipeline_bridge_0_m1_dbs_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal pipeline_bridge_0_m1_dbs_write_32 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pipeline_bridge_0_m1_latency_counter : OUT STD_LOGIC;
                    signal pipeline_bridge_0_m1_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pipeline_bridge_0_m1_readdatavalid : OUT STD_LOGIC;
                    signal pipeline_bridge_0_m1_waitrequest : OUT STD_LOGIC
                 );
end component pipeline_bridge_0_m1_arbitrator;

component pipeline_bridge_0 is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal m1_endofpacket : IN STD_LOGIC;
                    signal m1_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal m1_readdatavalid : IN STD_LOGIC;
                    signal m1_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal s1_address : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal s1_arbiterlock : IN STD_LOGIC;
                    signal s1_arbiterlock2 : IN STD_LOGIC;
                    signal s1_burstcount : IN STD_LOGIC;
                    signal s1_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal s1_chipselect : IN STD_LOGIC;
                    signal s1_debugaccess : IN STD_LOGIC;
                    signal s1_nativeaddress : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal s1_read : IN STD_LOGIC;
                    signal s1_write : IN STD_LOGIC;
                    signal s1_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal m1_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal m1_burstcount : OUT STD_LOGIC;
                    signal m1_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal m1_chipselect : OUT STD_LOGIC;
                    signal m1_debugaccess : OUT STD_LOGIC;
                    signal m1_read : OUT STD_LOGIC;
                    signal m1_write : OUT STD_LOGIC;
                    signal m1_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal s1_endofpacket : OUT STD_LOGIC;
                    signal s1_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal s1_readdatavalid : OUT STD_LOGIC;
                    signal s1_waitrequest : OUT STD_LOGIC
                 );
end component pipeline_bridge_0;

component pipeline_bridge_0_bridge_arbitrator is 
end component pipeline_bridge_0_bridge_arbitrator;

component spi_master_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal spi_master_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal spi_master_0_avalon_slave_0_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal d1_spi_master_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal spi_master_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal spi_master_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal spi_master_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal spi_master_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal spi_master_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal spi_master_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal spi_master_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component spi_master_0_avalon_slave_0_arbitrator;

component spi_master_0 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal miso : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal cs_n : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal mosi : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sclk : OUT STD_LOGIC;
                    signal wait_req : OUT STD_LOGIC
                 );
end component spi_master_0;

component twi_master_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal d1_twi_master_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal twi_master_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal twi_master_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal twi_master_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal twi_master_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal twi_master_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal twi_master_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component twi_master_0_avalon_slave_0_arbitrator;

component twi_master_0_avalon_streaming_sink_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_out_8b_sync_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal fifo_out_8b_sync_0_avalon_streaming_source_valid : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_0_avalon_streaming_sink_ready : IN STD_LOGIC;

                 -- outputs:
                    signal twi_master_0_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal twi_master_0_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                    signal twi_master_0_avalon_streaming_sink_valid : OUT STD_LOGIC
                 );
end component twi_master_0_avalon_streaming_sink_arbitrator;

component twi_master_0_avalon_streaming_source_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_0_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal twi_master_0_avalon_streaming_source_valid : IN STD_LOGIC;

                 -- outputs:
                    signal twi_master_0_avalon_streaming_source_ready : OUT STD_LOGIC
                 );
end component twi_master_0_avalon_streaming_source_arbitrator;

component twi_master_0 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal in_octet : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal in_valid : IN STD_LOGIC;
                    signal out_ready : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal scl_in : IN STD_LOGIC;
                    signal sda_in : IN STD_LOGIC;
                    signal sink_irq : IN STD_LOGIC;
                    signal source_irq : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal in_ready : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal out_octet : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal out_valid : OUT STD_LOGIC;
                    signal scl_act : OUT STD_LOGIC;
                    signal sda_act : OUT STD_LOGIC
                 );
end component twi_master_0;

component twi_master_1_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_address_to_slave : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_read : IN STD_LOGIC;
                    signal int_ctrl_0_avalon_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_1_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal d1_twi_master_1_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 : OUT STD_LOGIC;
                    signal twi_master_1_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal twi_master_1_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal twi_master_1_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal twi_master_1_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal twi_master_1_avalon_slave_0_write : OUT STD_LOGIC;
                    signal twi_master_1_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component twi_master_1_avalon_slave_0_arbitrator;

component twi_master_1_avalon_streaming_sink_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_out_8b_sync_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal fifo_out_8b_sync_1_avalon_streaming_source_valid : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_1_avalon_streaming_sink_ready : IN STD_LOGIC;

                 -- outputs:
                    signal twi_master_1_avalon_streaming_sink_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal twi_master_1_avalon_streaming_sink_ready_from_sa : OUT STD_LOGIC;
                    signal twi_master_1_avalon_streaming_sink_valid : OUT STD_LOGIC
                 );
end component twi_master_1_avalon_streaming_sink_arbitrator;

component twi_master_1_avalon_streaming_source_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal twi_master_1_avalon_streaming_source_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal twi_master_1_avalon_streaming_source_valid : IN STD_LOGIC;

                 -- outputs:
                    signal twi_master_1_avalon_streaming_source_ready : OUT STD_LOGIC
                 );
end component twi_master_1_avalon_streaming_source_arbitrator;

component twi_master_1 is 
           port (
                 -- inputs:
                    signal addr : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byte_en : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal in_octet : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal in_valid : IN STD_LOGIC;
                    signal out_ready : IN STD_LOGIC;
                    signal rst : IN STD_LOGIC;
                    signal scl_in : IN STD_LOGIC;
                    signal sda_in : IN STD_LOGIC;
                    signal sink_irq : IN STD_LOGIC;
                    signal source_irq : IN STD_LOGIC;
                    signal wr_en : IN STD_LOGIC;

                 -- outputs:
                    signal in_ready : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal out_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal out_octet : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal out_valid : OUT STD_LOGIC;
                    signal scl_act : OUT STD_LOGIC;
                    signal sda_act : OUT STD_LOGIC
                 );
end component twi_master_1;

component unici_core_burst_0_upstream_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_address_to_slave : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_latency_counter : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_write : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_0_upstream_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_0_upstream_readdatavalid : IN STD_LOGIC;
                    signal unici_core_burst_0_upstream_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal d1_unici_core_burst_0_upstream_end_xfer : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream : OUT STD_LOGIC;
                    signal unici_core_burst_0_upstream_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal unici_core_burst_0_upstream_burstcount : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal unici_core_burst_0_upstream_byteaddress : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal unici_core_burst_0_upstream_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal unici_core_burst_0_upstream_debugaccess : OUT STD_LOGIC;
                    signal unici_core_burst_0_upstream_read : OUT STD_LOGIC;
                    signal unici_core_burst_0_upstream_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_0_upstream_waitrequest_from_sa : OUT STD_LOGIC;
                    signal unici_core_burst_0_upstream_write : OUT STD_LOGIC;
                    signal unici_core_burst_0_upstream_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
                 );
end component unici_core_burst_0_upstream_arbitrator;

component unici_core_burst_0_downstream_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d1_pipeline_bridge_0_s1_end_xfer : IN STD_LOGIC;
                    signal pipeline_bridge_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal pipeline_bridge_0_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_address : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal unici_core_burst_0_downstream_burstcount : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_read : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_write : IN STD_LOGIC;
                    signal unici_core_burst_0_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal unici_core_burst_0_downstream_address_to_slave : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal unici_core_burst_0_downstream_latency_counter : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_0_downstream_readdatavalid : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_reset_n : OUT STD_LOGIC;
                    signal unici_core_burst_0_downstream_waitrequest : OUT STD_LOGIC
                 );
end component unici_core_burst_0_downstream_arbitrator;

component unici_core_burst_0 is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal downstream_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal downstream_readdatavalid : IN STD_LOGIC;
                    signal downstream_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal upstream_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal upstream_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal upstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal upstream_debugaccess : IN STD_LOGIC;
                    signal upstream_nativeaddress : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal upstream_read : IN STD_LOGIC;
                    signal upstream_write : IN STD_LOGIC;
                    signal upstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal downstream_address : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal downstream_arbitrationshare : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal downstream_burstcount : OUT STD_LOGIC;
                    signal downstream_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal downstream_debugaccess : OUT STD_LOGIC;
                    signal downstream_nativeaddress : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal downstream_read : OUT STD_LOGIC;
                    signal downstream_write : OUT STD_LOGIC;
                    signal downstream_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal upstream_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal upstream_readdatavalid : OUT STD_LOGIC;
                    signal upstream_waitrequest : OUT STD_LOGIC
                 );
end component unici_core_burst_0;

component unici_core_burst_1_upstream_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_address_to_slave : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal pcie_compiler_0_Rx_Interface_latency_counter : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_write : IN STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_1_upstream_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_1_upstream_readdatavalid : IN STD_LOGIC;
                    signal unici_core_burst_1_upstream_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal d1_unici_core_burst_1_upstream_end_xfer : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register : OUT STD_LOGIC;
                    signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream : OUT STD_LOGIC;
                    signal unici_core_burst_1_upstream_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal unici_core_burst_1_upstream_burstcount : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal unici_core_burst_1_upstream_byteaddress : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal unici_core_burst_1_upstream_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal unici_core_burst_1_upstream_debugaccess : OUT STD_LOGIC;
                    signal unici_core_burst_1_upstream_read : OUT STD_LOGIC;
                    signal unici_core_burst_1_upstream_readdata_from_sa : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_1_upstream_waitrequest_from_sa : OUT STD_LOGIC;
                    signal unici_core_burst_1_upstream_write : OUT STD_LOGIC;
                    signal unici_core_burst_1_upstream_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
                 );
end component unici_core_burst_1_upstream_arbitrator;

component unici_core_burst_1_downstream_arbitrator is 
           port (
                 -- inputs:
                    signal avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal unici_core_burst_1_downstream_burstcount : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_read : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_write : IN STD_LOGIC;
                    signal unici_core_burst_1_downstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal unici_core_burst_1_downstream_address_to_slave : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal unici_core_burst_1_downstream_latency_counter : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal unici_core_burst_1_downstream_readdatavalid : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_reset_n : OUT STD_LOGIC;
                    signal unici_core_burst_1_downstream_waitrequest : OUT STD_LOGIC
                 );
end component unici_core_burst_1_downstream_arbitrator;

component unici_core_burst_1 is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal downstream_readdata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal downstream_readdatavalid : IN STD_LOGIC;
                    signal downstream_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal upstream_address : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal upstream_burstcount : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal upstream_byteenable : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal upstream_debugaccess : IN STD_LOGIC;
                    signal upstream_nativeaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal upstream_read : IN STD_LOGIC;
                    signal upstream_write : IN STD_LOGIC;
                    signal upstream_writedata : IN STD_LOGIC_VECTOR (63 DOWNTO 0);

                 -- outputs:
                    signal downstream_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal downstream_arbitrationshare : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal downstream_burstcount : OUT STD_LOGIC;
                    signal downstream_byteenable : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal downstream_debugaccess : OUT STD_LOGIC;
                    signal downstream_nativeaddress : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal downstream_read : OUT STD_LOGIC;
                    signal downstream_write : OUT STD_LOGIC;
                    signal downstream_writedata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal upstream_readdata : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal upstream_readdatavalid : OUT STD_LOGIC;
                    signal upstream_waitrequest : OUT STD_LOGIC
                 );
end component unici_core_burst_1;

component unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch_module;

                signal avalon64_to_avalon8_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_read :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal avalon64_to_avalon8_0_avalon_slave_0_reset :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_write :  STD_LOGIC;
                signal avalon64_to_avalon8_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal ci_bridge_0_avalon_slave_0_reset :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_write :  STD_LOGIC;
                signal ci_bridge_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_ci_bridge_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_dvb_dma_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_dvb_dma_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_dvb_ts_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_dvb_ts_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_gpout_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_int_ctrl_0_avalon_cra_end_xfer :  STD_LOGIC;
                signal d1_int_ctrl_0_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_pcie_compiler_0_Control_Register_Access_end_xfer :  STD_LOGIC;
                signal d1_pcie_compiler_0_Tx_Interface_end_xfer :  STD_LOGIC;
                signal d1_pipeline_bridge_0_s1_end_xfer :  STD_LOGIC;
                signal d1_spi_master_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_twi_master_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_twi_master_1_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_unici_core_burst_0_upstream_end_xfer :  STD_LOGIC;
                signal d1_unici_core_burst_1_upstream_end_xfer :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_address :  STD_LOGIC_VECTOR (30 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_address_to_slave :  STD_LOGIC_VECTOR (30 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_burstcount :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dma_arbiter_0_avalon_master_reset :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_waitrequest :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_write :  STD_LOGIC;
                signal dma_arbiter_0_avalon_master_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_dma_0_avalon_slave_0_reset :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_write :  STD_LOGIC;
                signal dvb_dma_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_address :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_dma_1_avalon_slave_0_reset :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_write :  STD_LOGIC;
                signal dvb_dma_1_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_read :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_ts_0_avalon_slave_0_reset :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_write :  STD_LOGIC;
                signal dvb_ts_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_read :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dvb_ts_1_avalon_slave_0_reset :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_write :  STD_LOGIC;
                signal dvb_ts_1_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_read :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_slave_0_reset :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_write :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_streaming_sink_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal fifo_in_8b_sync_0_avalon_streaming_sink_ready :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa :  STD_LOGIC;
                signal fifo_in_8b_sync_0_avalon_streaming_sink_valid :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_read :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_slave_0_reset :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_write :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_streaming_sink_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal fifo_in_8b_sync_1_avalon_streaming_sink_ready :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa :  STD_LOGIC;
                signal fifo_in_8b_sync_1_avalon_streaming_sink_valid :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_slave_0_reset :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_write :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_streaming_source_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal fifo_out_8b_sync_0_avalon_streaming_source_ready :  STD_LOGIC;
                signal fifo_out_8b_sync_0_avalon_streaming_source_valid :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_slave_0_reset :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_write :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_streaming_source_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal fifo_out_8b_sync_1_avalon_streaming_source_ready :  STD_LOGIC;
                signal fifo_out_8b_sync_1_avalon_streaming_source_valid :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal gpout_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal gpout_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal gpout_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal gpout_0_avalon_slave_0_reset :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_write :  STD_LOGIC;
                signal gpout_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal int_ctrl_0_avalon_cra_write :  STD_LOGIC;
                signal int_ctrl_0_avalon_cra_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal int_ctrl_0_avalon_master_address :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal int_ctrl_0_avalon_master_address_to_slave :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal int_ctrl_0_avalon_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_waitrequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_write :  STD_LOGIC;
                signal int_ctrl_0_avalon_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_address :  STD_LOGIC_VECTOR (12 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_irq :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_read :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal int_ctrl_0_avalon_slave_reset :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_waitrequest :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_waitrequest_from_sa :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_write :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_cam0_bypass_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cam0_fail_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cam0_ready_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cam1_bypass_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cam1_fail_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cam1_ready_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cam_interrupts_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cam_mclki_from_the_dvb_ts_0 :  STD_LOGIC;
                signal internal_cam_mclki_from_the_dvb_ts_1 :  STD_LOGIC;
                signal internal_cam_mdi_from_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_cam_mdi_from_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_cam_mistrt_from_the_dvb_ts_0 :  STD_LOGIC;
                signal internal_cam_mistrt_from_the_dvb_ts_1 :  STD_LOGIC;
                signal internal_cam_mival_from_the_dvb_ts_0 :  STD_LOGIC;
                signal internal_cam_mival_from_the_dvb_ts_1 :  STD_LOGIC;
                signal internal_cam_readdata_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_cam_waitreq_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_a_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal internal_ci_bus_dir_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_d_en_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_d_out_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_ci_iord_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_iowr_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_reg_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_ci_we_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cia_ce_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cia_data_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cia_reset_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cia_reset_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cib_ce_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cib_data_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cib_reset_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_cib_reset_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_clk125_out_pcie_compiler_0 :  STD_LOGIC;
                signal internal_clk250_out_pcie_compiler_0 :  STD_LOGIC;
                signal internal_clk500_out_pcie_compiler_0 :  STD_LOGIC;
                signal internal_cs_n_from_the_spi_master_0 :  STD_LOGIC;
                signal internal_dma0_wait_from_the_dma_arbiter_0 :  STD_LOGIC;
                signal internal_dma1_wait_from_the_dma_arbiter_0 :  STD_LOGIC;
                signal internal_dvb_out_data_from_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_dvb_out_data_from_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_dvb_out_dsop_from_the_dvb_ts_0 :  STD_LOGIC;
                signal internal_dvb_out_dsop_from_the_dvb_ts_1 :  STD_LOGIC;
                signal internal_dvb_out_dval_from_the_dvb_ts_0 :  STD_LOGIC;
                signal internal_dvb_out_dval_from_the_dvb_ts_1 :  STD_LOGIC;
                signal internal_interrupt_from_the_ci_bridge_0 :  STD_LOGIC;
                signal internal_interrupt_from_the_dvb_dma_0 :  STD_LOGIC;
                signal internal_interrupt_from_the_dvb_dma_1 :  STD_LOGIC;
                signal internal_interrupt_from_the_dvb_ts_0 :  STD_LOGIC;
                signal internal_interrupt_from_the_dvb_ts_1 :  STD_LOGIC;
                signal internal_irq_from_the_fifo_in_8b_sync_0 :  STD_LOGIC;
                signal internal_irq_from_the_fifo_in_8b_sync_1 :  STD_LOGIC;
                signal internal_irq_from_the_fifo_out_8b_sync_0 :  STD_LOGIC;
                signal internal_irq_from_the_fifo_out_8b_sync_1 :  STD_LOGIC;
                signal internal_irq_from_the_spi_master_0 :  STD_LOGIC;
                signal internal_irq_from_the_twi_master_0 :  STD_LOGIC;
                signal internal_irq_from_the_twi_master_1 :  STD_LOGIC;
                signal internal_mem_addr_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (60 DOWNTO 0);
                signal internal_mem_addr_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (60 DOWNTO 0);
                signal internal_mem_byteen_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_mem_byteen_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_mem_size_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_mem_size_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_mem_wrdata_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal internal_mem_wrdata_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal internal_mem_write_from_the_dvb_dma_0 :  STD_LOGIC;
                signal internal_mem_write_from_the_dvb_dma_1 :  STD_LOGIC;
                signal internal_mosi_from_the_spi_master_0 :  STD_LOGIC;
                signal internal_out_address_from_the_avalon64_to_avalon8_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_out_read_from_the_avalon64_to_avalon8_0 :  STD_LOGIC;
                signal internal_out_write_from_the_avalon64_to_avalon8_0 :  STD_LOGIC;
                signal internal_out_writedata_from_the_avalon64_to_avalon8_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_pcie_compiler_0_pcie_core_clk_out :  STD_LOGIC;
                signal internal_pins_from_the_gpout_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal internal_powerdown_ext_pcie_compiler_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_rate_ext_pcie_compiler_0 :  STD_LOGIC;
                signal internal_reconfig_fromgxb_pcie_compiler_0 :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal internal_rxpolarity0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal internal_scl_act_from_the_twi_master_0 :  STD_LOGIC;
                signal internal_scl_act_from_the_twi_master_1 :  STD_LOGIC;
                signal internal_sclk_from_the_spi_master_0 :  STD_LOGIC;
                signal internal_sda_act_from_the_twi_master_0 :  STD_LOGIC;
                signal internal_sda_act_from_the_twi_master_1 :  STD_LOGIC;
                signal internal_tx_out0_pcie_compiler_0 :  STD_LOGIC;
                signal internal_txcompl0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal internal_txdata0_ext_pcie_compiler_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_txdatak0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal internal_txdetectrx_ext_pcie_compiler_0 :  STD_LOGIC;
                signal internal_txelecidle0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal module_input15 :  STD_LOGIC;
                signal out_clk_pcie_compiler_0_pcie_core_clk :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_address :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_chipselect :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_irq :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_read :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_waitrequest :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_waitrequest_from_sa :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_write :  STD_LOGIC;
                signal pcie_compiler_0_Control_Register_Access_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_address :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_address_to_slave :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_irq :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_irqnumber :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_latency_counter :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pcie_compiler_0_Rx_Interface_readdatavalid :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_reset_n :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_resetrequest :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_waitrequest :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_write :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_address :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_chipselect :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_read :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_readdata_from_sa :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_readdatavalid :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_readdatavalid_from_sa :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_waitrequest :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_waitrequest_from_sa :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_write :  STD_LOGIC;
                signal pcie_compiler_0_Tx_Interface_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pcie_compiler_0_pcie_core_clk_out_reset_n :  STD_LOGIC;
                signal pipeline_bridge_0_m1_address :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal pipeline_bridge_0_m1_address_to_slave :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal pipeline_bridge_0_m1_burstcount :  STD_LOGIC;
                signal pipeline_bridge_0_m1_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal pipeline_bridge_0_m1_chipselect :  STD_LOGIC;
                signal pipeline_bridge_0_m1_dbs_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pipeline_bridge_0_m1_dbs_write_32 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pipeline_bridge_0_m1_debugaccess :  STD_LOGIC;
                signal pipeline_bridge_0_m1_endofpacket :  STD_LOGIC;
                signal pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal pipeline_bridge_0_m1_latency_counter :  STD_LOGIC;
                signal pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal pipeline_bridge_0_m1_read :  STD_LOGIC;
                signal pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal pipeline_bridge_0_m1_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pipeline_bridge_0_m1_readdatavalid :  STD_LOGIC;
                signal pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave :  STD_LOGIC;
                signal pipeline_bridge_0_m1_waitrequest :  STD_LOGIC;
                signal pipeline_bridge_0_m1_write :  STD_LOGIC;
                signal pipeline_bridge_0_m1_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pipeline_bridge_0_s1_address :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal pipeline_bridge_0_s1_arbiterlock :  STD_LOGIC;
                signal pipeline_bridge_0_s1_arbiterlock2 :  STD_LOGIC;
                signal pipeline_bridge_0_s1_burstcount :  STD_LOGIC;
                signal pipeline_bridge_0_s1_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pipeline_bridge_0_s1_chipselect :  STD_LOGIC;
                signal pipeline_bridge_0_s1_debugaccess :  STD_LOGIC;
                signal pipeline_bridge_0_s1_endofpacket :  STD_LOGIC;
                signal pipeline_bridge_0_s1_endofpacket_from_sa :  STD_LOGIC;
                signal pipeline_bridge_0_s1_nativeaddress :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal pipeline_bridge_0_s1_read :  STD_LOGIC;
                signal pipeline_bridge_0_s1_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pipeline_bridge_0_s1_readdata_from_sa :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pipeline_bridge_0_s1_readdatavalid :  STD_LOGIC;
                signal pipeline_bridge_0_s1_reset_n :  STD_LOGIC;
                signal pipeline_bridge_0_s1_waitrequest :  STD_LOGIC;
                signal pipeline_bridge_0_s1_waitrequest_from_sa :  STD_LOGIC;
                signal pipeline_bridge_0_s1_write :  STD_LOGIC;
                signal pipeline_bridge_0_s1_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal reset_n_sources :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal spi_master_0_avalon_slave_0_reset :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_write :  STD_LOGIC;
                signal spi_master_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_0_avalon_slave_0_reset :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_write :  STD_LOGIC;
                signal twi_master_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_0_avalon_streaming_sink_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal twi_master_0_avalon_streaming_sink_ready :  STD_LOGIC;
                signal twi_master_0_avalon_streaming_sink_ready_from_sa :  STD_LOGIC;
                signal twi_master_0_avalon_streaming_sink_valid :  STD_LOGIC;
                signal twi_master_0_avalon_streaming_source_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal twi_master_0_avalon_streaming_source_ready :  STD_LOGIC;
                signal twi_master_0_avalon_streaming_source_valid :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_1_avalon_slave_0_reset :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_write :  STD_LOGIC;
                signal twi_master_1_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal twi_master_1_avalon_streaming_sink_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal twi_master_1_avalon_streaming_sink_ready :  STD_LOGIC;
                signal twi_master_1_avalon_streaming_sink_ready_from_sa :  STD_LOGIC;
                signal twi_master_1_avalon_streaming_sink_valid :  STD_LOGIC;
                signal twi_master_1_avalon_streaming_source_data :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal twi_master_1_avalon_streaming_source_ready :  STD_LOGIC;
                signal twi_master_1_avalon_streaming_source_valid :  STD_LOGIC;
                signal unici_core_burst_0_downstream_address :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal unici_core_burst_0_downstream_address_to_slave :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal unici_core_burst_0_downstream_arbitrationshare :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_downstream_burstcount :  STD_LOGIC;
                signal unici_core_burst_0_downstream_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal unici_core_burst_0_downstream_debugaccess :  STD_LOGIC;
                signal unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_latency_counter :  STD_LOGIC;
                signal unici_core_burst_0_downstream_nativeaddress :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_read :  STD_LOGIC;
                signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register :  STD_LOGIC;
                signal unici_core_burst_0_downstream_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_0_downstream_readdatavalid :  STD_LOGIC;
                signal unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 :  STD_LOGIC;
                signal unici_core_burst_0_downstream_reset_n :  STD_LOGIC;
                signal unici_core_burst_0_downstream_waitrequest :  STD_LOGIC;
                signal unici_core_burst_0_downstream_write :  STD_LOGIC;
                signal unici_core_burst_0_downstream_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_0_upstream_address :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal unici_core_burst_0_upstream_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_0_upstream_byteaddress :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_0_upstream_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal unici_core_burst_0_upstream_debugaccess :  STD_LOGIC;
                signal unici_core_burst_0_upstream_read :  STD_LOGIC;
                signal unici_core_burst_0_upstream_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_0_upstream_readdata_from_sa :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_0_upstream_readdatavalid :  STD_LOGIC;
                signal unici_core_burst_0_upstream_waitrequest :  STD_LOGIC;
                signal unici_core_burst_0_upstream_waitrequest_from_sa :  STD_LOGIC;
                signal unici_core_burst_0_upstream_write :  STD_LOGIC;
                signal unici_core_burst_0_upstream_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_1_downstream_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_1_downstream_address_to_slave :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_1_downstream_arbitrationshare :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_downstream_burstcount :  STD_LOGIC;
                signal unici_core_burst_1_downstream_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal unici_core_burst_1_downstream_debugaccess :  STD_LOGIC;
                signal unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_latency_counter :  STD_LOGIC;
                signal unici_core_burst_1_downstream_nativeaddress :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_read :  STD_LOGIC;
                signal unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_1_downstream_readdatavalid :  STD_LOGIC;
                signal unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_reset_n :  STD_LOGIC;
                signal unici_core_burst_1_downstream_waitrequest :  STD_LOGIC;
                signal unici_core_burst_1_downstream_write :  STD_LOGIC;
                signal unici_core_burst_1_downstream_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_1_upstream_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal unici_core_burst_1_upstream_burstcount :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal unici_core_burst_1_upstream_byteaddress :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal unici_core_burst_1_upstream_byteenable :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal unici_core_burst_1_upstream_debugaccess :  STD_LOGIC;
                signal unici_core_burst_1_upstream_read :  STD_LOGIC;
                signal unici_core_burst_1_upstream_readdata :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_1_upstream_readdata_from_sa :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal unici_core_burst_1_upstream_readdatavalid :  STD_LOGIC;
                signal unici_core_burst_1_upstream_waitrequest :  STD_LOGIC;
                signal unici_core_burst_1_upstream_waitrequest_from_sa :  STD_LOGIC;
                signal unici_core_burst_1_upstream_write :  STD_LOGIC;
                signal unici_core_burst_1_upstream_writedata :  STD_LOGIC_VECTOR (63 DOWNTO 0);

begin

  --the_avalon64_to_avalon8_0_avalon_slave_0, which is an e_instance
  the_avalon64_to_avalon8_0_avalon_slave_0 : avalon64_to_avalon8_0_avalon_slave_0_arbitrator
    port map(
      avalon64_to_avalon8_0_avalon_slave_0_address => avalon64_to_avalon8_0_avalon_slave_0_address,
      avalon64_to_avalon8_0_avalon_slave_0_byteenable => avalon64_to_avalon8_0_avalon_slave_0_byteenable,
      avalon64_to_avalon8_0_avalon_slave_0_read => avalon64_to_avalon8_0_avalon_slave_0_read,
      avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa => avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa,
      avalon64_to_avalon8_0_avalon_slave_0_reset => avalon64_to_avalon8_0_avalon_slave_0_reset,
      avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa => avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa,
      avalon64_to_avalon8_0_avalon_slave_0_write => avalon64_to_avalon8_0_avalon_slave_0_write,
      avalon64_to_avalon8_0_avalon_slave_0_writedata => avalon64_to_avalon8_0_avalon_slave_0_writedata,
      d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer => d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer,
      unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0,
      avalon64_to_avalon8_0_avalon_slave_0_readdata => avalon64_to_avalon8_0_avalon_slave_0_readdata,
      avalon64_to_avalon8_0_avalon_slave_0_waitrequest => avalon64_to_avalon8_0_avalon_slave_0_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_1_downstream_address_to_slave => unici_core_burst_1_downstream_address_to_slave,
      unici_core_burst_1_downstream_arbitrationshare => unici_core_burst_1_downstream_arbitrationshare,
      unici_core_burst_1_downstream_burstcount => unici_core_burst_1_downstream_burstcount,
      unici_core_burst_1_downstream_byteenable => unici_core_burst_1_downstream_byteenable,
      unici_core_burst_1_downstream_latency_counter => unici_core_burst_1_downstream_latency_counter,
      unici_core_burst_1_downstream_read => unici_core_burst_1_downstream_read,
      unici_core_burst_1_downstream_write => unici_core_burst_1_downstream_write,
      unici_core_burst_1_downstream_writedata => unici_core_burst_1_downstream_writedata
    );


  --the_avalon64_to_avalon8_0, which is an e_ptf_instance
  the_avalon64_to_avalon8_0 : avalon64_to_avalon8_0
    port map(
      out_address => internal_out_address_from_the_avalon64_to_avalon8_0,
      out_read => internal_out_read_from_the_avalon64_to_avalon8_0,
      out_write => internal_out_write_from_the_avalon64_to_avalon8_0,
      out_writedata => internal_out_writedata_from_the_avalon64_to_avalon8_0,
      readdata => avalon64_to_avalon8_0_avalon_slave_0_readdata,
      waitrequest => avalon64_to_avalon8_0_avalon_slave_0_waitrequest,
      address => avalon64_to_avalon8_0_avalon_slave_0_address,
      byteenable => avalon64_to_avalon8_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      out_readdata => out_readdata_to_the_avalon64_to_avalon8_0,
      out_waitrequest => out_waitrequest_to_the_avalon64_to_avalon8_0,
      read => avalon64_to_avalon8_0_avalon_slave_0_read,
      rst => avalon64_to_avalon8_0_avalon_slave_0_reset,
      write => avalon64_to_avalon8_0_avalon_slave_0_write,
      writedata => avalon64_to_avalon8_0_avalon_slave_0_writedata
    );


  --the_ci_bridge_0_avalon_slave_0, which is an e_instance
  the_ci_bridge_0_avalon_slave_0 : ci_bridge_0_avalon_slave_0_arbitrator
    port map(
      ci_bridge_0_avalon_slave_0_address => ci_bridge_0_avalon_slave_0_address,
      ci_bridge_0_avalon_slave_0_byteenable => ci_bridge_0_avalon_slave_0_byteenable,
      ci_bridge_0_avalon_slave_0_readdata_from_sa => ci_bridge_0_avalon_slave_0_readdata_from_sa,
      ci_bridge_0_avalon_slave_0_reset => ci_bridge_0_avalon_slave_0_reset,
      ci_bridge_0_avalon_slave_0_write => ci_bridge_0_avalon_slave_0_write,
      ci_bridge_0_avalon_slave_0_writedata => ci_bridge_0_avalon_slave_0_writedata,
      d1_ci_bridge_0_avalon_slave_0_end_xfer => d1_ci_bridge_0_avalon_slave_0_end_xfer,
      int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0,
      ci_bridge_0_avalon_slave_0_readdata => ci_bridge_0_avalon_slave_0_readdata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_ci_bridge_0, which is an e_ptf_instance
  the_ci_bridge_0 : ci_bridge_0
    port map(
      cam0_bypass => internal_cam0_bypass_from_the_ci_bridge_0,
      cam0_fail => internal_cam0_fail_from_the_ci_bridge_0,
      cam0_ready => internal_cam0_ready_from_the_ci_bridge_0,
      cam1_bypass => internal_cam1_bypass_from_the_ci_bridge_0,
      cam1_fail => internal_cam1_fail_from_the_ci_bridge_0,
      cam1_ready => internal_cam1_ready_from_the_ci_bridge_0,
      cam_interrupts => internal_cam_interrupts_from_the_ci_bridge_0,
      cam_readdata => internal_cam_readdata_from_the_ci_bridge_0,
      cam_waitreq => internal_cam_waitreq_from_the_ci_bridge_0,
      ci_a => internal_ci_a_from_the_ci_bridge_0,
      ci_bus_dir => internal_ci_bus_dir_from_the_ci_bridge_0,
      ci_d_en => internal_ci_d_en_from_the_ci_bridge_0,
      ci_d_out => internal_ci_d_out_from_the_ci_bridge_0,
      ci_iord_n => internal_ci_iord_n_from_the_ci_bridge_0,
      ci_iowr_n => internal_ci_iowr_n_from_the_ci_bridge_0,
      ci_oe_n => internal_ci_oe_n_from_the_ci_bridge_0,
      ci_reg_n => internal_ci_reg_n_from_the_ci_bridge_0,
      ci_we_n => internal_ci_we_n_from_the_ci_bridge_0,
      cia_ce_n => internal_cia_ce_n_from_the_ci_bridge_0,
      cia_data_buf_oe_n => internal_cia_data_buf_oe_n_from_the_ci_bridge_0,
      cia_reset => internal_cia_reset_from_the_ci_bridge_0,
      cia_reset_buf_oe_n => internal_cia_reset_buf_oe_n_from_the_ci_bridge_0,
      cib_ce_n => internal_cib_ce_n_from_the_ci_bridge_0,
      cib_data_buf_oe_n => internal_cib_data_buf_oe_n_from_the_ci_bridge_0,
      cib_reset => internal_cib_reset_from_the_ci_bridge_0,
      cib_reset_buf_oe_n => internal_cib_reset_buf_oe_n_from_the_ci_bridge_0,
      interrupt => internal_interrupt_from_the_ci_bridge_0,
      readdata => ci_bridge_0_avalon_slave_0_readdata,
      address => ci_bridge_0_avalon_slave_0_address,
      byteenable => ci_bridge_0_avalon_slave_0_byteenable,
      cam_address => cam_address_to_the_ci_bridge_0,
      cam_read => cam_read_to_the_ci_bridge_0,
      cam_write => cam_write_to_the_ci_bridge_0,
      cam_writedata => cam_writedata_to_the_ci_bridge_0,
      ci_d_in => ci_d_in_to_the_ci_bridge_0,
      cia_cd_n => cia_cd_n_to_the_ci_bridge_0,
      cia_ireq_n => cia_ireq_n_to_the_ci_bridge_0,
      cia_overcurrent_n => cia_overcurrent_n_to_the_ci_bridge_0,
      cia_wait_n => cia_wait_n_to_the_ci_bridge_0,
      cib_cd_n => cib_cd_n_to_the_ci_bridge_0,
      cib_ireq_n => cib_ireq_n_to_the_ci_bridge_0,
      cib_overcurrent_n => cib_overcurrent_n_to_the_ci_bridge_0,
      cib_wait_n => cib_wait_n_to_the_ci_bridge_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      rst => ci_bridge_0_avalon_slave_0_reset,
      write => ci_bridge_0_avalon_slave_0_write,
      writedata => ci_bridge_0_avalon_slave_0_writedata
    );


  --the_dma_arbiter_0_avalon_master, which is an e_instance
  the_dma_arbiter_0_avalon_master : dma_arbiter_0_avalon_master_arbitrator
    port map(
      dma_arbiter_0_avalon_master_address_to_slave => dma_arbiter_0_avalon_master_address_to_slave,
      dma_arbiter_0_avalon_master_reset => dma_arbiter_0_avalon_master_reset,
      dma_arbiter_0_avalon_master_waitrequest => dma_arbiter_0_avalon_master_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      d1_pcie_compiler_0_Tx_Interface_end_xfer => d1_pcie_compiler_0_Tx_Interface_end_xfer,
      dma_arbiter_0_avalon_master_address => dma_arbiter_0_avalon_master_address,
      dma_arbiter_0_avalon_master_burstcount => dma_arbiter_0_avalon_master_burstcount,
      dma_arbiter_0_avalon_master_byteenable => dma_arbiter_0_avalon_master_byteenable,
      dma_arbiter_0_avalon_master_write => dma_arbiter_0_avalon_master_write,
      dma_arbiter_0_avalon_master_writedata => dma_arbiter_0_avalon_master_writedata,
      dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface => dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface,
      dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface => dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface,
      dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface => dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface,
      pcie_compiler_0_Tx_Interface_waitrequest_from_sa => pcie_compiler_0_Tx_Interface_waitrequest_from_sa,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_dma_arbiter_0, which is an e_ptf_instance
  the_dma_arbiter_0 : dma_arbiter_0
    port map(
      dma0_wait => internal_dma0_wait_from_the_dma_arbiter_0,
      dma1_wait => internal_dma1_wait_from_the_dma_arbiter_0,
      mem_addr => dma_arbiter_0_avalon_master_address,
      mem_byteen => dma_arbiter_0_avalon_master_byteenable,
      mem_size => dma_arbiter_0_avalon_master_burstcount,
      mem_wrdata => dma_arbiter_0_avalon_master_writedata,
      mem_write => dma_arbiter_0_avalon_master_write,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dma0_addr => dma0_addr_to_the_dma_arbiter_0,
      dma0_byteen => dma0_byteen_to_the_dma_arbiter_0,
      dma0_size => dma0_size_to_the_dma_arbiter_0,
      dma0_wrdata => dma0_wrdata_to_the_dma_arbiter_0,
      dma0_write => dma0_write_to_the_dma_arbiter_0,
      dma1_addr => dma1_addr_to_the_dma_arbiter_0,
      dma1_byteen => dma1_byteen_to_the_dma_arbiter_0,
      dma1_size => dma1_size_to_the_dma_arbiter_0,
      dma1_wrdata => dma1_wrdata_to_the_dma_arbiter_0,
      dma1_write => dma1_write_to_the_dma_arbiter_0,
      mem_waitreq => dma_arbiter_0_avalon_master_waitrequest,
      rst => dma_arbiter_0_avalon_master_reset
    );


  --the_dvb_dma_0_avalon_slave_0, which is an e_instance
  the_dvb_dma_0_avalon_slave_0 : dvb_dma_0_avalon_slave_0_arbitrator
    port map(
      d1_dvb_dma_0_avalon_slave_0_end_xfer => d1_dvb_dma_0_avalon_slave_0_end_xfer,
      dvb_dma_0_avalon_slave_0_address => dvb_dma_0_avalon_slave_0_address,
      dvb_dma_0_avalon_slave_0_byteenable => dvb_dma_0_avalon_slave_0_byteenable,
      dvb_dma_0_avalon_slave_0_readdata_from_sa => dvb_dma_0_avalon_slave_0_readdata_from_sa,
      dvb_dma_0_avalon_slave_0_reset => dvb_dma_0_avalon_slave_0_reset,
      dvb_dma_0_avalon_slave_0_write => dvb_dma_0_avalon_slave_0_write,
      dvb_dma_0_avalon_slave_0_writedata => dvb_dma_0_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_dma_0_avalon_slave_0_readdata => dvb_dma_0_avalon_slave_0_readdata,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_dvb_dma_0, which is an e_ptf_instance
  the_dvb_dma_0 : dvb_dma_0
    port map(
      interrupt => internal_interrupt_from_the_dvb_dma_0,
      mem_addr => internal_mem_addr_from_the_dvb_dma_0,
      mem_byteen => internal_mem_byteen_from_the_dvb_dma_0,
      mem_size => internal_mem_size_from_the_dvb_dma_0,
      mem_wrdata => internal_mem_wrdata_from_the_dvb_dma_0,
      mem_write => internal_mem_write_from_the_dvb_dma_0,
      readdata => dvb_dma_0_avalon_slave_0_readdata,
      address => dvb_dma_0_avalon_slave_0_address,
      byteenable => dvb_dma_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_data => dvb_data_to_the_dvb_dma_0,
      dvb_dval => dvb_dval_to_the_dvb_dma_0,
      dvb_sop => dvb_sop_to_the_dvb_dma_0,
      mem_waitreq => mem_waitreq_to_the_dvb_dma_0,
      rst => dvb_dma_0_avalon_slave_0_reset,
      write => dvb_dma_0_avalon_slave_0_write,
      writedata => dvb_dma_0_avalon_slave_0_writedata
    );


  --the_dvb_dma_1_avalon_slave_0, which is an e_instance
  the_dvb_dma_1_avalon_slave_0 : dvb_dma_1_avalon_slave_0_arbitrator
    port map(
      d1_dvb_dma_1_avalon_slave_0_end_xfer => d1_dvb_dma_1_avalon_slave_0_end_xfer,
      dvb_dma_1_avalon_slave_0_address => dvb_dma_1_avalon_slave_0_address,
      dvb_dma_1_avalon_slave_0_byteenable => dvb_dma_1_avalon_slave_0_byteenable,
      dvb_dma_1_avalon_slave_0_readdata_from_sa => dvb_dma_1_avalon_slave_0_readdata_from_sa,
      dvb_dma_1_avalon_slave_0_reset => dvb_dma_1_avalon_slave_0_reset,
      dvb_dma_1_avalon_slave_0_write => dvb_dma_1_avalon_slave_0_write,
      dvb_dma_1_avalon_slave_0_writedata => dvb_dma_1_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_dma_1_avalon_slave_0_readdata => dvb_dma_1_avalon_slave_0_readdata,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_dvb_dma_1, which is an e_ptf_instance
  the_dvb_dma_1 : dvb_dma_1
    port map(
      interrupt => internal_interrupt_from_the_dvb_dma_1,
      mem_addr => internal_mem_addr_from_the_dvb_dma_1,
      mem_byteen => internal_mem_byteen_from_the_dvb_dma_1,
      mem_size => internal_mem_size_from_the_dvb_dma_1,
      mem_wrdata => internal_mem_wrdata_from_the_dvb_dma_1,
      mem_write => internal_mem_write_from_the_dvb_dma_1,
      readdata => dvb_dma_1_avalon_slave_0_readdata,
      address => dvb_dma_1_avalon_slave_0_address,
      byteenable => dvb_dma_1_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_data => dvb_data_to_the_dvb_dma_1,
      dvb_dval => dvb_dval_to_the_dvb_dma_1,
      dvb_sop => dvb_sop_to_the_dvb_dma_1,
      mem_waitreq => mem_waitreq_to_the_dvb_dma_1,
      rst => dvb_dma_1_avalon_slave_0_reset,
      write => dvb_dma_1_avalon_slave_0_write,
      writedata => dvb_dma_1_avalon_slave_0_writedata
    );


  --the_dvb_ts_0_avalon_slave_0, which is an e_instance
  the_dvb_ts_0_avalon_slave_0 : dvb_ts_0_avalon_slave_0_arbitrator
    port map(
      d1_dvb_ts_0_avalon_slave_0_end_xfer => d1_dvb_ts_0_avalon_slave_0_end_xfer,
      dvb_ts_0_avalon_slave_0_address => dvb_ts_0_avalon_slave_0_address,
      dvb_ts_0_avalon_slave_0_byteenable => dvb_ts_0_avalon_slave_0_byteenable,
      dvb_ts_0_avalon_slave_0_read => dvb_ts_0_avalon_slave_0_read,
      dvb_ts_0_avalon_slave_0_readdata_from_sa => dvb_ts_0_avalon_slave_0_readdata_from_sa,
      dvb_ts_0_avalon_slave_0_reset => dvb_ts_0_avalon_slave_0_reset,
      dvb_ts_0_avalon_slave_0_waitrequest_from_sa => dvb_ts_0_avalon_slave_0_waitrequest_from_sa,
      dvb_ts_0_avalon_slave_0_write => dvb_ts_0_avalon_slave_0_write,
      dvb_ts_0_avalon_slave_0_writedata => dvb_ts_0_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_ts_0_avalon_slave_0_readdata => dvb_ts_0_avalon_slave_0_readdata,
      dvb_ts_0_avalon_slave_0_waitrequest => dvb_ts_0_avalon_slave_0_waitrequest,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_dvb_ts_0, which is an e_ptf_instance
  the_dvb_ts_0 : dvb_ts_0
    port map(
      cam_mclki => internal_cam_mclki_from_the_dvb_ts_0,
      cam_mdi => internal_cam_mdi_from_the_dvb_ts_0,
      cam_mistrt => internal_cam_mistrt_from_the_dvb_ts_0,
      cam_mival => internal_cam_mival_from_the_dvb_ts_0,
      dvb_out_data => internal_dvb_out_data_from_the_dvb_ts_0,
      dvb_out_dsop => internal_dvb_out_dsop_from_the_dvb_ts_0,
      dvb_out_dval => internal_dvb_out_dval_from_the_dvb_ts_0,
      interrupt => internal_interrupt_from_the_dvb_ts_0,
      readdata => dvb_ts_0_avalon_slave_0_readdata,
      waitrequest => dvb_ts_0_avalon_slave_0_waitrequest,
      address => dvb_ts_0_avalon_slave_0_address,
      byteenable => dvb_ts_0_avalon_slave_0_byteenable,
      cam_baseclk => cam_baseclk_to_the_dvb_ts_0,
      cam_bypass => cam_bypass_to_the_dvb_ts_0,
      cam_mclko => cam_mclko_to_the_dvb_ts_0,
      cam_mdo => cam_mdo_to_the_dvb_ts_0,
      cam_mostrt => cam_mostrt_to_the_dvb_ts_0,
      cam_moval => cam_moval_to_the_dvb_ts_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_in0_data => dvb_in0_data_to_the_dvb_ts_0,
      dvb_in0_dsop => dvb_in0_dsop_to_the_dvb_ts_0,
      dvb_in0_dval => dvb_in0_dval_to_the_dvb_ts_0,
      dvb_in1_data => dvb_in1_data_to_the_dvb_ts_0,
      dvb_in1_dsop => dvb_in1_dsop_to_the_dvb_ts_0,
      dvb_in1_dval => dvb_in1_dval_to_the_dvb_ts_0,
      dvb_in2_data => dvb_in2_data_to_the_dvb_ts_0,
      dvb_in2_dsop => dvb_in2_dsop_to_the_dvb_ts_0,
      dvb_in2_dval => dvb_in2_dval_to_the_dvb_ts_0,
      read => dvb_ts_0_avalon_slave_0_read,
      rst => dvb_ts_0_avalon_slave_0_reset,
      write => dvb_ts_0_avalon_slave_0_write,
      writedata => dvb_ts_0_avalon_slave_0_writedata
    );


  --the_dvb_ts_1_avalon_slave_0, which is an e_instance
  the_dvb_ts_1_avalon_slave_0 : dvb_ts_1_avalon_slave_0_arbitrator
    port map(
      d1_dvb_ts_1_avalon_slave_0_end_xfer => d1_dvb_ts_1_avalon_slave_0_end_xfer,
      dvb_ts_1_avalon_slave_0_address => dvb_ts_1_avalon_slave_0_address,
      dvb_ts_1_avalon_slave_0_byteenable => dvb_ts_1_avalon_slave_0_byteenable,
      dvb_ts_1_avalon_slave_0_read => dvb_ts_1_avalon_slave_0_read,
      dvb_ts_1_avalon_slave_0_readdata_from_sa => dvb_ts_1_avalon_slave_0_readdata_from_sa,
      dvb_ts_1_avalon_slave_0_reset => dvb_ts_1_avalon_slave_0_reset,
      dvb_ts_1_avalon_slave_0_waitrequest_from_sa => dvb_ts_1_avalon_slave_0_waitrequest_from_sa,
      dvb_ts_1_avalon_slave_0_write => dvb_ts_1_avalon_slave_0_write,
      dvb_ts_1_avalon_slave_0_writedata => dvb_ts_1_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_ts_1_avalon_slave_0_readdata => dvb_ts_1_avalon_slave_0_readdata,
      dvb_ts_1_avalon_slave_0_waitrequest => dvb_ts_1_avalon_slave_0_waitrequest,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_dvb_ts_1, which is an e_ptf_instance
  the_dvb_ts_1 : dvb_ts_1
    port map(
      cam_mclki => internal_cam_mclki_from_the_dvb_ts_1,
      cam_mdi => internal_cam_mdi_from_the_dvb_ts_1,
      cam_mistrt => internal_cam_mistrt_from_the_dvb_ts_1,
      cam_mival => internal_cam_mival_from_the_dvb_ts_1,
      dvb_out_data => internal_dvb_out_data_from_the_dvb_ts_1,
      dvb_out_dsop => internal_dvb_out_dsop_from_the_dvb_ts_1,
      dvb_out_dval => internal_dvb_out_dval_from_the_dvb_ts_1,
      interrupt => internal_interrupt_from_the_dvb_ts_1,
      readdata => dvb_ts_1_avalon_slave_0_readdata,
      waitrequest => dvb_ts_1_avalon_slave_0_waitrequest,
      address => dvb_ts_1_avalon_slave_0_address,
      byteenable => dvb_ts_1_avalon_slave_0_byteenable,
      cam_baseclk => cam_baseclk_to_the_dvb_ts_1,
      cam_bypass => cam_bypass_to_the_dvb_ts_1,
      cam_mclko => cam_mclko_to_the_dvb_ts_1,
      cam_mdo => cam_mdo_to_the_dvb_ts_1,
      cam_mostrt => cam_mostrt_to_the_dvb_ts_1,
      cam_moval => cam_moval_to_the_dvb_ts_1,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dvb_in0_data => dvb_in0_data_to_the_dvb_ts_1,
      dvb_in0_dsop => dvb_in0_dsop_to_the_dvb_ts_1,
      dvb_in0_dval => dvb_in0_dval_to_the_dvb_ts_1,
      dvb_in1_data => dvb_in1_data_to_the_dvb_ts_1,
      dvb_in1_dsop => dvb_in1_dsop_to_the_dvb_ts_1,
      dvb_in1_dval => dvb_in1_dval_to_the_dvb_ts_1,
      dvb_in2_data => dvb_in2_data_to_the_dvb_ts_1,
      dvb_in2_dsop => dvb_in2_dsop_to_the_dvb_ts_1,
      dvb_in2_dval => dvb_in2_dval_to_the_dvb_ts_1,
      read => dvb_ts_1_avalon_slave_0_read,
      rst => dvb_ts_1_avalon_slave_0_reset,
      write => dvb_ts_1_avalon_slave_0_write,
      writedata => dvb_ts_1_avalon_slave_0_writedata
    );


  --the_fifo_in_8b_sync_0_avalon_slave_0, which is an e_instance
  the_fifo_in_8b_sync_0_avalon_slave_0 : fifo_in_8b_sync_0_avalon_slave_0_arbitrator
    port map(
      d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer => d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer,
      fifo_in_8b_sync_0_avalon_slave_0_address => fifo_in_8b_sync_0_avalon_slave_0_address,
      fifo_in_8b_sync_0_avalon_slave_0_byteenable => fifo_in_8b_sync_0_avalon_slave_0_byteenable,
      fifo_in_8b_sync_0_avalon_slave_0_read => fifo_in_8b_sync_0_avalon_slave_0_read,
      fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa => fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa,
      fifo_in_8b_sync_0_avalon_slave_0_reset => fifo_in_8b_sync_0_avalon_slave_0_reset,
      fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa => fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa,
      fifo_in_8b_sync_0_avalon_slave_0_write => fifo_in_8b_sync_0_avalon_slave_0_write,
      fifo_in_8b_sync_0_avalon_slave_0_writedata => fifo_in_8b_sync_0_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_in_8b_sync_0_avalon_slave_0_readdata => fifo_in_8b_sync_0_avalon_slave_0_readdata,
      fifo_in_8b_sync_0_avalon_slave_0_waitrequest => fifo_in_8b_sync_0_avalon_slave_0_waitrequest,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_fifo_in_8b_sync_0_avalon_streaming_sink, which is an e_instance
  the_fifo_in_8b_sync_0_avalon_streaming_sink : fifo_in_8b_sync_0_avalon_streaming_sink_arbitrator
    port map(
      fifo_in_8b_sync_0_avalon_streaming_sink_data => fifo_in_8b_sync_0_avalon_streaming_sink_data,
      fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa => fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa,
      fifo_in_8b_sync_0_avalon_streaming_sink_valid => fifo_in_8b_sync_0_avalon_streaming_sink_valid,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_in_8b_sync_0_avalon_streaming_sink_ready => fifo_in_8b_sync_0_avalon_streaming_sink_ready,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_0_avalon_streaming_source_data => twi_master_0_avalon_streaming_source_data,
      twi_master_0_avalon_streaming_source_valid => twi_master_0_avalon_streaming_source_valid
    );


  --the_fifo_in_8b_sync_0, which is an e_ptf_instance
  the_fifo_in_8b_sync_0 : fifo_in_8b_sync_0
    port map(
      irq => internal_irq_from_the_fifo_in_8b_sync_0,
      out_data => fifo_in_8b_sync_0_avalon_slave_0_readdata,
      st_ready => fifo_in_8b_sync_0_avalon_streaming_sink_ready,
      wait_req => fifo_in_8b_sync_0_avalon_slave_0_waitrequest,
      addr => fifo_in_8b_sync_0_avalon_slave_0_address,
      byte_en => fifo_in_8b_sync_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => fifo_in_8b_sync_0_avalon_slave_0_writedata,
      rd_en => fifo_in_8b_sync_0_avalon_slave_0_read,
      rst => fifo_in_8b_sync_0_avalon_slave_0_reset,
      st_data => fifo_in_8b_sync_0_avalon_streaming_sink_data,
      st_valid => fifo_in_8b_sync_0_avalon_streaming_sink_valid,
      wr_en => fifo_in_8b_sync_0_avalon_slave_0_write
    );


  --the_fifo_in_8b_sync_1_avalon_slave_0, which is an e_instance
  the_fifo_in_8b_sync_1_avalon_slave_0 : fifo_in_8b_sync_1_avalon_slave_0_arbitrator
    port map(
      d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer => d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer,
      fifo_in_8b_sync_1_avalon_slave_0_address => fifo_in_8b_sync_1_avalon_slave_0_address,
      fifo_in_8b_sync_1_avalon_slave_0_byteenable => fifo_in_8b_sync_1_avalon_slave_0_byteenable,
      fifo_in_8b_sync_1_avalon_slave_0_read => fifo_in_8b_sync_1_avalon_slave_0_read,
      fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa => fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa,
      fifo_in_8b_sync_1_avalon_slave_0_reset => fifo_in_8b_sync_1_avalon_slave_0_reset,
      fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa => fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa,
      fifo_in_8b_sync_1_avalon_slave_0_write => fifo_in_8b_sync_1_avalon_slave_0_write,
      fifo_in_8b_sync_1_avalon_slave_0_writedata => fifo_in_8b_sync_1_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_in_8b_sync_1_avalon_slave_0_readdata => fifo_in_8b_sync_1_avalon_slave_0_readdata,
      fifo_in_8b_sync_1_avalon_slave_0_waitrequest => fifo_in_8b_sync_1_avalon_slave_0_waitrequest,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_fifo_in_8b_sync_1_avalon_streaming_sink, which is an e_instance
  the_fifo_in_8b_sync_1_avalon_streaming_sink : fifo_in_8b_sync_1_avalon_streaming_sink_arbitrator
    port map(
      fifo_in_8b_sync_1_avalon_streaming_sink_data => fifo_in_8b_sync_1_avalon_streaming_sink_data,
      fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa => fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa,
      fifo_in_8b_sync_1_avalon_streaming_sink_valid => fifo_in_8b_sync_1_avalon_streaming_sink_valid,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_in_8b_sync_1_avalon_streaming_sink_ready => fifo_in_8b_sync_1_avalon_streaming_sink_ready,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_1_avalon_streaming_source_data => twi_master_1_avalon_streaming_source_data,
      twi_master_1_avalon_streaming_source_valid => twi_master_1_avalon_streaming_source_valid
    );


  --the_fifo_in_8b_sync_1, which is an e_ptf_instance
  the_fifo_in_8b_sync_1 : fifo_in_8b_sync_1
    port map(
      irq => internal_irq_from_the_fifo_in_8b_sync_1,
      out_data => fifo_in_8b_sync_1_avalon_slave_0_readdata,
      st_ready => fifo_in_8b_sync_1_avalon_streaming_sink_ready,
      wait_req => fifo_in_8b_sync_1_avalon_slave_0_waitrequest,
      addr => fifo_in_8b_sync_1_avalon_slave_0_address,
      byte_en => fifo_in_8b_sync_1_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => fifo_in_8b_sync_1_avalon_slave_0_writedata,
      rd_en => fifo_in_8b_sync_1_avalon_slave_0_read,
      rst => fifo_in_8b_sync_1_avalon_slave_0_reset,
      st_data => fifo_in_8b_sync_1_avalon_streaming_sink_data,
      st_valid => fifo_in_8b_sync_1_avalon_streaming_sink_valid,
      wr_en => fifo_in_8b_sync_1_avalon_slave_0_write
    );


  --the_fifo_out_8b_sync_0_avalon_slave_0, which is an e_instance
  the_fifo_out_8b_sync_0_avalon_slave_0 : fifo_out_8b_sync_0_avalon_slave_0_arbitrator
    port map(
      d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer => d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer,
      fifo_out_8b_sync_0_avalon_slave_0_address => fifo_out_8b_sync_0_avalon_slave_0_address,
      fifo_out_8b_sync_0_avalon_slave_0_byteenable => fifo_out_8b_sync_0_avalon_slave_0_byteenable,
      fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa => fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa,
      fifo_out_8b_sync_0_avalon_slave_0_reset => fifo_out_8b_sync_0_avalon_slave_0_reset,
      fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa => fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa,
      fifo_out_8b_sync_0_avalon_slave_0_write => fifo_out_8b_sync_0_avalon_slave_0_write,
      fifo_out_8b_sync_0_avalon_slave_0_writedata => fifo_out_8b_sync_0_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_out_8b_sync_0_avalon_slave_0_readdata => fifo_out_8b_sync_0_avalon_slave_0_readdata,
      fifo_out_8b_sync_0_avalon_slave_0_waitrequest => fifo_out_8b_sync_0_avalon_slave_0_waitrequest,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_fifo_out_8b_sync_0_avalon_streaming_source, which is an e_instance
  the_fifo_out_8b_sync_0_avalon_streaming_source : fifo_out_8b_sync_0_avalon_streaming_source_arbitrator
    port map(
      fifo_out_8b_sync_0_avalon_streaming_source_ready => fifo_out_8b_sync_0_avalon_streaming_source_ready,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_out_8b_sync_0_avalon_streaming_source_data => fifo_out_8b_sync_0_avalon_streaming_source_data,
      fifo_out_8b_sync_0_avalon_streaming_source_valid => fifo_out_8b_sync_0_avalon_streaming_source_valid,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_0_avalon_streaming_sink_ready_from_sa => twi_master_0_avalon_streaming_sink_ready_from_sa
    );


  --the_fifo_out_8b_sync_0, which is an e_ptf_instance
  the_fifo_out_8b_sync_0 : fifo_out_8b_sync_0
    port map(
      irq => internal_irq_from_the_fifo_out_8b_sync_0,
      out_data => fifo_out_8b_sync_0_avalon_slave_0_readdata,
      st_data => fifo_out_8b_sync_0_avalon_streaming_source_data,
      st_valid => fifo_out_8b_sync_0_avalon_streaming_source_valid,
      wait_req => fifo_out_8b_sync_0_avalon_slave_0_waitrequest,
      addr => fifo_out_8b_sync_0_avalon_slave_0_address,
      byte_en => fifo_out_8b_sync_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => fifo_out_8b_sync_0_avalon_slave_0_writedata,
      rst => fifo_out_8b_sync_0_avalon_slave_0_reset,
      st_ready => fifo_out_8b_sync_0_avalon_streaming_source_ready,
      wr_en => fifo_out_8b_sync_0_avalon_slave_0_write
    );


  --the_fifo_out_8b_sync_1_avalon_slave_0, which is an e_instance
  the_fifo_out_8b_sync_1_avalon_slave_0 : fifo_out_8b_sync_1_avalon_slave_0_arbitrator
    port map(
      d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer => d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer,
      fifo_out_8b_sync_1_avalon_slave_0_address => fifo_out_8b_sync_1_avalon_slave_0_address,
      fifo_out_8b_sync_1_avalon_slave_0_byteenable => fifo_out_8b_sync_1_avalon_slave_0_byteenable,
      fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa => fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa,
      fifo_out_8b_sync_1_avalon_slave_0_reset => fifo_out_8b_sync_1_avalon_slave_0_reset,
      fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa => fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa,
      fifo_out_8b_sync_1_avalon_slave_0_write => fifo_out_8b_sync_1_avalon_slave_0_write,
      fifo_out_8b_sync_1_avalon_slave_0_writedata => fifo_out_8b_sync_1_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_out_8b_sync_1_avalon_slave_0_readdata => fifo_out_8b_sync_1_avalon_slave_0_readdata,
      fifo_out_8b_sync_1_avalon_slave_0_waitrequest => fifo_out_8b_sync_1_avalon_slave_0_waitrequest,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_fifo_out_8b_sync_1_avalon_streaming_source, which is an e_instance
  the_fifo_out_8b_sync_1_avalon_streaming_source : fifo_out_8b_sync_1_avalon_streaming_source_arbitrator
    port map(
      fifo_out_8b_sync_1_avalon_streaming_source_ready => fifo_out_8b_sync_1_avalon_streaming_source_ready,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_out_8b_sync_1_avalon_streaming_source_data => fifo_out_8b_sync_1_avalon_streaming_source_data,
      fifo_out_8b_sync_1_avalon_streaming_source_valid => fifo_out_8b_sync_1_avalon_streaming_source_valid,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_1_avalon_streaming_sink_ready_from_sa => twi_master_1_avalon_streaming_sink_ready_from_sa
    );


  --the_fifo_out_8b_sync_1, which is an e_ptf_instance
  the_fifo_out_8b_sync_1 : fifo_out_8b_sync_1
    port map(
      irq => internal_irq_from_the_fifo_out_8b_sync_1,
      out_data => fifo_out_8b_sync_1_avalon_slave_0_readdata,
      st_data => fifo_out_8b_sync_1_avalon_streaming_source_data,
      st_valid => fifo_out_8b_sync_1_avalon_streaming_source_valid,
      wait_req => fifo_out_8b_sync_1_avalon_slave_0_waitrequest,
      addr => fifo_out_8b_sync_1_avalon_slave_0_address,
      byte_en => fifo_out_8b_sync_1_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => fifo_out_8b_sync_1_avalon_slave_0_writedata,
      rst => fifo_out_8b_sync_1_avalon_slave_0_reset,
      st_ready => fifo_out_8b_sync_1_avalon_streaming_source_ready,
      wr_en => fifo_out_8b_sync_1_avalon_slave_0_write
    );


  --the_gpout_0_avalon_slave_0, which is an e_instance
  the_gpout_0_avalon_slave_0 : gpout_0_avalon_slave_0_arbitrator
    port map(
      d1_gpout_0_avalon_slave_0_end_xfer => d1_gpout_0_avalon_slave_0_end_xfer,
      gpout_0_avalon_slave_0_address => gpout_0_avalon_slave_0_address,
      gpout_0_avalon_slave_0_byteenable => gpout_0_avalon_slave_0_byteenable,
      gpout_0_avalon_slave_0_readdata_from_sa => gpout_0_avalon_slave_0_readdata_from_sa,
      gpout_0_avalon_slave_0_reset => gpout_0_avalon_slave_0_reset,
      gpout_0_avalon_slave_0_write => gpout_0_avalon_slave_0_write,
      gpout_0_avalon_slave_0_writedata => gpout_0_avalon_slave_0_writedata,
      int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      gpout_0_avalon_slave_0_readdata => gpout_0_avalon_slave_0_readdata,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_gpout_0, which is an e_ptf_instance
  the_gpout_0 : gpout_0
    port map(
      pins => internal_pins_from_the_gpout_0,
      readdata => gpout_0_avalon_slave_0_readdata,
      address => gpout_0_avalon_slave_0_address,
      byteenable => gpout_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      rst => gpout_0_avalon_slave_0_reset,
      write => gpout_0_avalon_slave_0_write,
      writedata => gpout_0_avalon_slave_0_writedata
    );


  --the_int_ctrl_0_avalon_cra, which is an e_instance
  the_int_ctrl_0_avalon_cra : int_ctrl_0_avalon_cra_arbitrator
    port map(
      d1_int_ctrl_0_avalon_cra_end_xfer => d1_int_ctrl_0_avalon_cra_end_xfer,
      int_ctrl_0_avalon_cra_address => int_ctrl_0_avalon_cra_address,
      int_ctrl_0_avalon_cra_byteenable => int_ctrl_0_avalon_cra_byteenable,
      int_ctrl_0_avalon_cra_readdata_from_sa => int_ctrl_0_avalon_cra_readdata_from_sa,
      int_ctrl_0_avalon_cra_write => int_ctrl_0_avalon_cra_write,
      int_ctrl_0_avalon_cra_writedata => int_ctrl_0_avalon_cra_writedata,
      int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_cra_readdata => int_ctrl_0_avalon_cra_readdata,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_int_ctrl_0_avalon_slave, which is an e_instance
  the_int_ctrl_0_avalon_slave : int_ctrl_0_avalon_slave_arbitrator
    port map(
      d1_int_ctrl_0_avalon_slave_end_xfer => d1_int_ctrl_0_avalon_slave_end_xfer,
      int_ctrl_0_avalon_slave_address => int_ctrl_0_avalon_slave_address,
      int_ctrl_0_avalon_slave_byteenable => int_ctrl_0_avalon_slave_byteenable,
      int_ctrl_0_avalon_slave_read => int_ctrl_0_avalon_slave_read,
      int_ctrl_0_avalon_slave_readdata_from_sa => int_ctrl_0_avalon_slave_readdata_from_sa,
      int_ctrl_0_avalon_slave_reset => int_ctrl_0_avalon_slave_reset,
      int_ctrl_0_avalon_slave_waitrequest_from_sa => int_ctrl_0_avalon_slave_waitrequest_from_sa,
      int_ctrl_0_avalon_slave_write => int_ctrl_0_avalon_slave_write,
      int_ctrl_0_avalon_slave_writedata => int_ctrl_0_avalon_slave_writedata,
      pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_slave_readdata => int_ctrl_0_avalon_slave_readdata,
      int_ctrl_0_avalon_slave_waitrequest => int_ctrl_0_avalon_slave_waitrequest,
      pipeline_bridge_0_m1_address_to_slave => pipeline_bridge_0_m1_address_to_slave,
      pipeline_bridge_0_m1_burstcount => pipeline_bridge_0_m1_burstcount,
      pipeline_bridge_0_m1_byteenable => pipeline_bridge_0_m1_byteenable,
      pipeline_bridge_0_m1_chipselect => pipeline_bridge_0_m1_chipselect,
      pipeline_bridge_0_m1_dbs_address => pipeline_bridge_0_m1_dbs_address,
      pipeline_bridge_0_m1_dbs_write_32 => pipeline_bridge_0_m1_dbs_write_32,
      pipeline_bridge_0_m1_latency_counter => pipeline_bridge_0_m1_latency_counter,
      pipeline_bridge_0_m1_read => pipeline_bridge_0_m1_read,
      pipeline_bridge_0_m1_write => pipeline_bridge_0_m1_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_int_ctrl_0_avalon_master, which is an e_instance
  the_int_ctrl_0_avalon_master : int_ctrl_0_avalon_master_arbitrator
    port map(
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_readdata => int_ctrl_0_avalon_master_readdata,
      int_ctrl_0_avalon_master_waitrequest => int_ctrl_0_avalon_master_waitrequest,
      ci_bridge_0_avalon_slave_0_readdata_from_sa => ci_bridge_0_avalon_slave_0_readdata_from_sa,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      d1_ci_bridge_0_avalon_slave_0_end_xfer => d1_ci_bridge_0_avalon_slave_0_end_xfer,
      d1_dvb_dma_0_avalon_slave_0_end_xfer => d1_dvb_dma_0_avalon_slave_0_end_xfer,
      d1_dvb_dma_1_avalon_slave_0_end_xfer => d1_dvb_dma_1_avalon_slave_0_end_xfer,
      d1_dvb_ts_0_avalon_slave_0_end_xfer => d1_dvb_ts_0_avalon_slave_0_end_xfer,
      d1_dvb_ts_1_avalon_slave_0_end_xfer => d1_dvb_ts_1_avalon_slave_0_end_xfer,
      d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer => d1_fifo_in_8b_sync_0_avalon_slave_0_end_xfer,
      d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer => d1_fifo_in_8b_sync_1_avalon_slave_0_end_xfer,
      d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer => d1_fifo_out_8b_sync_0_avalon_slave_0_end_xfer,
      d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer => d1_fifo_out_8b_sync_1_avalon_slave_0_end_xfer,
      d1_gpout_0_avalon_slave_0_end_xfer => d1_gpout_0_avalon_slave_0_end_xfer,
      d1_int_ctrl_0_avalon_cra_end_xfer => d1_int_ctrl_0_avalon_cra_end_xfer,
      d1_pcie_compiler_0_Control_Register_Access_end_xfer => d1_pcie_compiler_0_Control_Register_Access_end_xfer,
      d1_spi_master_0_avalon_slave_0_end_xfer => d1_spi_master_0_avalon_slave_0_end_xfer,
      d1_twi_master_0_avalon_slave_0_end_xfer => d1_twi_master_0_avalon_slave_0_end_xfer,
      d1_twi_master_1_avalon_slave_0_end_xfer => d1_twi_master_1_avalon_slave_0_end_xfer,
      dvb_dma_0_avalon_slave_0_readdata_from_sa => dvb_dma_0_avalon_slave_0_readdata_from_sa,
      dvb_dma_1_avalon_slave_0_readdata_from_sa => dvb_dma_1_avalon_slave_0_readdata_from_sa,
      dvb_ts_0_avalon_slave_0_readdata_from_sa => dvb_ts_0_avalon_slave_0_readdata_from_sa,
      dvb_ts_0_avalon_slave_0_waitrequest_from_sa => dvb_ts_0_avalon_slave_0_waitrequest_from_sa,
      dvb_ts_1_avalon_slave_0_readdata_from_sa => dvb_ts_1_avalon_slave_0_readdata_from_sa,
      dvb_ts_1_avalon_slave_0_waitrequest_from_sa => dvb_ts_1_avalon_slave_0_waitrequest_from_sa,
      fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa => fifo_in_8b_sync_0_avalon_slave_0_readdata_from_sa,
      fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa => fifo_in_8b_sync_0_avalon_slave_0_waitrequest_from_sa,
      fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa => fifo_in_8b_sync_1_avalon_slave_0_readdata_from_sa,
      fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa => fifo_in_8b_sync_1_avalon_slave_0_waitrequest_from_sa,
      fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa => fifo_out_8b_sync_0_avalon_slave_0_readdata_from_sa,
      fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa => fifo_out_8b_sync_0_avalon_slave_0_waitrequest_from_sa,
      fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa => fifo_out_8b_sync_1_avalon_slave_0_readdata_from_sa,
      fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa => fifo_out_8b_sync_1_avalon_slave_0_waitrequest_from_sa,
      gpout_0_avalon_slave_0_readdata_from_sa => gpout_0_avalon_slave_0_readdata_from_sa,
      int_ctrl_0_avalon_cra_readdata_from_sa => int_ctrl_0_avalon_cra_readdata_from_sa,
      int_ctrl_0_avalon_master_address => int_ctrl_0_avalon_master_address,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_byteenable_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_granted_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_qualified_request_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_read_data_valid_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_ci_bridge_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_dma_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_dma_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_ts_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_dvb_ts_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_in_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_fifo_out_8b_sync_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_gpout_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra => int_ctrl_0_avalon_master_requests_int_ctrl_0_avalon_cra,
      int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      pcie_compiler_0_Control_Register_Access_readdata_from_sa => pcie_compiler_0_Control_Register_Access_readdata_from_sa,
      pcie_compiler_0_Control_Register_Access_waitrequest_from_sa => pcie_compiler_0_Control_Register_Access_waitrequest_from_sa,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      spi_master_0_avalon_slave_0_readdata_from_sa => spi_master_0_avalon_slave_0_readdata_from_sa,
      spi_master_0_avalon_slave_0_waitrequest_from_sa => spi_master_0_avalon_slave_0_waitrequest_from_sa,
      twi_master_0_avalon_slave_0_readdata_from_sa => twi_master_0_avalon_slave_0_readdata_from_sa,
      twi_master_1_avalon_slave_0_readdata_from_sa => twi_master_1_avalon_slave_0_readdata_from_sa
    );


  --the_int_ctrl_0, which is an e_ptf_instance
  the_int_ctrl_0 : int_ctrl_0
    port map(
      avlm_address => int_ctrl_0_avalon_master_address,
      avlm_byteenable => int_ctrl_0_avalon_master_byteenable,
      avlm_read => int_ctrl_0_avalon_master_read,
      avlm_write => int_ctrl_0_avalon_master_write,
      avlm_writedata => int_ctrl_0_avalon_master_writedata,
      avls_irq => int_ctrl_0_avalon_slave_irq,
      avls_readdata => int_ctrl_0_avalon_slave_readdata,
      avls_waitrequest => int_ctrl_0_avalon_slave_waitrequest,
      readdata => int_ctrl_0_avalon_cra_readdata,
      address => int_ctrl_0_avalon_cra_address,
      avlm_irq => avlm_irq_to_the_int_ctrl_0,
      avlm_readdata => int_ctrl_0_avalon_master_readdata,
      avlm_waitrequest => int_ctrl_0_avalon_master_waitrequest,
      avls_address => int_ctrl_0_avalon_slave_address,
      avls_byteenable => int_ctrl_0_avalon_slave_byteenable,
      avls_read => int_ctrl_0_avalon_slave_read,
      avls_write => int_ctrl_0_avalon_slave_write,
      avls_writedata => int_ctrl_0_avalon_slave_writedata,
      byteenable => int_ctrl_0_avalon_cra_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      rst => int_ctrl_0_avalon_slave_reset,
      write => int_ctrl_0_avalon_cra_write,
      writedata => int_ctrl_0_avalon_cra_writedata
    );


  --the_pcie_compiler_0_Control_Register_Access, which is an e_instance
  the_pcie_compiler_0_Control_Register_Access : pcie_compiler_0_Control_Register_Access_arbitrator
    port map(
      d1_pcie_compiler_0_Control_Register_Access_end_xfer => d1_pcie_compiler_0_Control_Register_Access_end_xfer,
      int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_granted_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_qualified_request_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_read_data_valid_pcie_compiler_0_Control_Register_Access,
      int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access => int_ctrl_0_avalon_master_requests_pcie_compiler_0_Control_Register_Access,
      pcie_compiler_0_Control_Register_Access_address => pcie_compiler_0_Control_Register_Access_address,
      pcie_compiler_0_Control_Register_Access_byteenable => pcie_compiler_0_Control_Register_Access_byteenable,
      pcie_compiler_0_Control_Register_Access_chipselect => pcie_compiler_0_Control_Register_Access_chipselect,
      pcie_compiler_0_Control_Register_Access_read => pcie_compiler_0_Control_Register_Access_read,
      pcie_compiler_0_Control_Register_Access_readdata_from_sa => pcie_compiler_0_Control_Register_Access_readdata_from_sa,
      pcie_compiler_0_Control_Register_Access_waitrequest_from_sa => pcie_compiler_0_Control_Register_Access_waitrequest_from_sa,
      pcie_compiler_0_Control_Register_Access_write => pcie_compiler_0_Control_Register_Access_write,
      pcie_compiler_0_Control_Register_Access_writedata => pcie_compiler_0_Control_Register_Access_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      int_ctrl_0_avalon_master_writedata => int_ctrl_0_avalon_master_writedata,
      pcie_compiler_0_Control_Register_Access_readdata => pcie_compiler_0_Control_Register_Access_readdata,
      pcie_compiler_0_Control_Register_Access_waitrequest => pcie_compiler_0_Control_Register_Access_waitrequest,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_pcie_compiler_0_Tx_Interface, which is an e_instance
  the_pcie_compiler_0_Tx_Interface : pcie_compiler_0_Tx_Interface_arbitrator
    port map(
      d1_pcie_compiler_0_Tx_Interface_end_xfer => d1_pcie_compiler_0_Tx_Interface_end_xfer,
      dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface => dma_arbiter_0_granted_pcie_compiler_0_Tx_Interface,
      dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface => dma_arbiter_0_qualified_request_pcie_compiler_0_Tx_Interface,
      dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface => dma_arbiter_0_requests_pcie_compiler_0_Tx_Interface,
      pcie_compiler_0_Tx_Interface_address => pcie_compiler_0_Tx_Interface_address,
      pcie_compiler_0_Tx_Interface_burstcount => pcie_compiler_0_Tx_Interface_burstcount,
      pcie_compiler_0_Tx_Interface_byteenable => pcie_compiler_0_Tx_Interface_byteenable,
      pcie_compiler_0_Tx_Interface_chipselect => pcie_compiler_0_Tx_Interface_chipselect,
      pcie_compiler_0_Tx_Interface_read => pcie_compiler_0_Tx_Interface_read,
      pcie_compiler_0_Tx_Interface_readdata_from_sa => pcie_compiler_0_Tx_Interface_readdata_from_sa,
      pcie_compiler_0_Tx_Interface_readdatavalid_from_sa => pcie_compiler_0_Tx_Interface_readdatavalid_from_sa,
      pcie_compiler_0_Tx_Interface_waitrequest_from_sa => pcie_compiler_0_Tx_Interface_waitrequest_from_sa,
      pcie_compiler_0_Tx_Interface_write => pcie_compiler_0_Tx_Interface_write,
      pcie_compiler_0_Tx_Interface_writedata => pcie_compiler_0_Tx_Interface_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      dma_arbiter_0_avalon_master_address_to_slave => dma_arbiter_0_avalon_master_address_to_slave,
      dma_arbiter_0_avalon_master_burstcount => dma_arbiter_0_avalon_master_burstcount,
      dma_arbiter_0_avalon_master_byteenable => dma_arbiter_0_avalon_master_byteenable,
      dma_arbiter_0_avalon_master_write => dma_arbiter_0_avalon_master_write,
      dma_arbiter_0_avalon_master_writedata => dma_arbiter_0_avalon_master_writedata,
      pcie_compiler_0_Tx_Interface_readdata => pcie_compiler_0_Tx_Interface_readdata,
      pcie_compiler_0_Tx_Interface_readdatavalid => pcie_compiler_0_Tx_Interface_readdatavalid,
      pcie_compiler_0_Tx_Interface_waitrequest => pcie_compiler_0_Tx_Interface_waitrequest,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_pcie_compiler_0_Rx_Interface, which is an e_instance
  the_pcie_compiler_0_Rx_Interface : pcie_compiler_0_Rx_Interface_arbitrator
    port map(
      pcie_compiler_0_Rx_Interface_address_to_slave => pcie_compiler_0_Rx_Interface_address_to_slave,
      pcie_compiler_0_Rx_Interface_latency_counter => pcie_compiler_0_Rx_Interface_latency_counter,
      pcie_compiler_0_Rx_Interface_readdata => pcie_compiler_0_Rx_Interface_readdata,
      pcie_compiler_0_Rx_Interface_readdatavalid => pcie_compiler_0_Rx_Interface_readdatavalid,
      pcie_compiler_0_Rx_Interface_reset_n => pcie_compiler_0_Rx_Interface_reset_n,
      pcie_compiler_0_Rx_Interface_waitrequest => pcie_compiler_0_Rx_Interface_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      d1_unici_core_burst_0_upstream_end_xfer => d1_unici_core_burst_0_upstream_end_xfer,
      d1_unici_core_burst_1_upstream_end_xfer => d1_unici_core_burst_1_upstream_end_xfer,
      pcie_compiler_0_Rx_Interface_address => pcie_compiler_0_Rx_Interface_address,
      pcie_compiler_0_Rx_Interface_burstcount => pcie_compiler_0_Rx_Interface_burstcount,
      pcie_compiler_0_Rx_Interface_byteenable => pcie_compiler_0_Rx_Interface_byteenable,
      pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_read => pcie_compiler_0_Rx_Interface_read,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register,
      pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_write => pcie_compiler_0_Rx_Interface_write,
      pcie_compiler_0_Rx_Interface_writedata => pcie_compiler_0_Rx_Interface_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_0_upstream_readdata_from_sa => unici_core_burst_0_upstream_readdata_from_sa,
      unici_core_burst_0_upstream_waitrequest_from_sa => unici_core_burst_0_upstream_waitrequest_from_sa,
      unici_core_burst_1_upstream_readdata_from_sa => unici_core_burst_1_upstream_readdata_from_sa,
      unici_core_burst_1_upstream_waitrequest_from_sa => unici_core_burst_1_upstream_waitrequest_from_sa
    );


  --pcie_compiler_0_pcie_core_clk_out out_clk assignment, which is an e_assign
  internal_pcie_compiler_0_pcie_core_clk_out <= out_clk_pcie_compiler_0_pcie_core_clk;
  --the_pcie_compiler_0, which is an e_ptf_instance
  the_pcie_compiler_0 : pcie_compiler_0
    port map(
      CraIrq_o => pcie_compiler_0_Control_Register_Access_irq,
      CraReadData_o => pcie_compiler_0_Control_Register_Access_readdata,
      CraWaitRequest_o => pcie_compiler_0_Control_Register_Access_waitrequest,
      RxmAddress_o => pcie_compiler_0_Rx_Interface_address,
      RxmBurstCount_o => pcie_compiler_0_Rx_Interface_burstcount,
      RxmByteEnable_o => pcie_compiler_0_Rx_Interface_byteenable,
      RxmRead_o => pcie_compiler_0_Rx_Interface_read,
      RxmResetRequest_o => pcie_compiler_0_Rx_Interface_resetrequest,
      RxmWriteData_o => pcie_compiler_0_Rx_Interface_writedata,
      RxmWrite_o => pcie_compiler_0_Rx_Interface_write,
      TxsReadDataValid_o => pcie_compiler_0_Tx_Interface_readdatavalid,
      TxsReadData_o => pcie_compiler_0_Tx_Interface_readdata,
      TxsWaitRequest_o => pcie_compiler_0_Tx_Interface_waitrequest,
      clk125_out => internal_clk125_out_pcie_compiler_0,
      clk250_out => internal_clk250_out_pcie_compiler_0,
      clk500_out => internal_clk500_out_pcie_compiler_0,
      pcie_core_clk => out_clk_pcie_compiler_0_pcie_core_clk,
      powerdown_ext => internal_powerdown_ext_pcie_compiler_0,
      rate_ext => internal_rate_ext_pcie_compiler_0,
      reconfig_fromgxb => internal_reconfig_fromgxb_pcie_compiler_0,
      rxpolarity0_ext => internal_rxpolarity0_ext_pcie_compiler_0,
      tx_out0 => internal_tx_out0_pcie_compiler_0,
      txcompl0_ext => internal_txcompl0_ext_pcie_compiler_0,
      txdata0_ext => internal_txdata0_ext_pcie_compiler_0,
      txdatak0_ext => internal_txdatak0_ext_pcie_compiler_0,
      txdetectrx_ext => internal_txdetectrx_ext_pcie_compiler_0,
      txelecidle0_ext => internal_txelecidle0_ext_pcie_compiler_0,
      AvlClk_i => internal_pcie_compiler_0_pcie_core_clk_out,
      CraAddress_i => pcie_compiler_0_Control_Register_Access_address,
      CraByteEnable_i => pcie_compiler_0_Control_Register_Access_byteenable,
      CraChipSelect_i => pcie_compiler_0_Control_Register_Access_chipselect,
      CraRead => pcie_compiler_0_Control_Register_Access_read,
      CraWrite => pcie_compiler_0_Control_Register_Access_write,
      CraWriteData_i => pcie_compiler_0_Control_Register_Access_writedata,
      RxmIrqNum_i => pcie_compiler_0_Rx_Interface_irqnumber,
      RxmIrq_i => pcie_compiler_0_Rx_Interface_irq,
      RxmReadDataValid_i => pcie_compiler_0_Rx_Interface_readdatavalid,
      RxmReadData_i => pcie_compiler_0_Rx_Interface_readdata,
      RxmWaitRequest_i => pcie_compiler_0_Rx_Interface_waitrequest,
      TxsAddress_i => pcie_compiler_0_Tx_Interface_address,
      TxsBurstCount_i => pcie_compiler_0_Tx_Interface_burstcount,
      TxsByteEnable_i => pcie_compiler_0_Tx_Interface_byteenable,
      TxsChipSelect_i => pcie_compiler_0_Tx_Interface_chipselect,
      TxsRead_i => pcie_compiler_0_Tx_Interface_read,
      TxsWriteData_i => pcie_compiler_0_Tx_Interface_writedata,
      TxsWrite_i => pcie_compiler_0_Tx_Interface_write,
      busy_altgxb_reconfig => busy_altgxb_reconfig_pcie_compiler_0,
      cal_blk_clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fixedclk_serdes => fixedclk_serdes_pcie_compiler_0,
      gxb_powerdown => gxb_powerdown_pcie_compiler_0,
      pcie_rstn => pcie_rstn_pcie_compiler_0,
      phystatus_ext => phystatus_ext_pcie_compiler_0,
      pipe_mode => pipe_mode_pcie_compiler_0,
      pll_powerdown => pll_powerdown_pcie_compiler_0,
      reconfig_clk => reconfig_clk_pcie_compiler_0,
      reconfig_togxb => reconfig_togxb_pcie_compiler_0,
      refclk => refclk_pcie_compiler_0,
      reset_n => pcie_compiler_0_Rx_Interface_reset_n,
      rx_in0 => rx_in0_pcie_compiler_0,
      rxdata0_ext => rxdata0_ext_pcie_compiler_0,
      rxdatak0_ext => rxdatak0_ext_pcie_compiler_0,
      rxelecidle0_ext => rxelecidle0_ext_pcie_compiler_0,
      rxstatus0_ext => rxstatus0_ext_pcie_compiler_0,
      rxvalid0_ext => rxvalid0_ext_pcie_compiler_0,
      test_in => test_in_pcie_compiler_0
    );


  --the_pipeline_bridge_0_s1, which is an e_instance
  the_pipeline_bridge_0_s1 : pipeline_bridge_0_s1_arbitrator
    port map(
      d1_pipeline_bridge_0_s1_end_xfer => d1_pipeline_bridge_0_s1_end_xfer,
      pipeline_bridge_0_s1_address => pipeline_bridge_0_s1_address,
      pipeline_bridge_0_s1_arbiterlock => pipeline_bridge_0_s1_arbiterlock,
      pipeline_bridge_0_s1_arbiterlock2 => pipeline_bridge_0_s1_arbiterlock2,
      pipeline_bridge_0_s1_burstcount => pipeline_bridge_0_s1_burstcount,
      pipeline_bridge_0_s1_byteenable => pipeline_bridge_0_s1_byteenable,
      pipeline_bridge_0_s1_chipselect => pipeline_bridge_0_s1_chipselect,
      pipeline_bridge_0_s1_debugaccess => pipeline_bridge_0_s1_debugaccess,
      pipeline_bridge_0_s1_endofpacket_from_sa => pipeline_bridge_0_s1_endofpacket_from_sa,
      pipeline_bridge_0_s1_nativeaddress => pipeline_bridge_0_s1_nativeaddress,
      pipeline_bridge_0_s1_read => pipeline_bridge_0_s1_read,
      pipeline_bridge_0_s1_readdata_from_sa => pipeline_bridge_0_s1_readdata_from_sa,
      pipeline_bridge_0_s1_reset_n => pipeline_bridge_0_s1_reset_n,
      pipeline_bridge_0_s1_waitrequest_from_sa => pipeline_bridge_0_s1_waitrequest_from_sa,
      pipeline_bridge_0_s1_write => pipeline_bridge_0_s1_write,
      pipeline_bridge_0_s1_writedata => pipeline_bridge_0_s1_writedata,
      unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register => unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register,
      unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      pipeline_bridge_0_s1_endofpacket => pipeline_bridge_0_s1_endofpacket,
      pipeline_bridge_0_s1_readdata => pipeline_bridge_0_s1_readdata,
      pipeline_bridge_0_s1_readdatavalid => pipeline_bridge_0_s1_readdatavalid,
      pipeline_bridge_0_s1_waitrequest => pipeline_bridge_0_s1_waitrequest,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_0_downstream_address_to_slave => unici_core_burst_0_downstream_address_to_slave,
      unici_core_burst_0_downstream_arbitrationshare => unici_core_burst_0_downstream_arbitrationshare,
      unici_core_burst_0_downstream_burstcount => unici_core_burst_0_downstream_burstcount,
      unici_core_burst_0_downstream_byteenable => unici_core_burst_0_downstream_byteenable,
      unici_core_burst_0_downstream_debugaccess => unici_core_burst_0_downstream_debugaccess,
      unici_core_burst_0_downstream_latency_counter => unici_core_burst_0_downstream_latency_counter,
      unici_core_burst_0_downstream_nativeaddress => unici_core_burst_0_downstream_nativeaddress,
      unici_core_burst_0_downstream_read => unici_core_burst_0_downstream_read,
      unici_core_burst_0_downstream_write => unici_core_burst_0_downstream_write,
      unici_core_burst_0_downstream_writedata => unici_core_burst_0_downstream_writedata
    );


  --the_pipeline_bridge_0_m1, which is an e_instance
  the_pipeline_bridge_0_m1 : pipeline_bridge_0_m1_arbitrator
    port map(
      pipeline_bridge_0_m1_address_to_slave => pipeline_bridge_0_m1_address_to_slave,
      pipeline_bridge_0_m1_dbs_address => pipeline_bridge_0_m1_dbs_address,
      pipeline_bridge_0_m1_dbs_write_32 => pipeline_bridge_0_m1_dbs_write_32,
      pipeline_bridge_0_m1_latency_counter => pipeline_bridge_0_m1_latency_counter,
      pipeline_bridge_0_m1_readdata => pipeline_bridge_0_m1_readdata,
      pipeline_bridge_0_m1_readdatavalid => pipeline_bridge_0_m1_readdatavalid,
      pipeline_bridge_0_m1_waitrequest => pipeline_bridge_0_m1_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      d1_int_ctrl_0_avalon_slave_end_xfer => d1_int_ctrl_0_avalon_slave_end_xfer,
      int_ctrl_0_avalon_slave_readdata_from_sa => int_ctrl_0_avalon_slave_readdata_from_sa,
      int_ctrl_0_avalon_slave_waitrequest_from_sa => int_ctrl_0_avalon_slave_waitrequest_from_sa,
      pipeline_bridge_0_m1_address => pipeline_bridge_0_m1_address,
      pipeline_bridge_0_m1_burstcount => pipeline_bridge_0_m1_burstcount,
      pipeline_bridge_0_m1_byteenable => pipeline_bridge_0_m1_byteenable,
      pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_byteenable_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_chipselect => pipeline_bridge_0_m1_chipselect,
      pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_granted_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_qualified_request_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_read => pipeline_bridge_0_m1_read,
      pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_read_data_valid_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave => pipeline_bridge_0_m1_requests_int_ctrl_0_avalon_slave,
      pipeline_bridge_0_m1_write => pipeline_bridge_0_m1_write,
      pipeline_bridge_0_m1_writedata => pipeline_bridge_0_m1_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n
    );


  --the_pipeline_bridge_0, which is an e_ptf_instance
  the_pipeline_bridge_0 : pipeline_bridge_0
    port map(
      m1_address => pipeline_bridge_0_m1_address,
      m1_burstcount => pipeline_bridge_0_m1_burstcount,
      m1_byteenable => pipeline_bridge_0_m1_byteenable,
      m1_chipselect => pipeline_bridge_0_m1_chipselect,
      m1_debugaccess => pipeline_bridge_0_m1_debugaccess,
      m1_read => pipeline_bridge_0_m1_read,
      m1_write => pipeline_bridge_0_m1_write,
      m1_writedata => pipeline_bridge_0_m1_writedata,
      s1_endofpacket => pipeline_bridge_0_s1_endofpacket,
      s1_readdata => pipeline_bridge_0_s1_readdata,
      s1_readdatavalid => pipeline_bridge_0_s1_readdatavalid,
      s1_waitrequest => pipeline_bridge_0_s1_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      m1_endofpacket => pipeline_bridge_0_m1_endofpacket,
      m1_readdata => pipeline_bridge_0_m1_readdata,
      m1_readdatavalid => pipeline_bridge_0_m1_readdatavalid,
      m1_waitrequest => pipeline_bridge_0_m1_waitrequest,
      reset_n => pipeline_bridge_0_s1_reset_n,
      s1_address => pipeline_bridge_0_s1_address,
      s1_arbiterlock => pipeline_bridge_0_s1_arbiterlock,
      s1_arbiterlock2 => pipeline_bridge_0_s1_arbiterlock2,
      s1_burstcount => pipeline_bridge_0_s1_burstcount,
      s1_byteenable => pipeline_bridge_0_s1_byteenable,
      s1_chipselect => pipeline_bridge_0_s1_chipselect,
      s1_debugaccess => pipeline_bridge_0_s1_debugaccess,
      s1_nativeaddress => pipeline_bridge_0_s1_nativeaddress,
      s1_read => pipeline_bridge_0_s1_read,
      s1_write => pipeline_bridge_0_s1_write,
      s1_writedata => pipeline_bridge_0_s1_writedata
    );


  --the_spi_master_0_avalon_slave_0, which is an e_instance
  the_spi_master_0_avalon_slave_0 : spi_master_0_avalon_slave_0_arbitrator
    port map(
      d1_spi_master_0_avalon_slave_0_end_xfer => d1_spi_master_0_avalon_slave_0_end_xfer,
      int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_spi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_spi_master_0_avalon_slave_0,
      spi_master_0_avalon_slave_0_address => spi_master_0_avalon_slave_0_address,
      spi_master_0_avalon_slave_0_byteenable => spi_master_0_avalon_slave_0_byteenable,
      spi_master_0_avalon_slave_0_readdata_from_sa => spi_master_0_avalon_slave_0_readdata_from_sa,
      spi_master_0_avalon_slave_0_reset => spi_master_0_avalon_slave_0_reset,
      spi_master_0_avalon_slave_0_waitrequest_from_sa => spi_master_0_avalon_slave_0_waitrequest_from_sa,
      spi_master_0_avalon_slave_0_write => spi_master_0_avalon_slave_0_write,
      spi_master_0_avalon_slave_0_writedata => spi_master_0_avalon_slave_0_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      spi_master_0_avalon_slave_0_readdata => spi_master_0_avalon_slave_0_readdata,
      spi_master_0_avalon_slave_0_waitrequest => spi_master_0_avalon_slave_0_waitrequest
    );


  --the_spi_master_0, which is an e_ptf_instance
  the_spi_master_0 : spi_master_0
    port map(
      cs_n => internal_cs_n_from_the_spi_master_0,
      irq => internal_irq_from_the_spi_master_0,
      mosi => internal_mosi_from_the_spi_master_0,
      out_data => spi_master_0_avalon_slave_0_readdata,
      sclk => internal_sclk_from_the_spi_master_0,
      wait_req => spi_master_0_avalon_slave_0_waitrequest,
      addr => spi_master_0_avalon_slave_0_address,
      byte_en => spi_master_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => spi_master_0_avalon_slave_0_writedata,
      miso => miso_to_the_spi_master_0,
      rst => spi_master_0_avalon_slave_0_reset,
      wr_en => spi_master_0_avalon_slave_0_write
    );


  --the_twi_master_0_avalon_slave_0, which is an e_instance
  the_twi_master_0_avalon_slave_0 : twi_master_0_avalon_slave_0_arbitrator
    port map(
      d1_twi_master_0_avalon_slave_0_end_xfer => d1_twi_master_0_avalon_slave_0_end_xfer,
      int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_granted_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_twi_master_0_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0 => int_ctrl_0_avalon_master_requests_twi_master_0_avalon_slave_0,
      twi_master_0_avalon_slave_0_address => twi_master_0_avalon_slave_0_address,
      twi_master_0_avalon_slave_0_byteenable => twi_master_0_avalon_slave_0_byteenable,
      twi_master_0_avalon_slave_0_readdata_from_sa => twi_master_0_avalon_slave_0_readdata_from_sa,
      twi_master_0_avalon_slave_0_reset => twi_master_0_avalon_slave_0_reset,
      twi_master_0_avalon_slave_0_write => twi_master_0_avalon_slave_0_write,
      twi_master_0_avalon_slave_0_writedata => twi_master_0_avalon_slave_0_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_0_avalon_slave_0_readdata => twi_master_0_avalon_slave_0_readdata
    );


  --the_twi_master_0_avalon_streaming_sink, which is an e_instance
  the_twi_master_0_avalon_streaming_sink : twi_master_0_avalon_streaming_sink_arbitrator
    port map(
      twi_master_0_avalon_streaming_sink_data => twi_master_0_avalon_streaming_sink_data,
      twi_master_0_avalon_streaming_sink_ready_from_sa => twi_master_0_avalon_streaming_sink_ready_from_sa,
      twi_master_0_avalon_streaming_sink_valid => twi_master_0_avalon_streaming_sink_valid,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_out_8b_sync_0_avalon_streaming_source_data => fifo_out_8b_sync_0_avalon_streaming_source_data,
      fifo_out_8b_sync_0_avalon_streaming_source_valid => fifo_out_8b_sync_0_avalon_streaming_source_valid,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_0_avalon_streaming_sink_ready => twi_master_0_avalon_streaming_sink_ready
    );


  --the_twi_master_0_avalon_streaming_source, which is an e_instance
  the_twi_master_0_avalon_streaming_source : twi_master_0_avalon_streaming_source_arbitrator
    port map(
      twi_master_0_avalon_streaming_source_ready => twi_master_0_avalon_streaming_source_ready,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa => fifo_in_8b_sync_0_avalon_streaming_sink_ready_from_sa,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_0_avalon_streaming_source_data => twi_master_0_avalon_streaming_source_data,
      twi_master_0_avalon_streaming_source_valid => twi_master_0_avalon_streaming_source_valid
    );


  --the_twi_master_0, which is an e_ptf_instance
  the_twi_master_0 : twi_master_0
    port map(
      in_ready => twi_master_0_avalon_streaming_sink_ready,
      irq => internal_irq_from_the_twi_master_0,
      out_data => twi_master_0_avalon_slave_0_readdata,
      out_octet => twi_master_0_avalon_streaming_source_data,
      out_valid => twi_master_0_avalon_streaming_source_valid,
      scl_act => internal_scl_act_from_the_twi_master_0,
      sda_act => internal_sda_act_from_the_twi_master_0,
      addr => twi_master_0_avalon_slave_0_address,
      byte_en => twi_master_0_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => twi_master_0_avalon_slave_0_writedata,
      in_octet => twi_master_0_avalon_streaming_sink_data,
      in_valid => twi_master_0_avalon_streaming_sink_valid,
      out_ready => twi_master_0_avalon_streaming_source_ready,
      rst => twi_master_0_avalon_slave_0_reset,
      scl_in => scl_in_to_the_twi_master_0,
      sda_in => sda_in_to_the_twi_master_0,
      sink_irq => sink_irq_to_the_twi_master_0,
      source_irq => source_irq_to_the_twi_master_0,
      wr_en => twi_master_0_avalon_slave_0_write
    );


  --the_twi_master_1_avalon_slave_0, which is an e_instance
  the_twi_master_1_avalon_slave_0 : twi_master_1_avalon_slave_0_arbitrator
    port map(
      d1_twi_master_1_avalon_slave_0_end_xfer => d1_twi_master_1_avalon_slave_0_end_xfer,
      int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_byteenable_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_granted_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_qualified_request_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_read_data_valid_twi_master_1_avalon_slave_0,
      int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0 => int_ctrl_0_avalon_master_requests_twi_master_1_avalon_slave_0,
      twi_master_1_avalon_slave_0_address => twi_master_1_avalon_slave_0_address,
      twi_master_1_avalon_slave_0_byteenable => twi_master_1_avalon_slave_0_byteenable,
      twi_master_1_avalon_slave_0_readdata_from_sa => twi_master_1_avalon_slave_0_readdata_from_sa,
      twi_master_1_avalon_slave_0_reset => twi_master_1_avalon_slave_0_reset,
      twi_master_1_avalon_slave_0_write => twi_master_1_avalon_slave_0_write,
      twi_master_1_avalon_slave_0_writedata => twi_master_1_avalon_slave_0_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      int_ctrl_0_avalon_master_address_to_slave => int_ctrl_0_avalon_master_address_to_slave,
      int_ctrl_0_avalon_master_byteenable => int_ctrl_0_avalon_master_byteenable,
      int_ctrl_0_avalon_master_dbs_address => int_ctrl_0_avalon_master_dbs_address,
      int_ctrl_0_avalon_master_dbs_write_16 => int_ctrl_0_avalon_master_dbs_write_16,
      int_ctrl_0_avalon_master_read => int_ctrl_0_avalon_master_read,
      int_ctrl_0_avalon_master_write => int_ctrl_0_avalon_master_write,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_1_avalon_slave_0_readdata => twi_master_1_avalon_slave_0_readdata
    );


  --the_twi_master_1_avalon_streaming_sink, which is an e_instance
  the_twi_master_1_avalon_streaming_sink : twi_master_1_avalon_streaming_sink_arbitrator
    port map(
      twi_master_1_avalon_streaming_sink_data => twi_master_1_avalon_streaming_sink_data,
      twi_master_1_avalon_streaming_sink_ready_from_sa => twi_master_1_avalon_streaming_sink_ready_from_sa,
      twi_master_1_avalon_streaming_sink_valid => twi_master_1_avalon_streaming_sink_valid,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_out_8b_sync_1_avalon_streaming_source_data => fifo_out_8b_sync_1_avalon_streaming_source_data,
      fifo_out_8b_sync_1_avalon_streaming_source_valid => fifo_out_8b_sync_1_avalon_streaming_source_valid,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_1_avalon_streaming_sink_ready => twi_master_1_avalon_streaming_sink_ready
    );


  --the_twi_master_1_avalon_streaming_source, which is an e_instance
  the_twi_master_1_avalon_streaming_source : twi_master_1_avalon_streaming_source_arbitrator
    port map(
      twi_master_1_avalon_streaming_source_ready => twi_master_1_avalon_streaming_source_ready,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa => fifo_in_8b_sync_1_avalon_streaming_sink_ready_from_sa,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      twi_master_1_avalon_streaming_source_data => twi_master_1_avalon_streaming_source_data,
      twi_master_1_avalon_streaming_source_valid => twi_master_1_avalon_streaming_source_valid
    );


  --the_twi_master_1, which is an e_ptf_instance
  the_twi_master_1 : twi_master_1
    port map(
      in_ready => twi_master_1_avalon_streaming_sink_ready,
      irq => internal_irq_from_the_twi_master_1,
      out_data => twi_master_1_avalon_slave_0_readdata,
      out_octet => twi_master_1_avalon_streaming_source_data,
      out_valid => twi_master_1_avalon_streaming_source_valid,
      scl_act => internal_scl_act_from_the_twi_master_1,
      sda_act => internal_sda_act_from_the_twi_master_1,
      addr => twi_master_1_avalon_slave_0_address,
      byte_en => twi_master_1_avalon_slave_0_byteenable,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      in_data => twi_master_1_avalon_slave_0_writedata,
      in_octet => twi_master_1_avalon_streaming_sink_data,
      in_valid => twi_master_1_avalon_streaming_sink_valid,
      out_ready => twi_master_1_avalon_streaming_source_ready,
      rst => twi_master_1_avalon_slave_0_reset,
      scl_in => scl_in_to_the_twi_master_1,
      sda_in => sda_in_to_the_twi_master_1,
      sink_irq => sink_irq_to_the_twi_master_1,
      source_irq => source_irq_to_the_twi_master_1,
      wr_en => twi_master_1_avalon_slave_0_write
    );


  --the_unici_core_burst_0_upstream, which is an e_instance
  the_unici_core_burst_0_upstream : unici_core_burst_0_upstream_arbitrator
    port map(
      d1_unici_core_burst_0_upstream_end_xfer => d1_unici_core_burst_0_upstream_end_xfer,
      pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_granted_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register,
      pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream => pcie_compiler_0_Rx_Interface_requests_unici_core_burst_0_upstream,
      unici_core_burst_0_upstream_address => unici_core_burst_0_upstream_address,
      unici_core_burst_0_upstream_burstcount => unici_core_burst_0_upstream_burstcount,
      unici_core_burst_0_upstream_byteaddress => unici_core_burst_0_upstream_byteaddress,
      unici_core_burst_0_upstream_byteenable => unici_core_burst_0_upstream_byteenable,
      unici_core_burst_0_upstream_debugaccess => unici_core_burst_0_upstream_debugaccess,
      unici_core_burst_0_upstream_read => unici_core_burst_0_upstream_read,
      unici_core_burst_0_upstream_readdata_from_sa => unici_core_burst_0_upstream_readdata_from_sa,
      unici_core_burst_0_upstream_waitrequest_from_sa => unici_core_burst_0_upstream_waitrequest_from_sa,
      unici_core_burst_0_upstream_write => unici_core_burst_0_upstream_write,
      unici_core_burst_0_upstream_writedata => unici_core_burst_0_upstream_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      pcie_compiler_0_Rx_Interface_address_to_slave => pcie_compiler_0_Rx_Interface_address_to_slave,
      pcie_compiler_0_Rx_Interface_burstcount => pcie_compiler_0_Rx_Interface_burstcount,
      pcie_compiler_0_Rx_Interface_byteenable => pcie_compiler_0_Rx_Interface_byteenable,
      pcie_compiler_0_Rx_Interface_latency_counter => pcie_compiler_0_Rx_Interface_latency_counter,
      pcie_compiler_0_Rx_Interface_read => pcie_compiler_0_Rx_Interface_read,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register,
      pcie_compiler_0_Rx_Interface_write => pcie_compiler_0_Rx_Interface_write,
      pcie_compiler_0_Rx_Interface_writedata => pcie_compiler_0_Rx_Interface_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_0_upstream_readdata => unici_core_burst_0_upstream_readdata,
      unici_core_burst_0_upstream_readdatavalid => unici_core_burst_0_upstream_readdatavalid,
      unici_core_burst_0_upstream_waitrequest => unici_core_burst_0_upstream_waitrequest
    );


  --the_unici_core_burst_0_downstream, which is an e_instance
  the_unici_core_burst_0_downstream : unici_core_burst_0_downstream_arbitrator
    port map(
      unici_core_burst_0_downstream_address_to_slave => unici_core_burst_0_downstream_address_to_slave,
      unici_core_burst_0_downstream_latency_counter => unici_core_burst_0_downstream_latency_counter,
      unici_core_burst_0_downstream_readdata => unici_core_burst_0_downstream_readdata,
      unici_core_burst_0_downstream_readdatavalid => unici_core_burst_0_downstream_readdatavalid,
      unici_core_burst_0_downstream_reset_n => unici_core_burst_0_downstream_reset_n,
      unici_core_burst_0_downstream_waitrequest => unici_core_burst_0_downstream_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      d1_pipeline_bridge_0_s1_end_xfer => d1_pipeline_bridge_0_s1_end_xfer,
      pipeline_bridge_0_s1_readdata_from_sa => pipeline_bridge_0_s1_readdata_from_sa,
      pipeline_bridge_0_s1_waitrequest_from_sa => pipeline_bridge_0_s1_waitrequest_from_sa,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_0_downstream_address => unici_core_burst_0_downstream_address,
      unici_core_burst_0_downstream_burstcount => unici_core_burst_0_downstream_burstcount,
      unici_core_burst_0_downstream_byteenable => unici_core_burst_0_downstream_byteenable,
      unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_granted_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_qualified_request_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_read => unici_core_burst_0_downstream_read,
      unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register => unici_core_burst_0_downstream_read_data_valid_pipeline_bridge_0_s1_shift_register,
      unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1 => unici_core_burst_0_downstream_requests_pipeline_bridge_0_s1,
      unici_core_burst_0_downstream_write => unici_core_burst_0_downstream_write,
      unici_core_burst_0_downstream_writedata => unici_core_burst_0_downstream_writedata
    );


  --the_unici_core_burst_0, which is an e_ptf_instance
  the_unici_core_burst_0 : unici_core_burst_0
    port map(
      downstream_address => unici_core_burst_0_downstream_address,
      downstream_arbitrationshare => unici_core_burst_0_downstream_arbitrationshare,
      downstream_burstcount => unici_core_burst_0_downstream_burstcount,
      downstream_byteenable => unici_core_burst_0_downstream_byteenable,
      downstream_debugaccess => unici_core_burst_0_downstream_debugaccess,
      downstream_nativeaddress => unici_core_burst_0_downstream_nativeaddress,
      downstream_read => unici_core_burst_0_downstream_read,
      downstream_write => unici_core_burst_0_downstream_write,
      downstream_writedata => unici_core_burst_0_downstream_writedata,
      upstream_readdata => unici_core_burst_0_upstream_readdata,
      upstream_readdatavalid => unici_core_burst_0_upstream_readdatavalid,
      upstream_waitrequest => unici_core_burst_0_upstream_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      downstream_readdata => unici_core_burst_0_downstream_readdata,
      downstream_readdatavalid => unici_core_burst_0_downstream_readdatavalid,
      downstream_waitrequest => unici_core_burst_0_downstream_waitrequest,
      reset_n => unici_core_burst_0_downstream_reset_n,
      upstream_address => unici_core_burst_0_upstream_byteaddress,
      upstream_burstcount => unici_core_burst_0_upstream_burstcount,
      upstream_byteenable => unici_core_burst_0_upstream_byteenable,
      upstream_debugaccess => unici_core_burst_0_upstream_debugaccess,
      upstream_nativeaddress => unici_core_burst_0_upstream_address,
      upstream_read => unici_core_burst_0_upstream_read,
      upstream_write => unici_core_burst_0_upstream_write,
      upstream_writedata => unici_core_burst_0_upstream_writedata
    );


  --the_unici_core_burst_1_upstream, which is an e_instance
  the_unici_core_burst_1_upstream : unici_core_burst_1_upstream_arbitrator
    port map(
      d1_unici_core_burst_1_upstream_end_xfer => d1_unici_core_burst_1_upstream_end_xfer,
      pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_granted_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_qualified_request_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_1_upstream_shift_register,
      pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream => pcie_compiler_0_Rx_Interface_requests_unici_core_burst_1_upstream,
      unici_core_burst_1_upstream_address => unici_core_burst_1_upstream_address,
      unici_core_burst_1_upstream_burstcount => unici_core_burst_1_upstream_burstcount,
      unici_core_burst_1_upstream_byteaddress => unici_core_burst_1_upstream_byteaddress,
      unici_core_burst_1_upstream_byteenable => unici_core_burst_1_upstream_byteenable,
      unici_core_burst_1_upstream_debugaccess => unici_core_burst_1_upstream_debugaccess,
      unici_core_burst_1_upstream_read => unici_core_burst_1_upstream_read,
      unici_core_burst_1_upstream_readdata_from_sa => unici_core_burst_1_upstream_readdata_from_sa,
      unici_core_burst_1_upstream_waitrequest_from_sa => unici_core_burst_1_upstream_waitrequest_from_sa,
      unici_core_burst_1_upstream_write => unici_core_burst_1_upstream_write,
      unici_core_burst_1_upstream_writedata => unici_core_burst_1_upstream_writedata,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      pcie_compiler_0_Rx_Interface_address_to_slave => pcie_compiler_0_Rx_Interface_address_to_slave,
      pcie_compiler_0_Rx_Interface_burstcount => pcie_compiler_0_Rx_Interface_burstcount,
      pcie_compiler_0_Rx_Interface_byteenable => pcie_compiler_0_Rx_Interface_byteenable,
      pcie_compiler_0_Rx_Interface_latency_counter => pcie_compiler_0_Rx_Interface_latency_counter,
      pcie_compiler_0_Rx_Interface_read => pcie_compiler_0_Rx_Interface_read,
      pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register => pcie_compiler_0_Rx_Interface_read_data_valid_unici_core_burst_0_upstream_shift_register,
      pcie_compiler_0_Rx_Interface_write => pcie_compiler_0_Rx_Interface_write,
      pcie_compiler_0_Rx_Interface_writedata => pcie_compiler_0_Rx_Interface_writedata,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_1_upstream_readdata => unici_core_burst_1_upstream_readdata,
      unici_core_burst_1_upstream_readdatavalid => unici_core_burst_1_upstream_readdatavalid,
      unici_core_burst_1_upstream_waitrequest => unici_core_burst_1_upstream_waitrequest
    );


  --the_unici_core_burst_1_downstream, which is an e_instance
  the_unici_core_burst_1_downstream : unici_core_burst_1_downstream_arbitrator
    port map(
      unici_core_burst_1_downstream_address_to_slave => unici_core_burst_1_downstream_address_to_slave,
      unici_core_burst_1_downstream_latency_counter => unici_core_burst_1_downstream_latency_counter,
      unici_core_burst_1_downstream_readdata => unici_core_burst_1_downstream_readdata,
      unici_core_burst_1_downstream_readdatavalid => unici_core_burst_1_downstream_readdatavalid,
      unici_core_burst_1_downstream_reset_n => unici_core_burst_1_downstream_reset_n,
      unici_core_burst_1_downstream_waitrequest => unici_core_burst_1_downstream_waitrequest,
      avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa => avalon64_to_avalon8_0_avalon_slave_0_readdata_from_sa,
      avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa => avalon64_to_avalon8_0_avalon_slave_0_waitrequest_from_sa,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer => d1_avalon64_to_avalon8_0_avalon_slave_0_end_xfer,
      reset_n => pcie_compiler_0_pcie_core_clk_out_reset_n,
      unici_core_burst_1_downstream_address => unici_core_burst_1_downstream_address,
      unici_core_burst_1_downstream_burstcount => unici_core_burst_1_downstream_burstcount,
      unici_core_burst_1_downstream_byteenable => unici_core_burst_1_downstream_byteenable,
      unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_granted_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_qualified_request_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_read => unici_core_burst_1_downstream_read,
      unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_read_data_valid_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0 => unici_core_burst_1_downstream_requests_avalon64_to_avalon8_0_avalon_slave_0,
      unici_core_burst_1_downstream_write => unici_core_burst_1_downstream_write,
      unici_core_burst_1_downstream_writedata => unici_core_burst_1_downstream_writedata
    );


  --the_unici_core_burst_1, which is an e_ptf_instance
  the_unici_core_burst_1 : unici_core_burst_1
    port map(
      downstream_address => unici_core_burst_1_downstream_address,
      downstream_arbitrationshare => unici_core_burst_1_downstream_arbitrationshare,
      downstream_burstcount => unici_core_burst_1_downstream_burstcount,
      downstream_byteenable => unici_core_burst_1_downstream_byteenable,
      downstream_debugaccess => unici_core_burst_1_downstream_debugaccess,
      downstream_nativeaddress => unici_core_burst_1_downstream_nativeaddress,
      downstream_read => unici_core_burst_1_downstream_read,
      downstream_write => unici_core_burst_1_downstream_write,
      downstream_writedata => unici_core_burst_1_downstream_writedata,
      upstream_readdata => unici_core_burst_1_upstream_readdata,
      upstream_readdatavalid => unici_core_burst_1_upstream_readdatavalid,
      upstream_waitrequest => unici_core_burst_1_upstream_waitrequest,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      downstream_readdata => unici_core_burst_1_downstream_readdata,
      downstream_readdatavalid => unici_core_burst_1_downstream_readdatavalid,
      downstream_waitrequest => unici_core_burst_1_downstream_waitrequest,
      reset_n => unici_core_burst_1_downstream_reset_n,
      upstream_address => unici_core_burst_1_upstream_byteaddress,
      upstream_burstcount => unici_core_burst_1_upstream_burstcount,
      upstream_byteenable => unici_core_burst_1_upstream_byteenable,
      upstream_debugaccess => unici_core_burst_1_upstream_debugaccess,
      upstream_nativeaddress => unici_core_burst_1_upstream_address,
      upstream_read => unici_core_burst_1_upstream_read,
      upstream_write => unici_core_burst_1_upstream_write,
      upstream_writedata => unici_core_burst_1_upstream_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch : unici_core_reset_pcie_compiler_0_pcie_core_clk_out_domain_synch_module
    port map(
      data_out => pcie_compiler_0_pcie_core_clk_out_reset_n,
      clk => internal_pcie_compiler_0_pcie_core_clk_out,
      data_in => module_input15,
      reset_n => reset_n_sources
    );

  module_input15 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_resetrequest)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_resetrequest)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_resetrequest)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pcie_compiler_0_Rx_Interface_resetrequest))))));
  --pcie_compiler_0_Rx_Interface_irq of type irq does not connect to anything so wire it to default (0)
  pcie_compiler_0_Rx_Interface_irq <= int_ctrl_0_avalon_slave_irq;
  --pcie_compiler_0_Rx_Interface_irqnumber of type irqnumber does not connect to anything so wire it to default (0)
  pcie_compiler_0_Rx_Interface_irqnumber <= std_logic_vector'("000000");
  --pipeline_bridge_0_m1_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  pipeline_bridge_0_m1_endofpacket <= std_logic'('0');
  --vhdl renameroo for output signals
  cam0_bypass_from_the_ci_bridge_0 <= internal_cam0_bypass_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam0_fail_from_the_ci_bridge_0 <= internal_cam0_fail_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam0_ready_from_the_ci_bridge_0 <= internal_cam0_ready_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam1_bypass_from_the_ci_bridge_0 <= internal_cam1_bypass_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam1_fail_from_the_ci_bridge_0 <= internal_cam1_fail_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam1_ready_from_the_ci_bridge_0 <= internal_cam1_ready_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam_interrupts_from_the_ci_bridge_0 <= internal_cam_interrupts_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam_mclki_from_the_dvb_ts_0 <= internal_cam_mclki_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  cam_mclki_from_the_dvb_ts_1 <= internal_cam_mclki_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  cam_mdi_from_the_dvb_ts_0 <= internal_cam_mdi_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  cam_mdi_from_the_dvb_ts_1 <= internal_cam_mdi_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  cam_mistrt_from_the_dvb_ts_0 <= internal_cam_mistrt_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  cam_mistrt_from_the_dvb_ts_1 <= internal_cam_mistrt_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  cam_mival_from_the_dvb_ts_0 <= internal_cam_mival_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  cam_mival_from_the_dvb_ts_1 <= internal_cam_mival_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  cam_readdata_from_the_ci_bridge_0 <= internal_cam_readdata_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cam_waitreq_from_the_ci_bridge_0 <= internal_cam_waitreq_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_a_from_the_ci_bridge_0 <= internal_ci_a_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_bus_dir_from_the_ci_bridge_0 <= internal_ci_bus_dir_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_d_en_from_the_ci_bridge_0 <= internal_ci_d_en_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_d_out_from_the_ci_bridge_0 <= internal_ci_d_out_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_iord_n_from_the_ci_bridge_0 <= internal_ci_iord_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_iowr_n_from_the_ci_bridge_0 <= internal_ci_iowr_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_oe_n_from_the_ci_bridge_0 <= internal_ci_oe_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_reg_n_from_the_ci_bridge_0 <= internal_ci_reg_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  ci_we_n_from_the_ci_bridge_0 <= internal_ci_we_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cia_ce_n_from_the_ci_bridge_0 <= internal_cia_ce_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cia_data_buf_oe_n_from_the_ci_bridge_0 <= internal_cia_data_buf_oe_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cia_reset_buf_oe_n_from_the_ci_bridge_0 <= internal_cia_reset_buf_oe_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cia_reset_from_the_ci_bridge_0 <= internal_cia_reset_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cib_ce_n_from_the_ci_bridge_0 <= internal_cib_ce_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cib_data_buf_oe_n_from_the_ci_bridge_0 <= internal_cib_data_buf_oe_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cib_reset_buf_oe_n_from_the_ci_bridge_0 <= internal_cib_reset_buf_oe_n_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  cib_reset_from_the_ci_bridge_0 <= internal_cib_reset_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  clk125_out_pcie_compiler_0 <= internal_clk125_out_pcie_compiler_0;
  --vhdl renameroo for output signals
  clk250_out_pcie_compiler_0 <= internal_clk250_out_pcie_compiler_0;
  --vhdl renameroo for output signals
  clk500_out_pcie_compiler_0 <= internal_clk500_out_pcie_compiler_0;
  --vhdl renameroo for output signals
  cs_n_from_the_spi_master_0 <= internal_cs_n_from_the_spi_master_0;
  --vhdl renameroo for output signals
  dma0_wait_from_the_dma_arbiter_0 <= internal_dma0_wait_from_the_dma_arbiter_0;
  --vhdl renameroo for output signals
  dma1_wait_from_the_dma_arbiter_0 <= internal_dma1_wait_from_the_dma_arbiter_0;
  --vhdl renameroo for output signals
  dvb_out_data_from_the_dvb_ts_0 <= internal_dvb_out_data_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  dvb_out_data_from_the_dvb_ts_1 <= internal_dvb_out_data_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  dvb_out_dsop_from_the_dvb_ts_0 <= internal_dvb_out_dsop_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  dvb_out_dsop_from_the_dvb_ts_1 <= internal_dvb_out_dsop_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  dvb_out_dval_from_the_dvb_ts_0 <= internal_dvb_out_dval_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  dvb_out_dval_from_the_dvb_ts_1 <= internal_dvb_out_dval_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  interrupt_from_the_ci_bridge_0 <= internal_interrupt_from_the_ci_bridge_0;
  --vhdl renameroo for output signals
  interrupt_from_the_dvb_dma_0 <= internal_interrupt_from_the_dvb_dma_0;
  --vhdl renameroo for output signals
  interrupt_from_the_dvb_dma_1 <= internal_interrupt_from_the_dvb_dma_1;
  --vhdl renameroo for output signals
  interrupt_from_the_dvb_ts_0 <= internal_interrupt_from_the_dvb_ts_0;
  --vhdl renameroo for output signals
  interrupt_from_the_dvb_ts_1 <= internal_interrupt_from_the_dvb_ts_1;
  --vhdl renameroo for output signals
  irq_from_the_fifo_in_8b_sync_0 <= internal_irq_from_the_fifo_in_8b_sync_0;
  --vhdl renameroo for output signals
  irq_from_the_fifo_in_8b_sync_1 <= internal_irq_from_the_fifo_in_8b_sync_1;
  --vhdl renameroo for output signals
  irq_from_the_fifo_out_8b_sync_0 <= internal_irq_from_the_fifo_out_8b_sync_0;
  --vhdl renameroo for output signals
  irq_from_the_fifo_out_8b_sync_1 <= internal_irq_from_the_fifo_out_8b_sync_1;
  --vhdl renameroo for output signals
  irq_from_the_spi_master_0 <= internal_irq_from_the_spi_master_0;
  --vhdl renameroo for output signals
  irq_from_the_twi_master_0 <= internal_irq_from_the_twi_master_0;
  --vhdl renameroo for output signals
  irq_from_the_twi_master_1 <= internal_irq_from_the_twi_master_1;
  --vhdl renameroo for output signals
  mem_addr_from_the_dvb_dma_0 <= internal_mem_addr_from_the_dvb_dma_0;
  --vhdl renameroo for output signals
  mem_addr_from_the_dvb_dma_1 <= internal_mem_addr_from_the_dvb_dma_1;
  --vhdl renameroo for output signals
  mem_byteen_from_the_dvb_dma_0 <= internal_mem_byteen_from_the_dvb_dma_0;
  --vhdl renameroo for output signals
  mem_byteen_from_the_dvb_dma_1 <= internal_mem_byteen_from_the_dvb_dma_1;
  --vhdl renameroo for output signals
  mem_size_from_the_dvb_dma_0 <= internal_mem_size_from_the_dvb_dma_0;
  --vhdl renameroo for output signals
  mem_size_from_the_dvb_dma_1 <= internal_mem_size_from_the_dvb_dma_1;
  --vhdl renameroo for output signals
  mem_wrdata_from_the_dvb_dma_0 <= internal_mem_wrdata_from_the_dvb_dma_0;
  --vhdl renameroo for output signals
  mem_wrdata_from_the_dvb_dma_1 <= internal_mem_wrdata_from_the_dvb_dma_1;
  --vhdl renameroo for output signals
  mem_write_from_the_dvb_dma_0 <= internal_mem_write_from_the_dvb_dma_0;
  --vhdl renameroo for output signals
  mem_write_from_the_dvb_dma_1 <= internal_mem_write_from_the_dvb_dma_1;
  --vhdl renameroo for output signals
  mosi_from_the_spi_master_0 <= internal_mosi_from_the_spi_master_0;
  --vhdl renameroo for output signals
  out_address_from_the_avalon64_to_avalon8_0 <= internal_out_address_from_the_avalon64_to_avalon8_0;
  --vhdl renameroo for output signals
  out_read_from_the_avalon64_to_avalon8_0 <= internal_out_read_from_the_avalon64_to_avalon8_0;
  --vhdl renameroo for output signals
  out_write_from_the_avalon64_to_avalon8_0 <= internal_out_write_from_the_avalon64_to_avalon8_0;
  --vhdl renameroo for output signals
  out_writedata_from_the_avalon64_to_avalon8_0 <= internal_out_writedata_from_the_avalon64_to_avalon8_0;
  --vhdl renameroo for output signals
  pcie_compiler_0_pcie_core_clk_out <= internal_pcie_compiler_0_pcie_core_clk_out;
  --vhdl renameroo for output signals
  pins_from_the_gpout_0 <= internal_pins_from_the_gpout_0;
  --vhdl renameroo for output signals
  powerdown_ext_pcie_compiler_0 <= internal_powerdown_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  rate_ext_pcie_compiler_0 <= internal_rate_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  reconfig_fromgxb_pcie_compiler_0 <= internal_reconfig_fromgxb_pcie_compiler_0;
  --vhdl renameroo for output signals
  rxpolarity0_ext_pcie_compiler_0 <= internal_rxpolarity0_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  scl_act_from_the_twi_master_0 <= internal_scl_act_from_the_twi_master_0;
  --vhdl renameroo for output signals
  scl_act_from_the_twi_master_1 <= internal_scl_act_from_the_twi_master_1;
  --vhdl renameroo for output signals
  sclk_from_the_spi_master_0 <= internal_sclk_from_the_spi_master_0;
  --vhdl renameroo for output signals
  sda_act_from_the_twi_master_0 <= internal_sda_act_from_the_twi_master_0;
  --vhdl renameroo for output signals
  sda_act_from_the_twi_master_1 <= internal_sda_act_from_the_twi_master_1;
  --vhdl renameroo for output signals
  tx_out0_pcie_compiler_0 <= internal_tx_out0_pcie_compiler_0;
  --vhdl renameroo for output signals
  txcompl0_ext_pcie_compiler_0 <= internal_txcompl0_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  txdata0_ext_pcie_compiler_0 <= internal_txdata0_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  txdatak0_ext_pcie_compiler_0 <= internal_txdatak0_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  txdetectrx_ext_pcie_compiler_0 <= internal_txdetectrx_ext_pcie_compiler_0;
  --vhdl renameroo for output signals
  txelecidle0_ext_pcie_compiler_0 <= internal_txelecidle0_ext_pcie_compiler_0;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component unici_core is 
           port (
                 -- 1) global signals:
                    signal pcie_compiler_0_pcie_core_clk_out : OUT STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_avalon64_to_avalon8_0
                    signal out_address_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal out_read_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC;
                    signal out_readdata_to_the_avalon64_to_avalon8_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal out_waitrequest_to_the_avalon64_to_avalon8_0 : IN STD_LOGIC;
                    signal out_write_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC;
                    signal out_writedata_from_the_avalon64_to_avalon8_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- the_ci_bridge_0
                    signal cam0_bypass_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam0_fail_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam0_ready_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam1_bypass_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam1_fail_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam1_ready_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam_address_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal cam_interrupts_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cam_read_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cam_readdata_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_waitreq_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cam_write_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cam_writedata_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal ci_a_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
                    signal ci_bus_dir_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal ci_d_en_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal ci_d_in_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal ci_d_out_from_the_ci_bridge_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal ci_iord_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal ci_iowr_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal ci_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal ci_reg_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal ci_we_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cia_cd_n_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cia_ce_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cia_data_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cia_ireq_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cia_overcurrent_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cia_reset_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cia_reset_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cia_wait_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cib_cd_n_to_the_ci_bridge_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cib_ce_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cib_data_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cib_ireq_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cib_overcurrent_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal cib_reset_buf_oe_n_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cib_reset_from_the_ci_bridge_0 : OUT STD_LOGIC;
                    signal cib_wait_n_to_the_ci_bridge_0 : IN STD_LOGIC;
                    signal interrupt_from_the_ci_bridge_0 : OUT STD_LOGIC;

                 -- the_dma_arbiter_0
                    signal dma0_addr_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal dma0_byteen_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dma0_size_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal dma0_wait_from_the_dma_arbiter_0 : OUT STD_LOGIC;
                    signal dma0_wrdata_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal dma0_write_to_the_dma_arbiter_0 : IN STD_LOGIC;
                    signal dma1_addr_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal dma1_byteen_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dma1_size_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal dma1_wait_from_the_dma_arbiter_0 : OUT STD_LOGIC;
                    signal dma1_wrdata_to_the_dma_arbiter_0 : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal dma1_write_to_the_dma_arbiter_0 : IN STD_LOGIC;

                 -- the_dvb_dma_0
                    signal dvb_data_to_the_dvb_dma_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_dval_to_the_dvb_dma_0 : IN STD_LOGIC;
                    signal dvb_sop_to_the_dvb_dma_0 : IN STD_LOGIC;
                    signal interrupt_from_the_dvb_dma_0 : OUT STD_LOGIC;
                    signal mem_addr_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal mem_byteen_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal mem_size_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal mem_waitreq_to_the_dvb_dma_0 : IN STD_LOGIC;
                    signal mem_wrdata_from_the_dvb_dma_0 : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal mem_write_from_the_dvb_dma_0 : OUT STD_LOGIC;

                 -- the_dvb_dma_1
                    signal dvb_data_to_the_dvb_dma_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_dval_to_the_dvb_dma_1 : IN STD_LOGIC;
                    signal dvb_sop_to_the_dvb_dma_1 : IN STD_LOGIC;
                    signal interrupt_from_the_dvb_dma_1 : OUT STD_LOGIC;
                    signal mem_addr_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (60 DOWNTO 0);
                    signal mem_byteen_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal mem_size_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal mem_waitreq_to_the_dvb_dma_1 : IN STD_LOGIC;
                    signal mem_wrdata_from_the_dvb_dma_1 : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal mem_write_from_the_dvb_dma_1 : OUT STD_LOGIC;

                 -- the_dvb_ts_0
                    signal cam_baseclk_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal cam_bypass_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal cam_mclki_from_the_dvb_ts_0 : OUT STD_LOGIC;
                    signal cam_mclko_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal cam_mdi_from_the_dvb_ts_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mdo_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mistrt_from_the_dvb_ts_0 : OUT STD_LOGIC;
                    signal cam_mival_from_the_dvb_ts_0 : OUT STD_LOGIC;
                    signal cam_mostrt_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal cam_moval_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_in0_data_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in0_dsop_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_in0_dval_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_in1_data_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in1_dsop_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_in1_dval_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_in2_data_to_the_dvb_ts_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in2_dsop_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_in2_dval_to_the_dvb_ts_0 : IN STD_LOGIC;
                    signal dvb_out_data_from_the_dvb_ts_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_out_dsop_from_the_dvb_ts_0 : OUT STD_LOGIC;
                    signal dvb_out_dval_from_the_dvb_ts_0 : OUT STD_LOGIC;
                    signal interrupt_from_the_dvb_ts_0 : OUT STD_LOGIC;

                 -- the_dvb_ts_1
                    signal cam_baseclk_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal cam_bypass_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal cam_mclki_from_the_dvb_ts_1 : OUT STD_LOGIC;
                    signal cam_mclko_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal cam_mdi_from_the_dvb_ts_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mdo_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cam_mistrt_from_the_dvb_ts_1 : OUT STD_LOGIC;
                    signal cam_mival_from_the_dvb_ts_1 : OUT STD_LOGIC;
                    signal cam_mostrt_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal cam_moval_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_in0_data_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in0_dsop_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_in0_dval_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_in1_data_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in1_dsop_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_in1_dval_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_in2_data_to_the_dvb_ts_1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_in2_dsop_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_in2_dval_to_the_dvb_ts_1 : IN STD_LOGIC;
                    signal dvb_out_data_from_the_dvb_ts_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal dvb_out_dsop_from_the_dvb_ts_1 : OUT STD_LOGIC;
                    signal dvb_out_dval_from_the_dvb_ts_1 : OUT STD_LOGIC;
                    signal interrupt_from_the_dvb_ts_1 : OUT STD_LOGIC;

                 -- the_fifo_in_8b_sync_0
                    signal irq_from_the_fifo_in_8b_sync_0 : OUT STD_LOGIC;

                 -- the_fifo_in_8b_sync_1
                    signal irq_from_the_fifo_in_8b_sync_1 : OUT STD_LOGIC;

                 -- the_fifo_out_8b_sync_0
                    signal irq_from_the_fifo_out_8b_sync_0 : OUT STD_LOGIC;

                 -- the_fifo_out_8b_sync_1
                    signal irq_from_the_fifo_out_8b_sync_1 : OUT STD_LOGIC;

                 -- the_gpout_0
                    signal pins_from_the_gpout_0 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_int_ctrl_0
                    signal avlm_irq_to_the_int_ctrl_0 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_pcie_compiler_0
                    signal busy_altgxb_reconfig_pcie_compiler_0 : IN STD_LOGIC;
                    signal clk125_out_pcie_compiler_0 : OUT STD_LOGIC;
                    signal clk250_out_pcie_compiler_0 : OUT STD_LOGIC;
                    signal clk500_out_pcie_compiler_0 : OUT STD_LOGIC;
                    signal fixedclk_serdes_pcie_compiler_0 : IN STD_LOGIC;
                    signal gxb_powerdown_pcie_compiler_0 : IN STD_LOGIC;
                    signal pcie_rstn_pcie_compiler_0 : IN STD_LOGIC;
                    signal phystatus_ext_pcie_compiler_0 : IN STD_LOGIC;
                    signal pipe_mode_pcie_compiler_0 : IN STD_LOGIC;
                    signal pll_powerdown_pcie_compiler_0 : IN STD_LOGIC;
                    signal powerdown_ext_pcie_compiler_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal rate_ext_pcie_compiler_0 : OUT STD_LOGIC;
                    signal reconfig_clk_pcie_compiler_0 : IN STD_LOGIC;
                    signal reconfig_fromgxb_pcie_compiler_0 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal reconfig_togxb_pcie_compiler_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal refclk_pcie_compiler_0 : IN STD_LOGIC;
                    signal rx_in0_pcie_compiler_0 : IN STD_LOGIC;
                    signal rxdata0_ext_pcie_compiler_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rxdatak0_ext_pcie_compiler_0 : IN STD_LOGIC;
                    signal rxelecidle0_ext_pcie_compiler_0 : IN STD_LOGIC;
                    signal rxpolarity0_ext_pcie_compiler_0 : OUT STD_LOGIC;
                    signal rxstatus0_ext_pcie_compiler_0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal rxvalid0_ext_pcie_compiler_0 : IN STD_LOGIC;
                    signal test_in_pcie_compiler_0 : IN STD_LOGIC_VECTOR (39 DOWNTO 0);
                    signal tx_out0_pcie_compiler_0 : OUT STD_LOGIC;
                    signal txcompl0_ext_pcie_compiler_0 : OUT STD_LOGIC;
                    signal txdata0_ext_pcie_compiler_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal txdatak0_ext_pcie_compiler_0 : OUT STD_LOGIC;
                    signal txdetectrx_ext_pcie_compiler_0 : OUT STD_LOGIC;
                    signal txelecidle0_ext_pcie_compiler_0 : OUT STD_LOGIC;

                 -- the_spi_master_0
                    signal cs_n_from_the_spi_master_0 : OUT STD_LOGIC;
                    signal irq_from_the_spi_master_0 : OUT STD_LOGIC;
                    signal miso_to_the_spi_master_0 : IN STD_LOGIC;
                    signal mosi_from_the_spi_master_0 : OUT STD_LOGIC;
                    signal sclk_from_the_spi_master_0 : OUT STD_LOGIC;

                 -- the_twi_master_0
                    signal irq_from_the_twi_master_0 : OUT STD_LOGIC;
                    signal scl_act_from_the_twi_master_0 : OUT STD_LOGIC;
                    signal scl_in_to_the_twi_master_0 : IN STD_LOGIC;
                    signal sda_act_from_the_twi_master_0 : OUT STD_LOGIC;
                    signal sda_in_to_the_twi_master_0 : IN STD_LOGIC;
                    signal sink_irq_to_the_twi_master_0 : IN STD_LOGIC;
                    signal source_irq_to_the_twi_master_0 : IN STD_LOGIC;

                 -- the_twi_master_1
                    signal irq_from_the_twi_master_1 : OUT STD_LOGIC;
                    signal scl_act_from_the_twi_master_1 : OUT STD_LOGIC;
                    signal scl_in_to_the_twi_master_1 : IN STD_LOGIC;
                    signal sda_act_from_the_twi_master_1 : OUT STD_LOGIC;
                    signal sda_in_to_the_twi_master_1 : IN STD_LOGIC;
                    signal sink_irq_to_the_twi_master_1 : IN STD_LOGIC;
                    signal source_irq_to_the_twi_master_1 : IN STD_LOGIC
                 );
end component unici_core;

component pcie_compiler_0_testbench is 
           port (
                 -- inputs:
                    signal clk125_out : IN STD_LOGIC;
                    signal clk250_out : IN STD_LOGIC;
                    signal clk500_out : IN STD_LOGIC;
                    signal powerdown_ext : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal rate_ext : IN STD_LOGIC;
                    signal reconfig_fromgxb : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal rxpolarity0_ext : IN STD_LOGIC;
                    signal tx_out0 : IN STD_LOGIC;
                    signal txcompl0_ext : IN STD_LOGIC;
                    signal txdata0_ext : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal txdatak0_ext : IN STD_LOGIC;
                    signal txdetectrx_ext : IN STD_LOGIC;
                    signal txelecidle0_ext : IN STD_LOGIC;

                 -- outputs:
                    signal busy_altgxb_reconfig : OUT STD_LOGIC;
                    signal fixedclk_serdes : OUT STD_LOGIC;
                    signal gxb_powerdown : OUT STD_LOGIC;
                    signal pcie_rstn : OUT STD_LOGIC;
                    signal phystatus_ext : OUT STD_LOGIC;
                    signal pipe_mode : OUT STD_LOGIC;
                    signal pll_powerdown : OUT STD_LOGIC;
                    signal reconfig_clk : OUT STD_LOGIC;
                    signal reconfig_togxb : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal refclk : OUT STD_LOGIC;
                    signal rx_in0 : OUT STD_LOGIC;
                    signal rxdata0_ext : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rxdatak0_ext : OUT STD_LOGIC;
                    signal rxelecidle0_ext : OUT STD_LOGIC;
                    signal rxstatus0_ext : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal rxvalid0_ext : OUT STD_LOGIC;
                    signal test_in : OUT STD_LOGIC_VECTOR (39 DOWNTO 0)
                 );
end component pcie_compiler_0_testbench;

                signal avlm_irq_to_the_int_ctrl_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal busy_altgxb_reconfig_pcie_compiler_0 :  STD_LOGIC;
                signal cam0_bypass_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam0_fail_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam0_ready_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam1_bypass_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam1_fail_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam1_ready_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam_address_to_the_ci_bridge_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal cam_baseclk_to_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_baseclk_to_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_bypass_to_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_bypass_to_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_interrupts_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cam_mclki_from_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_mclki_from_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_mclko_to_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_mclko_to_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_mdi_from_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cam_mdi_from_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cam_mdo_to_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cam_mdo_to_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cam_mistrt_from_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_mistrt_from_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_mival_from_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_mival_from_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_mostrt_to_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_mostrt_to_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_moval_to_the_dvb_ts_0 :  STD_LOGIC;
                signal cam_moval_to_the_dvb_ts_1 :  STD_LOGIC;
                signal cam_read_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cam_readdata_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cam_waitreq_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cam_write_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cam_writedata_to_the_ci_bridge_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal ci_a_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (14 DOWNTO 0);
                signal ci_bus_dir_from_the_ci_bridge_0 :  STD_LOGIC;
                signal ci_d_en_from_the_ci_bridge_0 :  STD_LOGIC;
                signal ci_d_in_to_the_ci_bridge_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal ci_d_out_from_the_ci_bridge_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal ci_iord_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal ci_iowr_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal ci_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal ci_reg_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal ci_we_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_cd_n_to_the_ci_bridge_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cia_ce_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_data_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_ireq_n_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_overcurrent_n_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_reset_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_reset_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cia_wait_n_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_cd_n_to_the_ci_bridge_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cib_ce_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_data_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_ireq_n_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_overcurrent_n_to_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_reset_buf_oe_n_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_reset_from_the_ci_bridge_0 :  STD_LOGIC;
                signal cib_wait_n_to_the_ci_bridge_0 :  STD_LOGIC;
                signal clk :  STD_LOGIC;
                signal clk125_out_pcie_compiler_0 :  STD_LOGIC;
                signal clk250_out_pcie_compiler_0 :  STD_LOGIC;
                signal clk500_out_pcie_compiler_0 :  STD_LOGIC;
                signal cs_n_from_the_spi_master_0 :  STD_LOGIC;
                signal dma0_addr_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (60 DOWNTO 0);
                signal dma0_byteen_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dma0_size_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal dma0_wait_from_the_dma_arbiter_0 :  STD_LOGIC;
                signal dma0_wrdata_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal dma0_write_to_the_dma_arbiter_0 :  STD_LOGIC;
                signal dma1_addr_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (60 DOWNTO 0);
                signal dma1_byteen_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dma1_size_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal dma1_wait_from_the_dma_arbiter_0 :  STD_LOGIC;
                signal dma1_wrdata_to_the_dma_arbiter_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal dma1_write_to_the_dma_arbiter_0 :  STD_LOGIC;
                signal dvb_data_to_the_dvb_dma_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_data_to_the_dvb_dma_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_dval_to_the_dvb_dma_0 :  STD_LOGIC;
                signal dvb_dval_to_the_dvb_dma_1 :  STD_LOGIC;
                signal dvb_in0_data_to_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_in0_data_to_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_in0_dsop_to_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_in0_dsop_to_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_in0_dval_to_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_in0_dval_to_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_in1_data_to_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_in1_data_to_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_in1_dsop_to_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_in1_dsop_to_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_in1_dval_to_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_in1_dval_to_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_in2_data_to_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_in2_data_to_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_in2_dsop_to_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_in2_dsop_to_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_in2_dval_to_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_in2_dval_to_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_out_data_from_the_dvb_ts_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_out_data_from_the_dvb_ts_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dvb_out_dsop_from_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_out_dsop_from_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_out_dval_from_the_dvb_ts_0 :  STD_LOGIC;
                signal dvb_out_dval_from_the_dvb_ts_1 :  STD_LOGIC;
                signal dvb_sop_to_the_dvb_dma_0 :  STD_LOGIC;
                signal dvb_sop_to_the_dvb_dma_1 :  STD_LOGIC;
                signal fixedclk_serdes_pcie_compiler_0 :  STD_LOGIC;
                signal gxb_powerdown_pcie_compiler_0 :  STD_LOGIC;
                signal int_ctrl_0_avalon_slave_irq :  STD_LOGIC;
                signal interrupt_from_the_ci_bridge_0 :  STD_LOGIC;
                signal interrupt_from_the_dvb_dma_0 :  STD_LOGIC;
                signal interrupt_from_the_dvb_dma_1 :  STD_LOGIC;
                signal interrupt_from_the_dvb_ts_0 :  STD_LOGIC;
                signal interrupt_from_the_dvb_ts_1 :  STD_LOGIC;
                signal irq_from_the_fifo_in_8b_sync_0 :  STD_LOGIC;
                signal irq_from_the_fifo_in_8b_sync_1 :  STD_LOGIC;
                signal irq_from_the_fifo_out_8b_sync_0 :  STD_LOGIC;
                signal irq_from_the_fifo_out_8b_sync_1 :  STD_LOGIC;
                signal irq_from_the_spi_master_0 :  STD_LOGIC;
                signal irq_from_the_twi_master_0 :  STD_LOGIC;
                signal irq_from_the_twi_master_1 :  STD_LOGIC;
                signal mem_addr_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (60 DOWNTO 0);
                signal mem_addr_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (60 DOWNTO 0);
                signal mem_byteen_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal mem_byteen_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal mem_size_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal mem_size_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal mem_waitreq_to_the_dvb_dma_0 :  STD_LOGIC;
                signal mem_waitreq_to_the_dvb_dma_1 :  STD_LOGIC;
                signal mem_wrdata_from_the_dvb_dma_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal mem_wrdata_from_the_dvb_dma_1 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal mem_write_from_the_dvb_dma_0 :  STD_LOGIC;
                signal mem_write_from_the_dvb_dma_1 :  STD_LOGIC;
                signal miso_to_the_spi_master_0 :  STD_LOGIC;
                signal mosi_from_the_spi_master_0 :  STD_LOGIC;
                signal out_address_from_the_avalon64_to_avalon8_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal out_read_from_the_avalon64_to_avalon8_0 :  STD_LOGIC;
                signal out_readdata_to_the_avalon64_to_avalon8_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal out_waitrequest_to_the_avalon64_to_avalon8_0 :  STD_LOGIC;
                signal out_write_from_the_avalon64_to_avalon8_0 :  STD_LOGIC;
                signal out_writedata_from_the_avalon64_to_avalon8_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pcie_compiler_0_Control_Register_Access_irq :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_irq :  STD_LOGIC;
                signal pcie_compiler_0_Rx_Interface_irqnumber :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_readdata_from_sa :  STD_LOGIC_VECTOR (63 DOWNTO 0);
                signal pcie_compiler_0_Tx_Interface_readdatavalid_from_sa :  STD_LOGIC;
                signal pcie_compiler_0_pcie_core_clk_out :  STD_LOGIC;
                signal pcie_rstn_pcie_compiler_0 :  STD_LOGIC;
                signal phystatus_ext_pcie_compiler_0 :  STD_LOGIC;
                signal pins_from_the_gpout_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pipe_mode_pcie_compiler_0 :  STD_LOGIC;
                signal pipeline_bridge_0_m1_debugaccess :  STD_LOGIC;
                signal pipeline_bridge_0_m1_endofpacket :  STD_LOGIC;
                signal pipeline_bridge_0_s1_endofpacket_from_sa :  STD_LOGIC;
                signal pll_powerdown_pcie_compiler_0 :  STD_LOGIC;
                signal powerdown_ext_pcie_compiler_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal rate_ext_pcie_compiler_0 :  STD_LOGIC;
                signal reconfig_clk_pcie_compiler_0 :  STD_LOGIC;
                signal reconfig_fromgxb_pcie_compiler_0 :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal reconfig_togxb_pcie_compiler_0 :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal refclk_pcie_compiler_0 :  STD_LOGIC;
                signal reset_n :  STD_LOGIC;
                signal rx_in0_pcie_compiler_0 :  STD_LOGIC;
                signal rxdata0_ext_pcie_compiler_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal rxdatak0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal rxelecidle0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal rxpolarity0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal rxstatus0_ext_pcie_compiler_0 :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal rxvalid0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal scl_act_from_the_twi_master_0 :  STD_LOGIC;
                signal scl_act_from_the_twi_master_1 :  STD_LOGIC;
                signal scl_in_to_the_twi_master_0 :  STD_LOGIC;
                signal scl_in_to_the_twi_master_1 :  STD_LOGIC;
                signal sclk_from_the_spi_master_0 :  STD_LOGIC;
                signal sda_act_from_the_twi_master_0 :  STD_LOGIC;
                signal sda_act_from_the_twi_master_1 :  STD_LOGIC;
                signal sda_in_to_the_twi_master_0 :  STD_LOGIC;
                signal sda_in_to_the_twi_master_1 :  STD_LOGIC;
                signal sink_irq_to_the_twi_master_0 :  STD_LOGIC;
                signal sink_irq_to_the_twi_master_1 :  STD_LOGIC;
                signal source_irq_to_the_twi_master_0 :  STD_LOGIC;
                signal source_irq_to_the_twi_master_1 :  STD_LOGIC;
                signal test_in_pcie_compiler_0 :  STD_LOGIC_VECTOR (39 DOWNTO 0);
                signal tx_out0_pcie_compiler_0 :  STD_LOGIC;
                signal txcompl0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal txdata0_ext_pcie_compiler_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal txdatak0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal txdetectrx_ext_pcie_compiler_0 :  STD_LOGIC;
                signal txelecidle0_ext_pcie_compiler_0 :  STD_LOGIC;
                signal unici_core_burst_1_downstream_debugaccess :  STD_LOGIC;
                signal unici_core_burst_1_downstream_nativeaddress :  STD_LOGIC_VECTOR (17 DOWNTO 0);


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : unici_core
    port map(
      cam0_bypass_from_the_ci_bridge_0 => cam0_bypass_from_the_ci_bridge_0,
      cam0_fail_from_the_ci_bridge_0 => cam0_fail_from_the_ci_bridge_0,
      cam0_ready_from_the_ci_bridge_0 => cam0_ready_from_the_ci_bridge_0,
      cam1_bypass_from_the_ci_bridge_0 => cam1_bypass_from_the_ci_bridge_0,
      cam1_fail_from_the_ci_bridge_0 => cam1_fail_from_the_ci_bridge_0,
      cam1_ready_from_the_ci_bridge_0 => cam1_ready_from_the_ci_bridge_0,
      cam_interrupts_from_the_ci_bridge_0 => cam_interrupts_from_the_ci_bridge_0,
      cam_mclki_from_the_dvb_ts_0 => cam_mclki_from_the_dvb_ts_0,
      cam_mclki_from_the_dvb_ts_1 => cam_mclki_from_the_dvb_ts_1,
      cam_mdi_from_the_dvb_ts_0 => cam_mdi_from_the_dvb_ts_0,
      cam_mdi_from_the_dvb_ts_1 => cam_mdi_from_the_dvb_ts_1,
      cam_mistrt_from_the_dvb_ts_0 => cam_mistrt_from_the_dvb_ts_0,
      cam_mistrt_from_the_dvb_ts_1 => cam_mistrt_from_the_dvb_ts_1,
      cam_mival_from_the_dvb_ts_0 => cam_mival_from_the_dvb_ts_0,
      cam_mival_from_the_dvb_ts_1 => cam_mival_from_the_dvb_ts_1,
      cam_readdata_from_the_ci_bridge_0 => cam_readdata_from_the_ci_bridge_0,
      cam_waitreq_from_the_ci_bridge_0 => cam_waitreq_from_the_ci_bridge_0,
      ci_a_from_the_ci_bridge_0 => ci_a_from_the_ci_bridge_0,
      ci_bus_dir_from_the_ci_bridge_0 => ci_bus_dir_from_the_ci_bridge_0,
      ci_d_en_from_the_ci_bridge_0 => ci_d_en_from_the_ci_bridge_0,
      ci_d_out_from_the_ci_bridge_0 => ci_d_out_from_the_ci_bridge_0,
      ci_iord_n_from_the_ci_bridge_0 => ci_iord_n_from_the_ci_bridge_0,
      ci_iowr_n_from_the_ci_bridge_0 => ci_iowr_n_from_the_ci_bridge_0,
      ci_oe_n_from_the_ci_bridge_0 => ci_oe_n_from_the_ci_bridge_0,
      ci_reg_n_from_the_ci_bridge_0 => ci_reg_n_from_the_ci_bridge_0,
      ci_we_n_from_the_ci_bridge_0 => ci_we_n_from_the_ci_bridge_0,
      cia_ce_n_from_the_ci_bridge_0 => cia_ce_n_from_the_ci_bridge_0,
      cia_data_buf_oe_n_from_the_ci_bridge_0 => cia_data_buf_oe_n_from_the_ci_bridge_0,
      cia_reset_buf_oe_n_from_the_ci_bridge_0 => cia_reset_buf_oe_n_from_the_ci_bridge_0,
      cia_reset_from_the_ci_bridge_0 => cia_reset_from_the_ci_bridge_0,
      cib_ce_n_from_the_ci_bridge_0 => cib_ce_n_from_the_ci_bridge_0,
      cib_data_buf_oe_n_from_the_ci_bridge_0 => cib_data_buf_oe_n_from_the_ci_bridge_0,
      cib_reset_buf_oe_n_from_the_ci_bridge_0 => cib_reset_buf_oe_n_from_the_ci_bridge_0,
      cib_reset_from_the_ci_bridge_0 => cib_reset_from_the_ci_bridge_0,
      clk125_out_pcie_compiler_0 => clk125_out_pcie_compiler_0,
      clk250_out_pcie_compiler_0 => clk250_out_pcie_compiler_0,
      clk500_out_pcie_compiler_0 => clk500_out_pcie_compiler_0,
      cs_n_from_the_spi_master_0 => cs_n_from_the_spi_master_0,
      dma0_wait_from_the_dma_arbiter_0 => dma0_wait_from_the_dma_arbiter_0,
      dma1_wait_from_the_dma_arbiter_0 => dma1_wait_from_the_dma_arbiter_0,
      dvb_out_data_from_the_dvb_ts_0 => dvb_out_data_from_the_dvb_ts_0,
      dvb_out_data_from_the_dvb_ts_1 => dvb_out_data_from_the_dvb_ts_1,
      dvb_out_dsop_from_the_dvb_ts_0 => dvb_out_dsop_from_the_dvb_ts_0,
      dvb_out_dsop_from_the_dvb_ts_1 => dvb_out_dsop_from_the_dvb_ts_1,
      dvb_out_dval_from_the_dvb_ts_0 => dvb_out_dval_from_the_dvb_ts_0,
      dvb_out_dval_from_the_dvb_ts_1 => dvb_out_dval_from_the_dvb_ts_1,
      interrupt_from_the_ci_bridge_0 => interrupt_from_the_ci_bridge_0,
      interrupt_from_the_dvb_dma_0 => interrupt_from_the_dvb_dma_0,
      interrupt_from_the_dvb_dma_1 => interrupt_from_the_dvb_dma_1,
      interrupt_from_the_dvb_ts_0 => interrupt_from_the_dvb_ts_0,
      interrupt_from_the_dvb_ts_1 => interrupt_from_the_dvb_ts_1,
      irq_from_the_fifo_in_8b_sync_0 => irq_from_the_fifo_in_8b_sync_0,
      irq_from_the_fifo_in_8b_sync_1 => irq_from_the_fifo_in_8b_sync_1,
      irq_from_the_fifo_out_8b_sync_0 => irq_from_the_fifo_out_8b_sync_0,
      irq_from_the_fifo_out_8b_sync_1 => irq_from_the_fifo_out_8b_sync_1,
      irq_from_the_spi_master_0 => irq_from_the_spi_master_0,
      irq_from_the_twi_master_0 => irq_from_the_twi_master_0,
      irq_from_the_twi_master_1 => irq_from_the_twi_master_1,
      mem_addr_from_the_dvb_dma_0 => mem_addr_from_the_dvb_dma_0,
      mem_addr_from_the_dvb_dma_1 => mem_addr_from_the_dvb_dma_1,
      mem_byteen_from_the_dvb_dma_0 => mem_byteen_from_the_dvb_dma_0,
      mem_byteen_from_the_dvb_dma_1 => mem_byteen_from_the_dvb_dma_1,
      mem_size_from_the_dvb_dma_0 => mem_size_from_the_dvb_dma_0,
      mem_size_from_the_dvb_dma_1 => mem_size_from_the_dvb_dma_1,
      mem_wrdata_from_the_dvb_dma_0 => mem_wrdata_from_the_dvb_dma_0,
      mem_wrdata_from_the_dvb_dma_1 => mem_wrdata_from_the_dvb_dma_1,
      mem_write_from_the_dvb_dma_0 => mem_write_from_the_dvb_dma_0,
      mem_write_from_the_dvb_dma_1 => mem_write_from_the_dvb_dma_1,
      mosi_from_the_spi_master_0 => mosi_from_the_spi_master_0,
      out_address_from_the_avalon64_to_avalon8_0 => out_address_from_the_avalon64_to_avalon8_0,
      out_read_from_the_avalon64_to_avalon8_0 => out_read_from_the_avalon64_to_avalon8_0,
      out_write_from_the_avalon64_to_avalon8_0 => out_write_from_the_avalon64_to_avalon8_0,
      out_writedata_from_the_avalon64_to_avalon8_0 => out_writedata_from_the_avalon64_to_avalon8_0,
      pcie_compiler_0_pcie_core_clk_out => pcie_compiler_0_pcie_core_clk_out,
      pins_from_the_gpout_0 => pins_from_the_gpout_0,
      powerdown_ext_pcie_compiler_0 => powerdown_ext_pcie_compiler_0,
      rate_ext_pcie_compiler_0 => rate_ext_pcie_compiler_0,
      reconfig_fromgxb_pcie_compiler_0 => reconfig_fromgxb_pcie_compiler_0,
      rxpolarity0_ext_pcie_compiler_0 => rxpolarity0_ext_pcie_compiler_0,
      scl_act_from_the_twi_master_0 => scl_act_from_the_twi_master_0,
      scl_act_from_the_twi_master_1 => scl_act_from_the_twi_master_1,
      sclk_from_the_spi_master_0 => sclk_from_the_spi_master_0,
      sda_act_from_the_twi_master_0 => sda_act_from_the_twi_master_0,
      sda_act_from_the_twi_master_1 => sda_act_from_the_twi_master_1,
      tx_out0_pcie_compiler_0 => tx_out0_pcie_compiler_0,
      txcompl0_ext_pcie_compiler_0 => txcompl0_ext_pcie_compiler_0,
      txdata0_ext_pcie_compiler_0 => txdata0_ext_pcie_compiler_0,
      txdatak0_ext_pcie_compiler_0 => txdatak0_ext_pcie_compiler_0,
      txdetectrx_ext_pcie_compiler_0 => txdetectrx_ext_pcie_compiler_0,
      txelecidle0_ext_pcie_compiler_0 => txelecidle0_ext_pcie_compiler_0,
      avlm_irq_to_the_int_ctrl_0 => avlm_irq_to_the_int_ctrl_0,
      busy_altgxb_reconfig_pcie_compiler_0 => busy_altgxb_reconfig_pcie_compiler_0,
      cam_address_to_the_ci_bridge_0 => cam_address_to_the_ci_bridge_0,
      cam_baseclk_to_the_dvb_ts_0 => cam_baseclk_to_the_dvb_ts_0,
      cam_baseclk_to_the_dvb_ts_1 => cam_baseclk_to_the_dvb_ts_1,
      cam_bypass_to_the_dvb_ts_0 => cam_bypass_to_the_dvb_ts_0,
      cam_bypass_to_the_dvb_ts_1 => cam_bypass_to_the_dvb_ts_1,
      cam_mclko_to_the_dvb_ts_0 => cam_mclko_to_the_dvb_ts_0,
      cam_mclko_to_the_dvb_ts_1 => cam_mclko_to_the_dvb_ts_1,
      cam_mdo_to_the_dvb_ts_0 => cam_mdo_to_the_dvb_ts_0,
      cam_mdo_to_the_dvb_ts_1 => cam_mdo_to_the_dvb_ts_1,
      cam_mostrt_to_the_dvb_ts_0 => cam_mostrt_to_the_dvb_ts_0,
      cam_mostrt_to_the_dvb_ts_1 => cam_mostrt_to_the_dvb_ts_1,
      cam_moval_to_the_dvb_ts_0 => cam_moval_to_the_dvb_ts_0,
      cam_moval_to_the_dvb_ts_1 => cam_moval_to_the_dvb_ts_1,
      cam_read_to_the_ci_bridge_0 => cam_read_to_the_ci_bridge_0,
      cam_write_to_the_ci_bridge_0 => cam_write_to_the_ci_bridge_0,
      cam_writedata_to_the_ci_bridge_0 => cam_writedata_to_the_ci_bridge_0,
      ci_d_in_to_the_ci_bridge_0 => ci_d_in_to_the_ci_bridge_0,
      cia_cd_n_to_the_ci_bridge_0 => cia_cd_n_to_the_ci_bridge_0,
      cia_ireq_n_to_the_ci_bridge_0 => cia_ireq_n_to_the_ci_bridge_0,
      cia_overcurrent_n_to_the_ci_bridge_0 => cia_overcurrent_n_to_the_ci_bridge_0,
      cia_wait_n_to_the_ci_bridge_0 => cia_wait_n_to_the_ci_bridge_0,
      cib_cd_n_to_the_ci_bridge_0 => cib_cd_n_to_the_ci_bridge_0,
      cib_ireq_n_to_the_ci_bridge_0 => cib_ireq_n_to_the_ci_bridge_0,
      cib_overcurrent_n_to_the_ci_bridge_0 => cib_overcurrent_n_to_the_ci_bridge_0,
      cib_wait_n_to_the_ci_bridge_0 => cib_wait_n_to_the_ci_bridge_0,
      dma0_addr_to_the_dma_arbiter_0 => dma0_addr_to_the_dma_arbiter_0,
      dma0_byteen_to_the_dma_arbiter_0 => dma0_byteen_to_the_dma_arbiter_0,
      dma0_size_to_the_dma_arbiter_0 => dma0_size_to_the_dma_arbiter_0,
      dma0_wrdata_to_the_dma_arbiter_0 => dma0_wrdata_to_the_dma_arbiter_0,
      dma0_write_to_the_dma_arbiter_0 => dma0_write_to_the_dma_arbiter_0,
      dma1_addr_to_the_dma_arbiter_0 => dma1_addr_to_the_dma_arbiter_0,
      dma1_byteen_to_the_dma_arbiter_0 => dma1_byteen_to_the_dma_arbiter_0,
      dma1_size_to_the_dma_arbiter_0 => dma1_size_to_the_dma_arbiter_0,
      dma1_wrdata_to_the_dma_arbiter_0 => dma1_wrdata_to_the_dma_arbiter_0,
      dma1_write_to_the_dma_arbiter_0 => dma1_write_to_the_dma_arbiter_0,
      dvb_data_to_the_dvb_dma_0 => dvb_data_to_the_dvb_dma_0,
      dvb_data_to_the_dvb_dma_1 => dvb_data_to_the_dvb_dma_1,
      dvb_dval_to_the_dvb_dma_0 => dvb_dval_to_the_dvb_dma_0,
      dvb_dval_to_the_dvb_dma_1 => dvb_dval_to_the_dvb_dma_1,
      dvb_in0_data_to_the_dvb_ts_0 => dvb_in0_data_to_the_dvb_ts_0,
      dvb_in0_data_to_the_dvb_ts_1 => dvb_in0_data_to_the_dvb_ts_1,
      dvb_in0_dsop_to_the_dvb_ts_0 => dvb_in0_dsop_to_the_dvb_ts_0,
      dvb_in0_dsop_to_the_dvb_ts_1 => dvb_in0_dsop_to_the_dvb_ts_1,
      dvb_in0_dval_to_the_dvb_ts_0 => dvb_in0_dval_to_the_dvb_ts_0,
      dvb_in0_dval_to_the_dvb_ts_1 => dvb_in0_dval_to_the_dvb_ts_1,
      dvb_in1_data_to_the_dvb_ts_0 => dvb_in1_data_to_the_dvb_ts_0,
      dvb_in1_data_to_the_dvb_ts_1 => dvb_in1_data_to_the_dvb_ts_1,
      dvb_in1_dsop_to_the_dvb_ts_0 => dvb_in1_dsop_to_the_dvb_ts_0,
      dvb_in1_dsop_to_the_dvb_ts_1 => dvb_in1_dsop_to_the_dvb_ts_1,
      dvb_in1_dval_to_the_dvb_ts_0 => dvb_in1_dval_to_the_dvb_ts_0,
      dvb_in1_dval_to_the_dvb_ts_1 => dvb_in1_dval_to_the_dvb_ts_1,
      dvb_in2_data_to_the_dvb_ts_0 => dvb_in2_data_to_the_dvb_ts_0,
      dvb_in2_data_to_the_dvb_ts_1 => dvb_in2_data_to_the_dvb_ts_1,
      dvb_in2_dsop_to_the_dvb_ts_0 => dvb_in2_dsop_to_the_dvb_ts_0,
      dvb_in2_dsop_to_the_dvb_ts_1 => dvb_in2_dsop_to_the_dvb_ts_1,
      dvb_in2_dval_to_the_dvb_ts_0 => dvb_in2_dval_to_the_dvb_ts_0,
      dvb_in2_dval_to_the_dvb_ts_1 => dvb_in2_dval_to_the_dvb_ts_1,
      dvb_sop_to_the_dvb_dma_0 => dvb_sop_to_the_dvb_dma_0,
      dvb_sop_to_the_dvb_dma_1 => dvb_sop_to_the_dvb_dma_1,
      fixedclk_serdes_pcie_compiler_0 => fixedclk_serdes_pcie_compiler_0,
      gxb_powerdown_pcie_compiler_0 => gxb_powerdown_pcie_compiler_0,
      mem_waitreq_to_the_dvb_dma_0 => mem_waitreq_to_the_dvb_dma_0,
      mem_waitreq_to_the_dvb_dma_1 => mem_waitreq_to_the_dvb_dma_1,
      miso_to_the_spi_master_0 => miso_to_the_spi_master_0,
      out_readdata_to_the_avalon64_to_avalon8_0 => out_readdata_to_the_avalon64_to_avalon8_0,
      out_waitrequest_to_the_avalon64_to_avalon8_0 => out_waitrequest_to_the_avalon64_to_avalon8_0,
      pcie_rstn_pcie_compiler_0 => pcie_rstn_pcie_compiler_0,
      phystatus_ext_pcie_compiler_0 => phystatus_ext_pcie_compiler_0,
      pipe_mode_pcie_compiler_0 => pipe_mode_pcie_compiler_0,
      pll_powerdown_pcie_compiler_0 => pll_powerdown_pcie_compiler_0,
      reconfig_clk_pcie_compiler_0 => reconfig_clk_pcie_compiler_0,
      reconfig_togxb_pcie_compiler_0 => reconfig_togxb_pcie_compiler_0,
      refclk_pcie_compiler_0 => refclk_pcie_compiler_0,
      reset_n => reset_n,
      rx_in0_pcie_compiler_0 => rx_in0_pcie_compiler_0,
      rxdata0_ext_pcie_compiler_0 => rxdata0_ext_pcie_compiler_0,
      rxdatak0_ext_pcie_compiler_0 => rxdatak0_ext_pcie_compiler_0,
      rxelecidle0_ext_pcie_compiler_0 => rxelecidle0_ext_pcie_compiler_0,
      rxstatus0_ext_pcie_compiler_0 => rxstatus0_ext_pcie_compiler_0,
      rxvalid0_ext_pcie_compiler_0 => rxvalid0_ext_pcie_compiler_0,
      scl_in_to_the_twi_master_0 => scl_in_to_the_twi_master_0,
      scl_in_to_the_twi_master_1 => scl_in_to_the_twi_master_1,
      sda_in_to_the_twi_master_0 => sda_in_to_the_twi_master_0,
      sda_in_to_the_twi_master_1 => sda_in_to_the_twi_master_1,
      sink_irq_to_the_twi_master_0 => sink_irq_to_the_twi_master_0,
      sink_irq_to_the_twi_master_1 => sink_irq_to_the_twi_master_1,
      source_irq_to_the_twi_master_0 => source_irq_to_the_twi_master_0,
      source_irq_to_the_twi_master_1 => source_irq_to_the_twi_master_1,
      test_in_pcie_compiler_0 => test_in_pcie_compiler_0
    );


  --the_pcie_compiler_0_testbench, which is an e_instance
  the_pcie_compiler_0_testbench : pcie_compiler_0_testbench
    port map(
      busy_altgxb_reconfig => busy_altgxb_reconfig_pcie_compiler_0,
      fixedclk_serdes => fixedclk_serdes_pcie_compiler_0,
      gxb_powerdown => gxb_powerdown_pcie_compiler_0,
      pcie_rstn => pcie_rstn_pcie_compiler_0,
      phystatus_ext => phystatus_ext_pcie_compiler_0,
      pipe_mode => pipe_mode_pcie_compiler_0,
      pll_powerdown => pll_powerdown_pcie_compiler_0,
      reconfig_clk => reconfig_clk_pcie_compiler_0,
      reconfig_togxb => reconfig_togxb_pcie_compiler_0,
      refclk => refclk_pcie_compiler_0,
      rx_in0 => rx_in0_pcie_compiler_0,
      rxdata0_ext => rxdata0_ext_pcie_compiler_0,
      rxdatak0_ext => rxdatak0_ext_pcie_compiler_0,
      rxelecidle0_ext => rxelecidle0_ext_pcie_compiler_0,
      rxstatus0_ext => rxstatus0_ext_pcie_compiler_0,
      rxvalid0_ext => rxvalid0_ext_pcie_compiler_0,
      test_in => test_in_pcie_compiler_0,
      clk125_out => clk125_out_pcie_compiler_0,
      clk250_out => clk250_out_pcie_compiler_0,
      clk500_out => clk500_out_pcie_compiler_0,
      powerdown_ext => powerdown_ext_pcie_compiler_0,
      rate_ext => rate_ext_pcie_compiler_0,
      reconfig_fromgxb => reconfig_fromgxb_pcie_compiler_0,
      rxpolarity0_ext => rxpolarity0_ext_pcie_compiler_0,
      tx_out0 => tx_out0_pcie_compiler_0,
      txcompl0_ext => txcompl0_ext_pcie_compiler_0,
      txdata0_ext => txdata0_ext_pcie_compiler_0,
      txdatak0_ext => txdatak0_ext_pcie_compiler_0,
      txdetectrx_ext => txdetectrx_ext_pcie_compiler_0,
      txelecidle0_ext => txelecidle0_ext_pcie_compiler_0
    );


  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
