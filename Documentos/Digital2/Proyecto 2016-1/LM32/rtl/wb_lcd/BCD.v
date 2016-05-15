module BCD(
	input [7:0] num,
	output reg[3:0] out_BCD1,
	output reg[3:0] out_BCD2,
	output reg[3:0] out_BCD3
	);

	reg [7:0] ref, ref2;
	
	always@( num )
	begin

	ref = num/100; // 242 - 2
	out_BCD1 = ref;
	ref = num % 100; // 56
	out_BCD2 = ref / 10; // 5
	out_BCD3 = num % 10;
	
	/*out_BCD1 <= 4;
	out_BCD2 <= 1;
	out_BCD3 <= 8;*/

	end
endmodule

