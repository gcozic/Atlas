library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.HermesPackage.all;

entity NOC is
port(
	clock         : in  std_logic;
	reset         : in  std_logic;
	rxLocal       : in  regNrot;
	data_inLocal  : in  arrayNrot_regflit;
	ack_rxLocal   : out regNrot;
	txLocal       : out regNrot;
	data_outLocal : out arrayNrot_regflit;
	ack_txLocal   : in  regNrot);
end NOC;

architecture NOC of NOC is

	signal rxN0000, rxN0100, rxN0200 : regNport;
	signal data_inN0000, data_inN0100, data_inN0200 : arrayNport_regflit;
	signal ack_rxN0000, ack_rxN0100, ack_rxN0200 : regNport;
	signal txN0000, txN0100, txN0200 : regNport;
	signal data_outN0000, data_outN0100, data_outN0200 : arrayNport_regflit;
	signal ack_txN0000, ack_txN0100, ack_txN0200 : regNport;
	signal rxN0001, rxN0101, rxN0201 : regNport;
	signal data_inN0001, data_inN0101, data_inN0201 : arrayNport_regflit;
	signal ack_rxN0001, ack_rxN0101, ack_rxN0201 : regNport;
	signal txN0001, txN0101, txN0201 : regNport;
	signal data_outN0001, data_outN0101, data_outN0201 : arrayNport_regflit;
	signal ack_txN0001, ack_txN0101, ack_txN0201 : regNport;
	signal rxN0002, rxN0102, rxN0202 : regNport;
	signal data_inN0002, data_inN0102, data_inN0202 : arrayNport_regflit;
	signal ack_rxN0002, ack_rxN0102, ack_rxN0202 : regNport;
	signal txN0002, txN0102, txN0202 : regNport;
	signal data_outN0002, data_outN0102, data_outN0202 : arrayNport_regflit;
	signal ack_txN0002, ack_txN0102, ack_txN0202 : regNport;
