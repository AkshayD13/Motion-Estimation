module hexagon_coordinate_calculator(
input [6:0] centre_x,centre_y,
output [6:0] coordinate1_x,coordinate1_y,coordinate2_x,coordinate2_y,coordinate3_x,coordinate3_y,coordinate4_x,coordinate4_y,coordinate5_x,coordinate5_y,coordinate6_x,coordinate6_y,
output flag);

//vertical and horizontal distance of hexagon vertices from centre coordinate is 3

//vertex 1
assign coordinate1_x=centre_x-3;
assign coordinate1_y=centre_y-1;

//vertex 2
assign coordinate2_x=centre_x-3;
assign coordinate2_y=centre_y+1;

//vertex 3
assign coordinate3_x=centre_x;
assign coordinate3_y=centre_y+3;

//vertex 4
assign coordinate4_x=centre_x+3;
assign coordinate4_y=centre_y+1;

//vertex 5
assign coordinate5_x=centre_x+3;
assign coordinate5_y=centre_y-1;

//vertex 6
assign coordinate6_x=centre_x;
assign coordinate6_y=centre_y-3;

//flag denotes whether the generated hexagon coordinates are within the boundry of the frame or not. If not, the FSM skips the computation and the current centre is considered for the motion vector
assign flag=(((centre_x-3)>0)&&((centre_x+3)<96)&&((centre_y-3)>0)&&((centre_y+3)<96));

endmodule
