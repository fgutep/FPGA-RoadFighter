module CC_Jugabilidad #(parameter RDATAWIDTH=8)(
    ////////////// OUTPUTS //////////
    P0_CC_Jugabilidad_data_OutBUS,
    P1_CC_Jugabilidad_data_OutBUS,
    ////////////// INPUTS //////////
    CC_Jugabilidad_load_InLow,
    CC_Jugabilidad_CLOCK_50,
    CC_Jugabilidad_RESET_InHigh,
    P0_CC_Jugabilidad_data_InBUS,
    P1_CC_Jugabilidad_data_InBUS,
	 CC_Jugabilidad_BackregsLoadInLow
);

//=======================================================
//  PARAMETER declarations
//=======================================================
// states declaration
localparam STATE_RESET_0      = 0;
localparam STATE_CHECK			= 1;
localparam CHECK_CARS      	= 2;
localparam STATE_SEND_CARS		= 3;
localparam STATE_NO_SEND  		= 4;
localparam STATE_END  			= 5;

//=======================================================
//  PORT declarations
//=======================================================
input [7:0] P0_CC_Jugabilidad_data_InBUS;
input [7:0] P1_CC_Jugabilidad_data_InBUS;
input CC_Jugabilidad_load_InLow;
input CC_Jugabilidad_CLOCK_50;
input CC_Jugabilidad_RESET_InHigh;



//=======================================================
//  REG/WIRE declarations
//=======================================================
output reg [7:0]P0_CC_Jugabilidad_data_OutBUS;
output reg [7:0]P1_CC_Jugabilidad_data_OutBUS;

output reg CC_Jugabilidad_BackregsLoadInLow;

reg SHOULDSEND = 1'b1;
reg [3:0] STATE_Register;
reg [3:0] STATE_Signal;
//=======================================================
//  Structural coding	
//=======================================================
// INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC: COMBINATIONAL
always @(*)
begin
    case (STATE_Register)
        STATE_RESET_0: STATE_Signal = STATE_CHECK;
        STATE_CHECK: STATE_Signal = CHECK_CARS;
        
			CHECK_CARS:
				begin
					if ((CC_Jugabilidad_load_InLow == 1'b0) && (SHOULDSEND == 1'b1))
					begin
							STATE_Signal = STATE_SEND_CARS;
					end
						else if ((CC_Jugabilidad_load_InLow == 1'b0) && (SHOULDSEND == 1'b0))
					begin
							STATE_Signal = STATE_NO_SEND;
					end
					else
					begin
							STATE_Signal = CHECK_CARS;
					end
				end

        default : STATE_Signal = CHECK_CARS;  
    endcase
end

// STATE REGISTER: SEQUENTIAL
always @ (posedge CC_Jugabilidad_CLOCK_50, posedge CC_Jugabilidad_RESET_InHigh)
begin
    if (CC_Jugabilidad_RESET_InHigh == 1'b1)
        STATE_Register <= STATE_RESET_0;
    else
        STATE_Register <= STATE_Signal;
end

//=======================================================
// Outputs
//=======================================================
// OUTPUT LOGIC: COMBINATIONAL
always @ (*)
begin
    case (STATE_Register)
        STATE_RESET_0 :    
            begin
                P0_CC_Jugabilidad_data_OutBUS = 8'b00000000;
                P1_CC_Jugabilidad_data_OutBUS = 8'b00000000;
					 CC_Jugabilidad_BackregsLoadInLow = 1'b1;
            end

        STATE_CHECK :    
            begin
                P0_CC_Jugabilidad_data_OutBUS = 8'b00000000;
                P1_CC_Jugabilidad_data_OutBUS = 8'b00000000;
					 CC_Jugabilidad_BackregsLoadInLow = 1'b1;
            end

        CHECK_CARS :
            begin
                P0_CC_Jugabilidad_data_OutBUS = 8'b00000000;
                P1_CC_Jugabilidad_data_OutBUS = 8'b00000000;
					 CC_Jugabilidad_BackregsLoadInLow = 1'b1;
            end

        STATE_SEND_CARS :
            begin
					if ((P0_CC_Jugabilidad_data_InBUS == 8'b00001111) || (P1_CC_Jugabilidad_data_InBUS == 8'b11110000)) begin
					    P0_CC_Jugabilidad_data_OutBUS = 8'b00000011;
    					P1_CC_Jugabilidad_data_OutBUS = 8'b11000000;
    					SHOULDSEND = 1'b0;
						CC_Jugabilidad_BackregsLoadInLow = 1'b0;
					end else begin
    					P0_CC_Jugabilidad_data_OutBUS = P0_CC_Jugabilidad_data_InBUS;
    					P1_CC_Jugabilidad_data_OutBUS = P1_CC_Jugabilidad_data_InBUS;
    					SHOULDSEND = 1'b0;
						CC_Jugabilidad_BackregsLoadInLow = 1'b0;
								end
				end
        STATE_NO_SEND :
            begin
                P0_CC_Jugabilidad_data_OutBUS = 8'b00000000;
                P1_CC_Jugabilidad_data_OutBUS = 8'b00000000;
					 SHOULDSEND = 1'b1;
					 CC_Jugabilidad_BackregsLoadInLow = 1'b0;
            end

        default :
            begin
					P0_CC_Jugabilidad_data_OutBUS = P0_CC_Jugabilidad_data_InBUS;
					P1_CC_Jugabilidad_data_OutBUS = P1_CC_Jugabilidad_data_InBUS;
					CC_Jugabilidad_BackregsLoadInLow = 1'b1;
            end
    endcase
end

endmodule
