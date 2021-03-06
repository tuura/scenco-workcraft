LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY intel_controller IS 
   PORT(
      -- inputs
      GO : IN  STD_LOGIC;
      CODE : IN  STD_LOGIC_VECTOR(3 downto 0);
      ACK_pciu :  IN  STD_LOGIC;
      ACK_ifu :  IN  STD_LOGIC;
      ACK_alu :  IN  STD_LOGIC;
      ACK_alu2 :  IN  STD_LOGIC;
      ACK_alu3 :  IN  STD_LOGIC;
      ACK_alu4 :  IN  STD_LOGIC;
      ACK_alu5 :  IN  STD_LOGIC;
      ACK_mau :  IN  STD_LOGIC;
      ACK_mau2 :  IN  STD_LOGIC;
      ACK_mau3 :  IN  STD_LOGIC;
      ACK_mau4 :  IN  STD_LOGIC;
      ACK_mau5 :  IN  STD_LOGIC;
      ACK_pciu2 :  IN  STD_LOGIC;
      ACK_ifu2 :  IN  STD_LOGIC;
      ACK_pciu3 :  IN  STD_LOGIC;
      ACK_ifu3 :  IN  STD_LOGIC;
      ACK_sidu :  IN  STD_LOGIC;
      CLK :  IN  STD_LOGIC;
      RST :  IN  STD_LOGIC;

      -- outputs
      FINE : OUT  STD_LOGIC;
      REQ_pciu : OUT  STD_LOGIC;
      REQ_ifu : OUT  STD_LOGIC;
      REQ_alu : OUT  STD_LOGIC;
      REQ_alu2 : OUT  STD_LOGIC;
      REQ_alu3 : OUT  STD_LOGIC;
      REQ_alu4 : OUT  STD_LOGIC;
      REQ_alu5 : OUT  STD_LOGIC;
      REQ_mau : OUT  STD_LOGIC;
      REQ_mau2 : OUT  STD_LOGIC;
      REQ_mau3 : OUT  STD_LOGIC;
      REQ_mau4 : OUT  STD_LOGIC;
      REQ_mau5 : OUT  STD_LOGIC;
      REQ_pciu2 : OUT  STD_LOGIC;
      REQ_ifu3 : OUT  STD_LOGIC;
      REQ_pciu3 : OUT  STD_LOGIC;
      REQ_sidu :  OUT  STD_LOGIC;
      REQ_ifu2 : OUT  STD_LOGIC);
END intel_controller;

ARCHITECTURE behavioural OF intel_controller IS 

type state is (start,
		s1_1, s1_2, s1_3, s1_4,
		s2_1, s2_2, s2_3, s2_4, s2_5, s2_6,
		s3_1, s3_2, s3_3, s3_4,
		s4_1, s4_2,
--		s5_1, s5_2, s5_3, s5_4, s5_5, s5_6, 
--		s6_1, s6_2, s6_3,
--		s7_1, s7_2, s7_3,
		s8_1, s8_2, s8_3, s8_4,
--		s9_1, s9_2,
		s10_1, s10_2, s10_3, s10_4, s10_5, s10_6,
		s11_1, s11_2, s11_3, s11_4, s11_5, s11_6, s11_7, s11_8, -- D
		s12_1, s12_2, s12_3, s12_4, s12_5, s12_6, -- F
		s13_1, s13_2, s13_3, s13_4, s13_5, s13_6, s13_7, s13_8, -- G
		s14_1, s14_2, s14_3, s14_4, s14_5, s14_6, -- J
		s15_1, s15_2, s15_3, s15_4, s15_5, s15_6, -- K
		s16_1, s16_2, s16_3, s16_4, s16_5, s16_6, -- L
		s17_1, s17_2, s17_3, s17_4, -- M
		s18_1, s18_2, s18_3, s18_4, s18_5, s18_6, s18_7, s18_8, -- N
		s19_1, s19_2, s19_3, s19_4, s19_5, s19_6, s19_7, s19_8, s19_9, s19_10, -- O
		done, done2);
signal cs, nx: state;

begin

