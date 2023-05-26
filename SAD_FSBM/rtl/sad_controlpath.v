module sad_controlpath(A0,B0,A1,B1,A2,B2,A3,B3,A4,B4,A5,B5,A6,B6,A7,B7,A8,B8,A9,B9,A10,B10,A11,B11,A12,B12,A13,B13,A14,B14,A15,B15,clk,rst,go,sad_reg,i,data_load);
input [7:0] A0,B0,A1,B1,A2,B2,A3,B3,A4,B4,A5,B5,A6,B6,A7,B7,A8,B8,A9,B9,A10,B10,A11,B11,A12,B12,A13,B13,A14,B14,A15,B15;
input rst,clk,go;
output [31:0]sad_reg;
output [8:0] i;
output data_load;


wire[7:0] diff0,diff1,diff2,diff3,diff4,diff5,diff6,diff7,diff8,diff9,diff10,diff11,diff12,diff13,diff14,diff15;
wire bout0,bout1,bout2,bout3,bout4,bout5,bout6,bout7,bout8,bout9,bout10,bout11,bout12,bout13,bout14,bout15;
wire [31:0]abs_diff;

parameter [2:0] s0=3'b000;
parameter [2:0] s1=3'b001;
parameter [2:0] s2=3'b010;
parameter [2:0] s3=3'b011;
parameter [2:0] s4=3'b100;
reg[4:0] i;

reg sum_clr,sum_load,i_clr,i_inc,sad_load,data_load;
reg [2:0]pst,nxt;
reg [31:0]sum,sad_reg;

//*********************************************************
//# CONTROLLER #//
//*********************************************************
always @ (posedge clk,posedge rst) //present state logic
begin
	if (rst) 
		begin
		pst<=s0;
		end
	else 
		begin
		pst<=nxt;
		end
end		

always @ (*) //next state logic
begin						//Assigning default values to all control signals
		data_load = 1'b0;
		sum_clr=1'b0;
		i_clr=1'b0;
		i_inc=1'b0;
		sum_load=1'b0;
		sad_load=1'b0;		
		case(pst)
	
		s0: nxt = (go==1)?s1:s0;
	
		s1: begin
			sum_clr = 1'b1;
			i_clr = 1'b1; 
			nxt = s2;
			end
		
		s2: begin
			nxt = (i<16)?s3:s4;
			data_load = 1'b1;	//data_load signal is used to load the data into reg A and B from FIFO data_out port to keep the data ready for the operations in state S3
			end
			
		s3: begin
			data_load = 1'b0;	//data_load is made 0 in order to stop the reading of the data from FIFO into reg A and B			
			sum_load = 1'b1;
			i_inc = 1'b1; 
			nxt = s2;
			end
		
		s4: begin
			sad_load = 1'b1;
			nxt = s0;
			end
	
		default: nxt = s0;
			
		endcase
end
//*********************************************************
//# DATA PATH #//
//*********************************************************
         
cla_8bit_subtractor x0 (A0,B0,diff0,bout0);
cla_8bit_subtractor x1 (A1,B1,diff1,bout1);
cla_8bit_subtractor x2 (A2,B2,diff2,bout2);
cla_8bit_subtractor x3 (A3,B3,diff3,bout3);
cla_8bit_subtractor x4 (A4,B4,diff4,bout4);
cla_8bit_subtractor x5 (A5,B5,diff5,bout5);
cla_8bit_subtractor x6 (A6,B6,diff6,bout6);
cla_8bit_subtractor x7 (A7,B7,diff7,bout7);
cla_8bit_subtractor x8 (A8,B8,diff8,bout8);
cla_8bit_subtractor x9 (A9,B9,diff9,bout9);
cla_8bit_subtractor x10 (A10,B10,diff10,bout10);
cla_8bit_subtractor x11 (A11,B11,diff11,bout11);
cla_8bit_subtractor x12 (A12,B12,diff12,bout12);
cla_8bit_subtractor x13 (A13,B13,diff13,bout13);
cla_8bit_subtractor x14 (A14,B14,diff14,bout14);
cla_8bit_subtractor x15 (A15,B15,diff15,bout15);

always @ (posedge clk)
begin
	if(i_clr || (i == 16)) 
	begin
		i<=1'b0;
	end
	else if(i_inc)
	begin
		i<=i+1;
	end
	else 
		i<=i;
end

always @(posedge clk)
begin
		if(sum_clr)
		begin
			sum<=32'b0;
		end
		else if(sum_load) 
		begin
			sum<=sum+abs_diff;
		end
		else 
			sum<=sum;	 
end

always @(posedge clk)
begin
	if(sad_load)
	begin
		sad_reg<=sum;
	end
	else 
		sad_reg<=sad_reg;

end                  
assign abs_diff = diff0+diff1+diff2+diff3+diff4+diff5+diff6+diff7+diff8+diff9+diff10+diff11+diff12+diff13+diff14+diff15;

endmodule