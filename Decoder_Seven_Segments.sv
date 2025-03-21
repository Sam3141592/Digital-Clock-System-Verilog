module Decoder_Seven_Segments(
  input [3:0] data,
  output reg a,
  output reg b,
  output reg c,
  output reg d,
  output reg e,
  output reg f,
  output reg g
);
  // Define a lookup table for the segment patterns
  // 0: a b c d e f  1: b c  2: a b d e g  3: a b c d g
  // 4: b c f g      5: a c d f g         6: a c d e f g
  // 7: a b c         8: a b c d e f g    9: a b c d f g
  reg [6:0] seg_patterns [0:9] = '{
                                   7'b1000000,
                                   7'b1111001,
                                   7'b0100100,
                                   7'b0110000,
                                   7'b0011001,
                                   7'b0010010,
                                   7'b0000010,
                                   7'b1111000,
                                   7'b0000000,
                                   7'b0010000
                                 };

  // Use the data input to index into the lookup table and
  // assign the output segments based on the resulting pattern
  always @* begin
    {a, b, c, d, e, f, g} = seg_patterns[data];
  end
endmodule