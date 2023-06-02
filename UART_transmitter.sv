module UART_transmitter(
    input logic clk,
    input logic start,
    input logic rst,
    input logic [7:0] data_in,
    output logic tx
//    output logic stop,
//    output logic idle,
//    output logic en_reg,
//    output logic load,
//    output logic st_not,
//    output logic [1:0] en_mux
);

    logic stop;
    logic idle;
    logic en_reg;
    logic load;
    // logic en_st;
    // logic st_not;
    logic [1:0] en_mux;
    logic baud_rate;
    UART_datapath datapath(.clk(clk),.stop(stop),.rst(rst),.idle(idle),.en_reg(en_reg),.load(load),./*en_st(en_st),.*/en_mux(en_mux),.data_in(data_in)/*,.start(start),.st_not(st_not)*/,.tx(tx),.baud_rate(baud_rate));
    UART_controller control(.start(start),.clk(clk),.rst(rst),./*en_st(en_st),.*/load(load),.idle(idle),.stop(stop)/*,.st_not(st_not)*/,.en_reg(en_reg),.en_mux(en_mux));
endmodule
