library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    generic(
        bitwidth        : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        reg_wr_en       : in     vl_logic;
        wr_select       : in     vl_logic_vector(3 downto 0);
        reg_select1     : in     vl_logic_vector(3 downto 0);
        reg_select2     : in     vl_logic_vector(3 downto 0);
        reg_data1       : out    vl_logic_vector;
        reg_data2       : out    vl_logic_vector;
        wr_data         : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bitwidth : constant is 1;
end RegisterFile;
