module ThreeBit_Seconds (
    input clk,    // Clock
   input m,
   input reset,
   input enable,
   output [2:0]o
    
);

wire [2:0]qcomp;
wire [2:0]intermedites1;
wire [2:0]intermedites2;
wire Wor[5:0];
wire Wand[2:0];
T_Flip_Flop tff1(clk,1,Wor[4],Wor[1],enable,o[0],qcomp[0]);
and (intermedites1[0],~m,o[0]),(intermedites1[1],m,qcomp[0]);
or (intermedites1[2],intermedites1[0],intermedites1[1]);
T_Flip_Flop tff2(clk,intermedites1[2],Wor[5],Wor[2],enable,o[1],qcomp[1]);
and (intermedites2[0],intermedites1[0],o[1]),(intermedites2[1],intermedites1[1],qcomp[1]);
or (intermedites2[2],intermedites2[0],intermedites2[1]);
T_Flip_Flop tff3(clk,intermedites2[2],Wand[2],Wor[3],enable,o[2],qcomp[2]);

and(Wand[0],m,reset);
and(Wand[1],~m,o[2],o[1]);
and(Wand[2],m,o[2],o[1],o[0]);
nor(Wor[0],~reset,m);
or(Wor[1],Wand[1],Wor[0]);
or(Wor[2],Wand[1],Wand[2]);
or(Wor[3],Wor[0],Wand[0],Wand[1]);
or(Wor[4],Wand[0],Wand[2]);
or(Wor[5],Wand[0],Wor[0]);





endmodule