begin

	Router0000 : Entity work.RouterBL(RouterBL)
	generic map( address => ADDRESSN0000 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0000,
		data_in  => data_inN0000,
		ack_rx   => ack_rxN0000,
		tx       => txN0000,
		data_out => data_outN0000,
		ack_tx   => ack_txN0000);

	Router0100 : Entity work.RouterBC(RouterBC)
	generic map( address => ADDRESSN0100 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0100,
		data_in  => data_inN0100,
		ack_rx   => ack_rxN0100,
		tx       => txN0100,
		data_out => data_outN0100,
		ack_tx   => ack_txN0100);

	Router0200 : Entity work.RouterBR(RouterBR)
	generic map( address => ADDRESSN0200 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0200,
		data_in  => data_inN0200,
		ack_rx   => ack_rxN0200,
		tx       => txN0200,
		data_out => data_outN0200,
		ack_tx   => ack_txN0200);

	Router0001 : Entity work.RouterCL(RouterCL)
	generic map( address => ADDRESSN0001 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0001,
		data_in  => data_inN0001,
		ack_rx   => ack_rxN0001,
		tx       => txN0001,
		data_out => data_outN0001,
		ack_tx   => ack_txN0001);

	Router0101 : Entity work.RouterCC(RouterCC)
	generic map( address => ADDRESSN0101 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0101,
		data_in  => data_inN0101,
		ack_rx   => ack_rxN0101,
		tx       => txN0101,
		data_out => data_outN0101,
		ack_tx   => ack_txN0101);

	Router0201 : Entity work.RouterCR(RouterCR)
	generic map( address => ADDRESSN0201 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0201,
		data_in  => data_inN0201,
		ack_rx   => ack_rxN0201,
		tx       => txN0201,
		data_out => data_outN0201,
		ack_tx   => ack_txN0201);

	Router0002 : Entity work.RouterTL(RouterTL)
	generic map( address => ADDRESSN0002 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0002,
		data_in  => data_inN0002,
		ack_rx   => ack_rxN0002,
		tx       => txN0002,
		data_out => data_outN0002,
		ack_tx   => ack_txN0002);

	Router0102 : Entity work.RouterTC(RouterTC)
	generic map( address => ADDRESSN0102 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0102,
		data_in  => data_inN0102,
		ack_rx   => ack_rxN0102,
		tx       => txN0102,
		data_out => data_outN0102,
		ack_tx   => ack_txN0102);

	Router0202 : Entity work.RouterTR(RouterTR)
	generic map( address => ADDRESSN0202 )
	port map(
		clock    => clock,
		reset    => reset,
		rx       => rxN0202,
		data_in  => data_inN0202,
		ack_rx   => ack_rxN0202,
		tx       => txN0202,
		data_out => data_outN0202,
		ack_tx   => ack_txN0202);

	-- ROUTER 0000
	-- EAST port
	data_inN0000(0)<=data_outN0100(1);
	rxN0000(0)<=txN0100(1);
	ack_txN0000(0)<=ack_rxN0100(1);
	-- WEST port
	data_inN0000(1)<=(others=>'0');
	rxN0000(1)<='0';
	ack_txN0000(1)<='0';
	-- NORTH port
	data_inN0000(2)<=data_outN0001(3);
	rxN0000(2)<=txN0001(3);
	ack_txN0000(2)<=ack_rxN0001(3);
	-- SOUTH port
	data_inN0000(3)<=(others=>'0');
	rxN0000(3)<='0';
	ack_txN0000(3)<='0';
	-- LOCAL port
	rxN0000(4)<=rxLocal(N0000);
	ack_txN0000(4)<=ack_txLocal(N0000);
	data_inN0000(4)<=data_inLocal(N0000);
	txLocal(N0000)<=txN0000(4);
	ack_rxLocal(N0000)<=ack_rxN0000(4);
	data_outLocal(N0000)<=data_outN0000(4);

	-- ROUTER 0100
	-- EAST port
	data_inN0100(0)<=data_outN0200(1);
	rxN0100(0)<=txN0200(1);
	ack_txN0100(0)<=ack_rxN0200(1);
	-- WEST port
	data_inN0100(1)<=data_outN0000(0);
	rxN0100(1)<=txN0000(0);
	ack_txN0100(1)<=ack_rxN0000(0);
	-- NORTH port
	data_inN0100(2)<=data_outN0101(3);
	rxN0100(2)<=txN0101(3);
	ack_txN0100(2)<=ack_rxN0101(3);
	-- SOUTH port
	data_inN0100(3)<=(others=>'0');
	rxN0100(3)<='0';
	ack_txN0100(3)<='0';
	-- LOCAL port
	rxN0100(4)<=rxLocal(N0100);
	ack_txN0100(4)<=ack_txLocal(N0100);
	data_inN0100(4)<=data_inLocal(N0100);
	txLocal(N0100)<=txN0100(4);
	ack_rxLocal(N0100)<=ack_rxN0100(4);
	data_outLocal(N0100)<=data_outN0100(4);

	-- ROUTER 0200
	-- EAST port
	data_inN0200(0)<=(others=>'0');
	rxN0200(0)<='0';
	ack_txN0200(0)<='0';
	-- WEST port
	data_inN0200(1)<=data_outN0100(0);
	rxN0200(1)<=txN0100(0);
	ack_txN0200(1)<=ack_rxN0100(0);
	-- NORTH port
	data_inN0200(2)<=data_outN0201(3);
	rxN0200(2)<=txN0201(3);
	ack_txN0200(2)<=ack_rxN0201(3);
	-- SOUTH port
	data_inN0200(3)<=(others=>'0');
	rxN0200(3)<='0';
	ack_txN0200(3)<='0';
	-- LOCAL port
	rxN0200(4)<=rxLocal(N0200);
	ack_txN0200(4)<=ack_txLocal(N0200);
	data_inN0200(4)<=data_inLocal(N0200);
	txLocal(N0200)<=txN0200(4);
	ack_rxLocal(N0200)<=ack_rxN0200(4);
	data_outLocal(N0200)<=data_outN0200(4);

	-- ROUTER 0001
	-- EAST port
	data_inN0001(0)<=data_outN0101(1);
	rxN0001(0)<=txN0101(1);
	ack_txN0001(0)<=ack_rxN0101(1);
	-- WEST port
	data_inN0001(1)<=(others=>'0');
	rxN0001(1)<='0';
	ack_txN0001(1)<='0';
	-- NORTH port
	data_inN0001(2)<=data_outN0002(3);
	rxN0001(2)<=txN0002(3);
	ack_txN0001(2)<=ack_rxN0002(3);
	-- SOUTH port
	data_inN0001(3)<=data_outN0000(2);
	rxN0001(3)<=txN0000(2);
	ack_txN0001(3)<=ack_rxN0000(2);
	-- LOCAL port
	rxN0001(4)<=rxLocal(N0001);
	ack_txN0001(4)<=ack_txLocal(N0001);
	data_inN0001(4)<=data_inLocal(N0001);
	txLocal(N0001)<=txN0001(4);
	ack_rxLocal(N0001)<=ack_rxN0001(4);
	data_outLocal(N0001)<=data_outN0001(4);

	-- ROUTER 0101
	-- EAST port
	data_inN0101(0)<=data_outN0201(1);
	rxN0101(0)<=txN0201(1);
	ack_txN0101(0)<=ack_rxN0201(1);
	-- WEST port
	data_inN0101(1)<=data_outN0001(0);
	rxN0101(1)<=txN0001(0);
	ack_txN0101(1)<=ack_rxN0001(0);
	-- NORTH port
	data_inN0101(2)<=data_outN0102(3);
	rxN0101(2)<=txN0102(3);
	ack_txN0101(2)<=ack_rxN0102(3);
	-- SOUTH port
	data_inN0101(3)<=data_outN0100(2);
	rxN0101(3)<=txN0100(2);
	ack_txN0101(3)<=ack_rxN0100(2);
	-- LOCAL port
	rxN0101(4)<=rxLocal(N0101);
	ack_txN0101(4)<=ack_txLocal(N0101);
	data_inN0101(4)<=data_inLocal(N0101);
	txLocal(N0101)<=txN0101(4);
	ack_rxLocal(N0101)<=ack_rxN0101(4);
	data_outLocal(N0101)<=data_outN0101(4);

	-- ROUTER 0201
	-- EAST port
	data_inN0201(0)<=(others=>'0');
	rxN0201(0)<='0';
	ack_txN0201(0)<='0';
	-- WEST port
	data_inN0201(1)<=data_outN0101(0);
	rxN0201(1)<=txN0101(0);
	ack_txN0201(1)<=ack_rxN0101(0);
	-- NORTH port
	data_inN0201(2)<=data_outN0202(3);
	rxN0201(2)<=txN0202(3);
	ack_txN0201(2)<=ack_rxN0202(3);
	-- SOUTH port
	data_inN0201(3)<=data_outN0200(2);
	rxN0201(3)<=txN0200(2);
	ack_txN0201(3)<=ack_rxN0200(2);
	-- LOCAL port
	rxN0201(4)<=rxLocal(N0201);
	ack_txN0201(4)<=ack_txLocal(N0201);
	data_inN0201(4)<=data_inLocal(N0201);
	txLocal(N0201)<=txN0201(4);
	ack_rxLocal(N0201)<=ack_rxN0201(4);
	data_outLocal(N0201)<=data_outN0201(4);

	-- ROUTER 0002
	-- EAST port
	data_inN0002(0)<=data_outN0102(1);
	rxN0002(0)<=txN0102(1);
	ack_txN0002(0)<=ack_rxN0102(1);
	-- WEST port
	data_inN0002(1)<=(others=>'0');
	rxN0002(1)<='0';
	ack_txN0002(1)<='0';
	-- NORTH port
	data_inN0002(2)<=(others=>'0');
	rxN0002(2)<='0';
	ack_txN0002(2)<='0';
	-- SOUTH port
	data_inN0002(3)<=data_outN0001(2);
	rxN0002(3)<=txN0001(2);
	ack_txN0002(3)<=ack_rxN0001(2);
	-- LOCAL port
	rxN0002(4)<=rxLocal(N0002);
	ack_txN0002(4)<=ack_txLocal(N0002);
	data_inN0002(4)<=data_inLocal(N0002);
	txLocal(N0002)<=txN0002(4);
	ack_rxLocal(N0002)<=ack_rxN0002(4);
	data_outLocal(N0002)<=data_outN0002(4);

	-- ROUTER 0102
	-- EAST port
	data_inN0102(0)<=data_outN0202(1);
	rxN0102(0)<=txN0202(1);
	ack_txN0102(0)<=ack_rxN0202(1);
	-- WEST port
	data_inN0102(1)<=data_outN0002(0);
	rxN0102(1)<=txN0002(0);
	ack_txN0102(1)<=ack_rxN0002(0);
	-- NORTH port
	data_inN0102(2)<=(others=>'0');
	rxN0102(2)<='0';
	ack_txN0102(2)<='0';
	-- SOUTH port
	data_inN0102(3)<=data_outN0101(2);
	rxN0102(3)<=txN0101(2);
	ack_txN0102(3)<=ack_rxN0101(2);
	-- LOCAL port
	rxN0102(4)<=rxLocal(N0102);
	ack_txN0102(4)<=ack_txLocal(N0102);
	data_inN0102(4)<=data_inLocal(N0102);
	txLocal(N0102)<=txN0102(4);
	ack_rxLocal(N0102)<=ack_rxN0102(4);
	data_outLocal(N0102)<=data_outN0102(4);

	-- ROUTER 0202
	-- EAST port
	data_inN0202(0)<=(others=>'0');
	rxN0202(0)<='0';
	ack_txN0202(0)<='0';
	-- WEST port
	data_inN0202(1)<=data_outN0102(0);
	rxN0202(1)<=txN0102(0);
	ack_txN0202(1)<=ack_rxN0102(0);
	-- NORTH port
	data_inN0202(2)<=(others=>'0');
	rxN0202(2)<='0';
	ack_txN0202(2)<='0';
	-- SOUTH port
	data_inN0202(3)<=data_outN0201(2);
	rxN0202(3)<=txN0201(2);
	ack_txN0202(3)<=ack_rxN0201(2);
	-- LOCAL port
	rxN0202(4)<=rxLocal(N0202);
	ack_txN0202(4)<=ack_txLocal(N0202);
	data_inN0202(4)<=data_inLocal(N0202);
	txLocal(N0202)<=txN0202(4);
	ack_rxLocal(N0202)<=ack_rxN0202(4);
	data_outLocal(N0202)<=data_outN0202(4);

	-- the component below, router_output, must be commented to simulate without SystemC
	router_output: Entity work.outmodulerouter
	port map(
		clock           => clock,
		reset           => reset,
		tx_r0p0         => txN0000(EAST),
		out_r0p0        => data_outN0000(EAST),
		ack_ir0p0       => ack_txN0000(EAST),
		tx_r0p2         => txN0000(NORTH),
		out_r0p2        => data_outN0000(NORTH),
		ack_ir0p2       => ack_txN0000(NORTH),
		tx_r1p0         => txN0100(EAST),
		out_r1p0        => data_outN0100(EAST),
		ack_ir1p0       => ack_txN0100(EAST),
		tx_r1p1         => txN0100(WEST),
		out_r1p1        => data_outN0100(WEST),
		ack_ir1p1       => ack_txN0100(WEST),
		tx_r1p2         => txN0100(NORTH),
		out_r1p2        => data_outN0100(NORTH),
		ack_ir1p2       => ack_txN0100(NORTH),
		tx_r2p1         => txN0200(WEST),
		out_r2p1        => data_outN0200(WEST),
		ack_ir2p1       => ack_txN0200(WEST),
		tx_r2p2         => txN0200(NORTH),
		out_r2p2        => data_outN0200(NORTH),
		ack_ir2p2       => ack_txN0200(NORTH),
		tx_r3p0         => txN0001(EAST),
		out_r3p0        => data_outN0001(EAST),
		ack_ir3p0       => ack_txN0001(EAST),
		tx_r3p2         => txN0001(NORTH),
		out_r3p2        => data_outN0001(NORTH),
		ack_ir3p2       => ack_txN0001(NORTH),
		tx_r3p3         => txN0001(SOUTH),
		out_r3p3        => data_outN0001(SOUTH),
		ack_ir3p3       => ack_txN0001(SOUTH),
		tx_r4p0         => txN0101(EAST),
		out_r4p0        => data_outN0101(EAST),
		ack_ir4p0       => ack_txN0101(EAST),
		tx_r4p1         => txN0101(WEST),
		out_r4p1        => data_outN0101(WEST),
		ack_ir4p1       => ack_txN0101(WEST),
		tx_r4p2         => txN0101(NORTH),
		out_r4p2        => data_outN0101(NORTH),
		ack_ir4p2       => ack_txN0101(NORTH),
		tx_r4p3         => txN0101(SOUTH),
		out_r4p3        => data_outN0101(SOUTH),
		ack_ir4p3       => ack_txN0101(SOUTH),
		tx_r5p1         => txN0201(WEST),
		out_r5p1        => data_outN0201(WEST),
		ack_ir5p1       => ack_txN0201(WEST),
		tx_r5p2         => txN0201(NORTH),
		out_r5p2        => data_outN0201(NORTH),
		ack_ir5p2       => ack_txN0201(NORTH),
		tx_r5p3         => txN0201(SOUTH),
		out_r5p3        => data_outN0201(SOUTH),
		ack_ir5p3       => ack_txN0201(SOUTH),
		tx_r6p0         => txN0002(EAST),
		out_r6p0        => data_outN0002(EAST),
		ack_ir6p0       => ack_txN0002(EAST),
		tx_r6p3         => txN0002(SOUTH),
		out_r6p3        => data_outN0002(SOUTH),
		ack_ir6p3       => ack_txN0002(SOUTH),
		tx_r7p0         => txN0102(EAST),
		out_r7p0        => data_outN0102(EAST),
		ack_ir7p0       => ack_txN0102(EAST),
		tx_r7p1         => txN0102(WEST),
		out_r7p1        => data_outN0102(WEST),
		ack_ir7p1       => ack_txN0102(WEST),
		tx_r7p3         => txN0102(SOUTH),
		out_r7p3        => data_outN0102(SOUTH),
		ack_ir7p3       => ack_txN0102(SOUTH),
		tx_r8p1         => txN0202(WEST),
		out_r8p1        => data_outN0202(WEST),
		ack_ir8p1       => ack_txN0202(WEST),
		tx_r8p3         => txN0202(SOUTH),
		out_r8p3        => data_outN0202(SOUTH),
		ack_ir8p3       => ack_txN0202(SOUTH));

end NOC;
