module sad_hexagonal_search(
input clk,rst,go,		//go signal becomes high when all the data of the two frames get read in the external memory
input[7:0]coordinate_values_currentframe0,coordinate_values_currentframe1,coordinate_values_currentframe2,coordinate_values_currentframe3,coordinate_values_currentframe4,coordinate_values_currentframe5,coordinate_values_currentframe6,	
						//coordinate_values_currentframe is the register with the pixel data of 7 coordinates of current frame accessed from the external memory
input [7:0]coordinate_values_referenceframe0,coordinate_values_referenceframe1,coordinate_values_referenceframe2,coordinate_values_referenceframe3,coordinate_values_referenceframe4,coordinate_values_referenceframe5,coordinate_values_referenceframe6,
						//coordinate_values_reference frame is the register with the pixel data of 7 coordinates of reference frame accessed from the external memory
output reg [6:0] x_coordinates_currentframe0,output wire [6:0] x_coordinates_currentframe1,x_coordinates_currentframe2,x_coordinates_currentframe3,x_coordinates_currentframe4,x_coordinates_currentframe5,x_coordinates_currentframe6,
						//x_coordinates_currentframe is register with x coordinates of 7 pixels including center of current frame for the hexagonal search
output reg [6:0] y_coordinates_currentframe0,output wire [6:0] y_coordinates_currentframe1,y_coordinates_currentframe2,y_coordinates_currentframe3,y_coordinates_currentframe4,y_coordinates_currentframe5,y_coordinates_currentframe6,
						//y_coordinates_currentframe is register with y coordinates of 7 pixels including center of current frame for the hexagonal search
output reg [6:0] x_coordinates_referenceframe0,output wire [6:0] x_coordinates_referenceframe1,x_coordinates_referenceframe2,x_coordinates_referenceframe3,x_coordinates_referenceframe4,x_coordinates_referenceframe5,x_coordinates_referenceframe6,
						//x_coordinates_referenceframe is register with x coordinates of 7 pixels including center of reference frame for the hexagonal search
output reg [6:0] y_coordinates_referenceframe0,output wire [6:0] y_coordinates_referenceframe1,y_coordinates_referenceframe2,y_coordinates_referenceframe3,y_coordinates_referenceframe4,y_coordinates_referenceframe5,y_coordinates_referenceframe6,
						//y_coordinates_referenceframe is register with y coordinates of 7 pixels including center of reference frame for the hexagonal search
output reg fetchpixeldata,				//Used as a flag to fetch the current and reference pixel data from the external memory
output reg [6:0] x_motion_coordinate,		//x_motion coordinate register will store the final coordinate after hexagonal search for a particular block to draw the motion vector
output reg [6:0] y_motion_coordinate,		//y_motion coordinate register will store the final coordinate after hexagonal search for a particular block to draw the motion vector
output reg [7:0] sad_value);			//sad_value is a register which stores sad values of a particular block(requirement doubful)

reg [3:0] p_state,n_state;
reg [2:0] i,j;					//i represents number of rows of blocks in a frame and j represents number of rows of columns in a frame
reg [1:0] k; 					//k represents number of hexagon centre changes
reg [5:0] counter;				//counter used to check on which block in current frame FSM is working on and to fetch appropriate centre coordinates of the reference 							search area
wire [6:0] x_centre_reference,y_centre_reference;
reg [7:0] cf_pixelvalue0,cf_pixelvalue1,cf_pixelvalue2,cf_pixelvalue3,cf_pixelvalue4,cf_pixelvalue5,cf_pixelvalue6,rf_pixelvalue0,rf_pixelvalue1,rf_pixelvalue2,rf_pixelvalue3,rf_pixelvalue4,rf_pixelvalue5,rf_pixelvalue6;
wire flag_currentframe,flag_referenceframe;	//these flags check if the hexagonal coordinates calculated are within the boundry of frame or not
reg i_clr,i_inc,j_clr,j_inc,k_clr,k_inc,counter_clr,counter_inc,sad_load,centre_initialization,current_centre_shift_row,current_centre_shift_column,reference_centre_shift;
wire [11:0] sad_min;
wire [2:0] new_centre;
parameter [3:0] s0=4'b0000;
parameter [3:0] s1=4'b0001;
parameter [3:0] s2=4'b0010;
parameter [3:0] s3=4'b0011;
parameter [3:0] s4=4'b0100;
parameter [3:0] s5=4'b0101;
parameter [3:0] s6=4'b0110;
parameter [3:0] s7=4'b0111;
parameter [3:0] s8=4'b1000;
parameter [3:0] s9=4'b1001;
parameter [3:0] s10=4'b1010;
parameter [3:0] s11=4'b1011;

