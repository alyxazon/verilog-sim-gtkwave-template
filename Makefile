# Project
MODULE_NAME     := simple_counter
VERILOG_FILES   := simple_counter.v
ICARUS_TB_FILES := simple_counter_tb.v
VERI_TB_FILES   := simple_counter_tb.cpp
TB_NAME         := testbench

# Icarus Verilog Settings
ICARUS_BIN          := iverilog
ICARUS_RUNTIME      := vvp
ICARUS_RUNTIME_ARGS := -vcd

# Verilator Settings
VERI_BIN   := verilator
VERI_FLAGS := -Wall
VERI_DIR   := obj_dir

# Generic Settings
GTKWAVE_BIN := gtkwave

# Targets
all: icarus_all verilator_all

icarus_all: icarus_compile icarus_run

icarus_compile:
	$(ICARUS_BIN) -o $(TB_NAME).icarus $(VERILOG_FILES) $(ICARUS_TB_FILES)

icarus_run:
	$(ICARUS_RUNTIME) -n $(TB_NAME).icarus $(ICARUS_RUNTIME_ARGS)

verilator_all: verilator_compile verilator_run

verilator_compile:
	$(VERI_BIN) $(VERI_FLAGS) -cc $(VERILOG_FILES) --exe $(VERI_TB_FILES) --trace
	make -C$(VERI_DIR) -f V$(MODULE_NAME).mk

verilator_run:
	./$(VERI_DIR)/V$(MODULE_NAME)

view_icarus:
	$(GTKWAVE_BIN) testbench_icarus.vcd &

view_verilator:
	$(GTKWAVE_BIN) testbench_verilator.vcd &

view: view_icarus view_verilator

clean:
	rm $(TB_NAME).icarus || true
	rm -rf $(VERI_DIR) || true
	rm *.vcd || true
