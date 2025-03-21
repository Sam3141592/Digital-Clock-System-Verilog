module FourBitCounterSynchronus (
   input clk,    // Clock
   input m,
   input reset,
   input pause,
   output [3:0]o
);

wire [3:0]qcomp;
wire [2:0]intermedites1;
wire [2:0]intermedites2;
wire [2:0]intermedites3;
wire and0;
wire and1;
wire res0;
wire res1;
wire res2;
wire res3;
wire andps0;
and(andps0,~pause,1);
T_Flip_Flop tff1(clk,andps0,and1,res0,1,o[0],qcomp[0]);
and (intermedites1[0],~m,o[0]),(intermedites1[1],m,qcomp[0]);
or (intermedites1[2],intermedites1[0],intermedites1[1]);
wire andps1;
and(andps1,intermedites1[2],~pause);
T_Flip_Flop tff2(clk,andps1,0,res1,1,o[1],qcomp[1]);
and (intermedites2[0],intermedites1[0],o[1]),(intermedites2[1],intermedites1[1],qcomp[1]);
or (intermedites2[2],intermedites2[0],intermedites2[1]);
wire andps2;
and(andps2,intermedites2[2],~pause);
T_Flip_Flop tff3(clk,andps2,0,res2,1,o[2],qcomp[2]);
and (intermedites3[0],intermedites2[0],o[2]),(intermedites3[1],intermedites2[1],qcomp[2]);
or (intermedites3[2],intermedites3[0],intermedites3[1]);
wire andps3;
and(andps3,intermedites3[2],~pause);
T_Flip_Flop tff4(clk,andps3,and1,res3,1,o[3],qcomp[3]);
and(and0, ~m, o[3],o[1]);
and(and1,m,o[0],o[1],o[2],o[3]);
or(res0, and0,reset);
or(res1,and0,and1,reset);
or(res2,reset,and0,and1);
or(res3,reset,and0);
endmodule