library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

entity RAM_16_4 is
    port(
        addr : in  std_logic_vector(3 downto 0);
        din  : in  std_logic_vector(3 downto 0);
        wr   : in  std_logic;
        clk  : in  std_logic;
        dout : out std_logic_vector(3 downto 0)
    );
end RAM_16_4;

architecture Behavioral of RAM_16_4 is

    type mem_type is array (0 to 15) of std_logic_vector(3 downto 0);
    signal mem : mem_type;

    signal addr_reg : std_logic_vector(3 downto 0);

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if (wr = '1') then
                mem(conv_integer(unsigned(addr))) <= din;
            end if;

            addr_reg <= addr;
        end if;
    end process;

    dout <= mem(conv_integer(unsigned(addr_reg)));

end Behavioral;