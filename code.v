//Digital clk
 module digital_clk(clk,an,cn);
 input clk;
 output reg [7:0]an;
 output reg [7:0]cn;
 reg clk_seg;
 reg [31:0] count;  //this is for clk_segment
 initial begin
 clk_seg<=0;
 count <=0;
 end
 always@(posedge clk)begin
    if(count == 100000)begin
        count<=0;
        clk_seg <= ~clk_seg;
        end
    else
        count <=count+1;
    end
 reg [2:0] sel=3'd2;
 wire [7:0] ca1,ca2,ca3,ca4,ca5,ca6,ca7,ca8;
 always@(posedge clk_seg)begin
    case(sel)
            3'd2:begin an=8'b1101_1111;cn=ca1;end
            3'd3:begin an=8'b1110_1111;cn=ca2;end
            3'd4:begin an=8'b1111_0111;cn=ca3;end
            3'd5:begin an=8'b1111_1011;cn=ca4;end
            3'd6:begin an=8'b1111_1101;cn=ca5;end
            3'd7:begin an=8'b1111_1110;cn=ca6;end
            endcase
            sel<=sel+1;
   end
   wire clr;
   wire[3:0]h1,h0,m1,m0,s1,s0;  
   ring_count utt(clk,clr,h1,h0,m1,m0,s1,s0);
   display uut2(clk,h1,ca1);
   display uut3(clk,h0,ca2);
   display uut4(clk,m1,ca3);
   display uut5(clk,m0,ca4);
   display uut6(clk,s1,ca5);
   display uut7(clk,s0,ca6);
   endmodule
 
 module ring_count(clk,rst,h1,h0,m1,m0,s1,s0);
 input clk,rst;
 output reg [3:0] h1,h0,m1,m0,s1,s0;
 reg clk_1hz;
 reg [31:0]c;
 initial begin
 clk_1hz<=0;
 c<=0;
 end
 always@(posedge clk)begin
 if(c == 50000000)begin
    c<=0;
    clk_1hz = ~clk_1hz;
    end
 else
    c <= c+1;
 end
 always@(posedge clk_1hz)begin
    if(h1==2 && h0==3 && m1==5 && m0==9 && s1==5 && s0==9)begin
        h1<=1;h0<=1;m1<=5;m0<=9;s1<=5;s0<=1;
        end
    else
    begin
        s0 =s0+1;
        if(s0 >9)begin
            s0<=0;
            s1<=s1+1;
           
        if (s1==5)begin
            s0<=0;
            s1<=0;
            m0<=m0+1;
         if(m0>9)begin
            s0<=0;s1<=0;m0<=0;m1<=m1+1;
         if(m1 == 5)begin
            s0<=0;s1<=0;m0<=0;m1<=0;h0<=h0+1;
         if(h0>9)begin
            s0<=0;s1<=0;m0<=0;m1<=0;h0<=0;h1<=h1+1;
         if(h1==2 && h0==3)begin
            s0<=0;s1<=0;m0<=0;m1<=0;h0<=0;h1<=0;
          end
          end
          end
          end
          end
          end
            
 end
 end
 endmodule
module display(clk,value,ca);
input clk;
input [3:0] value;
output reg [7:0] ca;
always@(posedge clk)begin
    case(value)
        4'd0:ca=8'b0000_0011;
        4'd1:ca=8'b1001_1111;
        4'd2:ca=8'b0010_0101;
        4'd3:ca=8'b0000_1101;
        4'd4:ca=8'b1001_1001;
        4'd5:ca=8'b0100_1001;
        4'd6:ca=8'b0100_0001;
        4'd7:ca=8'b0001_1011;
        4'd8:ca=8'b0000_0001;
        4'd9:ca=8'b0000_1001;
        endcase
        end
