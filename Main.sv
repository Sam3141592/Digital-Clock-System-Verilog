module Main (
	input clk,    // Clock
	input m,
	input pause,
	input reset,
	input add_sub_2,
	input speedup,
	input speeddown,
	output [3:0]u_sec,
	output [2:0]t_sec,
	output [3:0]u_mins,
	output [2:0]t_mins
);

wire [2:0]clks;
wire clkeff;

ClockDivider clkdiv(clk,clks[0],clks[1],clks[2]);

mux42 m42(clkeff,clks[0],clks[1],clks[2],0,speedup,speeddown);

wire Wand0, Wand1;

and (Wand0,m,1);
and (Wand1,~m,1);

wire Wmux0,Wmux1;

mux21 m0(Wmux0,0,Wand0,add_sub_2);
mux21 m1(Wmux1,0,Wand1,add_sub_2);

wire Wand2,Wand3;

and(Wand2,~m,pause);
and(Wand3,m,pause);

wire Wor0,Wor1;

wire Wand4,Wand5;

or(Wor0,Wand4,Wand2);
or(Wor1,Wand5,Wand3);

wire mux2;

mux21 m2(mux2,~Wor0,Wor1,m);

wire Wd0;

D_Flip_Flop d0(clkeff,mux2,0,0,1,Wd0);

and(Wand4,~Wd0,~pause);
and(Wand5,Wd0,~pause);

wire Wor2;

wire Wor12;

or(Wor2,reset,Wor12);

wire Wor3;
wire Wand8,Wand6;

or(Wor3,Wand8,Wand6,pause);

FourBitCounterSynchronus csu(clkeff,Wd0,Wor2,Wor3,u_sec);

wire Wand10;

and(Wand10,~Wd0,u_sec[3],u_sec[1]);

wire Wand18;

and(Wand18,Wd0,u_sec[0],u_sec[3]);

wire Wor4;

or(Wor4,Wand18,Wand10);

wire Wand12;

and(Wand12, clkeff,Wor4);

wire Wor6;

or(Wor6,Wor4,Wor3);

ThreeBit_Seconds cmu(Wand12,Wd0,Wor2,Wor6,t_sec);

wire Wand11;

and(Wand11,~Wd0,t_sec[2],t_sec[1]);

wire Wd1;

wire Wd1bar;

D_Flip_Flop d1(Wand12,t_sec[2],0,0,1,Wd1,Wd1bar);

wire Wand19;

and(Wand19,Wd0,t_sec[0],t_sec[2],Wd1bar,Wand18);

wire Wor5;

or(Wor5,Wand11,Wand19);

wire Wand14;

and(Wand14, clkeff, Wor5);

wire Wor8;

or(Wor8,Wor5,Wor3);

FourBitCounterMinutes cst(Wand14,Wd0,Wor2,Wmux1,Wmux0,Wor8,u_mins);

wire Wand13;

and(Wand13,u_mins[3],u_mins[1],~Wd0);

wire Wd2;

wire Wd2bar;

D_Flip_Flop d2(Wand14,u_mins[3],0,0,1,Wd2,Wd2bar);

wire Wand20;

and(Wand20,Wd0,u_mins[0],u_mins[3],Wd2bar,Wand19);

wire Wor7;

or(Wor7,Wand13,Wand20);

wire Wnor4, Wnor3;

nor(Wnor4,u_mins[0],u_mins[1],u_mins[2],u_mins[3]);

nor(Wnor3,~u_mins[0],u_mins[1],u_mins[2],u_mins[3]);


wire Wor11;

or(Wor11,Wnor3,Wnor4);

wire Wand16;

and(Wand16,u_mins[3],Wmux1);

wire Wand17;

and(Wand17,Wor11,Wmux0);

wire Wand15;

and(Wand15, clkeff,Wor7);

wire Wor9,Wor10;

or(Wor9,Wand15,Wand17,Wand16);

or(Wor10,Wmux0,Wmux1,Wor7,Wor3);

ThreeBit_Minutes cmt(Wor9,Wd0,Wor2,Wor10,t_mins);

wire Wand9;

and(Wand9,~Wd0,t_sec[1],t_sec[0],u_mins[3],u_mins[0],t_mins[2]);

wire Wnor2;

nor(Wnor2,u_sec[0],u_sec[1],u_sec[2],u_sec[3]);

and(Wand8,Wnor2,Wand9);

wire Wnor1,Wnor0;

nor(Wnor1,t_sec[0],t_sec[2]);

nor(Wnor0,u_mins[0],u_mins[1],u_mins[2],u_mins[3]);

wire Wand7;

and(Wand7,t_mins[0],~Wmux0);

wire Wand21;

and(Wand21,t_mins[2],~t_mins[1],t_mins[0]);

wire Wnor5;

nor(Wnor5,t_mins[2],t_mins[1],t_mins[0]);

wire Wnor6;

nor(Wnor6,t_mins[0],t_mins[1],~t_mins[2]);

wire Wnor7;

nor(Wnor7,u_mins[3],u_mins[0],u_mins[2],u_mins[1]);

wire Wand22;
wire Wor13;

and(Wand22,t_sec[1],u_mins[3],u_mins[0],t_sec[0],Wor13,t_mins[2]);

wire Wand23;
wire Wand24;

and(Wand23,Wnor6,Wnor7,Wor13,Wand24);
and(Wand24,t_sec[1],~t_sec[0]);

or(Wor12,Wand23,Wand22,Wand21,Wnor5);

or(Wor13,u_sec[2],u_sec[1],u_sec[3],u_sec[0]);

and(Wand6,Wnor2,Wnor1,t_sec[1],Wnor0,t_mins[0],Wd0,~t_mins[1],Wand7);

endmodule