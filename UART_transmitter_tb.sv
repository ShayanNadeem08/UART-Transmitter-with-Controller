module UART_transmitter_tb;
    logic clk;
    logic start;
    logic rst;
    logic [7:0] data_in;
    logic tx;
//    logic stop;
//        logic idle;
//        logic en_reg;
//        logic load;
//        logic st_not;
//        logic [1:0] en_mux;

    UART_transmitter UUT(.clk(clk),.start(start),.rst(rst),.data_in(data_in),.tx(tx));//,.stop(stop),.idle(idle),.en_reg(en_reg),.load(load),.st_not(st_not),.en_mux(en_mux));
    
    initial begin
       
        clk <= 1;
        data_in <= 8'b10000001;
        start <= 0;
        rst <= 1;
        repeat(5) @ (posedge clk);
        rst <= 0;
        // @ (posedge clk);
        start <= 1;
        // @ (posedge clk);
        data_in <= 8'b10000001;
        repeat (5) @ (posedge clk);
        start <= 0;
        repeat (1) @ (posedge clk);
        start <= 1;
        #200;
        start <= 1;
        data_in <= 8'b10001011;
        repeat (5) @ (posedge clk);
        start <= 0;
        repeat (1) @ (posedge clk);
        start <= 1;
        data_in <= 8'b10101010;
        @ (posedge clk);
        start <= 0;
        repeat (10) @ (posedge clk);
        start <= 1;
        # 400 $finish; 
      end

    always #5 clk <= ~clk;
    
endmodule
