// ========================
// axi_lite_dut.sv
// ========================
module axi_lite_dut (
  input logic         clk,
  input logic         reset_n,
  input logic [31:0]  awaddr,
  input logic         awvalid,
  output logic        awready,
  input logic [31:0]  wdata,
  input logic         wvalid,
  output logic        wready,
  output logic        bvalid,
  input logic         bready,
  input logic [31:0]  araddr,
  input logic         arvalid,
  output logic        arready,
  output logic [31:0] rdata,
  output logic        rvalid,
  input logic         rready
);

  logic [31:0] mem [0:255];

  // Write logic
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      awready <= 0;
      wready  <= 0;
      bvalid  <= 0;
    end else begin
      awready <= !awready && awvalid;
      wready  <= !wready && wvalid;
      if (awvalid && awready && wvalid && wready) begin
        mem[awaddr[7:0]] <= wdata;
        bvalid <= 1;
      end
      if (bvalid && bready)
        bvalid <= 0;
    end
  end

  // Read logic
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      arready <= 0;
      rvalid  <= 0;
    end else begin
      arready <= !arready && arvalid;
      if (arvalid && arready) begin
        rdata <= mem[araddr[7:0]];
        rvalid <= 1;
      end
      if (rvalid && rready)
        rvalid <= 0;
    end
  end

endmodule
