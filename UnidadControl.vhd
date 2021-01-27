library ieee;
use ieee.std_logic_1164.all;

entity UnidadControl is 
	port(
		clk 		: in std_logic;
		reset_n 	: in std_logic;
		start 	: in std_logic;
		stop 		: in std_logic;
		Impar 	: in std_logic;
		b_fin 	: in std_logic;
		led_p 	: out std_logic;
		led_sp 	: out std_logic;
		en_cnt	: out std_logic);
end UnidadControl;

architecture behavioral of UnidadControl is

	type t_estados is (St, Bits, Paridad, Sp); -- st (start) - sp (stop)
	signal est_act, est_sig : t_estados;
	
begin

VarEstado: process(clk,reset_n)
begin
			if reset_n = '0' then 
				est_act <= St; 
			elsif rising_edge(clk) then 
				est_act <= est_sig ;
			end if;
end process;

TransEstados : process()
begin
		est_sig <= est_act;
		
		case est_act is 
		
			when St =>
				if start = '0' then
					est_sig <= Bits;
				end if;
				
			when Bits =>
				if b_fin = '1' then
					est_sig <= Paridad;
				end if;
				
			when Paridad =>
				if Impar = '1' then 
					est_sig <= Sp;
				else
					est_sig <= St
				end if;
			
			when Sp =>
				if stop ='0' then
					est_sig <= St;
				end if;
		end case;
end process;


Salidas : proces()
begin
	Impar = '1';
	Stop = '1';
	
	case est_act is 
		when St =>
			if Impar = '0' then 
				Led_p <= '1';
			end if;
			
			if stop = '0' then
				led_sp = '1';
			end if;
			
		when Bits =>
			led_p = '0';
			led_sp = '0';
			
		when Paridad =>
			null;
			
		when Sp =>
			en_cnt = '0';
				
	end case;
end process;

end behavioral;