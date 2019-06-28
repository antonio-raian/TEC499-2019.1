	component Problema1Qsys is
		port (
			botoes_export : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			clk_clk       : in  std_logic                    := 'X';             -- clk
			leds_export   : out std_logic_vector(4 downto 0);                    -- export
			reset_reset_n : in  std_logic                    := 'X'              -- reset_n
		);
	end component Problema1Qsys;

	u0 : component Problema1Qsys
		port map (
			botoes_export => CONNECTED_TO_botoes_export, -- botoes.export
			clk_clk       => CONNECTED_TO_clk_clk,       --    clk.clk
			leds_export   => CONNECTED_TO_leds_export,   --   leds.export
			reset_reset_n => CONNECTED_TO_reset_reset_n  --  reset.reset_n
		);

