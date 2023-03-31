with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

procedure parcel is
   height : float := 0.0;
   length : float := 0.0;
   width : float := 0.0;
   ret : float := 0.0;

   procedure girth(height, length, width: in float; ret: out float) is

      largest : float := 0.0;

   begin

      largest := height;

      if length > largest then
         largest := length;
      end if;

      if width > largest then
         largest := width;
      end if;

      ret := 2.0 * (height+length+width - largest);

   end girth;

begin

   put("Please enter the height: ");
   get(height);

   put("Please enter the length: ");
   get(length);

   put("Please enter the width: ");
   get(width);

   girth(height, length, width, ret);

   put(ret, 5);

   if ret+length > 72.0 then
      put("Package too large");
   else 
      put("Package valid size");
   end if;

end parcel;