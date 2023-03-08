library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use work.HermesPackage.all;

entity topNoC is
end;

architecture topNoC of topNoC is

	signal clk, reset, finish : std_logic;
	signal data_in, data_out : arrayNrot_regflit;
	signal rx, ack_rx, tx, ack_tx : regNrot;

begin
	reset <= '1', '0' after 15 ns;
	process
	begin
		clk <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	NOC: Entity work.NOC
	port map(
		clock        => clk,
		reset        => reset,
		data_outLocal=> data_out,
		txLocal      => tx,
		ack_txLocal  => ack_tx,
		data_inLocal => data_in,
		rxLocal      => rx,
		ack_rxLocal  => ack_rx);

	ack_tx <= tx;

	cim00: Entity work.inputmodule
	port map(
		clock       => clk,
		reset       => reset,
		finish      => finish,
		outtx0      => rx(N0000),
		outdata0    => data_in(N0000),
		inack0      => ack_rx(N0000),
		outtx1      => rx(N0100),
		outdata1    => data_in(N0100),
		inack1      => ack_rx(N0100),
		outtx2      => rx(N0200),
		outdata2    => data_in(N0200),
		inack2      => ack_rx(N0200),
		outtx3      => rx(N0001),
		outdata3    => data_in(N0001),
		inack3      => ack_rx(N0001),
		outtx4      => rx(N0101),
		outdata4    => data_in(N0101),
		inack4      => ack_rx(N0101),
		outtx5      => rx(N0201),
		outdata5    => data_in(N0201),
		inack5      => ack_rx(N0201),
		outtx6      => rx(N0002),
		outdata6    => data_in(N0002),
		inack6      => ack_rx(N0002),
		outtx7      => rx(N0102),
		outdata7    => data_in(N0102),
		inack7      => ack_rx(N0102),
		outtx8      => rx(N0202),
		outdata8    => data_in(N0202),
		inack8      => ack_rx(N0202));

	com00: Entity work.outmodule
	port map(
		clock       => clk,
		reset       => reset,
		finish      => finish,
		inTx0       => tx(N0000),
		inData0     => data_out(N0000),
		inTx1       => tx(N0100),
		inData1     => data_out(N0100),
		inTx2       => tx(N0200),
		inData2     => data_out(N0200),
		inTx3       => tx(N0001),
		inData3     => data_out(N0001),
		inTx4       => tx(N0101),
		inData4     => data_out(N0101),
		inTx5       => tx(N0201),
		inData5     => data_out(N0201),
		inTx6       => tx(N0002),
		inData6     => data_out(N0002),
		inTx7       => tx(N0102),
		inData7     => data_out(N0102),
		inTx8       => tx(N0202),
		inData8     => data_out(N0202));

end topNoC;
