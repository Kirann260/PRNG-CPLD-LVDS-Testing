libraryieee; 
use ieee.std_logic_1164.all; 
entity cpld_kiran is 
port(clk:instd_logic; 
rst:instd_logic; 
clk_1:inoutstd_logic:='1'; 
clk_2:inoutstd_logic:='0'; 
D_in: inoutstd_logic_vector(9 downto 0); 
R_out:inoutstd_logic_vector(9 downto 0); 
G: outstd_logic:='1'; 
G1: outstd_logic:='0'; 
error: inoutstd_logic_vector(0 downto 0)); 
end cpld_kiran; 
architecture behaviour of cpld_kiran is 
 --clock divider for 24Mhz clock pulse-- --clock 1 running on rising edge of clock--- 
begin 
process(clk) 
begin 
ifrising_edge (clk) then 
clk_1<=not(clk_1); 
endif; 
endprocess; ---clock 2 running on faling edge of clock ------- 
process(clk) 
begin 
iffalling_edge (clk) then 
clk_2<=not(clk_2); 
endif; 
endprocess; 
 -----random------ 
process(clk_1) 
begin 
ifrising_edge(clk_1) then 
if(rst='1') then 
D_in(0)<='1'; 
D_in(1)<='1'; 
D_in(2)<='1'; 
D_in(3)<='1'; 
D_in(4)<='1'; 
D_in(5)<='1'; 
D_in(6)<='1'; 
D_in(7)<='1'; 
D_in(8)<='1'; 
D_in(9)<='1'; 
else 
D_in(0)<=D_in(7) xorD_in(8) ; 
D_in(1)<=D_in(0); 
D_in(2)<=D_in(1); 
D_in(3)<=D_in(2); 
D_in(4)<=D_in(9) xorD_in(3); 
D_in(5)<=D_in(4); 
D_in(6)<=D_in(5); 
D_in(7)<=D_in(6); 
D_in(8)<=D_in(7); 
D_in(9)<=D_in(8); 
endif; 
endif; 
endprocess; 
 --comparison-- 
process(clk_2) 
begin 
 
iffalling_edge(clk_2) then 
ifR_out(0)=D_in(0) and 
R_out(3)=D_in(3) and 
R_out(6)=D_in(6) and 
R_out(9)=D_in(9) then 
 
error(0)<='0'; 
else 
error(0)<='1'; 
endif; 
endif; 
endprocess; 
end behaviour; 