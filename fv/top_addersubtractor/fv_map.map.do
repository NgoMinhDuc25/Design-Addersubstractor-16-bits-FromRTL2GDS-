
//input ports
add mapped point p_Clock p_Clock -type PI PI
add mapped point p_Reset p_Reset -type PI PI
add mapped point p_Sel p_Sel -type PI PI
add mapped point p_AddSub p_AddSub -type PI PI
add mapped point p_A[15] p_A[15] -type PI PI
add mapped point p_A[14] p_A[14] -type PI PI
add mapped point p_A[13] p_A[13] -type PI PI
add mapped point p_A[12] p_A[12] -type PI PI
add mapped point p_A[11] p_A[11] -type PI PI
add mapped point p_A[10] p_A[10] -type PI PI
add mapped point p_A[9] p_A[9] -type PI PI
add mapped point p_A[8] p_A[8] -type PI PI
add mapped point p_A[7] p_A[7] -type PI PI
add mapped point p_A[6] p_A[6] -type PI PI
add mapped point p_A[5] p_A[5] -type PI PI
add mapped point p_A[4] p_A[4] -type PI PI
add mapped point p_A[3] p_A[3] -type PI PI
add mapped point p_A[2] p_A[2] -type PI PI
add mapped point p_A[1] p_A[1] -type PI PI
add mapped point p_A[0] p_A[0] -type PI PI
add mapped point p_B[15] p_B[15] -type PI PI
add mapped point p_B[14] p_B[14] -type PI PI
add mapped point p_B[13] p_B[13] -type PI PI
add mapped point p_B[12] p_B[12] -type PI PI
add mapped point p_B[11] p_B[11] -type PI PI
add mapped point p_B[10] p_B[10] -type PI PI
add mapped point p_B[9] p_B[9] -type PI PI
add mapped point p_B[8] p_B[8] -type PI PI
add mapped point p_B[7] p_B[7] -type PI PI
add mapped point p_B[6] p_B[6] -type PI PI
add mapped point p_B[5] p_B[5] -type PI PI
add mapped point p_B[4] p_B[4] -type PI PI
add mapped point p_B[3] p_B[3] -type PI PI
add mapped point p_B[2] p_B[2] -type PI PI
add mapped point p_B[1] p_B[1] -type PI PI
add mapped point p_B[0] p_B[0] -type PI PI

//output ports
add mapped point p_Z[15] p_Z[15] -type PO PO
add mapped point p_Z[14] p_Z[14] -type PO PO
add mapped point p_Z[13] p_Z[13] -type PO PO
add mapped point p_Z[12] p_Z[12] -type PO PO
add mapped point p_Z[11] p_Z[11] -type PO PO
add mapped point p_Z[10] p_Z[10] -type PO PO
add mapped point p_Z[9] p_Z[9] -type PO PO
add mapped point p_Z[8] p_Z[8] -type PO PO
add mapped point p_Z[7] p_Z[7] -type PO PO
add mapped point p_Z[6] p_Z[6] -type PO PO
add mapped point p_Z[5] p_Z[5] -type PO PO
add mapped point p_Z[4] p_Z[4] -type PO PO
add mapped point p_Z[3] p_Z[3] -type PO PO
add mapped point p_Z[2] p_Z[2] -type PO PO
add mapped point p_Z[1] p_Z[1] -type PO PO
add mapped point p_Z[0] p_Z[0] -type PO PO
add mapped point p_Overflow p_Overflow -type PO PO

//inout ports
add mapped point vddio vddio
add mapped point vssio vssio
add mapped point vddcore vddcore
add mapped point vsscore vsscore




