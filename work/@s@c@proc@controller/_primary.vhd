library verilog;
use verilog.vl_types.all;
entity SCProcController is
    port(
        opcode          : in     vl_logic_vector(3 downto 0);
        func            : in     vl_logic_vector(3 downto 0);
        allowBr         : out    vl_logic;
        brBaseMux       : out    vl_logic;
        rs1Mux          : out    vl_logic;
        rs2Mux          : out    vl_logic_vector(1 downto 0);
        alu2Mux         : out    vl_logic_vector(1 downto 0);
        aluOp           : out    vl_logic_vector(3 downto 0);
        cmpOp           : out    vl_logic_vector(3 downto 0);
        wrReg           : out    vl_logic;
        wrMem           : out    vl_logic;
        dstRegMux       : out    vl_logic_vector(1 downto 0)
    );
end SCProcController;