process (CLK,RST)
begin
   if (RST='1') then      cs <= start;
   elsif (CLK'event and CLK='1') then
      cs <= nx;
   end if;
end process;

process (cs, ACK_pciu, ACK_ifu, ACK_alu, ACK_alu2, ACK_alu3, ACK_alu4, ACK_alu5,
	 ACK_mau, ACK_mau2, ACK_mau3, ACK_mau4, ACK_mau5, ACK_pciu2, ACK_ifu2,
	 ACK_pciu3, ACK_ifu3, ACK_sidu, go, code)
begin
	case cs is
		when start =>
			FINE <= '0';
			REQ_pciu <= '0';
			REQ_pciu2 <= '0';
			REQ_pciu3 <= '0';
			REQ_ifu <= '0';
			REQ_ifu2 <= '0';
			REQ_ifu3 <= '0';
			REQ_alu <= '0';
			REQ_alu2 <= '0';
			REQ_alu3 <= '0';
			REQ_alu4 <= '0';
			REQ_alu5 <= '0';
			REQ_mau <= '0';
			REQ_mau2 <= '0';
			REQ_mau3 <= '0';
			REQ_mau4 <= '0';
			REQ_mau5 <= '0';
			REQ_sidu <= '0';
			if (go = '1') then
				case code is
					when "0000" =>
						nx <= s1_1;
					when "0001" =>
						nx <= s2_1;
					when "0010" =>
						nx <= s3_1;
					when "0011" =>
						nx <= s11_1; --D
					when "0100" =>
						nx <= s8_1; -- E
					when "0101" =>
						nx <= s12_1;
					when "0110" =>
						nx <= s13_1;
					when "0111" =>
						nx <= s4_1; -- H
					when "1000" =>
						nx <= s10_1;  
					when "1001" =>
						nx <= s14_1; -- J
					when "1010" =>
						nx <= s15_1; -- K
					when "1011" =>
						nx <= s16_1;
					when "1100" =>
						nx <= s17_1;
					when "1101" =>
						nx <= s18_1;
					when "1110" =>
						nx <= s19_1;
					when others =>
						nx <= start;
				end case;
			end if;

		-- CLASS A
		when s1_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s1_2;
			end if;
		when s1_2 =>
			REQ_mau <= '1';
			if (ACK_mau = '1') then
				nx <= s1_3;
			end if;
		when s1_3 =>
			REQ_ifu <= '1';
			REQ_alu2 <= '1';
			if (ACK_ifu = '1' and ACK_alu2 = '1') then
				nx <= s1_4;
			end if;
		when s1_4 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= done;
			end if;

		-- CLASS B
		when s2_1 =>
			REQ_pciu <= '1';
			if (ACK_pciu = '1') then
				nx <= s2_2;
			end if;
		when s2_2 =>
			REQ_ifu <= '1';
			if (ACK_ifu = '1') then
				nx <= s2_3;
			end if;
		when s2_3 =>
			REQ_alu <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu = '1' and ACK_pciu2 = '1') then
				nx <= s2_4;
			end if;
		when s2_4 =>
			REQ_ifu2 <= '1';
			REQ_mau <= '1';
			if (ACK_ifu2 = '1' and ACK_mau = '1') then
				nx <= s2_5;
			end if;
		when s2_5 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s2_6;
			end if;
		when s2_6 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= done;
			end if;

		-- CLASS C
		when s3_1 =>
			REQ_pciu <= '1';
			if (ACK_pciu = '1') then
				nx <= s3_2;
			end if;
		when s3_2 =>
			REQ_ifu <= '1';
			if (ACK_ifu = '1') then
				nx <= s3_3;
			end if;
		when s3_3 =>
			REQ_alu <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu = '1' and ACK_pciu2 = '1') then
				nx <= s3_4;
			end if;
		when s3_4 =>
			REQ_ifu2 <= '1';
			REQ_mau <= '1';
			if (ACK_ifu2 = '1' and ACK_mau = '1') then
				nx <= done;
			end if;

		-- CLASS D
		when s11_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s11_2;
			end if;
		when s11_2 =>
			REQ_mau <= '1';
			if (ACK_mau = '1') then
				nx <= s11_3;
			end if;
		when s11_3 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s11_4;
			end if;
		when s11_4 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= s11_5;
			end if;
		when s11_5 =>
			REQ_alu3 <= '1';
			if (ACK_alu3 = '1') then
				nx <= s11_6;
			end if;
		when s11_6 =>
			REQ_mau3 <= '1';
			REQ_ifu <= '1';
			if (ACK_mau3 = '1' and ACK_ifu = '1') then
				nx <= s11_7;
			end if;
		when s11_7 =>
			REQ_alu4 <= '1';
			if (ACK_alu4 = '1') then
				nx <= s11_8;
			end if;
		when s11_8 =>
			REQ_mau4 <= '1';
			if (ACK_mau4 = '1') then
				nx <= done;
			end if;

		-- CLASS G
		when s13_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s13_2;
			end if;
		when s13_2 =>
			REQ_mau <= '1';
			if (ACK_mau = '1') then
				nx <= s13_3;
			end if;
		when s13_3 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s13_4;
			end if;
		when s13_4 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= s13_5;
			end if;
		when s13_5 =>
			REQ_alu3 <= '1';
			if (ACK_alu3 = '1') then
				nx <= s13_6;
			end if;
		when s13_6 =>
			REQ_mau3 <= '1';
			if (ACK_mau3 = '1') then
				nx <= s13_7;
			end if;
		when s13_7 =>
			REQ_alu4 <= '1';
			if (ACK_alu4 = '1') then
				nx <= s13_8;
			end if;
		when s13_8 =>
			REQ_mau4 <= '1';
			REQ_ifu <= '1';
			if (ACK_mau4 = '1' and ACK_ifu = '1') then
				nx <= done;
			end if;

		-- CLASS H
		when s4_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' AND ACK_alu = '1') then
				nx <= s4_2;
			end if;
		when s4_2 =>
			REQ_ifu <= '1';
			if (ACK_ifu = '1') then
				nx <= done;
			end if;

		-- CLASS Q
