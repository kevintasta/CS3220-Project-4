library verilog;
use verilog.vl_types.all;
entity EBUFF is
    port(
        pcIn            : in     vl_logic_vector(31 downto 0);
        src1RegIn       : in     vl_logic_vector(31 downto 0);
        aluCalcIn       : in     vl_logic_vector(31 downto 0);
        aluCondIn       : in     vl_logic_vector(31 downto 0);
        destRegIn       : in     vl_logic_vector(3 downto 0);
        regWrEnIn       : in     vl_logic;
        memWrEnIn       : in     vl_logic;
        isLWIn          : in     vl_logic;
        opIn            : in     vl_logic_vector(3 downto 0);
        dstMuxIn        : in     vl_logic_vector(1 downto 0);
        clk             : in     vl_logic;
        flush           : in     vl_logic;
        pcOut           : out    vl_logic_vector(31 downto 0);
        src1RegOut      : out    vl_logic_vector(31 downto 0);
        aluCalcOut      : out    vl_logic_vector(31 downto 0);
        aluCondOut      : out    vl_logic_vector(31 downto 0);
        destRegOut      : out    vl_logic_vector(3 downto 0);
        regWrEnOut      : out    vl_logic;
        memWrEnOut      : out    vl_logic;
        isLWOut         : out    vl_logic;
        opOut           : out    vl_logic_vector(3 downto 0);
        dstMuxOut       : out    vl_logic_vector(1 downto 0)
    );
end EBUFF;
