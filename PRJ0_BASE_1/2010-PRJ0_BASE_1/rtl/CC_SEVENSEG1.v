//##########################################################################
//######					TTDE-SD HDL EXAMPLES											####
//######	Fredy Enrique Segura-Quijano fsegura@uniandes.edu.co				####   
//######																						####   
//######				MODIFICADO: Agosto de 2016 - FES								####   
//##########################################################################
//# TTDE-SD
//# Copyright (C) 2014 Bogotá, Colombia
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>.
//#/
//###########################################################################

module CC_SEVENSEG1(
 input CC_SEVENSEG1_CLOCK_50, CC_SEVENSEG1_RESET_InHigh,
 input [3:0] CC_SEVENSEG1_in0, CC_SEVENSEG1_in1, CC_SEVENSEG1_in2, CC_SEVENSEG1_in3,  //the 4 inputs for each display
 output CC_SEVENSEG1_a, CC_SEVENSEG1_b, CC_SEVENSEG1_c, CC_SEVENSEG1_d, CC_SEVENSEG1_e, CC_SEVENSEG1_f, CC_SEVENSEG1_g, CC_SEVENSEG1_dp, //the individual LED output for the seven segment along with the digital point
 output [3:0] CC_SEVENSEG1_an   // the 4 bit enable signal
 );
 
localparam N = 15;
 
reg [N-1:0]count; //the 18 bit counter which allows us to multiplex at 1000Hz
 
always @ (posedge CC_SEVENSEG1_CLOCK_50 or posedge CC_SEVENSEG1_RESET_InHigh)
 begin
  if (CC_SEVENSEG1_RESET_InHigh==1'b1)
   count <= 0;
  else
   count <= count + 1'b1;
 end
 
reg [6:0]sseg; //the 7 bit register to hold the data to output
reg [3:0]an_temp; //register for the 4 bit enable
 
always @ (*)
 begin
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
    
   2'b00 :  //When the 2 MSB's are 00 enable the fourth display
    begin
     sseg = CC_SEVENSEG1_in0;
     an_temp = 4'b0001;
    end
    
   2'b01:  //When the 2 MSB's are 01 enable the third display
    begin
     sseg = CC_SEVENSEG1_in1;
     an_temp = 4'b0010;
    end
    
   2'b10:  //When the 2 MSB's are 10 enable the second display
    begin
     sseg = CC_SEVENSEG1_in2;
     an_temp = 4'b0100;
    end
     
   2'b11:  //When the 2 MSB's are 11 enable the first display
    begin
     sseg = CC_SEVENSEG1_in3;
     an_temp = 4'b1000;
    end
  endcase
 end
assign CC_SEVENSEG1_an = an_temp;
 
 
reg [6:0] sseg_temp; // 7 bit register to hold the binary value of each input given
 
always @ (*)
 begin
  case(sseg)
//   4'd0 : sseg_temp = 7'b1000000; //to display 0
   4'd0 : sseg_temp = 7'b1000000; //to display 0  40h

	4'd1 : sseg_temp = 7'b1111001; //to display 1 	79h
   4'd2 : sseg_temp = 7'b0100100; //to display 2 	24h
   4'd3 : sseg_temp = 7'b0110000; //to display 3 	30h
   4'd4 : sseg_temp = 7'b0011001; //to display 4 	19h
   4'd5 : sseg_temp = 7'b0010010; //to display 5 	12h
   4'd6 : sseg_temp = 7'b0000010; //to display 6 	02h
   4'd7 : sseg_temp = 7'b1111000; //to display 7 	78h
   4'd8 : sseg_temp = 7'b0000000; //to display 8 	00h
   4'd9 : sseg_temp = 7'b0010000; //to display 9   10h
   default : sseg_temp = 7'b0111111; //dash
  endcase
 end
assign {CC_SEVENSEG1_g, CC_SEVENSEG1_f, CC_SEVENSEG1_e, CC_SEVENSEG1_d, CC_SEVENSEG1_c, CC_SEVENSEG1_b, CC_SEVENSEG1_a} = sseg_temp; //concatenate the outputs to the register, this is just a more neat way of doing this.
// I could have done in the case statement: 4'd0 : {g, f, e, d, c, b, a} = 7'b1000000; 
// its the same thing.. write however you like it
 
assign CC_SEVENSEG1_dp = 1'b0; //since the decimal point is not needed, all 4 of them are turned off
 
 
endmodule

