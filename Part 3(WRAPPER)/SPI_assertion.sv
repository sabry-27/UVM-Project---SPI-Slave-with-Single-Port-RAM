module spi_slave_assertions (clk, rst_n, SS_n, MISO,MOSI, rx_valid,rx_data, cs );
    input logic clk;
    input logic rst_n;
    input logic SS_n;
    input logic MISO;
    input logic rx_valid;
    input logic [9:0] rx_data;
    input logic [2:0] cs ;
    input logic MOSI;
localparam IDLE      = 3'b000;
    localparam WRITE     = 3'b001;
    localparam CHK_CMD   = 3'b010;
    localparam READ_ADD  = 3'b011;
    localparam READ_DATA = 3'b100;

 property p1 ;
        @(posedge clk) 
            !rst_n |=> (MISO == 1'b0 && rx_valid == 1'b0 && rx_data == '0)
 endproperty
sequence s2;
   $fell(SS_n) ##1 MOSI == 0 ##1 MOSI == 0 ##1 MOSI == 0;
endsequence
property p2;
    @(posedge clk) disable iff (!rst_n)
    s2 |-> ##10 (rx_valid == 1'b1) |-> (SS_n == 1'b1) [->1];
endproperty

sequence s3;
   $fell(SS_n) ##1 MOSI == 0 ##1 MOSI == 0 ##1 MOSI == 1;
endsequence
property p3;
    @(posedge clk) disable iff (!rst_n)
    s3 |-> ##10 (rx_valid == 1'b1) |-> (SS_n == 1'b1) [->1];
endproperty
sequence s4;
   $fell(SS_n) ##1 MOSI == 1 ##1 MOSI == 1 ##1 MOSI == 0;
endsequence
property p4;
    @(posedge clk) disable iff (!rst_n)
    s4 |-> ##10 (rx_valid == 1'b1) |-> (SS_n == 1'b1) [->1];
endproperty

sequence s5;
   $fell(SS_n) ##1 MOSI == 1 ##1 MOSI == 1 ##1 MOSI == 1;
endsequence
property p5;
    @(posedge clk) disable iff (!rst_n)
    s5 |-> ##10 (rx_valid == 1'b1) |-> (SS_n == 1'b1) [->1];
endproperty

 property p6 ;
          @(posedge clk) disable iff (!rst_n)
            $rose(rx_valid) |-> s_eventually $rose(SS_n)
 endproperty
ap1:assert property(p1);
cp1:cover property(p1);
ap2:assert property(p2);
cp2:cover property(p2);
ap3:assert property(p3);
cp3:cover property(p3);
ap4:assert property(p4);
cp4:cover property(p4);
ap5:assert property(p5);
cp5:cover property(p5);
ap6:assert property(p6);
cp6:cover property(p6);


endmodule