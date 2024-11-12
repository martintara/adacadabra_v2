package body Ringbuffer is
   procedure Initialize(RB : out Ringbuffer) is
   begin --set buffer values to inital state
      RB.Head := 0;
      RB.Count := 0;
      for I in Buffer_Array'Range loop
         RB.Buffer(I) := Distance_cm(0.0);
      end loop;
   end Initialize;

   procedure Add_Reading(RB : in out Ringbuffer; R : Distance_cm; E : Boolean) is
   begin
      if Integer(R) < 2 then --bad value, don't add to buffer

         if E then --if exception mode
            raise Bad_Reading; --raise an exception
         else --otherwise
            return; --just return
         end if;
      end if;
      RB.Buffer(RB.Head) := R; --add reading to head of ringbuffer
      RB.Head := (RB.Head + 1) mod Max_Size; --increment head (or reset if it exceeds the buffer size)
      if RB.Count < Max_Size then --if the buffer hasnt filled up yet
         RB.Count := RB.Count + 1; --keep track of how many indexes are actually used
      end if;
   end Add_Reading;

   function Average(RB : Ringbuffer) return Float is
      Total : Float := 0.0;
   begin
      for I in 0 .. (RB.Count - 1) loop
         Total := Total + Float(RB.Buffer((RB.Head + I) mod Max_Size)); --sum array values
      end loop;
      return Total / Float(RB.Count); --return sum divided by number of values (average)
   end Average;
end Ringbuffer;