//Fetching the centre point of the search area in the reference frame
reference_search_area_centre reference_frame_centres(.counter(counter),.x_centre_reference(x_centre_reference),.y_centre_reference(y_centre_reference));

//Instantiations to get the coordinates of hexagon for current and reference frame
hexagon_coordinate_calculator cf_coordinates(.centre_x(x_coordinates_currentframe0),.centre_y(y_coordinates_currentframe0),.coordinate1_x(x_coordinates_currentframe1),.coordinate1_y(y_coordinates_currentframe1),.coordinate2_x(x_coordinates_currentframe2),.coordinate2_y(y_coordinates_currentframe2),.coordinate3_x(x_coordinates_currentframe3),.coordinate3_y(y_coordinates_currentframe3),.coordinate4_x(x_coordinates_currentframe4),.coordinate4_y(y_coordinates_currentframe4),.coordinate5_x(x_coordinates_currentframe5),.coordinate5_y(y_coordinates_currentframe5),.coordinate6_x(x_coordinates_currentframe6),.coordinate6_y(y_coordinates_currentframe6),.flag(flag_currentframe));

hexagon_coordinate_calculator rf_coordinates(.centre_x(x_coordinates_referenceframe0),.centre_y(y_coordinates_referenceframe0),.coordinate1_x(x_coordinates_referenceframe1),.coordinate1_y(y_coordinates_referenceframe1),.coordinate2_x(x_coordinates_referenceframe2),.coordinate2_y(y_coordinates_referenceframe2),.coordinate3_x(x_coordinates_referenceframe3),.coordinate3_y(y_coordinates_referenceframe3),.coordinate4_x(x_coordinates_referenceframe4),.coordinate4_y(y_coordinates_referenceframe4),.coordinate5_x(x_coordinates_referenceframe5),.coordinate5_y(y_coordinates_referenceframe5),.coordinate6_x(x_coordinates_referenceframe6),.coordinate6_y(y_coordinates_referenceframe6),.flag(flag_referenceframe));

sad_calculation sad(.coordinate_values_currentframe0(cf_pixelvalue0),.coordinate_values_currentframe1(cf_pixelvalue1),.coordinate_values_currentframe2(cf_pixelvalue2),.coordinate_values_currentframe3(cf_pixelvalue3),.coordinate_values_currentframe4(cf_pixelvalue4),.coordinate_values_currentframe5(cf_pixelvalue5),.coordinate_values_currentframe6(cf_pixelvalue6),.coordinate_values_referenceframe0(rf_pixelvalue0),.coordinate_values_referenceframe1(rf_pixelvalue1),.coordinate_values_referenceframe2(rf_pixelvalue2),.coordinate_values_referenceframe3(rf_pixelvalue3),.coordinate_values_referenceframe4(rf_pixelvalue4),.coordinate_values_referenceframe5(rf_pixelvalue5),.coordinate_values_referenceframe6(rf_pixelvalue6),.sad_min(sad_min),.new_centre(new_centre));

always @(posedge clk)
begin
	if(rst)
	begin
		p_state<=s0;
	end
	else
	begin
		p_state<=n_state;
	end
end

