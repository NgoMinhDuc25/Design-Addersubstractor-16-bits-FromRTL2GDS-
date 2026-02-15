module adderk (carryin, X, Y, S, carryout);
    parameter k = 16;
    input  [k-1:0] X, Y;
    input  carryin;
    output [k-1:0] S;
    output carryout;
    
    reg [k-1:0] S;
    reg carryout;

    always @(X or Y or carryin) begin
        {carryout, S} = X + Y + carryin;
    end
endmodule

