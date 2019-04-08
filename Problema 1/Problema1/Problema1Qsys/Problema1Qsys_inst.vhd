	component Problema1Qsys is
		port (
			clk_clk         : in  std_logic                    := 'X';             -- clk
			reset_reset_n   : in  std_logic                    := 'X';             -- reset_n
			botoes_in_port  : in  std_logic_vector(7 downto 0) := (others => 'X'); -- in_port
			botoes_out_port : out std_logic_vector(7 downto 0);                    -- out_port
			leds_export     : out std_logic_vector(7 downto 0)                     -- export
		);
	end component Problema1Qsys;

	u0 : component Problema1Qsys
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --    clk.clk
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --  reset.reset_n
			botoes_in_port  => CONNECTED_TO_botoes_in_port,  -- botoes.in_port
			botoes_out_port => CONNECTED_TO_botoes_out_port, --       .out_port
			leds_export     => CONNECTED_TO_leds_export      --   leds.export
		);

