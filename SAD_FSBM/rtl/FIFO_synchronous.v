module FIFO_synchronous(input [7:0]data_in, 
						input clk,rst,rd,wr,
						output reg empty,full,
						output reg [4:0] FIFO_count,
						output reg [7:0]data_out);
						
						
reg [7:0]FIFO_memory[15:0]; //16 memory locations, each of size 8-bits declared
reg [3:0]rd_ptr,wr_ptr;				
/*
4 bit pointer declared as 16 memory locations are present. 
5-bit FIFO_count is taken in order to flag full, as it's not possible
if 4 bit FIFO_count can count till only (0-15)
*/


always @(posedge clk)
begin							//write operation  block
	if(wr && !full)
	begin
		FIFO_memory[wr_ptr]<=data_in;
	end
	else if(wr&&rd)
	begin
		FIFO_memory[wr_ptr]<=data_in;
	end
end

always @(posedge clk)
begin							//read operation  block
	if(rd && !empty)
	begin
		data_out<=FIFO_memory[rd_ptr];
	end
	else if(rd&&wr)
	begin
		data_out<=FIFO_memory[rd_ptr];
	end
end


always @(posedge clk)
begin						//wr and rd ptr inc block
	if(rst)
	begin
		{wr_ptr,rd_ptr}<=0;
	end
	else
	begin
		wr_ptr<=((wr && !full)||(rd&&wr))?wr_ptr+1:wr_ptr;
		rd_ptr<=((rd && !empty)||(rd&&wr))?rd_ptr+1:rd_ptr;
	end
end


always @(posedge clk)
begin
	if(rst)
	begin
		FIFO_count<=0;
	end
	else
	begin
		case({rd,wr})
		2'b00:FIFO_count<=FIFO_count;
		2'b01:FIFO_count<=(FIFO_count==16)?16:FIFO_count+1;
		2'b10:FIFO_count<=(FIFO_count==0)?0:FIFO_count-1;
		2'b11:FIFO_count<=FIFO_count;
		endcase
	end
end
assign full = (FIFO_count==16);
assign empty = (FIFO_count==0);
endmodule
