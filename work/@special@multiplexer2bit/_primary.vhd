library verilog;
use verilog.vl_types.all;
entity SpecialMultiplexer2bit is
    generic(
        bitwidth        : integer := 32
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        selector        : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bitwidth : constant is 1;
end SpecialMultiplexer2bit;
