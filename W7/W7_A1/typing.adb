with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;
with ada.numerics.discrete_random;

procedure typing is

   i : integer := 0;
   c : character;
   word : string(1..3);

   type randRange is new Integer range 1..26;

   package Rand_Int is new ada.numerics.discrete_random(randRange);

   use Rand_Int;

   gen : Generator;
   num : randRange;

begin

   loop

      i := i + 1;

      reset(gen);
      num := random(gen);
      
      if num = 1 then
         c := 'a';
      elsif num = 2 then
         c := 'b';
      elsif num = 3 then
         c := 'c';
      elsif num = 4 then
         c := 'd';
      elsif num = 5 then
         c := 'e';
      elsif num = 6 then
         c := 'f';
      elsif num = 7 then
         c := 'g';
      elsif num = 8 then
         c := 'h';
      elsif num = 9 then
         c := 'i';
      elsif num = 10 then
         c := 'j';
      elsif num = 11 then
         c := 'k';
      elsif num = 12 then
         c := 'l';
      elsif num = 13 then
         c := 'm';
      elsif num = 14 then
         c := 'n';
      elsif num = 15 then
         c := 'o';
      elsif num = 16 then
         c := 'p';
      elsif num = 17 then
         c := 'q';
      elsif num = 18 then
         c := 'r';
      elsif num = 19 then
         c := 's';
      elsif num = 20 then
         c := 't';
      elsif num = 21 then
         c := 'u';
      elsif num = 22 then
         c := 'v';
      elsif num = 23 then
         c := 'w';
      elsif num = 24 then
         c := 'x';
      elsif num = 25 then
         c := 'y';
      elsif num = 26 then
         c := 'z';
      end if;

      if i = 1 then
         word(1) := c;
      elsif i = 2 then
         word(2) := c;
      elsif i = 3 then
         word(3) := c;
      else
         word(1) := word(2);
         word(2) := word(3);
         word(3) := c;
      end if;

      if word = "vox" then
         exit;
      end if;

   end loop;

   put_line(word);
   put_line(Integer'Image(i));

end typing;