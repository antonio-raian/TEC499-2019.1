	Problema1Qsys u0 (
		.botoes_export       (<connected-to-botoes_export>),       //         botoes.export
		.clk_clk             (<connected-to-clk_clk>),             //            clk.clk
		.lcd_controller_rs   (<connected-to-lcd_controller_rs>),   // lcd_controller.rs
		.lcd_controller_rw   (<connected-to-lcd_controller_rw>),   //               .rw
		.lcd_controller_en   (<connected-to-lcd_controller_en>),   //               .en
		.lcd_controller_lcd  (<connected-to-lcd_controller_lcd>),  //               .lcd
		.m_led_coluna_export (<connected-to-m_led_coluna_export>), //   m_led_coluna.export
		.m_led_linha_export  (<connected-to-m_led_linha_export>),  //    m_led_linha.export
		.reset_reset_n       (<connected-to-reset_reset_n>)        //          reset.reset_n
	);

