	component Problema1Qsys is
		port (
			botoes_export       : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			clk_clk             : in  std_logic                    := 'X';             -- clk
			lcd_controller_rs   : out std_logic;                                       -- rs
			lcd_controller_rw   : out std_logic;                                       -- rw
			lcd_controller_en   : out std_logic;                                       -- en
			lcd_controller_lcd  : out std_logic_vector(7 downto 0);                    -- lcd
			m_led_coluna_export : out std_logic_vector(4 downto 0);                    -- export
			m_led_linha_export  : out std_logic_vector(4 downto 0);                    -- export
			reset_reset_n       : in  std_logic                    := 'X'              -- reset_n
		);
	end component Problema1Qsys;

	u0 : component Problema1Qsys
		port map (
			botoes_export       => CONNECTED_TO_botoes_export,       --         botoes.export
			clk_clk             => CONNECTED_TO_clk_clk,             --            clk.clk
			lcd_controller_rs   => CONNECTED_TO_lcd_controller_rs,   -- lcd_controller.rs
			lcd_controller_rw   => CONNECTED_TO_lcd_controller_rw,   --               .rw
			lcd_controller_en   => CONNECTED_TO_lcd_controller_en,   --               .en
			lcd_controller_lcd  => CONNECTED_TO_lcd_controller_lcd,  --               .lcd
			m_led_coluna_export => CONNECTED_TO_m_led_coluna_export, --   m_led_coluna.export
			m_led_linha_export  => CONNECTED_TO_m_led_linha_export,  --    m_led_linha.export
			reset_reset_n       => CONNECTED_TO_reset_reset_n        --          reset.reset_n
		);

