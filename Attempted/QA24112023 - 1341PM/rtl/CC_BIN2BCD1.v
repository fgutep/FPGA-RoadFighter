/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
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
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/

module CC_BIN2BCD1 (
	CC_BIN2BCD_bcd_OutBUS,
	CC_BIN2BCD_bin_InBUS
);
   
//input ports and their sizes
input [7:0] CC_BIN2BCD_bin_InBUS;
//output ports and, their size
output [11:0] CC_BIN2BCD_bcd_OutBUS;
//Internal variables
reg [11 : 0] CC_BIN2BCD_bcd_OutBUS; 
reg [3:0] i;   
     
     //Always block - implement the Double Dabble algorithm
     always @(CC_BIN2BCD_bin_InBUS)
        begin
            CC_BIN2BCD_bcd_OutBUS = 0; //initialize bcd to zero.
            for (i = 0; i < 8; i = i+1) //run for 8 iterations
            begin
                CC_BIN2BCD_bcd_OutBUS = {CC_BIN2BCD_bcd_OutBUS[10:0],CC_BIN2BCD_bin_InBUS[7-i]}; //concatenation
                    
                //if a hex digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 7 && CC_BIN2BCD_bcd_OutBUS[3:0] > 4) 
                    CC_BIN2BCD_bcd_OutBUS[3:0] = CC_BIN2BCD_bcd_OutBUS[3:0] + 3;
                if(i < 7 && CC_BIN2BCD_bcd_OutBUS[7:4] > 4)
                    CC_BIN2BCD_bcd_OutBUS[7:4] = CC_BIN2BCD_bcd_OutBUS[7:4] + 3;
                if(i < 7 && CC_BIN2BCD_bcd_OutBUS[11:8] > 4)
                    CC_BIN2BCD_bcd_OutBUS[11:8] = CC_BIN2BCD_bcd_OutBUS[11:8] + 3;  
            end
        end     
                
endmodule
 