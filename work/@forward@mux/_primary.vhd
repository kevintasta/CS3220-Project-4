library verilog;
use verilog.vl_types.all;
entity ForwardMux is
    generic(
        REG             : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        ALU             : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        MEM             : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        WB              : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        regOut          : in     vl_logic_vector(31 downto 0);
        aluOut          : in     vl_logic_vector(31 downto 0);
        memOut          : in     vl_logic_vector(31 downto 0);
        wbOut           : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        muxOut          : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of REG : constant is 2;
    attribute mti_svvh_generic_type of ALU : constant is 2;
    attribute mti_svvh_generic_type of MEM : constant is 2;
    attribute mti_svvh_generic_type of WB : constant is 2;
end ForwardMux;
