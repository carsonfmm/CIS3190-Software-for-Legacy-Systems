with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

procedure udf is
   time : float := 0.0;
   vel : float := 0.0;
   acc : float := 0.0;

   procedure velocity(time: in float; vel: out float) is
   begin

      vel := 0.00001 * (time*time*time) - 0.00488 * sqrt(time) + 0.75795 * time + 181.3566;

   end velocity;

   procedure acceleration(vel: in float; acc: out float) is
   begin

      acc := 3.0 - sqrt(0.000062 * vel);

   end acceleration;

begin

   put("Please enter the time in seconds: ");
   get(time);

   velocity(time, vel);
   acceleration(vel, acc);

   put(vel, 5);
   put(acc, 5);

end udf;