endmodule
//stop watch
module digital_clk(clk,clr,clr1,an,cn);
 input clk,clr,clr1;
 output reg [7:0]an;
 output reg [7:0]cn;
 reg clk_seg;
 reg [31:0] count;  //this is for clk_segment
 initial begin
 clk_seg <= 0;
 count <= 0;
 end
 always@(posedge clk)begin
    if(count == 100000)begin
        count<=0;
        clk_seg <= ~clk_seg;
        end
    else
        count <=count+1;
    end
 reg [2:0] sel=3'd0;
 wire [7:0] ca1,ca2,ca3,ca4,ca5,ca6,ca7,ca8;
 always@(posedge clk_seg)begin
    case(sel)
    	    3'd0:begin an=8'b0111_1111;cn=ca1;end
    	    3'd1:begin an=8'b1011_1111;cn=ca2;end
            3'd2:begin an=8'b1101_1111;cn=ca3;end
            3'd3:begin an=8'b1110_1111;cn=ca4;end
            3'd4:begin an=8'b1111_0111;cn=ca5;end
            3'd5:begin an=8'b1111_1011;cn=ca6;end
            3'd6:begin an=8'b1111_1101;cn=ca7;end
            3'd7:begin an=8'b1111_1110;cn=ca8;end
            endcase
            sel<=sel+1;
   end
   wire[3:0]h1,h0,m1,m0,s1,s0,ms1,ms0;  
   ring_count utt(clk,clr,clr1,h1,h0,m1,m0,s1,s0,ms1,ms0);
   display uut2(clk,h1,ca1);
   display uut3(clk,h0,ca2);
   display uut4(clk,m1,ca3);
   display uut5(clk,m0,ca4);
   display uut6(clk,s1,ca5);
   display uut7(clk,s0,ca6);
   display uut8(clk,ms1,ca7);
   display uut9(clk,ms0,ca8);
   endmodule
 
 module ring_count(clk,rst,clr1,h1,h0,m1,m0,s1,s0,ms1,ms0);
 input clk,rst,clr1;
 output reg [3:0] h1,h0,m1,m0,s1,s0,ms1,ms0;
 reg clk_1hz;
 reg [18:0]c;
 initial begin
 clk_1hz<=0;
 c<=0;
 end
 always@(posedge clk)begin
 if(c == 500000)begin
    c<=0;
    clk_1hz = ~clk_1hz;
    end
 else
    c <= c+1;
 end
 always@(posedge clk_1hz)begin
 	if(rst)begin
 		ms0<=ms0;ms1<=ms1;s0<=s0;s1<=s1;m0<=m0;m1<=m1;h0<=h0;h1<=h1;
 		end
 	else if(clr1)begin
 		ms0<=0;ms1<=0;s0<=0;s1<=0;m0<=0;m1<=0;h0<=0;h1<=0;
 		end
    else
    begin
    	if(h1==2 && h0==3 && m1==5 && m0==9 && s1==5 && s0==9 && ms1== 9 && ms0==9)begin
        	h1<=0;h0<=0;m1<=0;m0<=0;s1<=0;s0<=0;ms0<=0;ms1<=0;
        end
        ms0 = ms0+1;
        if(ms0 >9)begin
            ms0<=0;ms1<=ms1+1; 
        if (ms1==9)begin
            ms0<=0;ms1<=0;s0<=s0+1;
         if(s0==9)begin
           ms0<=0;ms1<=0;s0<=0;s1<=s1+1;
         if(s1 == 5)begin
           ms0<=0;ms1<=0;s0<=0;s1<=0;m0<=m0+1;
        if(m0==9)begin
           ms0<=0;ms1<=0;s0<=0;s1<=0;m0<=0;m1<=m1+1;
        if(m1 == 5)begin
           ms0<=0;ms1<=0;s0<=0;s1<=0;m0<=0;m1<=0;h0<=h0+1;
         if(h0 == 9)begin
           ms0<=0;ms1<=0;s0<=0;s1<=0;m0<=0;m1<=0;h0<=0;h1<=h1+1;
         if(h1==2 && h0==3)begin
           ms0<=0;ms1<=0;s0<=0;s1<=0;m0<=0;m1<=0;h0<=0;h1<=0;
          end
          end
          end
          end
          end
          end
          end
          end
            
 end
 end
 endmodule
module display(clk,value,ca);
input clk;
input [3:0] value;
output reg [7:0] ca;
always@(posedge clk)begin
    case(value)
        4'd0:ca=8'b0000_0011;
        4'd1:ca=8'b1001_1111;
        4'd2:ca=8'b0010_0101;
        4'd3:ca=8'b0000_1101;
        4'd4:ca=8'b1001_1001;
        4'd5:ca=8'b0100_1001;
        4'd6:ca=8'b0100_0001;
        4'd7:ca=8'b0001_1011;
        4'd8:ca=8'b0000_0001;
        4'd9:ca=8'b0000_1001;
        endcase
        end
