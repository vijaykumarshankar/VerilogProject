module traffic_lights(clk,
                      reset,
                      red1,
                      green1,
                      yellow1,
                      red2,
                      green2,
                      yellow2,
                      red3,
                      green3,
                      yellow3,
                      red4,
                      green4,
                      yellow4,
                      ped_light1,
                      ped_light3,
                      ped1,
                      ped3,
                      buzzer);

  //==================================================================================================================
  //													     PORT LIST
  //==================================================================================================================

  input clk,reset,ped1,ped3;  
  output reg red1,green1,yellow1;
  output reg red2,green2,yellow2;
  output reg red3,green3,yellow3;
  output reg red4,green4,yellow4;
  output reg ped_light1;
  output reg ped_light3;
  output reg buzzer;


  reg [3:0] state1, nextstate1,state2,nextstate2;
  reg [31:0] counter = 6'b000000;
  reg [31:0] first_counter = 31'b000000;
  reg [31:0] second_counter = 31'b000000;
  reg [31:0] third_counter = 31'b000000;
  reg [31:0] fourth_counter = 31'b000000;
  reg [31:0] fifth_counter = 31'b000000;
  reg [31:0] sixth_counter = 31'b000000;
  reg [31:0] seventh_counter = 31'b000000;
  reg [31:0] eighth_counter = 31'b000000;
  reg [31:0] ninth_counter = 31'b000000;
  reg [31:0] tenth_counter = 31'b000000;
  reg [31:0] eleven_counter = 31'b000000;
  reg [31:0] twelfth_counter = 31'b000000;
  reg [31:0] thirteen_counter = 31'b000000;
  reg [31:0] fourteen_counter = 31'b000000;


  localparam ST_RESET = 6'h0;
  localparam ST_FIRST = 6'h1;
  localparam ST_SECOND = 6'h2;
  localparam ST_THIRD = 6'h3;
  localparam ST_FOURTH = 6'h4;
  localparam ST_FIFTH = 6'h5;
  localparam ST_SIXTH = 6'h6;
  localparam ST_SEVENTH = 6'h7;
  localparam ST_EIGHT = 6'h8;
  localparam ST_NINE = 6'h9;
  localparam ST_TEN = 6'hA;
  localparam ST_ELEVEN = 6'hB;
  localparam ST_TWELVE = 6'hC;
  localparam ST_THIRTEEN = 6'hD;
  localparam ST_FOURTEEN = 6'hE;
  localparam ST_RESET2 = 6'hF;

  always @(*) begin
    if(reset) begin
      ped_light1 = 0; 
      ped_light3 =0;
      state1 <= ST_RESET;
      state2 <= ST_RESET2;
    end else begin
      state1 <= nextstate1;
      state2 <= nextstate2;
    end
    if (ped1 == 1) begin
      if (green1 == 1) begin
        ped_light1 = 1;
        buzzer=1;
      end else begin
        ped_light1 = 0;
        buzzer=0;

      end
    end
    if (ped3 == 1) begin
      if (green3 == 1) begin
        ped_light3 = 1;
        buzzer=1;
      end else begin
        ped_light3 = 0;
        buzzer=0;

      end
    end
  end


  //1st Intersection

  always @ (posedge clk) begin
    case(state1) 
      ST_RESET:
        begin
          red1 = 1; yellow1 = 1; green1 = 1;   
          red2 = 1; yellow2 = 1; green2 = 1;
          nextstate1 = ST_FIRST;
        end
      ST_FIRST: // 1st Intersection signals are made red   
        begin
          red1 = 1; yellow1 = 0; green1 = 0;   
          red2 = 1; yellow2 = 0; green2 = 0;
          if(first_counter == 250000000)begin
            first_counter = 0;
            nextstate1 = ST_SECOND;
          end else first_counter = first_counter + 1;
        end
      ST_SECOND: //1st Signal becomes green  
        begin 
          red1 = 0; yellow1 = 0; green1 = 1;
          red2 = 1; yellow2 = 0; green2 = 0;
          if(second_counter == 500000000) begin 
            second_counter = 0;
            nextstate1 = ST_THIRD;
          end else second_counter = second_counter + 1;
        end

      ST_THIRD: // Signal 1 becomes yellow 
        begin 
          red1 = 0; yellow1 = 1; green1 = 0;
          red2 = 1; yellow2 = 0; green2 = 0;
          if(third_counter == 200000000) begin 
            third_counter = 0; 
            nextstate1 = ST_FOURTH;
          end else third_counter= third_counter + 1;
        end

      ST_FOURTH: // Singal 1 becomes red and both signals remain red for a brief time
        begin 
          red1 = 1; yellow1 = 0; green1 = 0;   
          red2 = 1; yellow2 = 0; green2 = 0;
          if(fourth_counter == 100000000) begin 
            fourth_counter=0;
            nextstate1 = ST_FIFTH;					
          end else fourth_counter= fourth_counter + 1;
        end

      ST_FIFTH:
        begin // Signal 2 becomes green 
          red1 = 1; yellow1 = 0; green1 = 0;   
          red2 = 0; yellow2 = 0; green2 = 1;
          if(fifth_counter == 500000000) begin 
            fifth_counter = 0; 
            nextstate1 = ST_SIXTH;
          end else fifth_counter= fifth_counter + 1;
        end


      ST_SIXTH: // Signal 2 becomes yellow
        begin
          red1 = 1; yellow1 = 0; green1 = 0;   
          red2 = 0; yellow2 = 1; green2 = 0;
          if(sixth_counter == 200000000) begin //Signal 4 and 2 turn red 
            sixth_counter=0;
            nextstate1 = ST_SEVENTH;					
          end else sixth_counter= sixth_counter + 1;
        end

      ST_SEVENTH: // 1st Intersection signals are made red   
        begin
          red1 = 1; yellow1 = 0; green1 = 0;   
          red2 = 1; yellow2 = 0; green2 = 0;
          if(seventh_counter == 100000000)begin
            seventh_counter = 0;
            nextstate1 = ST_SECOND;
          end else seventh_counter = seventh_counter + 1;
        end
    endcase
  end

  always @ (posedge clk) begin
    case(state2) 
      ST_RESET2:
        begin
          red3 = 1; yellow3 = 1; green3 = 1;   
          red4 = 1; yellow4 = 1; green4 = 1;
          nextstate2 = ST_EIGHT;
        end

      ST_EIGHT: // 3rd and 4th signal become red  
        begin
          red3 = 1; yellow3 = 0; green3 = 0;   
          red4 = 1; yellow4 = 0; green4 = 0;
          if(eighth_counter == 500000000)begin
            eighth_counter = 0;
            nextstate2 = ST_NINE;
          end else eighth_counter = eighth_counter + 1;
        end

      ST_NINE:  
        begin 
          red3 = 0; yellow3 = 0; green3 = 1;
          red4 = 1; yellow4 = 0; green4 = 0;
          if(ninth_counter == 500000000) begin 
            ninth_counter = 0;
            nextstate2 = ST_TEN;
          end else ninth_counter = ninth_counter + 1;
        end

      ST_TEN: 
        begin 
          red3 = 0; yellow3 = 1; green3 = 0;
          red4 = 1; yellow4 = 0; green4 = 0;
          if(tenth_counter == 200000000) begin 
            tenth_counter = 0; 
            nextstate2 = ST_ELEVEN;
          end else tenth_counter = tenth_counter + 1;
        end

      ST_ELEVEN: 
        begin 
          red3 = 1; yellow3 = 0; green3 = 0;   
          red4 = 1; yellow4 = 0; green4 = 0;
          if(eleven_counter == 100000000) begin  
            eleven_counter=0;
            nextstate2 = ST_TWELVE;
          end else eleven_counter = eleven_counter + 1;
        end

      ST_TWELVE:
        begin 
          red3 = 1; yellow3 = 0; green3 = 0;   
          red4 = 0; yellow4 = 0; green4 = 1;
          if(twelfth_counter == 500000000) begin 
            twelfth_counter = 0; 
            nextstate2 = ST_THIRTEEN;
          end else twelfth_counter = twelfth_counter + 1;
        end

      ST_THIRTEEN: 
        begin 
          red3 = 1; yellow3 = 0; green3 = 0;   
          red4 = 0; yellow4 = 1; green4 = 0;
          if(thirteen_counter == 200000000) begin 
            thirteen_counter=0;
            nextstate2 = ST_FOURTEEN;					
          end else thirteen_counter = thirteen_counter + 1;
        end

      ST_FOURTEEN: // 3rd and 4th signal become red  
        begin
          red3 = 1; yellow3 = 0; green3 = 0;   
          red4 = 1; yellow4 = 0; green4 = 0;
          if(fourteen_counter == 100000000)begin
            fourteen_counter = 0;
            nextstate2 = ST_NINE;
          end else fourteen_counter = fourteen_counter + 1;
        end
    endcase
  end

endmodule