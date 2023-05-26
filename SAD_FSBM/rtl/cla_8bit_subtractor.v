module cla_8bit_subtractor(input [7:0]a,b,output [7:0]diff,output bout);
wire [7:0]y,greater,smaller;
wire cin;
assign cin=1'b1;
absolute abs(.a(a),.b(b),.greater(greater),.smaller(smaller));
assign y[7:0]=(~smaller[7:0]);
cla_8bit adder1(.a(greater),.b(y),.cin(cin),.s(diff),.cout(bout));
endmodule

