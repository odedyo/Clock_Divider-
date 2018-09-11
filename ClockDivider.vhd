library ieee;
use ieee.std_logic_1164.all;

Entity ClockDivider is
port(CLOCK_50 : in std_logic;				--FPGA Board clock
	   SW : in std_logic_vector(17 downto 16);	--SW
	 LEDR : out std_logic_vector(0 downto 0);	--LED output to received frequencies
	 GPIO : out std_logic_vector(0 downto 0));	--output to received frequencies
end ClockDivider;

architecture behave of ClockDivider is
shared VARIABLE count : integer RANGE 0 to 50000000 :=0;
signal Hz1_50 : std_logic;
signal Hz1_25 : std_logic;
signal Hz10_50 : std_logic;
signal Hz10_75 : std_logic;

begin
process(CLOCK_50)

begin

if CLOCK_50'event and CLOCK_50='1' then
	
	if(SW="00") then				
		LEDR(0)<=Hz1_50;			
		GPIO(0)<=Hz1_50;			-- 1 Hz , duty cycle 50%
		count:=count+1;				
		if (count=25000000) then
			Hz1_50<=not Hz1_50;
			count:=0;
		end if;
	
	elsif(SW="01") then
	LEDR(0)<=Hz1_25;
	GPIO(0)<=Hz1_25;
	count:=count+1;
		if (count=37500000) then                -- 1 Hz , duty cycle 25%
			Hz1_25<='1';
		elsif(count=50000000) then
			Hz1_25<='0';
			count:=0;
		end if;

	elsif(SW="10") then
	LEDR(0)<=Hz10_50;
	GPIO(0)<=Hz10_50;
	count:=count+1;
		if (count=5000000) then
			Hz10_50<=not Hz10_50;		-- 10 Hz , duty cycle 25%
			count:=0;
		end if;
	
	elsif(SW="11") then
	LEDR(0)<=Hz10_75;
	GPIO(0)<=Hz10_75;
	count:=count+1;
		if (count=1250000) then			-- 10 Hz , duty cycle 75%
			Hz10_75<='1';
		elsif(count=5000000) then
			Hz10_75<='0';
			count:=0;
		end if;
	end if;
end if;
end process;
end behave;

