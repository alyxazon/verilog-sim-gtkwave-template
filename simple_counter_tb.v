module simple_counter_tb;

  parameter WIDTH = 4;

  reg clock = 0;
  always #5 clock = !clock;

  reg reset = 0;
  initial begin
     # 0  reset = 1;
     # 10 reset = 0;
     # 1000 $stop;
  end

  wire [WIDTH-1:0] counter_value;
  wire counter_pulse;

  //simple_counter counter_dut (counter_value, counter_pulse, clock, reset);
  simple_counter #(WIDTH) counter_dut (
    .count_o(counter_value),
    .pulse_o(counter_pulse),
    .clock_i(clock),
    .reset_i(reset)
  );

  initial
    begin
      $monitor("Time %t, Counter => 0x%h (%0d)", $time, counter_value, counter_value);
      $dumpfile("testbench_icarus.vcd");
      $dumpvars(0,simple_counter_tb);
    end

endmodule
