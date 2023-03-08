-------------------------------------------------------------------------------
-- Title      : Traffic Monitor for Router CC
-- Project    : Power Model
-------------------------------------------------------------------------------
-- File       : Hermes_monitorCC.vhd
-- Author     : Guilherme Guindani
-- Company    : GAPH
-- Created    : 2008-03-04
-- Last update: 2010-10-27
-- Platform   : ASIC-NOC
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Traffic Monitor for flit reception. Monitors the amount of
-- flits received in a parametrizable time window.
-- How to use: (ONLY IN THE HERMES NoC)
-- Place the monitor in the file NoC.vhd, intanciating one
-- monitor per router. Note there is a monitor architecture for
-- each Router type presented in the Hermes NoC. There are
-- some modifications to be made on the port map for the 
-- HANDSHAKE, CREDIT NO VIRTUAL CHANNELS,
-- CREDIT 2 VIRTUAL CHANNELS and CREDIT 4 VIRTUAL
-- CHANNELS respectivelly. These modfications are:
--
-- Hermes NoC HANDSHAKE:
-- The signals "clock_rx_in", "credit_o_in" and "lane_in"
-- must be set to "(others=>'0')".
--
-- Hermes NoC CREDIT NO VIRTUAL CHANNELS:
-- The signal "ack_rx_in" must be set to (others=>'0');
-- In the singal "credit_o_in" only the first bit of all positions
-- of the must be mapped, the others must be set to "(others=>'0');
-- In the signal "lane_in" the first bit of all positions must set
-- set to '1', all other bits must be set to '0'.
--
-- Hermes NoC CREDIT 2 VIRTUAL CHANNELS
-- The signal "ack_rx_in" must be set to (others=>'0');
-- In the signal "credit_o_in" only the positions 1 and 0 of the
-- array must be mapped, the others must be set to "(others=>'0')";
-- In the signal "lane_in" only the positions 1 and 0 of the array
-- must be mapped, the others must be set to "(others=>'0')".
--
-- Hermes NoC CREDIT 4 VIRTUAL CHANNELS
-- The signal "ack_rx_in" must be set to (others=>'0');
-- In the signal "credit_o_in" all positions of the array must be
-- mapped;
-- In the signal "lane_in" all positions of the array must be
-- mapped.
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2008-03-04  1.0      Guindani        Created
-- 2008-03-17  1.5      Guindani        Implemented the suggested modifications  (Moraes's Modifications)
-- 2008-04-29 1.6      Guindani        Introduced the virtual channels handling
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

use work.HermesPackage.all;
use work.MonitorPackage.all;

entity RouterCR_monitor is
  
	generic (
	time_window : std_logic_vector(11 downto 0) := x"3e8"); -- Parametrizable time window (in clock cycles)

	port (
	clock         : in  std_logic;				-- Monitor's clock
	reset         : in  std_logic;				-- Monitor's reset
	count_o_west : out std_logic_vector(15 downto 0);	-- Flit count result for west port
	count_o_north : out std_logic_vector(15 downto 0);	-- Flit count result for north port
	count_o_south : out std_logic_vector(15 downto 0);	-- Flit count result for south port
	count_o_local : out std_logic_vector(15 downto 0);	-- Flit count result for local port
    
	clock_rx_in   : in  regNport;				-- Flow control clock_rx input signal
	rx_in         : in  regNport;				-- Flow control rx input signal
	credit_o_in   : in  reg_cv;				-- Credit based credit_o input signal	                     
	lane_in       : in  reg_cv;				-- Virtual channels input signals
	ack_rx_in     : in  regNport);				-- Handshake ack_rx input signal (Must set to '0' if credit based)
    
end RouterCR_monitor;

architecture RouterCR_monitor of RouterCR_monitor is

	signal count_en_west  : std_logic := '0';		-- Enables the flit count at the west counter
	signal reg_west_D     : std_logic_vector(15 downto 0) := (others=>'0'); -- Input signal for the flit count register at the west port
	signal reg_west_Q     : std_logic_vector(15 downto 0) := (others=>'0'); -- Output signal for the flit count register at the west port
	signal count_0cv_west : std_logic := '0';		-- Virtual channel 0 count enable
	signal count_1cv_west : std_logic := '0';		-- Virtual channel 1 count enable
	signal count_2cv_west : std_logic := '0';		-- Virtual channel 2 count enable
	signal count_3cv_west : std_logic := '0';		-- Virtual channel 3 count enable
	signal count_cv_west  : std_logic := '0';		-- Virtual channels  count enable

	signal count_en_north  : std_logic := '0';		-- Enables the flit count at the north counter
	signal reg_north_D     : std_logic_vector(15 downto 0) := (others=>'0'); -- Input signal for the flit count register at the north port
	signal reg_north_Q     : std_logic_vector(15 downto 0) := (others=>'0'); -- Output signal for the flit count register at the north port
	signal count_0cv_north : std_logic := '0';		-- Virtual channel 0 count enable
	signal count_1cv_north : std_logic := '0';		-- Virtual channel 1 count enable
	signal count_2cv_north : std_logic := '0';		-- Virtual channel 2 count enable
	signal count_3cv_north : std_logic := '0';		-- Virtual channel 3 count enable
	signal count_cv_north  : std_logic := '0';		-- Virtual channels  count enable

	signal count_en_south  : std_logic := '0';		-- Enables the flit count at the south counter
	signal reg_south_D     : std_logic_vector(15 downto 0) := (others=>'0'); -- Input signal for the flit count register at the south port
	signal reg_south_Q     : std_logic_vector(15 downto 0) := (others=>'0'); -- Output signal for the flit count register at the south port
	signal count_0cv_south : std_logic := '0';		-- Virtual channel 0 count enable
	signal count_1cv_south : std_logic := '0';		-- Virtual channel 1 count enable
	signal count_2cv_south : std_logic := '0';		-- Virtual channel 2 count enable
	signal count_3cv_south : std_logic := '0';		-- Virtual channel 3 count enable
	signal count_cv_south  : std_logic := '0';		-- Virtual channels  count enable

	signal count_en_local  : std_logic := '0';		-- Enables the flit count at the local counter
	signal reg_local_D     : std_logic_vector(15 downto 0) := (others=>'0'); -- Input signal for the flit count register at the local port
	signal reg_local_Q     : std_logic_vector(15 downto 0) := (others=>'0'); -- Output signal for the flit count register at the local port
	signal count_0cv_local : std_logic := '0';		-- Virtual channel 0 count enable
	signal count_1cv_local : std_logic := '0';		-- Virtual channel 1 count enable
	signal count_2cv_local : std_logic := '0';		-- Virtual channel 2 count enable
	signal count_3cv_local : std_logic := '0';		-- Virtual channel 3 count enable
	signal count_cv_local  : std_logic := '0';		-- Virtual channels  count enable

  
	signal count_rst      : std_logic := '0';		-- Resets the flit counter in all ports
	signal reached        : std_logic := '0';		-- Signal wich informs that the time window was reached
	signal reg_save       : std_logic := '0';		-- Saves the counter output for all ports
	signal clk_count      : std_logic_vector(11 downto 0) := (others=>'0'); -- Clock counter
 
begin  -- flit_monitor

	-- Probing the virtual channels at the east port
	count_0cv_west <= (credit_o_in(1)(0) and lane_in(1)(0));
	count_1cv_west <= (credit_o_in(1)(1) and lane_in(1)(1));
	count_2cv_west <= (credit_o_in(1)(2) and lane_in(1)(2));
	count_3cv_west <= (credit_o_in(1)(3) and lane_in(1)(3));
	count_cv_west  <= (count_0cv_west or count_1cv_west or count_2cv_west or count_3cv_west);

	-- Enabling the counter at the west port
	count_en_west  <= (count_cv_west and rx_in(1) and (not clock_rx_in(1))) or ack_rx_in(1);

	-- Probing the virtual channels at the east port
	count_0cv_north <= (credit_o_in(2)(0) and lane_in(2)(0));
	count_1cv_north <= (credit_o_in(2)(1) and lane_in(2)(1));
	count_2cv_north <= (credit_o_in(2)(2) and lane_in(2)(2));
	count_3cv_north <= (credit_o_in(2)(3) and lane_in(2)(3));
	count_cv_north  <= (count_0cv_north or count_1cv_north or count_2cv_north or count_3cv_north);

	-- Enabling the counter at the north port
	count_en_north  <= (count_cv_north and rx_in(2) and (not clock_rx_in(2))) or ack_rx_in(2);

	-- Probing the virtual channels at the east port
	count_0cv_south <= (credit_o_in(3)(0) and lane_in(3)(0));
	count_1cv_south <= (credit_o_in(3)(1) and lane_in(3)(1));
	count_2cv_south <= (credit_o_in(3)(2) and lane_in(3)(2));
	count_3cv_south <= (credit_o_in(3)(3) and lane_in(3)(3));
	count_cv_south  <= (count_0cv_south or count_1cv_south or count_2cv_south or count_3cv_south);

	-- Enabling the counter at the south port
	count_en_south  <= (count_cv_south and rx_in(3) and (not clock_rx_in(3))) or ack_rx_in(3);

	-- Probing the virtual channels at the east port
	count_0cv_local <= (credit_o_in(4)(0) and lane_in(4)(0));
	count_1cv_local <= (credit_o_in(4)(1) and lane_in(4)(1));
	count_2cv_local <= (credit_o_in(4)(2) and lane_in(4)(2));
	count_3cv_local <= (credit_o_in(4)(3) and lane_in(4)(3));
	count_cv_local  <= (count_0cv_local or count_1cv_local or count_2cv_local or count_3cv_local);

	-- Enabling the counter at the local port
	count_en_local  <= (count_cv_local and rx_in(4) and (not clock_rx_in(4))) or ack_rx_in(4);


	-- Reseting the flit counter at all port
	count_rst <= reached or reset;

	-- Flit counter at west port
	COUNTER_west: entity work.reg16bit
	port map (
		ck  => count_en_west,
		rst => count_rst,
		ce  => '1',
		D   => reg_west_D,
		Q   => reg_west_Q);

	-- Increasing the count at west port
	reg_west_D <= reg_west_Q + 1;

	-- Output register at west port
	west_OUT: entity work.reg16bit
	port map (
		ck  => clock,
		rst => reset,
		ce  => reg_save,
		D   => reg_west_Q,
		Q   => count_o_west);

	-- Flit counter at north port
	COUNTER_north: entity work.reg16bit
	port map (
		ck  => count_en_north,
		rst => count_rst,
		ce  => '1',
		D   => reg_north_D,
		Q   => reg_north_Q);

	-- Increasing the count at north port
	reg_north_D <= reg_north_Q + 1;

	-- Output register at north port
	north_OUT: entity work.reg16bit
	port map (
		ck  => clock,
		rst => reset,
		ce  => reg_save,
		D   => reg_north_Q,
		Q   => count_o_north);

	-- Flit counter at south port
	COUNTER_south: entity work.reg16bit
	port map (
		ck  => count_en_south,
		rst => count_rst,
		ce  => '1',
		D   => reg_south_D,
		Q   => reg_south_Q);

	-- Increasing the count at south port
	reg_south_D <= reg_south_Q + 1;

	-- Output register at south port
	south_OUT: entity work.reg16bit
	port map (
		ck  => clock,
		rst => reset,
		ce  => reg_save,
		D   => reg_south_Q,
		Q   => count_o_south);

	-- Flit counter at local port
	COUNTER_local: entity work.reg16bit
	port map (
		ck  => count_en_local,
		rst => count_rst,
		ce  => '1',
		D   => reg_local_D,
		Q   => reg_local_Q);

	-- Increasing the count at local port
	reg_local_D <= reg_local_Q + 1;

	-- Output register at local port
	local_OUT: entity work.reg16bit
	port map (
		ck  => clock,
		rst => reset,
		ce  => reg_save,
		D   => reg_local_Q,
		Q   => count_o_local);


	-- purpose: Clock counter and time window checking
	-- type   : sequential
	-- inputs : clock, reset, clk_count
	-- outputs: reached, reg_save
	CLOCK_COUNTER: process (clock, reset, clk_count)
	begin  -- process CLOCK_COUNTER
		if reset = '1' then				-- asynchronous reset (active high)
			reg_save  <= '0';
			reached   <= '0';
			clk_count <= (others=>'0');
		elsif clock'event and clock = '1' then		-- rising clock edge
			clk_count <= clk_count + 1;
			if clk_count = time_window then
				reg_save <= '1';
				reached  <= '0';
			elsif clk_count = time_window + 1 then
				clk_count <= (others=>'0');
				reached   <= '1';
				reg_save  <= '0';
			else
				reg_save <= '0';
				reached  <= '0';        
			end if;
		end if;
	end process CLOCK_COUNTER;
  
end RouterCR_monitor;
