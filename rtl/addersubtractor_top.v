module top_addersubtractor (
    // Các chân vật lý nối ra ngoài Chip (Pad)
    input  wire p_Clock,
    input  wire p_Reset,
    input  wire p_Sel,
    input  wire p_AddSub,
    input  wire [15:0] p_A,
    input  wire [15:0] p_B,
    output wire [15:0] p_Z,
    output wire p_Overflow,

    // Chân nguồn IO (3.3V) và Core (1.2V/1.8V)
    inout wire vddio,    // IO Power
    inout wire vssio,    // IO Ground
    inout wire vddcore,  // Core Power
    inout wire vsscore   // Core Ground
);

    // Tín hiệu nội bộ (Core side)
    wire c_Clock, c_Reset, c_Sel, c_AddSub;
    wire [15:0] c_A, c_B, c_Z;
    wire c_Overflow;

    // ---------------------------------------------------------
    // 1. INPUT PADS
    // ---------------------------------------------------------
    sg13g2_IOPadIn pad_clk    (.pad(p_Clock),   .p2c(c_Clock));
    sg13g2_IOPadIn pad_rst    (.pad(p_Reset),   .p2c(c_Reset));
    sg13g2_IOPadIn pad_sel    (.pad(p_Sel),     .p2c(c_Sel));
    sg13g2_IOPadIn pad_addsub (.pad(p_AddSub),  .p2c(c_AddSub));

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_input_pads
            sg13g2_IOPadIn pad_A_inst (.pad(p_A[i]), .p2c(c_A[i]));
            sg13g2_IOPadIn pad_B_inst (.pad(p_B[i]), .p2c(c_B[i]));
        end
    endgenerate

    // ---------------------------------------------------------
    // 2. OUTPUT PADS
    // ---------------------------------------------------------
    sg13g2_IOPadOut4mA pad_ovfl (.pad(p_Overflow), .c2p(c_Overflow));

    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_output_pads
            sg13g2_IOPadOut4mA pad_Z_inst (.pad(p_Z[i]), .c2p(c_Z[i]));
        end
    endgenerate

    // ---------------------------------------------------------
    // 3. POWER PADS (Dựa trên PIN của LEF: iovdd, iovss, vdd, vss)
    // Phải nối cả 4 đường để đảm bảo tính liên tục của Pad Ring
    // ---------------------------------------------------------
    sg13g2_IOPadIOVdd pad_iovdd_inst (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));
    sg13g2_IOPadIOVss pad_iovss_inst (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));

    sg13g2_IOPadVdd   pad_vdd_inst   (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));
    sg13g2_IOPadVss   pad_vss_inst   (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));

    // ---------------------------------------------------------
    // 4. CORNER PADS (Phải nối nguồn theo LEF)
    // ---------------------------------------------------------
    sg13g2_Corner corner_top_left     (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));
    sg13g2_Corner corner_top_right    (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));
    sg13g2_Corner corner_bottom_left  (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));
    sg13g2_Corner corner_bottom_right (.iovdd(vddio), .iovss(vssio), .vdd(vddcore), .vss(vsscore));

    // ---------------------------------------------------------
    // 5. CORE LOGIC
    // ---------------------------------------------------------
    addersubtractor core_logic (
        .A(c_A), .B(c_B), .Clock(c_Clock), .Reset(c_Reset),
        .Sel(c_Sel), .AddSub(c_AddSub), .Z(c_Z), .Overflow(c_Overflow)
    );

endmodule