endmodule



// scrolling


module bcd7seg(input [7:0] y, output reg [7:0] disp);
    always @(y) begin
        case(y)
            0:disp = 8'b1101_0001;//h
            1:disp = 8'b1111_0011;//l
            2: disp = 8'b11101111; // dash
            3: disp = 8'b00110001; //P
            4: disp = 8'b0111_0011;//r
            5: disp = 8'b00000011;//o
            6: disp = 8'b1000_1111;//j
            7: disp = 8'b00100001;//e
            8: disp = 8'b01100011; // c
            9: disp = 8'b11100001; // t
            10:disp = 8'b1111_1111;//blank
           
        endcase
    end
endmodule 

module slow_clock_1hz(input clk_in, output reg clk_out); //time
    reg [56:0] period_count = 0;
    always @(posedge clk_in) begin
        if (period_count != 50000000 - 1) begin
            period_count <= period_count + 1;
            clk_out = 0;
        end else begin
            period_count <= 0;
            clk_out = ~clk_out;
        end 
    end
endmodule

module slow_clock_100hz(input clk_in, output reg clk_out); //visible
    reg [20:0] period_count = 0;
    always @(posedge clk_in) begin
        if (period_count != 500000-1 ) begin
            period_count <= period_count + 1;
            clk_out = 0;
        end else begin
            period_count <= 0;
            clk_out = ~clk_out ;
        end 
    end
endmodule

