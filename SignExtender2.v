 
`timescale 1ns / 1ps
module SignExtender(Bus64, Imm26, Ctrl);
	output reg [63:0] Bus64;
	input [25:0] Imm26;
	input [2:0]Ctrl;

	wire extBit;
	//assign #1 extBit = (Ctrl ? 1'b0 : Imm26[25]);


always @(*)begin
	 begin
        if(Ctrl[2:0] == 3'b000) begin  // I-type
	   Bus64 = {52'b0,Imm26[21:10]};
        end
        if(Ctrl[2:0] == 3'b001)begin // D type
           Bus64 = {{55{Imm26[20]}}, Imm26[20:12]};
	end
	if(Ctrl[2:0] == 3'b010)begin // B
          Bus64 = {{38{Imm26[25]}}, Imm26[25:0]};
	end
	if(Ctrl[2:0] == 3'b011)begin // CB 
	  Bus64 = {{45{Imm26[23]}}, Imm26[23:5]};
	end
	if(Ctrl[2:0] == 3'b100)begin// IW-Type 
		if(Imm26[22:21] == 2'b00)begin// LSL 0 
		    Bus64 = {48'b0, Imm26[20:5]};
		end
		if(Imm26[22:21] == 2'b01)begin //LSL 16
 		    Bus64 = {32'b0, Imm26[20:5], 16'b0};		
		end
		if(Imm26[22:21] == 2'b10) begin//LSL 32
		    Bus64 = {16'b0, Imm26[20:5], 32'b0};
		end
		if(Imm26[22:21] == 2'b11)begin//LSL 48
		    Bus64 = {Imm26[20:5], 48'b0};
		end
	  
	end
	if(Ctrl[2:0] == 3'bxxx)begin 
          Bus64 = {64'bx};
        end
	
	
      end
end
endmodule
