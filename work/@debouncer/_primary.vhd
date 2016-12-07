library verilog;
use verilog.vl_types.all;
entity Debouncer is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic;
        \out\           : out    vl_logic
    );
end Debouncer;
