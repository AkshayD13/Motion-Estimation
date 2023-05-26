module SAD_top( data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7,
				data_in8,data_in9,data_in10,data_in11,data_in12,data_in13,data_in14,data_in15,
				data_in16,data_in17,data_in18,data_in19,data_in20,data_in21,data_in22,data_in23,
				data_in24,data_in25,data_in26,data_in27,data_in28,data_in29,data_in30,data_in31,
				clk,
				rst,
				wr,
				empty0,empty1,empty2,empty3,empty4,empty5,empty6,empty7,empty8,empty9,empty10,
				empty11,empty12,empty13,empty14,empty15,empty16,empty17,empty18,empty19,empty20,
				empty21,empty22,empty23,empty24,empty25,empty26,empty27,empty28,empty29,empty30,empty31,
				full0,full1,full2,full3,full4,full5,full6,full7,full8,full9,full10,
				full11,full12,full13,full14,full15,full16,full17,full18,full19,full20,
				full21,full22,full23,full24,full25,full26,full27,full28,full29,full30,full31,
				FIFO_count0,FIFO_count1,FIFO_count2,FIFO_count3,FIFO_count4,FIFO_count5,FIFO_count6,FIFO_count7,
				FIFO_count8,FIFO_count9,FIFO_count10,FIFO_count11,FIFO_count12,FIFO_count13,FIFO_count14,FIFO_count15,
				FIFO_count16,FIFO_count17,FIFO_count18,FIFO_count19,FIFO_count20,FIFO_count21,FIFO_count22,FIFO_count23,
				FIFO_count24,FIFO_count25,FIFO_count26,FIFO_count27,FIFO_count28,FIFO_count29,FIFO_count30,FIFO_count31,
				data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7,data_out8,
				data_out9,data_out10,data_out11,data_out12,data_out13,data_out14,data_out15,data_out16,
				data_out17,data_out18,data_out19,data_out20,data_out21,data_out22,data_out23,data_out24,
				data_out25,data_out26,data_out27,data_out28,data_out29,data_out30,data_out31,
				sad_reg,
				i);
input [7:0]data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7,
		   data_in8,data_in9,data_in10,data_in11,data_in12,data_in13,data_in14,data_in15,
		   data_in16,data_in17,data_in18,data_in19,data_in20,data_in21,data_in22,data_in23,
		   data_in24,data_in25,data_in26,data_in27,data_in28,data_in29,data_in30,data_in31;
input clk,rst,wr;
output wire empty0,empty1,empty2,empty3,empty4,empty5,empty6,empty7,empty8,empty9,empty10,
				empty11,empty12,empty13,empty14,empty15,empty16,empty17,empty18,empty19,empty20,empty21,empty22,empty23,empty24,empty25,empty26,
				empty27,empty28,empty29,empty30,empty31,
				full0,full1,full2,full3,full4,full5,full6,full7,full8,full9,full10,
				full11,full12,full13,full14,full15,full16,full17,full18,full19,full20,full21,full22,full23,full24,full25,full26,
				full27,full28,full29,full30,full31;
output wire [4:0]FIFO_count0,FIFO_count1,FIFO_count2,FIFO_count3,FIFO_count4,FIFO_count5,FIFO_count6,FIFO_count7,
				FIFO_count8,FIFO_count9,FIFO_count10,FIFO_count11,FIFO_count12,FIFO_count13,FIFO_count14,FIFO_count15,
				FIFO_count16,FIFO_count17,FIFO_count18,FIFO_count19,FIFO_count20,FIFO_count21,FIFO_count22,FIFO_count23,
				FIFO_count24,FIFO_count25,FIFO_count26,FIFO_count27,FIFO_count28,FIFO_count29,FIFO_count30,FIFO_count31;
output wire [7:0] data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7,data_out8,
				data_out9,data_out10,data_out11,data_out12,data_out13,data_out14,data_out15,data_out16,data_out17,
				data_out18,data_out19,data_out20,data_out21,data_out22,data_out23,data_out24,
				data_out25,data_out26,data_out27,data_out28,data_out29,data_out30,data_out31;
