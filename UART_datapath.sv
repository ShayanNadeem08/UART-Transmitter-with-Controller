module baud_rate_generator(
    input logic clk,
    input logic rst,
    output logic baud_gen
);
    logic [19:0] count;
    always_ff @ (posedge clk) begin
        if (rst) begin
            count <= 0;
        end else if (count == 5209) begin
            count <= 0;
            baud_gen <= ~baud_gen;
        end else begin
            count <= count + 1;
        end
    end
endmodule


module PISO_register(
    input logic baud_rate,
    input logic load,
    input logic rst,
    input logic en_reg,
    input logic [7:0] data_in,
    output logic sr_out
);

logic [7:0] shift_reg;

// initial sr_out = 0;
always_ff @(posedge baud_rate) begin
    if (rst) begin
        shift_reg <= 0;
    end else if (en_reg) begin    
        if (load) begin
            sr_out <= 0;
            shift_reg <= data_in;
        end else begin
            shift_reg <= {1'b0,shift_reg[7:1]};
            sr_out <= shift_reg[0];
        end
    end
end

endmodule




module mux_4X1(
    input logic [3:0] in,
    input logic [1:0] en_mux,
    output logic tx
);
    always_comb begin
        case (en_mux)
            2'h0 : tx = in[0];
            2'h1 : tx = in[1];
            2'h2 : tx = in[2];
            2'h3 : tx = in[3];
            // 2'h3 : tx = in[3];
        endcase
    end
endmodule



module UART_datapath(
    input logic clk,
    input logic stop,
    input logic rst,
    input logic idle,
    input logic en_reg,
    input logic load,
//    input logic en_st,
    input logic [1:0] en_mux,
    input logic [7:0] data_in,
    // input logic st_not,
    output logic tx,
    output logic baud_rate

);
//    logic st_out;
    logic tx_in_mod; 
    logic [3:0] in; 
    baud_rate_generator brg1(.clk(clk),.rst(rst),.baud_gen(baud_rate));

//    start_register sr1(.start(start),.baud_rate(clk),.en_st(en_st),.st_out(st_out));

    PISO_register pr1(.baud_rate(clk),.load(load),.rst(rst),.en_reg(en_reg),.data_in(data_in),.sr_out(tx_in_mod));

    assign in[0] = idle;
    // assign in[1] = st_not;
    assign in[1] = tx_in_mod;
    assign in[2] = stop;
    // assign in[3] = 1'bx;
    mux_4X1 m1(.in(in),.en_mux(en_mux),.tx(tx));
    
endmodule