--		when s5_1 =>
--			REQ_pciu <= '1';
--			if (ACK_pciu = '1') then
--				nx <= s5_2;
--			end if;
--		when s5_2 =>
--			REQ_ifu <= '1';
--			if (ACK_ifu = '1') then
--				nx <= s5_3;
--			end if;
--		when s5_3 =>
--			REQ_alu <= '1';
--			REQ_pciu2 <= '1';
--			if (ACK_alu = '1' and ACK_pciu2 = '1') then
--				nx <= s5_4;
--			end if;
--		when s5_4 =>
--			REQ_ifu2 <= '1';
--			REQ_mau <= '1';
--			if (ACK_ifu2 = '1' and ACK_mau = '1') then
--				nx <= s5_5;
--			end if;
--		when s5_5 =>
--			REQ_alu2 <= '1';
--			if (ACK_alu2 = '1') then
--				nx <= done;
--			end if;

		-- CLASS R
--		when s6_1 =>
--			REQ_pciu <= '1';
--			REQ_sidu <= '1';
--			if (ACK_pciu = '1' and ACK_sidu = '1') then
--				nx <= s6_2;
--			end if;
--		when s6_2 =>
--			REQ_ifu <= '1';
--			REQ_alu <= '1';
--			if (ACK_ifu = '1' and ACK_alu = '1') then
--				nx <= s6_3;
--			end if;
--		when s6_3 =>
--			REQ_mau <= '1';
--			if (ACK_mau = '1') then
--				nx <= done;
--			end if;

		-- CLASS S
--		when s7_1 =>
--			REQ_pciu <= '1';
--			REQ_alu <= '1';
--			if (ACK_pciu = '1' and ACK_alu = '1') then
--				nx <= s7_2;
--			end if;
--		when s7_2 =>
--			REQ_ifu <= '1';
--			REQ_mau <= '1';
--			if (ACK_ifu = '1' and ACK_mau = '1') then
--				nx <= s7_3;
--			end if;
--		when s7_3 =>
--			REQ_sidu <= '1';
--			REQ_alu2 <= '1';
--			if (ACK_sidu = '1' and ACK_alu2 = '1') then
--				nx <= done;
--			end if;

		-- CLASS E
		when s8_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s8_2;
			end if;
		when s8_2 =>
			REQ_mau <= '1';
			REQ_ifu <= '1';
			if (ACK_mau = '1' and ACK_ifu = '1') then
				nx <= s8_3;
			end if;
		when s8_3 =>
			REQ_pciu2 <= '1';
			REQ_alu2 <= '1';
			if (ACK_pciu2 = '1' and ACK_alu2 = '1') then
				nx <= s8_4;
			end if;
		when s8_4 =>
			REQ_ifu2 <= '1';
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1' and ACK_ifu2 = '1') then
				nx <= done;
			end if;

		-- CLASS F
		when s12_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s12_2;
			end if;
		when s12_2 =>
			REQ_ifu <= '1';
			REQ_mau <= '1';
			if (ACK_ifu = '1' and ACK_mau = '1') then
				nx <= s12_3;
			end if;
		when s12_3 =>
			REQ_alu2 <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu2 = '1' and ACK_pciu2 = '1') then
				nx <= s12_4;
			end if;
		when s12_4 =>
			REQ_ifu2 <= '1';
			REQ_mau2 <= '1';
			if (ACK_ifu2 = '1' and ACK_mau2 = '1') then
				nx <= s12_5;
			end if;
		when s12_5 =>
			REQ_alu3 <= '1';
			if (ACK_alu3 = '1') then
				nx <= s2_6;
			end if;
		when s12_6 =>
			REQ_mau3 <= '1';
			if (ACK_mau3 = '1') then
				nx <= done;
			end if;

		-- CLASS J
		when s14_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s14_2;
			end if;
		when s14_2 =>
			REQ_ifu <= '1';
			REQ_mau <= '1';
			if (ACK_ifu = '1' and ACK_mau = '1') then
				nx <= s14_3;
			end if;
		when s14_3 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s14_4;
			end if;
		when s14_4 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= s14_5;
			end if;
		when s14_5 =>
			REQ_alu3 <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu3 = '1' and ACK_pciu2 = '1') then
				nx <= s14_6;
			end if;
		when s14_6 =>
			REQ_mau3 <= '1';
			REQ_ifu2 <= '1';
			if (ACK_mau3 = '1' and ACK_ifu2 = '1') then
				nx <= done;
			end if;

		-- CLASS U