module scrolling_message(
    input clk, 
    input reset, 
    output [7:0] seg,
    output reg [7:0] an
);
    wire slowclock_1hz;
    wire slowclock_100hz;
    reg [7:0] scroll;
    reg [7:0] zero,nineth,tenth,eighth,seventh,sixth,fifth,fourth, third, second, first;
    reg [7:0] d;
    reg [2:0] count;
    
    slow_clock_100hz u0(clk, slowclock_100hz);
    slow_clock_1hz u1(clk, slowclock_1hz);
    
    always @(posedge slowclock_1hz or posedge reset) begin
        if (reset)
            scroll <= 0;
        else if (scroll == 47)
            scroll <= 0;
        else 
            scroll <= scroll + 1;
    end
    
    always @(posedge slowclock_1hz) begin
        case (scroll)
            0: begin eighth =2;seventh =2;sixth =0; fifth =7;fourth = 1; third = 1; second = 5; first = 2; end
            1: begin eighth =2;seventh =2 ;sixth =2; fifth =0;fourth = 7; third = 1; second = 1; first = 5; end
            2: begin eighth =5;seventh =2 ;sixth =2; fifth =2;fourth = 0; third = 7; second = 1; first = 1; end
            3: begin eighth =1;seventh =5 ;sixth =2; fifth =2;fourth = 2; third = 0; second = 7; first = 1; end
            4: begin eighth =1;seventh =1 ;sixth =5; fifth =2;fourth = 2; third = 2; second = 0; first = 7; end
            5: begin eighth =7;seventh =1 ;sixth =1; fifth =5;fourth = 2; third = 2; second = 2; first = 0; end
            6: begin eighth =0;seventh =7 ;sixth =1; fifth =1;fourth = 5; third = 2; second = 2; first = 2; end
            7: begin eighth =2;seventh =0 ;sixth =7; fifth =1;fourth = 1; third = 5; second = 2; first = 2; end
            8: begin eighth =10;seventh =2 ;sixth =0; fifth =7;fourth =1; third = 1; second = 5; first = 2; end
            9: begin eighth =10;seventh =10 ;sixth =2; fifth =0;fourth = 7; third = 1; second = 1; first = 5; end
            10: begin eighth =10;seventh =10 ;sixth =10; fifth =2;fourth =0; third = 7; second = 1; first = 1; end
            11: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth =2; third = 0; second = 7; first = 1;end
            12: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 2; second = 0; first = 7; end
            13: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 2; first = 0;end
            14: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 2;end
            15: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            16: begin eighth =2;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 10;end
            17: begin eighth =9;seventh =2 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            18: begin eighth =8;seventh =9 ;sixth =2; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            19: begin eighth =7;seventh =8 ;sixth =9; fifth =2;fourth = 10; third = 10; second = 10; first = 10;end
            20: begin eighth =6;seventh =7 ;sixth =8; fifth =9;fourth = 2; third = 10; second = 10; first = 10;end
            21: begin eighth =5;seventh =6 ;sixth =7; fifth =8;fourth = 9; third = 2; second = 10; first = 10; end
            22: begin eighth =4;seventh =5 ;sixth =6; fifth =7;fourth = 8; third = 9; second = 2; first = 10; end
            23: begin eighth =3;seventh =4 ;sixth =5; fifth =6;fourth = 7; third = 8; second = 9; first = 2; end
            24: begin eighth =2;seventh =3 ;sixth =4; fifth =5;fourth = 6; third = 7; second = 8; first = 9; end
            25: begin eighth =9;seventh =2 ;sixth =3; fifth =4;fourth = 5; third = 6; second = 7; first = 8; end
            26: begin eighth =8;seventh =9 ;sixth =2; fifth =3;fourth = 4; third = 5; second = 6; first = 7; end
            27: begin eighth =7;seventh =8 ;sixth =9; fifth =2;fourth = 3; third = 4; second = 5; first = 6;end
            28: begin eighth =6;seventh =7 ;sixth =8; fifth =9;fourth = 2; third = 3; second = 4; first = 5; end
            29: begin eighth =5;seventh =6 ;sixth =7; fifth =8;fourth = 9; third = 2; second = 3; first = 4; end
            30: begin eighth =4;seventh =5 ;sixth =6; fifth =7;fourth = 8; third = 9; second = 2; first = 3; end
            31: begin eighth =3;seventh =4 ;sixth =5; fifth =6;fourth = 7; third = 8; second = 9; first = 2; end
            32: begin eighth =10;seventh =3 ;sixth =4; fifth =5;fourth = 6; third =7; second = 8; first = 9; end
            33: begin eighth =10;seventh =10 ;sixth =3; fifth =4;fourth = 5; third = 6; second = 7; first = 8; end
            34: begin eighth =10;seventh =10;sixth =10; fifth =3;fourth = 4; third = 5; second = 6; first = 7; end
            35: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 3; third = 4; second = 5; first = 6; end
            36: begin eighth =10;seventh =10;sixth =10; fifth =10;fourth = 10; third = 3; second = 4; first = 5; end
            37: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 3; first = 4; end
            38: begin eighth =10;seventh =10 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 3; end
            39: begin eighth =10;seventh =10;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            40: begin eighth =2;seventh =10;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            41: begin eighth =5;seventh =2 ;sixth =10; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            42: begin eighth =1;seventh =5 ;sixth =2; fifth =10;fourth = 10; third = 10; second = 10; first = 10; end
            43: begin eighth =1;seventh =1 ;sixth =5; fifth =2;fourth = 10; third = 10; second = 10; first = 10; end
            44: begin eighth =7;seventh =1 ;sixth =1; fifth =5;fourth = 2; third = 10; second = 10; first = 10; end
            45: begin eighth =0;seventh =7 ;sixth =1; fifth =1;fourth = 5; third = 2; second = 10; first = 10; end
            46: begin eighth =2;seventh =0 ;sixth =7; fifth =1;fourth = 1; third = 5; second = 2; first = 10;end
            endcase 
        
    end
    
    always @(posedge slowclock_100hz) begin
        if (reset)
            count <= 0;
        else 
            count <= count + 1;
        
        case (count)
            3'd0: begin d = first;  an = 8'b11111110; end
            3'd1: begin d = second;  an = 8'b11111101; end   
            3'd2: begin d = third;  an = 8'b11111011; end
            3'd3: begin d = fourth;  an = 8'b11110111; end
            3'd4: begin d = fifth;  an = 8'b11101111; end
            3'd5: begin d = sixth;  an = 8'b11011111; end
            3'd6: begin d = seventh;  an = 8'b10111111; end
            3'd7: begin d = eighth;  an = 8'b01111111; end
            
           
        endcase
    end
    
    bcd7seg u3(d, seg);
endmodule
