library verilog;
use verilog.vl_types.all;
entity Shiftbit is
    generic(
        bitwidth        : integer := 32;
        shift_by        : integer := 2
    );
    port(
        din             : in     vl_logic_vector;
        dout            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bitwidth : constant is 1;
    attribute mti_svvh_generic_type of shift_by : constant is 1;
end Shiftbit;
