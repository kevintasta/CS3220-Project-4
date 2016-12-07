library verilog;
use verilog.vl_types.all;
entity Decoder is
    generic(
        bitwidth        : integer := 32
    );
    port(
        inst            : in     vl_logic_vector;
        op_code         : out    vl_logic_vector(3 downto 0);
        func_code       : out    vl_logic_vector(3 downto 0);
        rd              : out    vl_logic_vector(3 downto 0);
        rs1             : out    vl_logic_vector(3 downto 0);
        rs2             : out    vl_logic_vector(3 downto 0);
        imm             : out    vl_logic_vector(15 downto 0);
        isLW            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bitwidth : constant is 1;
end Decoder;
