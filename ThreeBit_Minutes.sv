module ThreeBit_Minutes (
   input clk,    // Clock
   input m,
   input reset,
   input enable,
   output [2:0]o
);

wire [2:0]qcomp;
wire [2:0]intermedites1;
wire [2:0]intermedites2;
wire T1, T2, T3;


wire reset1;
and (reset1, m, reset);
wire reset2;
nor(reset2, ~reset, m);


wire pause;
not(pause, enable);

and (T1, 1, pause);

T_Flip_Flop tff1(clk,T1,reset2,reset1,enable,o[0],qcomp[0]);
and (intermedites1[0],~m,o[0])   ,    (intermedites1[1],m,qcomp[0]);
or (intermedites1[2],intermedites1[0],intermedites1[1]);

and(T2, intermedites1[2], pause);


wire reserFin;
or(reserFin, reset1, reset2);

T_Flip_Flop tff2(clk,T2,0,reserFin,enable,o[1],qcomp[1]);
and (intermedites2[0],intermedites1[0],o[1])   ,   (intermedites2[1],intermedites1[1],qcomp[1]);
or (intermedites2[2],intermedites2[0],intermedites2[1]);

and (T3, intermedites2[2], pause);
T_Flip_Flop tff3(clk,T3,reset1,reset2,enable,o[2],qcomp[2]);




endmodule