output [31:0]sad_reg;
output [4:0] i;
wire go,data_load,FULL;

FIFO_synchronous fifo0( .data_in(data_in0),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty0),
						.full(full0),
						.FIFO_count(FIFO_count0),
						.data_out(data_out0));
						
FIFO_synchronous fifo1( .data_in(data_in1),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty1),
						.full(full1),
						.FIFO_count(FIFO_count1),
						.data_out(data_out1));
						
FIFO_synchronous fifo2( .data_in(data_in2),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty2),
						.full(full2),
						.FIFO_count(FIFO_count2),
						.data_out(data_out2));

FIFO_synchronous fifo3( .data_in(data_in3),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty3),
						.full(full3),
						.FIFO_count(FIFO_count3),
						.data_out(data_out3));
						
FIFO_synchronous fifo4( .data_in(data_in4),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty4),
						.full(full4),
						.FIFO_count(FIFO_count4),
						.data_out(data_out4));

FIFO_synchronous fifo5( .data_in(data_in5),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty5),
						.full(full5),
						.FIFO_count(FIFO_count5),
						.data_out(data_out5));

FIFO_synchronous fifo6( .data_in(data_in6),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty6),
						.full(full6),
						.FIFO_count(FIFO_count6),
						.data_out(data_out6));
						
FIFO_synchronous fifo7( .data_in(data_in7),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty7),
						.full(full7),
						.FIFO_count(FIFO_count7),
						.data_out(data_out7));
						
FIFO_synchronous fifo8( .data_in(data_in8),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty8),
						.full(full8),
						.FIFO_count(FIFO_count8),
						.data_out(data_out8));

FIFO_synchronous fifo9( .data_in(data_in9),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty9),
						.full(full9),
						.FIFO_count(FIFO_count9),
						.data_out(data_out9));

FIFO_synchronous fifo10( .data_in(data_in10),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty10),
						.full(full10),
						.FIFO_count(FIFO_count10),
						.data_out(data_out10));
						
FIFO_synchronous fifo11( .data_in(data_in11),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty11),
						.full(full11),
						.FIFO_count(FIFO_count11),
						.data_out(data_out11));
						
						
FIFO_synchronous fifo12( .data_in(data_in12),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty12),
						.full(full12),
						.FIFO_count(FIFO_count12),
						.data_out(data_out12));

FIFO_synchronous fifo13( .data_in(data_in13),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty13),
						.full(full13),
						.FIFO_count(FIFO_count13),
						.data_out(data_out13));
						
FIFO_synchronous fifo14( .data_in(data_in14),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty14),
						.full(full14),
						.FIFO_count(FIFO_count14),
						.data_out(data_out14));
						
FIFO_synchronous fifo15( .data_in(data_in15),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty15),
						.full(full15),
						.FIFO_count(FIFO_count15),
						.data_out(data_out15));

FIFO_synchronous fifo16( .data_in(data_in16),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty16),
						.full(full16),
						.FIFO_count(FIFO_count16),
						.data_out(data_out16));
						
FIFO_synchronous fifo17( .data_in(data_in17),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty17),
						.full(full17),
						.FIFO_count(FIFO_count17),
						.data_out(data_out17));
						
FIFO_synchronous fifo18( .data_in(data_in18),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty18),
						.full(full18),
						.FIFO_count(FIFO_count18),
						.data_out(data_out18));

FIFO_synchronous fifo19( .data_in(data_in19),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty19),
						.full(full19),
						.FIFO_count(FIFO_count19),
						.data_out(data_out19));
						
FIFO_synchronous fifo20( .data_in(data_in20),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty20),
						.full(full20),
						.FIFO_count(FIFO_count20),
						.data_out(data_out20));

