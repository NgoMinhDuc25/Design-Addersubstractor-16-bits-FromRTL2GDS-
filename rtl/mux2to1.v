module mux2to1 (V, W, Sel, F);
    parameter k = 16; 
    input  [k-1:0] V, W;
    input  Sel;
    output [k-1:0] F;
    
    reg [k-1:0] F;

    always @(V or W or Sel) begin
        if (Sel == 1'b0) 
            F = V;
        else 
            F = W;
    end
endmodule

