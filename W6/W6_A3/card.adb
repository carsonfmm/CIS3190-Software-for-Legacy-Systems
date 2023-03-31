with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

procedure card is
   number : string(1..16);
   ret : integer := 0;

   function Sum_Of_Digits(N: Natural; Base: Natural := 10) return Natural is
      Sum: Natural := 0;
      Val: Natural := N;
   begin
      while Val > 0 loop
         Sum := Sum + (Val mod Base);
         Val := Val / Base;
      end loop;
      return Sum;
   end Sum_Of_Digits;

   procedure calc(number: in string; ret: out integer) is

   doubled1 : integer := 0;
   doubled2 : integer := 0;
   doubled3 : integer := 0;
   doubled4 : integer := 0;
   doubled5 : integer := 0;
   doubled6 : integer := 0;
   doubled7 : integer := 0;
   doubled8 : integer := 0;

   begin

      doubled1 := integer'value ((1 => number(number'first)));
      doubled1 := doubled1 * 2;
      doubled2 := integer'value ((1 => number(number'first+2)));
      doubled2 := doubled2 * 2;
      doubled3 := integer'value ((1 => number(number'first+4)));
      doubled3 := doubled3 * 2;
      doubled4 := integer'value ((1 => number(number'first+6)));
      doubled4 := doubled4 * 2;
      doubled5 := integer'value ((1 => number(number'first+8)));
      doubled5 := doubled5 * 2;
      doubled6 := integer'value ((1 => number(number'first+10)));
      doubled6 := doubled6 * 2;
      doubled7 := integer'value ((1 => number(number'first+12)));
      doubled7 := doubled7 * 2;
      doubled8 := integer'value ((1 => number(number'first+14)));
      doubled8 := doubled8 * 2;

      ret := Sum_Of_Digits(doubled1) + Sum_Of_Digits(doubled2) + Sum_Of_Digits(doubled3) + Sum_Of_Digits(doubled4) + Sum_Of_Digits(doubled5) + Sum_Of_Digits(doubled6) + Sum_Of_Digits(doubled7) + Sum_Of_Digits(doubled8);
      ret := ret + integer'value ((1 => number(number'first+1))) + integer'value ((1 => number(number'first+3))) + integer'value ((1 => number(number'first+5))) + integer'value ((1 => number(number'first+7))) + integer'value ((1 => number(number'first+9))) + integer'value ((1 => number(number'first+11))) + integer'value ((1 => number(number'first+13))) + integer'value ((1 => number(number'first+15)));

   end calc;

begin

   put("Please enter the card number: ");
   get(number);

   calc(number, ret);

   put("Total: " & integer'image(ret));

   if ret rem 10 = 0 then
      put_line("");
      put_line("Card valid");
   else
      put_line("");
      put_line("Card not valid");
   end if;

end card;