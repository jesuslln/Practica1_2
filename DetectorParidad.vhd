library ieee;
use ieee.std_logic_1164.all;

entity DetectorParidad is
	port(
		entrada : in std_logic_vector(10 downto 0);
		impar   : out std_logic
	);
end DetectorParidad;

architecture behavioral of DetectorParidad is

	signal b_paridad : std_logic_vector(8 downto 0);
	signal p	  : std_logic := '0';

begin

b_paridad <= entrada(9 downto 1);

Paridad : for i in 0 to 8 generate
			p <= b_paridad(i) xor p;
end Paridad;

impar <= p;

end behavioral;


