with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;

procedure convert is
   x : integer := 5;
   y : integer := 10000;
   z : integer := 5000;
   tmp : float := 0.0;

begin

   x := 171 * (x rem 177) - 2*(x/177);
   if x < 0 then
      x := x + 30269;
   end if;

   y := 172 * (y rem 176) - 35*(y/176);
   if y < 0 then
      y := y + 30307;
   end if;

   z := 170 * (z rem 178) - 63*(z/178);
   if z < 0 then
      z := z + 30323;
   end if;

   tmp := float(x)/30269.0 + float(y)/30307.0 + float(z)/30323.0;

   put(tmp - (Float'Ceiling(tmp)));

end convert;