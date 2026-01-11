`timescale 1ns/1ps

module memory(
	input clk,
	input [11:0] addr,
	input [31:0] wdata,
	output [31:0] rdata,
	input wen,
	input cen);

	reg [4095:0] mem[31:0];
	reg [31:0]reg_rdata;


	always@(posedge clk) begin
		//Chip Enable
		if(cen) begin
			//Write Enable
			if(wen)begin
				mem[addr] <= wdata;
			end
			else begin
				reg_rdata <= mem[addr];
			end
		end
	end

	assign rdata=reg_rdata;
endmodule

