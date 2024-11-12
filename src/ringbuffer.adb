package body Ringbuffer is
   procedure Initialize(RB : out Ringbuffer) is
   begin
      RB.Head := 0;
      RB.Count := 0;
      for I in Buffer_Array'Range loop
         RB.Buffer(I) := Distance_cm(0.0);
      end loop;
   end Initialize;

   procedure Add_Reading(RB : in out Ringbuffer; R : Distance_cm; E : Boolean) is
   begin
      if Integer(R) < 2 then --bad value, don't add to buffer
         if E then --throw exception if bad value?
            raise Bad_Reading;
         else
            return;
         end if;
      end if;
      RB.Buffer(RB.Head) := R;
      RB.Head := (RB.Head + 1) mod Max_Size;
      if RB.Count < Max_Size then
         RB.Count := RB.Count + 1;
      end if;
   end Add_Reading;

   function Average(RB : Ringbuffer) return Float is
      Total : Float := 0.0;
   begin
      for I in 0 .. (RB.Count - 1) loop
         Total := Total + Float(RB.Buffer((RB.Head + 1) mod Max_Size));
      end loop;
      return Total / Float(RB.Count);
   end Average;
end Ringbuffer;
