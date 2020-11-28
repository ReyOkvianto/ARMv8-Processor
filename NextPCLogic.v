module NextPCLogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
	input [63:0] CurrentPC, SignExtImm64; 
	input Branch, ALUZero, Uncondbranch; 
	output reg [63:0] NextPC; 

	always @(*)
		begin
			if((Uncondbranch) || (Branch && ALUZero))
				#2 NextPC <= CurrentPC + (SignExtImm64 << 2);
			else
				#1 NextPC <= CurrentPC + 4;
		end
endmodule


