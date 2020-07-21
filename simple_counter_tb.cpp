#include "Vsimple_counter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include <iostream>

int main(int argc, char** argv)
{
  Verilated::commandArgs(argc, argv);

  // init top verilog instance
  Vsimple_counter* top = new Vsimple_counter();

  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace(tfp, 99);  // Trace 99 levels of hierarchy
  tfp->open("testbench_verilator.vcd");

  // initialize simulation inputs
  top->clock_i = 0;
  top->reset_i = 1;

  // run simulation for some clock periods
  for(int i = 0; i < 100; i++)
  {
    top->reset_i    = (i < 1);

    for(int clk = 0; clk < 2; ++clk)
    {
      top->eval();
      tfp->dump((2 * i) + clk);
      top->clock_i = !top->clock_i;

      if (top->clock_i && i != 0)
      {
        std::cout << "Cycle: " << i << " Counter => 0x" << std::hex << uint32_t(top->count_o) << std::dec << " (" << uint32_t(top->count_o) << ")" << std::endl;
      }
    }
  }
  tfp->close();

  return 0;
}
