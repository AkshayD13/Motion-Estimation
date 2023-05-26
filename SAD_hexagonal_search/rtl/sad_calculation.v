module sad_calculation(
input[7:0]coordinate_values_currentframe0,coordinate_values_currentframe1,coordinate_values_currentframe2,coordinate_values_currentframe3,coordinate_values_currentframe4,coordinate_values_currentframe5,coordinate_values_currentframe6,	
input [7:0]coordinate_values_referenceframe0,coordinate_values_referenceframe1,coordinate_values_referenceframe2,coordinate_values_referenceframe3,coordinate_values_referenceframe4,coordinate_values_referenceframe5,coordinate_values_referenceframe6,
output [11:0] sad_min,output [2:0] new_centre);

wire [7:0] ad0[0:6];
wire [7:0] ad1[0:6];
wire [7:0] ad2[0:6];
wire [7:0] ad3[0:6];
wire [7:0] ad4[0:6];
wire [7:0] ad5[0:6];
wire [7:0] ad6[0:6];
wire [6:0]bout0,bout1,bout2,bout3,bout4,bout5,bout6;
wire [12:0] sad0,sad1,sad2,sad3,sad4,sad5,sad6,comp1,comp2,comp3,comp4,comp5;
//calculating absolute differences and SAD value for each point of the hexagon including the centre
cla_8bit_subtractor sub00(coordinate_values_currentframe0,coordinate_values_referenceframe0,ad0[0],bout0[0]);
cla_8bit_subtractor sub01(coordinate_values_currentframe0,coordinate_values_referenceframe1,ad0[1],bout0[1]);
cla_8bit_subtractor sub02(coordinate_values_currentframe0,coordinate_values_referenceframe2,ad0[2],bout0[2]);
cla_8bit_subtractor sub03(coordinate_values_currentframe0,coordinate_values_referenceframe3,ad0[3],bout0[3]);
cla_8bit_subtractor sub04(coordinate_values_currentframe0,coordinate_values_referenceframe4,ad0[4],bout0[4]);
cla_8bit_subtractor sub05(coordinate_values_currentframe0,coordinate_values_referenceframe5,ad0[5],bout0[5]);
cla_8bit_subtractor sub06(coordinate_values_currentframe0,coordinate_values_referenceframe6,ad0[6],bout0[6]);

assign sad0=((ad0[0]+ad0[1])+(ad0[2]+ad0[3]))+(ad0[4]+ad0[5])+ad0[6];

cla_8bit_subtractor sub10(coordinate_values_currentframe1,coordinate_values_referenceframe0,ad1[0],bout1[0]);
cla_8bit_subtractor sub11(coordinate_values_currentframe1,coordinate_values_referenceframe1,ad1[1],bout1[1]);
cla_8bit_subtractor sub12(coordinate_values_currentframe1,coordinate_values_referenceframe2,ad1[2],bout1[2]);
cla_8bit_subtractor sub13(coordinate_values_currentframe1,coordinate_values_referenceframe3,ad1[3],bout1[3]);
cla_8bit_subtractor sub14(coordinate_values_currentframe1,coordinate_values_referenceframe4,ad1[4],bout1[4]);
cla_8bit_subtractor sub15(coordinate_values_currentframe1,coordinate_values_referenceframe5,ad1[5],bout1[5]);
cla_8bit_subtractor sub16(coordinate_values_currentframe1,coordinate_values_referenceframe6,ad1[6],bout1[6]);

assign sad1=((ad1[0]+ad1[1])+(ad1[2]+ad1[3]))+(ad1[4]+ad1[5])+ad1[6];

cla_8bit_subtractor sub20(coordinate_values_currentframe2,coordinate_values_referenceframe0,ad2[0],bout2[0]);
cla_8bit_subtractor sub21(coordinate_values_currentframe2,coordinate_values_referenceframe1,ad2[1],bout2[1]);
cla_8bit_subtractor sub22(coordinate_values_currentframe2,coordinate_values_referenceframe2,ad2[2],bout2[2]);
cla_8bit_subtractor sub23(coordinate_values_currentframe2,coordinate_values_referenceframe3,ad2[3],bout2[3]);
cla_8bit_subtractor sub24(coordinate_values_currentframe2,coordinate_values_referenceframe4,ad2[4],bout2[4]);
cla_8bit_subtractor sub25(coordinate_values_currentframe2,coordinate_values_referenceframe5,ad2[5],bout2[5]);
cla_8bit_subtractor sub26(coordinate_values_currentframe2,coordinate_values_referenceframe6,ad2[6],bout2[6]);

assign sad2=((ad2[0]+ad2[1])+(ad2[2]+ad2[3]))+(ad2[4]+ad2[5])+ad2[6];

