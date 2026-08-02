libraryieee; 
use ieee.std_logic_1164.all; 
entity Kiran is 
port(osc_in:instd_logic; 
osc_out:inoutstd_logic; 
rst:instd_logic; 
D_in: inoutstd_logic_vector(9 downto 0); 
R_out:inoutstd_logic_vector(9 downto 0); 
output:inoutstd_logic; 
error: outstd_logic); 
end Kiran; 
 
architecture behaviour of Kiran is 
signal G:std_logic:='1'; 
signal G1:std_logic:='0'; 
signalx,y:std_logic; 
signal clk_24:std_logic; 
signal clk_12:std_logic:='0'; 
signalcount_x:integerrange 0 to 4; 
signal clk_6:std_logic:= '0'; 
signalcount_y:integerrange 0 to 4; 
signal clk_3:std_logic:='0'; 
signalcount_a:integerrange 0 to 4; --clock divider for 24Mhz clock pulse-- 
begin 
process(osc_in) 
begin 
osc_out<= not(osc_in); 
endprocess; 
process(osc_out) 
begin 
    clk_24<=osc_out; 
endprocess; 
 --clock divider for 12Mhz clock pulse-- 
process(osc_out) 
begin 
if(count_x=1) then 
count_x<=0; 
    clk_12<= not (clk_12); 
else 
count_x<=count_x+1; 
endif; 
endprocess; 
 --clock divider for 6Mhz clock pulse--- 
process(osc_out) 
begin 
if(osc_out ='1')then 
if (count_y= 1) then 
count_y<= 0; 
    clk_6<= not (clk_6); 
else 
count_y<= count_y+1; 
endif; 
endif; 
endprocess; 
 --clock divider for 3 Mhz clock pulse-- 
process(osc_out) 
begin 
if(osc_out='1')then 
if (count_a=3) then 
count_a<=0; 
    clk_3<=not (clk_3); 
else 
count_a<=count_a+1; 
endif; 
endif; 
endprocess; 
 --selection-- 
process(clk_24) 
begin 
if(x='0'and y='0') then 
    output<=clk_24; 
elsif(x='0'and y='1') then 
    output<=clk_12; 
elsif(x='1'and y='0')  then 
    output<=clk_6; 
else 
    output<=clk_3; 
endif; 
endprocess; 
 -----random------ 
process(output) 
begin 
if(output='1')then 
if(rst='1') then 
D_in(0)<='1'after 10 ps; 
D_in(1)<='1'after 10 ps; 
D_in(2)<='1'after 10 ps; 
D_in(3)<='1'after 10 ps; 
D_in(4)<='1'after 10 ps; 
D_in(5)<='1'after 10 ps; 
D_in(6)<='1'after 10 ps; 
D_in(7)<='1'after 10 ps; 
D_in(8)<='1'after 10 ps; 
D_in(9)<='1'after 10 ps; 
 
else 
D_in(0)<=D_in(7) xorD_in(8) after 10 ps; 
D_in(1)<=D_in(0)after 10 ps; 
D_in(2)<=D_in(1)after 10 ps; 
D_in(3)<=D_in(2)after 10 ps; 
D_in(4)<=D_in(9) xorD_in(3) after 10 ps; 
D_in(5)<=D_in(4)after 10 ps; 
D_in(6)<=D_in(5)after 10 ps; 
D_in(7)<=D_in(6)after 10 ps; 
D_in(8)<=D_in(7)after 10 ps; 
D_in(9)<=D_in(8)after 10 ps; 
endif; 
endif; 
endprocess; 
 --comparison-- 
process(output) 
begin 
ifrising_edge(output) then 
ifR_out(9 downto 0)=D_in(9 downto 0) then 
error<='0'; 
else 
error<='1';
endif; 
endif; 
endprocess; 
end behaviour;