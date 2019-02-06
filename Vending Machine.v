/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////					/////////////////////////////////////////////////////////////////
/////////////////////////////////////////// VENDING MACHINE /////////////////////////////////////////////////////////////////
///////////////////////////////////////////					/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module vending_machine(	input d1,c25,c50,p1,p2,p3,p4,p5,p6,p7,p8,y, rst, 
                       output [6:0]bcdc2, bcdc1, bcdd, bcdp, 
                       output reg ledg, ledr,ledp1, ledp2, ledp3, ledp4, ledp5, ledp6, ledp7, ledp8  );

  reg [6:0] BCD[18:0];
  integer i,j,p,d, nc50,nc25,nd;
  integer change,prodamtd, money, DisplayMoney,counter;
  /////////////////////////////////////////// ASSIGN 7 SEGMENT /////////////////////////////////////////////////////////////////	
  assign bcdc2=BCD[j];
  assign bcdc1=BCD[i];
  assign bcdd=BCD[d];
  assign bcdp=BCD[p];
  /////////////////////////////////////////// COUNT DOLLAR, CENTS ///////////////////////////////////////////////////////////////		
  always@(posedge d1 or posedge rst) begin
    if(rst)
      nd=0;
    else
      nd=nd+1; 		end
  always@(posedge c50 or posedge rst) begin
    if(rst)
      nc50=0;
    else
      nc50=nc50+1; 		end
  always@(posedge c25 or posedge rst) begin
    if(rst)
      nc25=0;
    else
      nc25=nc25+1; 		end
  //////////////////////////////////////////////// TRANSACTION ///////////////////////////////////////////////////////////////
  always @( y) begin

    if(y) begin
      change= money - prodamtd;
      if(change >=0)begin
        ledg=1;
        ledr=0;		
        j = change%10;
        change = change/10;
        i = change%10;
        change = change/10;
        d= change%10; 	
        p = 18; 
      end	
      else begin
        ledg=0;
        ledr=1; 
        p=13; d=10; i=1; j=17;end
    end
    else begin
      ledg=0;
      ledr=0;
      money = (nc25*25)+(nc50*50)+(nd*100);
      DisplayMoney=money;
      j = DisplayMoney%10;
      DisplayMoney = DisplayMoney/10;
      i = DisplayMoney%10;
      DisplayMoney = DisplayMoney/10;
      d = DisplayMoney%10; 	


      //States are defined here
      case({p1,p2,p3,p4,p5,p6,p7,p8})
        8'b1000_0000: begin prodamtd=100;  	 p=10; ledp1=1; ledp2=0; ledp3=0; ledp4=0; ledp5=0; ledp6=0; ledp7=0; ledp8=0;end 
        8'b0100_0000: begin prodamtd=200;  	 p=8;  ledp1=0; ledp2=1; ledp3=0; ledp4=0; ledp5=0; ledp6=0; ledp7=0; ledp8=0;end
        8'b0010_0000: begin prodamtd=300; 	 p=11; ledp1=0; ledp2=0; ledp3=1; ledp4=0; ledp5=0; ledp6=0; ledp7=0; ledp8=0;end 
        8'b0001_0000: begin prodamtd=360;    p=0 ; ledp1=0; ledp2=0; ledp3=0; ledp4=1; ledp5=0; ledp6=0; ledp7=0; ledp8=0;end
        8'b0000_1000: begin prodamtd=340;	 p=12; ledp1=0; ledp2=0; ledp3=0; ledp4=0; ledp5=1; ledp6=0; ledp7=0; ledp8=0;end
        8'b0000_0100: begin prodamtd=450;    p=13; ledp1=0; ledp2=0; ledp3=0; ledp4=0; ledp5=0; ledp6=1; ledp7=0; ledp8=0;end
        8'b0000_0010: begin prodamtd=410;    p=14; ledp1=0; ledp2=0; ledp3=0; ledp4=0; ledp5=0; ledp6=0; ledp7=1; ledp8=0;end
        8'b0000_0001: begin prodamtd=576;    p=15; ledp1=0; ledp2=0; ledp3=0; ledp4=0; ledp5=0; ledp6=0; ledp7=0; ledp8=1;end
        default: begin prodamtd=0;		 p=16; ledp1=0; ledp2=0; ledp3=0; ledp4=0; ledp5=0; ledp6=0; ledp7=0; ledp8=0;end
      endcase
    end
  end
  //////////////////////////////////////// 7 SEGMENT MODULE ///////////////////////////////////////////////////////////	
  initial begin												//7 Segment display character value 

    BCD[0]=7'b100_0000;									// 0
    BCD[1]=7'b111_1001;									//1 and I
    BCD[2]=7'b010_0100;									//2
    BCD[3]=7'b011_0000;									//3
    BCD[4]=7'b001_1001;									//4
    BCD[5]=7'b001_0010;									//5 and S
    BCD[6]=7'b000_0011;									//6
    BCD[7]=7'b111_1000;									//7
    BCD[8]=7'b000_0000;									//8
    BCD[9]=7'b001_1000;									//9
    BCD[10]=7'b000_1000;									//A
    BCD[11]=7'b100_0110;									//C
    BCD[12]=7'b000_0110;									//E
    BCD[13]=7'b000_1110;									//F
    BCD[14]=7'b000_0010;									//G
    BCD[15]=7'b000_1001;									//H
    BCD[16]=7'b000_1100;									//P
    BCD[17]=7'b100_0111;									//L
    BCD[18]=7'b111_1111;							//off
  end

endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////					/////////////////////////////////////////////////////////////////
/////////////////////////////////////////// VENDING MACHINE /////////////////////////////////////////////////////////////////
///////////////////////////////////////////					/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
