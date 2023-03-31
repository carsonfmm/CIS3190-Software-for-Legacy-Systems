with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

procedure velocity is
   mass, radius, velocity, numerator : float;

begin

   put("Please enter the mass: ");
   get(mass);

   put("Please enter the radius: ");
   get(radius);

   numerator := sqrt(2.0 * (6.673*10.0**(-11)) * mass);
   velocity := numerator / radius;

   put (velocity);

end velocity;