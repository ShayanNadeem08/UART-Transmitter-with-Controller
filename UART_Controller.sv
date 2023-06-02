module UART_controller(
    input logic start,
    input logic clk,
    input logic rst,
//    output logic en_st,
    output logic load,
    output logic idle,
    output logic stop,
    // output logic st_not,
    output logic en_reg,
    output logic [1:0] en_mux
);

    parameter IDLE_STATE = 2'b00,/* START_STATE = 01,*/ TRANSMISSION_STATE = 2'b01, STOP_STATE = 2'b10;
    logic [1:0] state;
    logic [3:0] count;
    logic count1;
    logic baud_rate;
    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE_STATE;
            idle <= 1;
            count <= 0;
            count1 <= 0;
        end else begin
            case (state)
                IDLE_STATE : begin
                    idle <= 1;
                    if (start) begin
                        state <= IDLE_STATE;
                    end else if (~start) begin
                        // st_not <= 0;
                        state <= TRANSMISSION_STATE;
                    end
                end

    //            START_STATE : begin
    //                if (count1 == 1'b1) begin
    //                    state <= DATA_STATE;
    //                    count1 <= 0;
    //                end else begin
    //                    count1 <= count + 1;
    //                end
    //            end

                TRANSMISSION_STATE : begin
                    if (count == 4'h8) begin
                        stop <= 1;  
                        state <= STOP_STATE;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end

                STOP_STATE : begin
                    stop <= 1;
                    if (start) state <= IDLE_STATE;
                end

                default : state <= IDLE_STATE;
            endcase
        end
    end

    always_comb begin
        if (rst) begin
            en_reg = 1;
            load = 1;
            en_mux = 2'h0;
        end else begin
            case (state)
                IDLE_STATE : begin
    //                en_st = 0;
                    en_reg = 1;
                    load = 1;
                    en_mux = 2'h0;
                    // if (~start) en_mux = 2'h1;
                end

    //            START_STATE : begin
    ////                en_st = 1;
    //                en_reg = 0;
    //                en_mux = 2'h1;
    //            end

                TRANSMISSION_STATE : begin
    //                en_st = 0;
                    en_reg = 1;
                    load = 0;
                    en_mux = 2'h1;
                end

                STOP_STATE : begin
    //                en_st = 0;
                    en_reg = 0;
                    load = 0;
                    en_mux = 2'h2;
                end

                default : begin
    //                en_st = 0;
                    en_reg = 1;
                    load = 1;
                    en_mux = 2'h0;
                end

            endcase
        end
    end

endmodule
