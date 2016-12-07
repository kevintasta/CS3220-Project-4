library verilog;
use verilog.vl_types.all;
entity DBUFF is
    port(
        incPC           : in     vl_logic_vector(31 downto 0);
        src1RegIn       : in     vl_logic_vector(31 downto 0);
        src2RegIn       : in     vl_logic_vector(31 downto 0);
        sextIn          : in     vl_logic_vector(31 downto 0);
        offsetIn        : in     vl_logic_vector(31 downto 0);
        aluOpIn         : in     vl_logic_vector(3 downto 0);
        aluCmpIn        : in     vl_logic_vector(3 downto 0);
        aluSelIn        : in     vl_logic_vector(1 downto 0);
        destRegIn       : in     vl_logic_vector(3 downto 0);
        regWrEnIn       : in     vl_logic;
        memWrEnIn       : in     vl_logic;
        isLWIn          : in     vl_logic;
        opIn            : in     vl_logic_vector(3 downto 0);
        dstRegMuxIn     : in     vl_logic_vector(1 downto 0);
        clk             : in     vl_logic;
        flush           : in     vl_logic;
        incPCOut        : out    vl_logic_vector(31 downto 0);
        src1RegOut      : out    vl_logic_vector(31 downto 0);
        src2RegOut      : out    vl_logic_vector(31 downto 0);
        sextOut         : out    vl_logic_vector(31 downto 0);
        offsetOut       : out    vl_logic_vector(31 downto 0);
        aluOpOut        : out    vl_logic_vector(3 downto 0);
        aluCmpOut       : out    vl_logic_vector(3 downto 0);
        aluSelOut       : out    vl_logic_vector(1 downto 0);
        destRegOut      : out    vl_logic_vector(3 downto 0);
        regWrEnOut      : out    vl_logic;
        memWrEnOut      : out    vl_logic;
        isLWOut         : out    vl_logic;
        opOut           : out    vl_logic_vector(3 downto 0);
        dstRegMuxOut    : out    vl_logic_vector(1 downto 0)
    );
end DBUFF;