--		when s9_1 =>
--			REQ_pciu <= '1';
--			if (ACK_pciu = '1') then
--				nx <= s9_2;
--			end if;
--		when s9_2 =>
--			REQ_ifu <= '1';
--			if (ACK_ifu = '1') then
--				nx <= done;
--			end if;

		-- CLASS I
		when s10_1 =>
			REQ_pciu <= '1';
			if (ACK_pciu = '1') then
				nx <= s10_2;
			end if;
		when s10_2 =>
			REQ_ifu <= '1';
			if (ACK_ifu = '1') then
				nx <= s10_3;
			end if;
		when s10_3 =>
			REQ_alu <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu = '1' and ACK_pciu2 = '1') then
				nx <= s10_4;
			end if;
		when s10_4 =>
			REQ_ifu2 <= '1';
			REQ_mau <= '1';
			if (ACK_ifu2 = '1' and ACK_mau = '1') then
				nx <= s10_5;
			end if;
		when s10_5 =>
			REQ_alu2 <= '1';
			REQ_pciu3 <= '1';
			if (ACK_alu2 = '1' and ACK_pciu3 = '1') then
				nx <= s10_6;
			end if;
		when s10_6 =>
			REQ_mau2 <= '1';
			REQ_ifu3 <= '1';
			if (ACK_mau2 = '1' and ACK_ifu3 = '1') then
				nx <= done;
			end if;

		-- CLASS K
		when s15_1 =>
			REQ_pciu <= '1';
			if (ACK_pciu = '1') then
				nx <= s15_2;
			end if;
		when s15_2 =>
			REQ_ifu <= '1';
			if (ACK_ifu = '1') then
				nx <= s15_3;
			end if;
		when s15_3 =>
			REQ_alu <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu = '1' and ACK_pciu2 = '1') then
				nx <= s15_4;
			end if;
		when s15_4 =>
			REQ_ifu2 <= '1';
			if (ACK_ifu2 = '1') then
				nx <= s15_5;
			end if;
		when s15_5 =>
			REQ_alu2 <= '1';
			REQ_pciu3 <= '1';
			if (ACK_alu2 = '1' and ACK_pciu3 = '1') then
				nx <= s15_6;
			end if;
		when s15_6 =>
			REQ_mau <= '1';
			REQ_ifu3 <= '1';
			if (ACK_mau = '1' and ACK_ifu3 = '1') then
				nx <= done;
			end if;

		-- CLASS L
		when s16_1 =>
			REQ_pciu <= '1';
			if (ACK_pciu = '1') then
				nx <= s16_2;
			end if;
		when s16_2 =>
			REQ_ifu <= '1';
			if (ACK_ifu = '1') then
				nx <= s16_3;
			end if;
		when s16_3 =>
			REQ_alu <= '1';
			REQ_pciu2 <= '1';
			if (ACK_alu = '1' and ACK_pciu2 = '1') then
				nx <= s16_4;
			end if;
		when s16_4 =>
			REQ_ifu2 <= '1';
			REQ_mau <= '1';
			REQ_sidu <= '1';
			if (ACK_ifu2 = '1' and ACK_mau = '1' and ACK_sidu = '1') then
				nx <= s16_5;
			end if;
		when s16_5 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s16_6;
			end if;
		when s16_6 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= done;
			end if;

		-- CLASS M
		when s17_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s17_2;
			end if;
		when s17_2 =>
			REQ_ifu <= '1';
			REQ_mau <= '1';
			if (ACK_ifu = '1' and ACK_mau = '1') then
				nx <= s17_3;
			end if;
		when s17_3 =>
			REQ_alu2 <= '1';
			REQ_pciu2 <= '1';
			REQ_sidu <= '1';
			if (ACK_alu2 = '1' and ACK_pciu2 = '1' and ACK_sidu = '1') then
				nx <= s17_4;
			end if;
		when s17_4 =>
			REQ_ifu2 <= '1';
			REQ_mau2 <= '1';
			if (ACK_ifu2 = '1' and ACK_mau2 = '1') then
				nx <= done;
			end if;

		-- CLASS N
		when s18_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s18_2;
			end if;
		when s18_2 =>
			REQ_mau <= '1';
			REQ_ifu <= '1';
			if (ACK_mau = '1' and ACK_ifu = '1') then
				nx <= s18_3;
			end if;
		when s18_3 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s18_4;
			end if;
		when s18_4 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= s18_5;
			end if;
		when s18_5 =>
			REQ_alu3 <= '1';
			if (ACK_alu3 = '1') then
				nx <= s18_6;
			end if;
		when s18_6 =>
			REQ_mau3 <= '1';
			if (ACK_mau3 = '1') then
				nx <= s18_7;
			end if;
		when s18_7 =>
			REQ_alu4 <= '1';
			if (ACK_alu4 = '1') then
				nx <= s18_8;
			end if;
		when s18_8 =>
			REQ_mau4 <= '1';
			if (ACK_mau4 = '1') then
				nx <= done;
			end if;

		-- CLASS O
		when s19_1 =>
			REQ_pciu <= '1';
			REQ_alu <= '1';
			if (ACK_pciu = '1' and ACK_alu = '1') then
				nx <= s19_2;
			end if;
		when s19_2 =>
			REQ_mau <= '1';
			REQ_ifu <= '1';
			if (ACK_mau = '1' and ACK_ifu = '1') then
				nx <= s19_3;
			end if;
		when s19_3 =>
			REQ_alu2 <= '1';
			if (ACK_alu2 = '1') then
				nx <= s19_4;
			end if;
		when s19_4 =>
			REQ_mau2 <= '1';
			if (ACK_mau2 = '1') then
				nx <= s19_5;
			end if;
		when s19_5 =>
			REQ_alu3 <= '1';
			if (ACK_alu3 = '1') then
				nx <= s19_6;
			end if;
		when s19_6 =>
			REQ_mau3 <= '1';
			if (ACK_mau3 = '1') then
				nx <= s19_7;
			end if;
		when s19_7 =>
			REQ_alu4 <= '1';
			if (ACK_alu4 = '1') then
				nx <= s19_8;
			end if;
		when s19_8 =>
			REQ_mau4 <= '1';
			if (ACK_mau4 = '1') then
				nx <= s19_9;
			end if;
		when s19_9 =>
			REQ_alu5 <= '1';
			if (ACK_alu5 = '1') then
				nx <= s19_10;
			end if;
		when s19_10 =>
			REQ_mau5 <= '1';
			if (ACK_mau5 = '1') then
				nx <= done;
			end if;

		when done =>
			FINE <= '1';
			if (go = '0') then
				nx <= done2;
			end if;

		when done2 =>
			REQ_pciu <= '0';
			REQ_ifu <= '0';
			REQ_alu <= '0';
			REQ_alu2 <= '0';
			REQ_alu3 <= '0';
			REQ_alu4 <= '0';
			REQ_alu5 <= '0';
			REQ_mau <= '0';
			REQ_mau2 <= '0';
			REQ_mau3 <= '0';
			REQ_mau4 <= '0';
			REQ_mau5 <= '0';
			REQ_pciu2 <= '0';
			REQ_pciu3 <= '0';
			REQ_ifu2 <= '0';
			REQ_ifu3 <= '0';
			REQ_sidu <= '0';
			if (ACK_pciu = '0' and
			    ACK_ifu = '0' and
			    ACK_alu = '0' and
			    ACK_alu2 = '0' and
			    ACK_alu3 = '0' and
			    ACK_alu4 = '0' and
			    ACK_alu5 = '0' and
			    ACK_mau = '0' and
			    ACK_mau2 = '0' and
			    ACK_mau3 = '0' and
			    ACK_mau4 = '0' and
			    ACK_mau5 = '0' and
			    ACK_pciu2 = '0' and
			    ACK_pciu3 = '0' and
			    ACK_ifu3 = '0' and
			    ACK_sidu = '0' and
			    ACK_ifu2 = '0') then
				nx <= start;
			end if;

end case;
end process;

END behavioural;
