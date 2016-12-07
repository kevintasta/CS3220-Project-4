library verilog;
use verilog.vl_types.all;
entity JalCheck is
    port(
        opCode          : in     vl_logic_vector(3 downto 0);
        isJal           : out    vl_logic;
        isBr            : out    vl_logic
    );
end JalCheck;
