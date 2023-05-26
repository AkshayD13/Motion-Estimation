module absolute(input [7:0]a,b,output [7:0]greater,smaller);
assign greater=(a>=b)?a:b;
assign smaller=(a>=b)?b:a;
endmodule