//Sequential Pins
add mapped point core_logic/Breg[7]/q core_logic/Breg_reg[7]/Q -type DFF DFF
add mapped point core_logic/Breg[8]/q core_logic/Breg_reg[8]/Q -type DFF DFF
add mapped point core_logic/Breg[12]/q core_logic/Breg_reg[12]/Q -type DFF DFF
add mapped point core_logic/Breg[14]/q core_logic/Breg_reg[14]/Q -type DFF DFF
add mapped point core_logic/Breg[0]/q core_logic/Breg_reg[0]/Q -type DFF DFF
add mapped point core_logic/Breg[15]/q core_logic/Breg_reg[15]/Q -type DFF DFF
add mapped point core_logic/Breg[6]/q core_logic/Breg_reg[6]/Q -type DFF DFF
add mapped point core_logic/Breg[11]/q core_logic/Breg_reg[11]/Q -type DFF DFF
add mapped point core_logic/Breg[4]/q core_logic/Breg_reg[4]/Q -type DFF DFF
add mapped point core_logic/Breg[9]/q core_logic/Breg_reg[9]/Q -type DFF DFF
add mapped point core_logic/Breg[5]/q core_logic/Breg_reg[5]/Q -type DFF DFF
add mapped point core_logic/Breg[13]/q core_logic/Breg_reg[13]/Q -type DFF DFF
add mapped point core_logic/Breg[1]/q core_logic/Breg_reg[1]/Q -type DFF DFF
add mapped point core_logic/Breg[10]/q core_logic/Breg_reg[10]/Q -type DFF DFF
add mapped point core_logic/Breg[3]/q core_logic/Breg_reg[3]/Q -type DFF DFF
add mapped point core_logic/Breg[2]/q core_logic/Breg_reg[2]/Q -type DFF DFF
add mapped point core_logic/Zreg[4]/q core_logic/Zreg_reg[4]/Q -type DFF DFF
add mapped point core_logic/Zreg[1]/q core_logic/Zreg_reg[1]/Q -type DFF DFF
add mapped point core_logic/Zreg[2]/q core_logic/Zreg_reg[2]/Q -type DFF DFF
add mapped point core_logic/Zreg[3]/q core_logic/Zreg_reg[3]/Q -type DFF DFF
add mapped point core_logic/Zreg[0]/q core_logic/Zreg_reg[0]/Q -type DFF DFF
add mapped point core_logic/Zreg[11]/q core_logic/Zreg_reg[11]/Q -type DFF DFF
add mapped point core_logic/Zreg[5]/q core_logic/Zreg_reg[5]/Q -type DFF DFF
add mapped point core_logic/Zreg[6]/q core_logic/Zreg_reg[6]/Q -type DFF DFF
add mapped point core_logic/Zreg[12]/q core_logic/Zreg_reg[12]/Q -type DFF DFF
add mapped point core_logic/Zreg[8]/q core_logic/Zreg_reg[8]/Q -type DFF DFF
add mapped point core_logic/Zreg[9]/q core_logic/Zreg_reg[9]/Q -type DFF DFF
add mapped point core_logic/Zreg[10]/q core_logic/Zreg_reg[10]/Q -type DFF DFF
add mapped point core_logic/Zreg[7]/q core_logic/Zreg_reg[7]/Q -type DFF DFF
add mapped point core_logic/Zreg[13]/q core_logic/Zreg_reg[13]/Q -type DFF DFF
add mapped point core_logic/Zreg[14]/q core_logic/Zreg_reg[14]/Q -type DFF DFF
add mapped point core_logic/Zreg[15]/q core_logic/Zreg_reg[15]/Q -type DFF DFF
add mapped point core_logic/Overflow/q core_logic/Overflow_reg/Q -type DFF DFF
add mapped point core_logic/Areg[6]/q core_logic/Areg_reg[6]/Q -type DFF DFF
add mapped point core_logic/Areg[14]/q core_logic/Areg_reg[14]/Q -type DFF DFF
add mapped point core_logic/SelR/q core_logic/SelR_reg/Q -type DFF DFF
add mapped point core_logic/Areg[1]/q core_logic/Areg_reg[1]/Q -type DFF DFF
add mapped point core_logic/Areg[3]/q core_logic/Areg_reg[3]/Q -type DFF DFF
add mapped point core_logic/Areg[13]/q core_logic/Areg_reg[13]/Q -type DFF DFF
add mapped point core_logic/Areg[4]/q core_logic/Areg_reg[4]/Q -type DFF DFF
add mapped point core_logic/Areg[5]/q core_logic/Areg_reg[5]/Q -type DFF DFF
add mapped point core_logic/Areg[0]/q core_logic/Areg_reg[0]/Q -type DFF DFF
add mapped point core_logic/Areg[10]/q core_logic/Areg_reg[10]/Q -type DFF DFF
add mapped point core_logic/Areg[8]/q core_logic/Areg_reg[8]/Q -type DFF DFF
add mapped point core_logic/Areg[9]/q core_logic/Areg_reg[9]/Q -type DFF DFF
add mapped point core_logic/AddSubR/q core_logic/AddSubR_reg/Q -type DFF DFF
add mapped point core_logic/Areg[11]/q core_logic/Areg_reg[11]/Q -type DFF DFF
add mapped point core_logic/Areg[12]/q core_logic/Areg_reg[12]/Q -type DFF DFF
add mapped point core_logic/Areg[2]/q core_logic/Areg_reg[2]/Q -type DFF DFF
add mapped point core_logic/Areg[15]/q core_logic/Areg_reg[15]/Q -type DFF DFF
add mapped point core_logic/Areg[7]/q core_logic/Areg_reg[7]/Q -type DFF DFF



//Black Boxes
add mapped point pad_iovdd_inst pad_iovdd_inst -type BBOX BBOX
add mapped point pad_iovss_inst pad_iovss_inst -type BBOX BBOX
add mapped point pad_vdd_inst pad_vdd_inst -type BBOX BBOX
add mapped point pad_vss_inst pad_vss_inst -type BBOX BBOX



//Empty Modules as Blackboxes
