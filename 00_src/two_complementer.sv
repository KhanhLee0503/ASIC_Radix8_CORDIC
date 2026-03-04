module two_complementer(
    input logic [31:0] data_in,
    input logic enable,
    output logic [31:0] data_out
);

assign data_out = enable ? ~data_in + 32'h1 : data_in;

endmodule