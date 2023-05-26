module SAD_tb;

reg [7:0]data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7,
		   data_in8,data_in9,data_in10,data_in11,data_in12,data_in13,data_in14,data_in15,
		   data_in16,data_in17,data_in18,data_in19,data_in20,data_in21,data_in22,data_in23,
		   data_in24,data_in25,data_in26,data_in27,data_in28,data_in29,data_in30,data_in31;
reg clk,rst,wr;
wire empty0,empty1,empty2,empty3,empty4,empty5,empty6,empty7,empty8,empty9,empty10,
				empty11,empty12,empty13,empty14,empty15,empty16,empty17,empty18,empty19,empty20,empty21,empty22,empty23,empty24,empty25,empty26,
				empty27,empty28,empty29,empty30,empty31,
				full0,full1,full2,full3,full4,full5,full6,full7,full8,full9,full10,
				full11,full12,full13,full14,full15,full16,full17,full18,full19,full20,full21,full22,full23,full24,full25,full26,
				full27,full28,full29,full30,full31;
wire [4:0]FIFO_count0,FIFO_count1,FIFO_count2,FIFO_count3,FIFO_count4,FIFO_count5,FIFO_count6,FIFO_count7,
				FIFO_count8,FIFO_count9,FIFO_count10,FIFO_count11,FIFO_count12,FIFO_count13,FIFO_count14,FIFO_count15,
				FIFO_count16,FIFO_count17,FIFO_count18,FIFO_count19,FIFO_count20,FIFO_count21,FIFO_count22,FIFO_count23,
				FIFO_count24,FIFO_count25,FIFO_count26,FIFO_count27,FIFO_count28,FIFO_count29,FIFO_count30,FIFO_count31;
wire [7:0] data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7,data_out8,
				data_out9,data_out10,data_out11,data_out12,data_out13,data_out14,data_out15,data_out16,data_out17,
				data_out18,data_out19,data_out20,data_out21,data_out22,data_out23,data_out24,
				data_out25,data_out26,data_out27,data_out28,data_out29,data_out30,data_out31;
wire [31:0]sad_reg;
wire [4:0] i;
wire go,data_load,FULL;
//reg [7:0]A0,B0,A1,B1,A2,B2,A3,B3,A4,B4,A5,B5,A6,B6,
		//A7,B7,A8,B8,A9,B9,A10,B10,A11,B11,A12,B12,A13,B13,A14,B14,A15,B15;
reg [0:15][7:0]A,B;
/*
reg[7:0]data_in1,data_in2;
// rd1,rd2 signals are controlled in top module

reg clk,rst,wr1,wr2;
wire empty1,full1,empty2,full2;
wire [8:0] FIFO_count1,FIFO_count2;
wire [7:0]data_out1,data_out2;
wire [31:0]sad_reg;
wire [8:0] I;
reg [7:0]A,B;*/

