library verilog;
use verilog.vl_types.all;
entity Forwarding is
    generic(
        REG             : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        ALU             : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        MEM             : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        WB              : vl_logic_vector(1 downto 0) := (Hi1, Hi1);
        SW              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi1);
        BRANCH          : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi0);
        NOP             : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi0)
    );
    port(
        opIn            : in     vl_logic_vector(3 downto 0);
        opEx            : in     vl_logic_vector(3 downto 0);
        opMem           : in     vl_logic_vector(3 downto 0);
        opWb            : in     vl_logic_vector(3 downto 0);
        reg1In          : in     vl_logic_vector(3 downto 0);
        reg2In          : in     vl_logic_vector(3 downto 0);
        regDestEx       : in     vl_logic_vector(3 downto 0);
        regDestMem      : in     vl_logic_vector(3 downto 0);
        regDestWb       : in     vl_logic_vector(3 downto 0);
        reg1Mux         : out    vl_logic_vector(1 downto 0);
        reg2Mux         : out    vl_logic_vector(1 downto 0);
        isLW            : in     vl_logic;
        lwStall         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of REG : constant is 2;
    attribute mti_svvh_generic_type of ALU : constant is 2;
    attribute mti_svvh_generic_type of MEM : constant is 2;
    attribute mti_svvh_generic_type of WB : constant is 2;
    attribute mti_svvh_generic_type of SW : constant is 2;
    attribute mti_svvh_generic_type of BRANCH : constant is 2;
    attribute mti_svvh_generic_type of NOP : constant is 2;
end Forwarding;
