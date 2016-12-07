library verilog;
use verilog.vl_types.all;
entity MBUFF is
    port(
        memValIn        : in     vl_logic_vector(31 downto 0);
        destRegIn       : in     vl_logic_vector(3 downto 0);
        regWrEnIn       : in     vl_logic;
        opIn            : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        flush           : in     vl_logic;
        memValOut       : out    vl_logic_vector(31 downto 0);
        destRegOut      : out    vl_logic_vector(3 downto 0);
        regWrEnOut      : out    vl_logic;
        opOut           : out    vl_logic_vector(3 downto 0)
    );
end MBUFF;
