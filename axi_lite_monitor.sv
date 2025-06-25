// ========================
// axi_lite_monitor.sv
// ========================
module axi_lite_monitor (
  input logic clk,
  input logic reset_n,
  input logic awvalid,
  input logic awready,
  input logic [31:0] awaddr
);

  always_ff @(posedge clk) begin
    if (!reset_n) disable fork;
    if (awvalid && awready)
      $display("[MONITOR] AWADDR captured: %h", awaddr);
  end

endmodule