FIFO_synchronous fifo21( .data_in(data_in21),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty21),
						.full(full21),
						.FIFO_count(FIFO_count21),
						.data_out(data_out21));

FIFO_synchronous fifo22( .data_in(data_in22),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty22),
						.full(full22),
						.FIFO_count(FIFO_count22),
						.data_out(data_out22));
						
FIFO_synchronous fifo23( .data_in(data_in23),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty23),
						.full(full23),
						.FIFO_count(FIFO_count23),
						.data_out(data_out23));
						
FIFO_synchronous fifo24( .data_in(data_in24),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty24),
						.full(full24),
						.FIFO_count(FIFO_count24),
						.data_out(data_out24));

FIFO_synchronous fifo25( .data_in(data_in25),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty25),
						.full(full25),
						.FIFO_count(FIFO_count25),
						.data_out(data_out25));

FIFO_synchronous fifo26( .data_in(data_in26),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty26),
						.full(full26),
						.FIFO_count(FIFO_count26),
						.data_out(data_out26));
						
FIFO_synchronous fifo27( .data_in(data_in27),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty27),
						.full(full27),
						.FIFO_count(FIFO_count27),
						.data_out(data_out27));
						
						
FIFO_synchronous fifo28( .data_in(data_in28),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty28),
						.full(full28),
						.FIFO_count(FIFO_count28),
						.data_out(data_out28));

FIFO_synchronous fifo29( .data_in(data_in29),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty29),
						.full(full29),
						.FIFO_count(FIFO_count29),
						.data_out(data_out29));
						
FIFO_synchronous fifo30( .data_in(data_in30),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty30),
						.full(full30),
						.FIFO_count(FIFO_count30),
						.data_out(data_out30));
						
FIFO_synchronous fifo31( .data_in(data_in31),
						.clk(clk),
						.rst(rst),
						.rd(rd),
						.wr(wr),
						.empty(empty31),
						.full(full31),
						.FIFO_count(FIFO_count31),
						.data_out(data_out31));
assign go=(FULL)?1:0;

//assign {wr1,wr2}=((empty1&&empty2)||(~go))?2'b11:2'b00;
sad_controlpath cp (.A0(data_out0),.B0(data_out1),
					.A1(data_out2),.B1(data_out3),
					.A2(data_out4),.B2(data_out5),
					.A3(data_out6),.B3(data_out7),
					.A4(data_out8),.B4(data_out9),
					.A5(data_out10),.B5(data_out11),
					.A6(data_out12),.B6(data_out13),
					.A7(data_out14),.B7(data_out15),
					.A8(data_out16),.B8(data_out17),
					.A9(data_out18),.B9(data_out19),
					.A10(data_out20),.B10(data_out21),
					.A11(data_out22),.B11(data_out23),
					.A12(data_out24),.B12(data_out25),
					.A13(data_out26),.B13(data_out27),
					.A14(data_out28),.B14(data_out29),
					.A15(data_out30),.B15(data_out31),
					.clk(clk),.rst(rst),.go(go),.sad_reg(sad_reg),.i(i),.data_load(data_load));
/*sad_controlpath controlpath(.A(data_out1),
							.B(data_out2),
							.clk(clk),
							.rst(rst),
							.go(go),
							.sad_reg(sad_reg),
							.i(i),
							.data_load(data_load));*/
assign rd=(data_load)?1'b1:1'b0;
assign FULL=(full0&&full1&&full2&&full3&&full4&&full5&&full6&&full7&&full8&&full9&&full10&&full1&&full12&&full13&&full14&&full15&&full16
             &&full17&&full18&&full19&&full20&&full21&&full22&&full23&&full24&&full25&&full26&&full27&&full28&&full29&&full30&&full31);
endmodule

//notes:
//make read 1 only when data_load is 1
//rd can be read when data_load is 1 to synchronize the loading of the data from the FIFO to the registers A,B

