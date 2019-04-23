module skeleton(resetn, 
	ps2_clock, ps2_data, 										// ps2 related I/O
	debug_data_in, debug_addr, leds, 						// extra debugging ports
	lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,// LCD info
	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,		// seven segements
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,															//	VGA Blue[9:0]
	CLOCK_50,														// 50 MHz clock
	north,
	south,
	east,
	west,
	color_switch, store_switch,
	// Servo Outputs 
	servo1,servo2,servo3,servo4,servo_t,servo_l,servo_b,servo_r,
	finished_LED);
	
//		  address_imem,                   // O: The address of the data to get from imem
//        q_imem,                         // I: The data from imem
//
//        // Dmem
//        address_dmem,                   // O: The address of the data to get or put from/to dmem
//        data,                           // O: The data to write to dmem
//        wren,                           // O: Write enable for dmem
//        q_dmem,                         // I: The data from dmem
//
//        // Regfile
//        ctrl_writeEnable,               // O: Write enable for regfile
//        ctrl_writeReg,                  // O: Register to write to in regfile
//        ctrl_readRegA,                  // O: Register to read from port A of regfile
//        ctrl_readRegB,                  // O: Register to read from port B of regfile
//        data_writeReg,                  // O: Data to write to for regfile
//        data_readRegA,                  // I: Data from port A of regfile
//        data_readRegB,                   // I: Data from port B of regfile
//		  
//		  //extra processor outputs
//		  alu_inputA, alu_inputB, alu_output,
//		  select_pc,
//		  fd_inst_in, fd_inst_out);  									
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	input				CLOCK_50;

	////////////////////////	PS2	////////////////////////////
	input 			resetn,north,south,east,west,color_switch, store_switch;
	inout 			ps2_data, ps2_clock;
	
	////////////////////////	LCD and Seven Segment	////////////////////////////
	output 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[31:0] 	debug_data_in;
	output   [11:0]   debug_addr;
	
	
	
	
	
	wire			 clock;
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;
	wire	[7:0]	 ps2_key_data;
	wire			 ps2_key_pressed;
	wire	[7:0]	 ps2_out;	
	//reg          x,y;
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// your processor
	//processor myprocessor(clock, ~resetn, /*ps2_key_pressed, ps2_out, lcd_write_en, lcd_write_data,*/ debug_data_in, debug_addr);
	
	// keyboard controller
	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
	lcd mylcd(clock, ~resetn, 1'b1, ps2_out, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(4'd13, seg1);
	Hexadecimal_To_Seven_Segment hex2(ps2_out[7:4], seg2);
	
	// the other seven segment displays are currently set to 0
	Hexadecimal_To_Seven_Segment hex3(q_dmem[3:0], seg3);
	Hexadecimal_To_Seven_Segment hex4(finished_LED, seg4);
	Hexadecimal_To_Seven_Segment hex5(address_dmem[3:0], seg5);
	Hexadecimal_To_Seven_Segment hex6(address_dmem[7:4], seg6);
	Hexadecimal_To_Seven_Segment hex7(4'b0, seg7);
	Hexadecimal_To_Seven_Segment hex8(enable, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;
		
	// VGA
	
	wire [31:0] vga_data_out;
	wire [11:0] vga_dmem_addr;
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(.iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .oBLANK_n(VGA_BLANK),
								 .oHS(VGA_HS),
								 .oVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R), .north(north), .south(south), .east(east), .west(west), 
								 .color_switch(color_switch), .store_switch(store_switch), .vga_data_out(vga_data_out), .vga_dmem_addr(vga_dmem_addr), .enable(enable));
								 

//////////////////////////////////////////////////
///////MY PROCESSOR SKELETON							 
		
	//extra outputs for testing
//	 output [31:0] alu_inputA, alu_inputB, alu_output;
//	 output[1:0] select_pc;
//	 output[31:0] fd_inst_in, fd_inst_out;
//	 
//    input clock, reset;
//
//	 output [11:0] address_imem;
//	 output [31:0] q_imem;
	 
	 wire [31:0] alu_inputA, alu_inputB, alu_output;
	 wire[1:0] select_pc;
	 wire[31:0] fd_inst_in, fd_inst_out;
	 
    //input clock, reset;

	 wire [11:0] address_imem;
	 wire [31:0] q_imem;
	 
    imem my_imem(
        .address    (address_imem),            // address of data
		  .clken 	  (1'b1),
        .clock      (clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

	 wire [11:0] address_dmem;
    wire [31:0] proc_data;
    wire wren, proc_wren;
    wire [31:0] q_dmem;
	 wire [31:0] data_dmem;
	 wire wren_out1;
	 
	 //vga_controller and processor both write to dmem; ServoTranslator only reads
	 //0 for vga data, 1 for proc data; can switch these if necessary
	 assign sel_dmem_data = 1'b0; //temporary
	 mux_2 dmem_datamux(enable, vga_data_out, proc_data, data_dmem);
	 
	 //will eventually need two muxes for address cause you need that for reading and writing
	 mux_2 dmem_addrmux(enable, vga_dmem_addr, servo_dmem_addr, address_dmem);
	 mux_2 dmem_wrenmux(enable, 1'b1, proc_wren, wren_out1);
	 mux_2 dmem_wrenmux2(,wren_out1,1'b0,wren);
	 
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (~clock),                  // may need to invert the clock
        .data	    (data_dmem),    // data you want to write
        .wren	    (wren),      // write enable
        .q          (q_dmem)    // data from dmem
    );


	 wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        ~clock,
        ctrl_writeEnable,
        ~resetn,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    processor my_processor(
        // Control signals
        clock,                          // I: The master clock
        ~resetn,                          // I: A reset signal

        // Imem
        address_imem,                   // O: The address of the data to get from imem
        q_imem,                         // I: The data from imem

        // Dmem
        proc_address_dmem,                   // O: The address of the data to get or put from/to dmem
        proc_data,                           // O: The data to write to dmem
        proc_wren,                           // O: Write enable for dmem
        q_dmem,                         // I: The data from dmem

        // Regfile
        ctrl_writeEnable,               // O: Write enable for regfile
        ctrl_writeReg,                  // O: Register to write to in regfile
        ctrl_readRegA,                  // O: Register to read from port A of regfile
        ctrl_readRegB,                  // O: Register to read from port B of regfile
        data_writeReg,                  // O: Data to write to for regfile
        data_readRegA,                  // I: Data from port A of regfile
        data_readRegB,                   // I: Data from port B of regfile
		  
		  //extra outputs for testing
		  alu_inputA, alu_inputB, alu_output,
		  select_pc,
		  fd_inst_in, fd_inst_out
    );								 
	
//	input enable,clk,rst;
//	input [3:0] dmem_out;
	output servo1,servo2,servo3,servo4,servo_t,servo_l,servo_b,servo_r,finished_LED;
	wire enable;//,clk,rst;
	wire [3:0] dmem_out;
//	wire servo1,servo2,servo3,servo4,servo_t,servo_l,servo_b,servo_r;
	wire [31:0] servo_dmem_addr;
	assign dmem_out = q_dmem;
	ServoTranslator(dmem_out[3:0],enable, CLOCK_50, ~resetn,
								//output to each servo
									//Back and forth
									servo1,servo2,servo3,servo4,
									//90 degree rotation
									servo_t,servo_l,servo_b,servo_r,
									//Dmem address to index into
									servo_dmem_addr,
									finished_LED);
	
	
endmodule
