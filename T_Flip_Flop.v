
module T_Flip_Flop(Clock,
                   T,
                   Preset,
                   Reset,
                   Tick,
                   Q,
                   Q_bar);

   /***************************************************************************
    ** Here all module parameters are defined with a dummy value             **
    ***************************************************************************/
   parameter ActiveLevel = 1;


   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  Clock;
   input  Preset;
   input  Reset;
   input  T;
   input  Tick;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output Q;
   output Q_bar;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire s_next_state;
   reg[1:0] s_current_state_reg;

   /***************************************************************************
    ** Here the ouput signals are defined                                    **
    ***************************************************************************/
   assign Q     = s_current_state_reg[ActiveLevel];
   assign Q_bar = ~(s_current_state_reg[ActiveLevel]);

   /***************************************************************************
    ** Here the update logic is defined                                      **
    ***************************************************************************/
   assign s_next_state = s_current_state_reg^T;

   /***************************************************************************
    ** Here the initial register value is defined; for simulation only       **
    ***************************************************************************/
   initial
   begin
      s_current_state_reg = 0;
   end

   /***************************************************************************
    ** Here the actual state register is defined                             **
    ***************************************************************************/
   /*always @(posedge Reset or posedge Preset or negedge Clock)
   begin
      if (Reset) s_current_state_reg[0] <= 1'b0;
      else if (Preset) s_current_state_reg[0] <= 1'b1;
      else if (Tick) s_current_state_reg[0] <= s_next_state;
   end
  */
   always @(posedge Reset or posedge Preset or posedge Clock)
   begin
      if (Reset) s_current_state_reg[1] <= 1'b0;
      else if (Preset) s_current_state_reg[1] <= 1'b1;
      else if (Tick) s_current_state_reg[1] <= s_next_state;
   end


endmodule
