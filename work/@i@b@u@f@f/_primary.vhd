library verilog;
use verilog.vl_types.all;
entity IBUFF is
    port(
        incPC           : in     vl_logic_vector(31 downto 0);
        instrIn         : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        flush           : in     vl_logic;
        pcOut           : out    vl_logic_vector(31 downto 0);
        instrOut        : out    vl_logic_vector(31 downto 0)
    );
end IBUFF;