cla_8bit_subtractor sub30(coordinate_values_currentframe3,coordinate_values_referenceframe0,ad3[0],bout3[0]);
cla_8bit_subtractor sub31(coordinate_values_currentframe3,coordinate_values_referenceframe1,ad3[1],bout3[1]);
cla_8bit_subtractor sub32(coordinate_values_currentframe3,coordinate_values_referenceframe2,ad3[2],bout3[2]);
cla_8bit_subtractor sub33(coordinate_values_currentframe3,coordinate_values_referenceframe3,ad3[3],bout3[3]);
cla_8bit_subtractor sub34(coordinate_values_currentframe3,coordinate_values_referenceframe4,ad3[4],bout3[4]);
cla_8bit_subtractor sub35(coordinate_values_currentframe3,coordinate_values_referenceframe5,ad3[5],bout3[5]);
cla_8bit_subtractor sub36(coordinate_values_currentframe3,coordinate_values_referenceframe6,ad3[6],bout3[6]);

assign sad3=((ad3[0]+ad3[1])+(ad3[2]+ad3[3]))+(ad3[4]+ad3[5])+ad3[6];

cla_8bit_subtractor sub40(coordinate_values_currentframe4,coordinate_values_referenceframe0,ad4[0],bout4[0]);
cla_8bit_subtractor sub41(coordinate_values_currentframe4,coordinate_values_referenceframe1,ad4[1],bout4[1]);
cla_8bit_subtractor sub42(coordinate_values_currentframe4,coordinate_values_referenceframe2,ad4[2],bout4[2]);
cla_8bit_subtractor sub43(coordinate_values_currentframe4,coordinate_values_referenceframe3,ad4[3],bout4[3]);
cla_8bit_subtractor sub44(coordinate_values_currentframe4,coordinate_values_referenceframe4,ad4[4],bout4[4]);
cla_8bit_subtractor sub45(coordinate_values_currentframe4,coordinate_values_referenceframe5,ad4[5],bout4[5]);
cla_8bit_subtractor sub46(coordinate_values_currentframe4,coordinate_values_referenceframe6,ad4[6],bout4[6]);

assign sad4=((ad4[0]+ad4[1])+(ad4[2]+ad4[3]))+(ad4[4]+ad4[5])+ad4[6];

cla_8bit_subtractor sub50(coordinate_values_currentframe5,coordinate_values_referenceframe0,ad5[0],bout5[0]);
cla_8bit_subtractor sub51(coordinate_values_currentframe5,coordinate_values_referenceframe1,ad5[1],bout5[1]);
cla_8bit_subtractor sub52(coordinate_values_currentframe5,coordinate_values_referenceframe2,ad5[2],bout5[2]);
cla_8bit_subtractor sub53(coordinate_values_currentframe5,coordinate_values_referenceframe3,ad5[3],bout5[3]);
cla_8bit_subtractor sub54(coordinate_values_currentframe5,coordinate_values_referenceframe4,ad5[4],bout5[4]);
cla_8bit_subtractor sub55(coordinate_values_currentframe5,coordinate_values_referenceframe5,ad5[5],bout5[5]);
cla_8bit_subtractor sub56(coordinate_values_currentframe5,coordinate_values_referenceframe6,ad5[6],bout5[6]);

assign sad5=((ad5[0]+ad5[1])+(ad5[2]+ad5[3]))+(ad5[4]+ad5[5])+ad5[6];

cla_8bit_subtractor sub60(coordinate_values_currentframe6,coordinate_values_referenceframe0,ad6[0],bout6[0]);
cla_8bit_subtractor sub61(coordinate_values_currentframe6,coordinate_values_referenceframe1,ad6[1],bout6[1]);
cla_8bit_subtractor sub62(coordinate_values_currentframe6,coordinate_values_referenceframe2,ad6[2],bout6[2]);
cla_8bit_subtractor sub63(coordinate_values_currentframe6,coordinate_values_referenceframe3,ad6[3],bout6[3]);
cla_8bit_subtractor sub64(coordinate_values_currentframe6,coordinate_values_referenceframe4,ad6[4],bout6[4]);
cla_8bit_subtractor sub65(coordinate_values_currentframe6,coordinate_values_referenceframe5,ad6[5],bout6[5]);
cla_8bit_subtractor sub66(coordinate_values_currentframe6,coordinate_values_referenceframe6,ad6[6],bout6[6]);

assign sad6=((ad6[0]+ad6[1])+(ad6[2]+ad6[3]))+(ad6[4]+ad6[5])+ad6[6];



//Comparison logic to find the minimum SAD value out of total 7 SAD values
//comp6 has the minimum SAD value which is used to take the decision whether to shift the centre of the hexagon to any vertex or not
assign comp1=(sad0>sad1)?sad1:sad0;
assign comp2=(comp1>sad2)?sad2:comp1;
assign comp3=(comp2>sad3)?sad3:comp2;
assign comp4=(comp3>sad4)?sad4:comp3;
assign comp5=(comp4>sad5)?sad5:comp4;
assign sad_min=(comp5>sad6)?sad6:comp5;

//logic to obtain the vertex in the reference frame which corresponds to the vertex in the current frame with minimum SAD value
assign new_centre=(sad_min==sad0)?3'b000:(sad_min==sad1)?3'b001:(sad_min==sad2)?3'b010:(sad_min==sad3)?3'b011:(sad_min==sad4)?3'b100:(sad_min==sad5)?3'b101:3'b110;

endmodule









