module simple_counter(count_o, pulse_o, clock_i, reset_i);

  parameter WIDTH = 4;

  output [WIDTH-1:0] count_o;
  output             pulse_o;
  input              clock_i, reset_i;

  reg [WIDTH-1:0] count_o;
  reg             pulse_o;
  wire            clock_i, reset_i;

  // Count up every clock cycle
  always @(posedge clock_i or posedge reset_i)
  begin
    if (reset_i)
      count_o <= 0;
    else
      count_o <= count_o + 1;
  end

  // Pulse on every overflow
  always @(posedge clock_i or posedge reset_i)
  begin
    if (reset_i)
      pulse_o <= 0;
    else
      if (count_o == ((2**WIDTH)-1))
        pulse_o <= 1;
      else
        pulse_o <= 0;
  end

endmodule
