library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ram_ctrl is
    port(
        clkfast    : in  std_logic;
        rst        : in  std_logic;
        -- from RX
        intr       : in  std_logic;
        data_out   : in  std_logic_vector(7 downto 0);
        -- from TX
        xmitmt     : in  std_logic;
        -- to TX
        data_in    : out std_logic_vector(7 downto 0);
        shift_load : out std_logic;
        -- to/from RAM
        addr       : out std_logic_vector(3 downto 0);
        din        : out std_logic_vector(7 downto 0);
        wr         : out std_logic;
        dout       : in  std_logic_vector(7 downto 0)
    );
end ram_ctrl;

architecture fsm of ram_ctrl is

    -- port names now match the other modules (data_out from RX, data_in to TX)

    constant TERMINATOR : std_logic_vector(7 downto 0) := x"0D";  -- carriage return

    type STATE_TYPE is (s0, s1, s2, s3, s4);

    attribute state_vector : string;
    attribute state_vector of fsm : architecture is "current_state";

    signal current_state : STATE_TYPE;
    signal next_state    : STATE_TYPE;

    signal wr_ptr  : unsigned(3 downto 0);
    signal rd_ptr  : unsigned(3 downto 0);
    signal msg_len : unsigned(3 downto 0);
    signal tx_buf  : std_logic_vector(7 downto 0);

begin

    ----------------------------------------------------------------------------
    clocked : process(clkfast, rst)
    ----------------------------------------------------------------------------
    begin
        if (rst = '1') then
            current_state <= s0;
            wr_ptr        <= (others => '0');
            rd_ptr        <= (others => '0');
            msg_len       <= (others => '0');
            tx_buf        <= (others => '0');

        elsif (rising_edge(clkfast)) then
            current_state <= next_state;

            case current_state is

                when s0 =>  -- IDLE
                    wr_ptr <= (others => '0');
                    rd_ptr <= (others => '0');

                when s1 =>  -- WRITING
                    if (intr = '1') then
                        if (data_out = TERMINATOR) then
                            msg_len <= wr_ptr;
                            rd_ptr  <= (others => '0');
                        else
                            wr_ptr <= wr_ptr + 1;
                        end if;
                    end if;

                when s2 =>  -- WAIT_READ (RAM latency)
                    null;

                when s3 =>  -- READING
                    tx_buf <= dout;
                    rd_ptr <= rd_ptr + 1;

                when s4 =>  -- TXWAIT
                    null;

                when others =>
                    null;

            end case;
        end if;
    end process clocked;

    ----------------------------------------------------------------------------
    nextstate : process(current_state, intr, data_out, xmitmt, rd_ptr, msg_len)
    ----------------------------------------------------------------------------
    begin
        case current_state is

            when s0 =>
                if (intr = '1') then
                    next_state <= s1;
                else
                    next_state <= s0;
                end if;

            when s1 =>
                if (intr = '1' and data_out = TERMINATOR) then
                    next_state <= s2;
                else
                    next_state <= s1;
                end if;

            when s2 =>
                next_state <= s3;

            when s3 =>
                next_state <= s4;

            when s4 =>
                if (xmitmt = '1') then
                    if (rd_ptr = msg_len) then
                        next_state <= s0;
                    else
                        next_state <= s2;
                    end if;
                else
                    next_state <= s4;
                end if;

            when others =>
                next_state <= s0;

        end case;
    end process nextstate;

    ----------------------------------------------------------------------------
    output : process(current_state, wr_ptr, rd_ptr, data_out, tx_buf)
    ----------------------------------------------------------------------------
    begin
        -- defaults
        wr         <= '0';
        shift_load <= '0';
        addr       <= (others => '0');
        din        <= (others => '0');
        data_in    <= (others => '0');

        case current_state is

            when s1 =>  -- WRITING
                if (intr = '1') then
                    wr   <= '1';
                    addr <= std_logic_vector(wr_ptr);
                    din  <= data_out;
                end if;

            when s2 =>  -- WAIT_READ
                addr <= std_logic_vector(rd_ptr);
                wr   <= '0';

            when s3 =>  -- READING
                addr       <= std_logic_vector(rd_ptr);
                data_in    <= dout;
                shift_load <= '1';

            when s4 =>  -- TXWAIT
                data_in <= tx_buf;

            when others =>
                null;

        end case;
    end process output;

end fsm;
