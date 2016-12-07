library verilog;
use verilog.vl_types.all;
entity Alu is
    generic(
        bitwidth        : integer := 32
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        alu_func        : in     vl_logic_vector(3 downto 0);
        cmp_func        : in     vl_logic_vector(3 downto 0);
        flag            : out    vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bitwidth : constant is 1;
end Alu;