SAD_top dut ( .data_in0(A[0]),.data_in1(B[0]),.data_in2(A[1]),.data_in3(B[1]),.data_in4(A[2]),.data_in5(B[2]),.data_in6(A[3]),.data_in7(B[3]),
				.data_in8(A[4]),.data_in9(B[4]),.data_in10(A[5]),.data_in11(B[5]),.data_in12(A[6]),.data_in13(B[6]),.data_in14(A[7]),.data_in15(B[7]),
				.data_in16(A[8]),.data_in17(B[8]),.data_in18(A[9]),.data_in19(B[9]),.data_in20(A[10]),.data_in21(B[10]),.data_in22(A[11]),.data_in23(B[11]),
				.data_in24(A[12]),.data_in25(B[12]),.data_in26(A[13]),.data_in27(B[13]),.data_in28(A[14]),.data_in29(B[14]),.data_in30(A[15]),.data_in31(B[15]),
				.clk(clk),
				.rst(rst),
				.wr(wr),
				.empty0(empty0),.empty1(empty1),.empty2(empty2),.empty3(empty3),.empty4(empty4),.empty5(empty5),.empty6(empty6),.empty7(empty7),.empty8(empty8),.empty9(empty9),.empty10(empty10),
				.empty11(empty11),.empty12(empty12),.empty13(empty13),.empty14(empty14),.empty15(empty15),.empty16(empty16),.empty17(empty17),.empty18(empty18),.empty19(empty19),.empty20(empty20),
				.empty21(empty21),.empty22(empty22),.empty23(empty23),.empty24(empty24),.empty25(empty25),.empty26(empty26),.empty27(empty27),.empty28(empty28),.empty29(empty29),.empty30(empty30),.empty31(empty31),
				.full0(full0),.full1(full1),.full2(full2),.full3(full3),.full4(full4),.full5(full5),.full6(full6),.full7(full7),.full8(full8),.full9(full9),.full10(full10),
				.full11(full11),.full12(full12),.full13(full13),.full14(full14),.full15(full15),.full16(full16),.full17(full17),.full18(full18),.full19(full19),.full20(full20),
				.full21(full21),.full22(full22),.full23(full23),.full24(full24),.full25(full25),.full26(full26),.full27(full27),.full28(full28),.full29(full29),.full30(full30),.full31(full31),
				.FIFO_count0(FIFO_count0),.FIFO_count1(FIFO_count1),.FIFO_count2(FIFO_count2),.FIFO_count3(FIFO_count3),.FIFO_count4(FIFO_count4),.FIFO_count5(FIFO_count5),.FIFO_count6(FIFO_count6),.FIFO_count7(FIFO_count7),
				.FIFO_count8(FIFO_count8),.FIFO_count9(FIFO_count9),.FIFO_count10(FIFO_count10),.FIFO_count11(FIFO_count11),.FIFO_count12(FIFO_count12),.FIFO_count13(FIFO_count13),.FIFO_count14(FIFO_count14),.FIFO_count15(FIFO_count15),
				.FIFO_count16(FIFO_count16),.FIFO_count17(FIFO_count17),.FIFO_count18(FIFO_count18),.FIFO_count19(FIFO_count19),.FIFO_count20(FIFO_count20),.FIFO_count21(FIFO_count21),.FIFO_count22(FIFO_count22),.FIFO_count23(FIFO_count23),
				.FIFO_count24(FIFO_count24),.FIFO_count25(FIFO_count25),.FIFO_count26(FIFO_count26),.FIFO_count27(FIFO_count27),.FIFO_count28(FIFO_count28),.FIFO_count29(FIFO_count29),.FIFO_count30(FIFO_count30),.FIFO_count31(FIFO_count31),
				.data_out0(data_out0),.data_out1(data_out1),.data_out2(data_out2),.data_out3(data_out3),.data_out4(data_out4),.data_out5(data_out5),.data_out6(data_out6),.data_out7(data_out7),.data_out8(data_out8),
				.data_out9(data_out9),.data_out10(data_out10),.data_out11(data_out11),.data_out12(data_out12),.data_out13(data_out13),.data_out14(data_out14),.data_out15(data_out15),.data_out16(data_out16),
				.data_out17(data_out17),.data_out18(data_out18),.data_out19(data_out19),.data_out20(data_out20),.data_out21(data_out21),.data_out22(data_out22),.data_out23(data_out23),.data_out24(data_out24),
				.data_out25(data_out25),.data_out26(data_out26),.data_out27(data_out27),.data_out28(data_out28),.data_out29(data_out29),.data_out30(data_out30),.data_out31(data_out31),
				.sad_reg(sad_reg),
				.i(i));
				
reg [127:0] data1 [0:15];//16x16
reg [127:0] data2 [0:15];
initial $readmemb("D:\Project\Myimp\SAD_full_search\tb\f1.bin", data1);
initial $readmemb("D:\Project\Myimp\SAD_full_search\tb\f2.bin", data2);

integer i1,j1,i2,j2;
//reg a=1;
reg [0:15][7:0] part1,part2;
initial 
begin
	clk=1;
	rst=1;
	#55 rst=0;
	wr=0;
end

initial
begin
	#55
	for(i1=0;i1<16;i1=i1+1)
	begin
		{part1} = data1[i1];
		for(j1=0;j1<16;j1=j1+1)
		begin
			$display("A[i]:%b,",part1[j1]);
			#20 A[i1]=part1[j1];
			wr=1;
		end	
	end
	#20 if(FULL==1)
	begin
		wr=0;
	end
end



initial
begin
	#55
	for(i2=0;i2<16;i2=i2+1)
	begin
		//$display("%b",data2[i]);
		{part2} = data2[i2];
		for(j2=0;j2<16;j2=j2+1)
		begin
			//$display("B:%b,",part2[j2]);
			#20 B[i2]=part2[j2];
			wr=1;
		end	
	end
	#20 if(FULL==1)
	begin
		wr=0;
	end
end


always #10 clk=!clk;

assign FULL=(full0&&full1&&full2&&full3&&full4&&full5&&full6&&full7&&full8&&full9&&full10&&full1&&full12&&full13&&full14&&full15&&full16
             &&full17&&full18&&full19&&full20&&full21&&full22&&full23&&full24&&full25&&full26&&full27&&full28&&full29&&full30&&full31);
endmodule
