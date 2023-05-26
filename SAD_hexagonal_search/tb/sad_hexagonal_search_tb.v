module sad_hexagonal_search_tb;
reg clk,rst,go;
reg  [7:0]coordinate_values_currentframe0,coordinate_values_currentframe1,coordinate_values_currentframe2,coordinate_values_currentframe3,coordinate_values_currentframe4,coordinate_values_currentframe5,coordinate_values_currentframe6;
reg  [7:0]coordinate_values_referenceframe0,coordinate_values_referenceframe1,coordinate_values_referenceframe2,coordinate_values_referenceframe3,coordinate_values_referenceframe4,coordinate_values_referenceframe5,coordinate_values_referenceframe6;
 wire [6:0] x_coordinates_currentframe0,x_coordinates_currentframe1,x_coordinates_currentframe2,x_coordinates_currentframe3,x_coordinates_currentframe4,x_coordinates_currentframe5,x_coordinates_currentframe6;
wire [6:0] y_coordinates_currentframe0,y_coordinates_currentframe1,y_coordinates_currentframe2,y_coordinates_currentframe3,y_coordinates_currentframe4,y_coordinates_currentframe5,y_coordinates_currentframe6;
wire [6:0] x_coordinates_referenceframe0,x_coordinates_referenceframe1,x_coordinates_referenceframe2,x_coordinates_referenceframe3,x_coordinates_referenceframe4,x_coordinates_referenceframe5,x_coordinates_referenceframe6;
wire [6:0] y_coordinates_referenceframe0,y_coordinates_referenceframe1,y_coordinates_referenceframe2,y_coordinates_referenceframe3,y_coordinates_referenceframe4,y_coordinates_referenceframe5,y_coordinates_referenceframe6;
wire fetchpixeldata;
wire [6:0] x_motion_coordinate,y_motion_coordinate;
wire [7:0] sad_value;

sad_hexagonal_search sad(clk,rst,go,coordinate_values_currentframe0,coordinate_values_currentframe1,coordinate_values_currentframe2,coordinate_values_currentframe3,coordinate_values_currentframe4,coordinate_values_currentframe5,coordinate_values_currentframe6,coordinate_values_referenceframe0,coordinate_values_referenceframe1,coordinate_values_referenceframe2,coordinate_values_referenceframe3,coordinate_values_referenceframe4,coordinate_values_referenceframe5,coordinate_values_referenceframe6,x_coordinates_currentframe0,x_coordinates_currentframe1,x_coordinates_currentframe2,x_coordinates_currentframe3,x_coordinates_currentframe4,x_coordinates_currentframe5,x_coordinates_currentframe6,y_coordinates_currentframe0,y_coordinates_currentframe1,y_coordinates_currentframe2,y_coordinates_currentframe3,y_coordinates_currentframe4,y_coordinates_currentframe5,y_coordinates_currentframe6,x_coordinates_referenceframe0,x_coordinates_referenceframe1,x_coordinates_referenceframe2,x_coordinates_referenceframe3,x_coordinates_referenceframe4,x_coordinates_referenceframe5,x_coordinates_referenceframe6,y_coordinates_referenceframe0,y_coordinates_referenceframe1,y_coordinates_referenceframe2,y_coordinates_referenceframe3,y_coordinates_referenceframe4,y_coordinates_referenceframe5,y_coordinates_referenceframe6,fetchpixeldata,x_motion_coordinate,y_motion_coordinate,sad_value);


reg [767:0] data1 [0:95];
reg [767:0] data2 [0:95];
initial $readmemh("/home/userdata/22mvd0107/SAD_module/SAD_hexagonal_search/tb/f22.txt", data1);
initial $readmemh("/home/userdata/22mvd0107/SAD_module/SAD_hexagonal_search/tb/f22.txt", data2);
reg [7:0] memory1 [0:95][0:95];
reg [7:0] memory2 [0:95][0:95];
integer i1,j1,i2,j2;
reg [6:0]a,b,c,d;
reg [0:95][7:0]row,column;
initial 
begin
	clk=1;
	rst=1;
	#55 rst=0;
end
//memory1: current frame data
initial
begin
	#55
	for(i1=0;i1<96;i1=i1+1)
	begin
		row=data1[i1];
		for(j1=0;j1<96;j1=j1+1)
		begin
			memory1[i1][j1]=row[j1];
		end
	end
	go=1;
end
//memory2: reference frame data
initial
begin
	#55
	for(i2=0;i2<96;i2=i2+1)
	begin
		row=data1[i2];
		for(j2=0;j2<96;j2=j2+1)
		begin
			memory2[i2][j2]=row[j2];
		end
	end
	go=1;
end
always @(posedge clk)
begin
	if(fetchpixeldata==1)
	begin
		coordinate_values_currentframe0<=memory1[x_coordinates_currentframe0][y_coordinates_currentframe0];
		coordinate_values_currentframe1<=memory1[x_coordinates_currentframe1][y_coordinates_currentframe1];
		coordinate_values_currentframe2<=memory1[x_coordinates_currentframe2][y_coordinates_currentframe2];
		coordinate_values_currentframe3<=memory1[x_coordinates_currentframe3][y_coordinates_currentframe3];
		coordinate_values_currentframe4<=memory1[x_coordinates_currentframe4][y_coordinates_currentframe4];
		coordinate_values_currentframe5<=memory1[x_coordinates_currentframe5][y_coordinates_currentframe5];
		coordinate_values_currentframe6<=memory1[x_coordinates_currentframe6][y_coordinates_currentframe6];

		coordinate_values_referenceframe0<=memory2[x_coordinates_referenceframe0][y_coordinates_referenceframe0];
		coordinate_values_referenceframe1<=memory2[x_coordinates_referenceframe1][y_coordinates_referenceframe1];
		coordinate_values_referenceframe2<=memory2[x_coordinates_referenceframe2][y_coordinates_referenceframe2];
		coordinate_values_referenceframe3<=memory2[x_coordinates_referenceframe3][y_coordinates_referenceframe3];
		coordinate_values_referenceframe4<=memory2[x_coordinates_referenceframe4][y_coordinates_referenceframe4];
		coordinate_values_referenceframe5<=memory2[x_coordinates_referenceframe5][y_coordinates_referenceframe5];
		coordinate_values_referenceframe6<=memory2[x_coordinates_referenceframe6][y_coordinates_referenceframe6];
	end
end

always #10 clk=!clk;

endmodule
