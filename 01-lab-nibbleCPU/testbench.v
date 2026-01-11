`timescale 1ns/1ps

module testbench();

	reg clk;
	reg rst_n;

	reg [3:0] prog_nibble_in;
	reg prog_nibble_in_valid;
	wire [3:0] prog_nibble_out;
	wire prog_out_valid;
	wire prog_done;

	wire [11:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [31:0] mem_rdata;
	wire mem_wen;
	wire mem_cen;

	cpu_top dut(.clk(clk),
                .rst_n(rst_n),
                .prog_nibble_in(prog_nibble_in),
                .prog_nibble_in_valid(prog_nibble_in_valid),
                .prog_nibble_out(prog_nibble_out),
                .prog_out_valid(prog_out_valid),
                .prog_done(prog_done),
                .mem_addr(mem_addr),
                .mem_wdata(mem_wdata),
                .mem_rdata(mem_rdata),
                .mem_wen(mem_wen),
                .mem_cen(mem_cen));

    	memory mem_inst( .clk(clk),
                .addr(mem_addr),
                .wdata(mem_wdata),
                .rdata(mem_rdata),
                .wen(mem_wen),
                .cen(mem_cen));

	always #50 clk = ~clk;

	initial begin

	clk=0;
	rst_n=0;
	repeat(4) @(negedge clk);
	rst_n=1;
	@(negedge clk);

   	//Load 32'h12345678 to memory address 12'hF0 - CMD_WRITE  (12'h0F0,8'h02,32'h12345678)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h0;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h2;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h8;
	@(negedge clk); prog_nibble_in = 4'h7;
	@(negedge clk); prog_nibble_in = 4'h6;
	@(negedge clk); prog_nibble_in = 4'h5;
	@(negedge clk); prog_nibble_in = 4'h4;
	@(negedge clk); prog_nibble_in = 4'h3;
	@(negedge clk); prog_nibble_in = 4'h2;
	@(negedge clk); prog_nibble_in = 4'h1;
	@(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Load 32'h87654321 to memory address 12'hF1 - CMD_WRITE  (12'h0F1,8'h02,32'h87654321)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h1;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h2;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h1;
	@(negedge clk); prog_nibble_in = 4'h2;
	@(negedge clk); prog_nibble_in = 4'h3;
	@(negedge clk); prog_nibble_in = 4'h4;
	@(negedge clk); prog_nibble_in = 4'h5;
	@(negedge clk); prog_nibble_in = 4'h6;
	@(negedge clk); prog_nibble_in = 4'h7;
	@(negedge clk); prog_nibble_in = 4'h8;
	@(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Add mem(0x0F2) = mem(0x0F1) + mem(0x0F0) - CMD_ADD (12'h0F0,8'h10,32'hX)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h0;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h1;
	@(negedge clk); prog_nibble_in = 4'hX;
	repeat(8) @(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Read mem(0xF2) - CMD_READ (12'h0F2,8'h03,32'hX)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h2;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h3;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'hX;
	repeat(8) @(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Load 32'hfedcba98 to memory address 12'hF3 - CMD_WRITE  (12'h0F3,8'h02,32'hfedcba98)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h3;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h2;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h8;
	@(negedge clk); prog_nibble_in = 4'h9;
	@(negedge clk); prog_nibble_in = 4'ha;
	@(negedge clk); prog_nibble_in = 4'hb;
	@(negedge clk); prog_nibble_in = 4'hc;
	@(negedge clk); prog_nibble_in = 4'hd;
	@(negedge clk); prog_nibble_in = 4'he;
	@(negedge clk); prog_nibble_in = 4'hf;
	@(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Multiply {mem(0xF5),mem(0xF4)} = mem(0x0F3) + mem(0x0F2) - CMD_MUL (12'h0F3,8'h12,32'hX)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h2;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h2;
	@(negedge clk); prog_nibble_in = 4'h1;
	@(negedge clk); prog_nibble_in = 4'hX;
	repeat(8) @(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Read mem(0xF4) - CMD_READ (12'h0F4,8'h03,32'hX)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h4;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h3;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'hX;
	repeat(8) @(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(2) @(negedge clk);

	//Read mem(0xF5) - CMD_READ (12'h0F2,8'h03,32'hX)
	prog_nibble_in_valid = 1;
	prog_nibble_in = 4'h5;
	@(negedge clk) prog_nibble_in = 4'hF;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'h3;
	@(negedge clk); prog_nibble_in = 4'h0;
	@(negedge clk); prog_nibble_in = 4'hX;
	repeat(8) @(negedge clk);
	prog_nibble_in_valid = 0;

	//Wait for 2 clock cycles
	repeat(18) @(negedge clk);

	$stop;
	end
endmodule

