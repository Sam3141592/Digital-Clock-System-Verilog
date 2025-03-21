module Clock_Divider (
	input clk2,
	output reg clk1
);

initial begin
	clk1 =0;
end
always @(posedge clk2)
begin
clk1=~clk1;
end



endmodule