always @(*)
begin
	i_clr=1'b0;
	i_inc=1'b0;
	j_clr=1'b0;
	j_inc=1'b0;
	k_clr=1'b0;
	k_inc=1'b0;
	counter_clr=1'b0;
	counter_inc=1'b0;
	fetchpixeldata=1'b0;
	sad_load=1'b0;
	centre_initialization=1'b0;
	current_centre_shift_row=1'b0;
	current_centre_shift_column=1'b0;
	reference_centre_shift=1'b0;
	case(p_state)
	
	s0: n_state=(go==1)?s1:s0;
	
	s1:begin
	i_clr=1'b1;
	j_clr=1'b1;
	k_clr=1'b1;
	counter_clr=1'b1;
	n_state=s2;
	end

	s2: n_state=(i<6)?s3:s0;
	
	s3: n_state=(j<6)?s4:s11;
	
	s4: begin 
	centre_initialization=1'b1;	
	n_state=(k<3)?s5:s9;
	end
	
	s5: begin
	fetchpixeldata=1'b1;
	if(flag_referenceframe==1) n_state=s6;
	else n_state=s9;
	end

	s6: begin
	cf_pixelvalue0=coordinate_values_currentframe0;
	cf_pixelvalue1=coordinate_values_currentframe1;
	cf_pixelvalue2=coordinate_values_currentframe2;
	cf_pixelvalue3=coordinate_values_currentframe3;
	cf_pixelvalue4=coordinate_values_currentframe4;
	cf_pixelvalue5=coordinate_values_currentframe5;
	cf_pixelvalue6=coordinate_values_currentframe6;
	rf_pixelvalue0=coordinate_values_referenceframe0;
	rf_pixelvalue1=coordinate_values_referenceframe1;
	rf_pixelvalue2=coordinate_values_referenceframe2;
	rf_pixelvalue3=coordinate_values_referenceframe3;
	rf_pixelvalue4=coordinate_values_referenceframe4;
	rf_pixelvalue5=coordinate_values_referenceframe5;
	rf_pixelvalue6=coordinate_values_referenceframe6;
	n_state=s7;
	end
	
	s7: begin
	if(new_centre==0)
	begin
		n_state=s9;
	end
	else
	begin
		n_state=s8;
	end
	end

	s8: begin
	sad_value=sad_min;
	k_inc=1'b1;
	reference_centre_shift=1'b1;
	n_state=s4;
	end

	s9: begin
	k_clr=1'b1;
	x_motion_coordinate=x_coordinates_referenceframe0;
	y_motion_coordinate=y_coordinates_referenceframe0;
	n_state=s10;
	end

	s10: begin
	j_inc=1'b1;
	counter_inc=1'b1;
	current_centre_shift_column=1'b1;
	//Add logic to shift the current centre to the next block for processing
	n_state=s3;
	end
	
	s11: begin
	i_inc=1'b1;
	j_clr=1'b1;
	k_clr=1'b1;
	current_centre_shift_row=1'b1;
	//Add logic to shift the centre to the next row
	n_state=s2;
	end
	endcase
end

always @ (posedge clk)
begin
	if(i_clr || (i == 6)) 
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

always @ (posedge clk)
begin
	if(j_clr || (j == 6)) 
	begin
		j<=1'b0;
	end
	else if(j_inc)
	begin
		j<=j+1;
	end
	else 
		j<=j;
end

always @ (posedge clk)
begin
	if(k_clr || (k == 6)) 
	begin
		k<=1'b0;
	end
	else if(k_inc)
	begin
		k<=k+1;
	end
	else 
		k<=k;
end

always @ (posedge clk)
begin
	if(counter_clr || (counter == 36)) 
	begin
		counter<=1'b0;
	end
	else if(counter_inc)
	begin
		counter<=counter+1;
	end
	else 
		counter<=counter;
end

//always block to store the reference hexagon coordinates in s4,s8 state
always @(posedge clk)
begin
	if(k==0&&centre_initialization==1)
	begin
		x_coordinates_referenceframe0<=x_centre_reference;
		y_coordinates_referenceframe0<=y_centre_reference;
	end
	else if(reference_centre_shift==1)
	begin
		if(new_centre==1)
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe1;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe1;
		end
		else if(new_centre==2)
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe2;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe2;
		end
		else if(new_centre==3)
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe3;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe3;
		end
		else if(new_centre==4)
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe4;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe4;
		end
		else if(new_centre==5)
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe5;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe5;
		end
		else if(new_centre==6)
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe6;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe6;
		end
		else
		begin
			x_coordinates_referenceframe0<=x_coordinates_referenceframe0;
			y_coordinates_referenceframe0<=y_coordinates_referenceframe0;
		end
	end
	else
	begin
		x_coordinates_referenceframe0<=x_coordinates_referenceframe0;
		y_coordinates_referenceframe0<=y_coordinates_referenceframe0;
	end
end

//always block to store the current hexagon coordinates in s4,s10 state
always @(posedge clk)
begin
	if(i==0&&j==0&&k==0&&centre_initialization==1)
	begin
		x_coordinates_currentframe0<=8;
		y_coordinates_currentframe0<=8;
	end
	else if(current_centre_shift_column==1)
	begin
		x_coordinates_currentframe0<=x_coordinates_currentframe0;
		y_coordinates_currentframe0<=y_coordinates_currentframe0+16;
	end
	else if(current_centre_shift_row==1)
	begin
		x_coordinates_currentframe0<=x_coordinates_currentframe0+16;
		y_coordinates_currentframe0<=y_coordinates_currentframe0;
	end
	else
	begin
		x_coordinates_currentframe0<=x_coordinates_currentframe0;
		y_coordinates_currentframe0<=y_coordinates_currentframe0;
	end
end

endmodule
