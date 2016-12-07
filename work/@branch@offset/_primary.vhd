library verilog;
use verilog.vl_types.all;
entity BranchOffset is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        pc              : in     vl_logic_vector(31 downto 0);
        brOffset        : out    vl_logic_vector(31 downto 0)
    );
end BranchOffset;
