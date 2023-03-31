with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

procedure estimate is
   g, thickness, thermal : float;
   input : integer;

begin

   put_line("Please enter a number representing a Freezing Index mass: ");
   put_line("1: Montreal - 1030");
   put_line("2: Quebec - 1413");
   put_line("3: Sherbrooke - 1016");
   put_line("4: Gaspe - 1356");
   get(input);

   put("Please enter a number representing the thermal characteristic value: ");
   get(thermal);

   if input = 1 then
      g := 1030.0;
   elsif input = 2 then
      g := 1413.0;
   elsif input = 3 then
      g := 1016.0;
   else
      g := 1356.0;
   end if;

   thickness := 3.6 * thermal * (sqrt(g));

   put("The Estimated Ice Thickness is: ");
   put(thickness);

end estimate;