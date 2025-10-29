module testbench();
  logic        clk, reset, memwrite;
  logic [31:0] pc, instr;
  logic [31:0] writedata, addr, readdata;
  logic [9:0] LEDR;
    
  // microprocessor
  riscvmulti cpu(clk, reset, addr, writedata, memwrite, readdata);

  // memory 
  mem ram(clk, memwrite, addr, writedata, readdata);

  // initialize test
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars(0);
      reset <= 1; #15 reset <= 0;
      $monitor("%3t PC=%h LED=%h", $time, cpu.PC, LEDR);
      #12000 $writememh("riscv.out", ram.RAM);
      $writememh("cpu_regs.out", cpu.RegisterBank);
      $finish;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // memory-mapped i/o
  wire isIO  = addr[8]; // 0x0000_0100
  wire isRAM = !isIO;
  localparam IO_LEDS_bit = 2; // 0x0000_0104
  localparam IO_HEX_bit  = 3; // 0x0000_0108
  localparam IO_KEY_bit  = 4; // 0x0000_0110 
  localparam IO_SW_bit   = 5; // 0x0000_0120
  reg [23:0] hex_digits; // memory-mapped I/O register for HEX

  always @(posedge clk)
    if (memwrite & isIO) begin // I/O write 
      if (addr[IO_LEDS_bit])
        LEDR <= writedata;
      if (addr[IO_HEX_bit])
        hex_digits <= writedata;
  end

endmodule
