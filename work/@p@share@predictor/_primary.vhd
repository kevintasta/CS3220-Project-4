library verilog;
use verilog.vl_types.all;
entity PSharePredictor is
    generic(
        PC_CHUNK_WIDTH  : integer := 12;
        HISTORY_WIDTH   : integer := 12;
        TABLE_SIZE      : integer := 4096
    );
    port(
        clk             : in     vl_logic;
        predictPC       : in     vl_logic_vector(15 downto 0);
        updatePC        : in     vl_logic_vector(15 downto 0);
        predict         : in     vl_logic;
        update          : in     vl_logic;
        reality         : in     vl_logic;
        prediction      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PC_CHUNK_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of HISTORY_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of TABLE_SIZE : constant is 1;
end PSharePredictor;
