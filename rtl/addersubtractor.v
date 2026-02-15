module addersubtractor (A, B, Clock, Reset, Sel, AddSub, Z, Overflow);
    parameter n = 16;
    input [n-1:0] A, B;
    input Clock, Reset, Sel, AddSub;
    output [n-1:0] Z;
    output Overflow;

    reg SelR, AddSubR, Overflow;
    reg [n-1:0] Areg, Breg, Zreg;
    wire [n-1:0] G, H, M; // Bo Z o day vi Z la output wire
    wire carryout, over_flow;

    // 1. Khoi tao logic to hop
    // Dung XOR (^) de dao bit khi thuc hien phep tru
    assign H = Breg ^ {n{AddSubR}}; 

    mux2to1 multiplexer (Areg, Zreg, SelR, G);
    defparam multiplexer.k = n;

    adderk nbit_adder (AddSubR, G, H, M, carryout);
    defparam nbit_adder.k = n;

    // Dung AND (&) chuan Verilog
    assign over_flow = carryout & G[n-1] & H[n-1] & M[n-1];
    
    assign Z = Zreg;

    // 2. Khoi tao Registers (Sequential Logic)
    always @(posedge Reset or posedge Clock) begin
        if (Reset == 1'b1) begin
            Areg <= 0; 
            Breg <= 0; 
            Zreg <= 0;
            SelR <= 0; 
            AddSubR <= 0; 
            Overflow <= 0;
        end else begin
            Areg <= A; 
            Breg <= B; 
            Zreg <= M;
            SelR <= Sel; 
            AddSubR <= AddSub; 
            Overflow <= over_flow;
        end
    end
endmodule


