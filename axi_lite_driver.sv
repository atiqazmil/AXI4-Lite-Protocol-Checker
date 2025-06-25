// ========================
// axi_lite_driver.sv
// ========================
module axi_lite_driver (
  input  logic        clk,
  input  logic        reset_n,
  output logic [31:0] awaddr,
  output logic        awvalid,
  input  logic        awready,
  output logic [31:0] wdata,
  output logic        wvalid,
  input  logic        wready,
  input  logic        bvalid,
  output logic        bready,
  output logic [31:0] araddr,
  output logic        arvalid,
  input  logic        arready,
  input  logic [31:0] rdata,
  input  logic        rvalid,
  output logic        rready
);

  typedef enum {IDLE, WRITE, READ} state_t;
  state_t state;

  initial begin
    awaddr = 32'h10;
    awvalid = 0;
    wdata  = 32'hABCD1234;
    wvalid = 0;
    bready = 1;
    araddr = 32'h10;
    arvalid = 0;
    rready = 1;
  end

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      state <= IDLE;
    end else begin
      case (state)
        IDLE: begin
          awvalid <= 1;
          wvalid  <= 1;
          state <= WRITE;
        end
        WRITE: begin
          if (awready && wready) begin
            awvalid <= 0;
            wvalid  <= 0;
          end
          if (bvalid) begin
            arvalid <= 1;
            state <= READ;
          end
        end
        READ: begin
          if (arready)
            arvalid <= 0;
        end
      endcase
    end
  end

endmodule

