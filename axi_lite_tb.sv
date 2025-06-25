// ========================
// axi_lite_tb.sv
// ========================
module axi_lite_tb;
  logic clk, reset_n;
  logic [31:0] awaddr, wdata, araddr, rdata;
  logic awvalid, awready, wvalid, wready, bvalid, bready;
  logic arvalid, arready, rvalid, rready;

  axi_lite_dut dut (.*);
  axi_lite_driver driver (.*);
  axi_lite_monitor mon (.clk(clk), .reset_n(reset_n), .awvalid(awvalid), .awready(awready), .awaddr(awaddr));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset_n = 0;
    #20;
    reset_n = 1;
  end

  // Waveform dump
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, axi_lite_tb);
  end

  // Functional coverage
  covergroup axi_lite_cov @(posedge clk);
    coverpoint awvalid;
    coverpoint wvalid;
    coverpoint bvalid;
    coverpoint arvalid;
    coverpoint rvalid;
    aw_w_cross: cross awvalid, wvalid;
  endgroup
  axi_lite_cov cov_inst = new();

  always @(posedge clk) begin
    if (reset_n)
      cov_inst.sample();
  end

  // Assertion as property
  property write_response_order;
    @(posedge clk) disable iff (!reset_n)
      (awvalid && awready && wvalid && wready) |=> bvalid;
  endproperty
  assert property (write_response_order)
    else $fatal("[ASSERT] Write response BVALID missing after AW/W handshake");

  // Scoreboard check
  logic [31:0] expected_data = 32'hABCD1234;
  always_ff @(posedge clk) begin
    if (rvalid && rready) begin
      if (rdata !== expected_data)
        $error("[SCOREBOARD] Mismatch! Expected: %h, Got: %h", expected_data, rdata);
      else
        $display("[SCOREBOARD] PASS. Read data: %h", rdata);
    end
  end
endmodule

