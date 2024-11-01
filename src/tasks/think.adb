with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with protectedobjects; use protectedobjects;

package body think is
   task body thinktask is
      aclock : Time;
      FLReading : Integer;
      FRReading : Integer;
      BReading : Integer;

      -- Procedure to update the shared direction and log it
      procedure Update_Direction(D : Directions) is
      begin
         Shared_Data.SetDir(D);
         Put_Line("New Direction: " & Directions'Image(D));
      end Update_Direction;

   begin
      Put_Line("Started thinking task.");
      loop
         aclock := Clock;

         Put_Line("Started thinking task.");
         --  FLReading := Integer(Shared_Data.GetFLAvg);
         --  FRReading := Integer(Shared_Data.GetFRAvg);
         --  BReading := Integer(Shared_Data.GetBAvg);
         FLReading := 1;
         FRReading := 2;
         BReading := 3;

         Put_Line("FLS: " & Integer'Image(FLReading));
         Put_Line("FRS: " & Integer'Image(FRReading));
         Put_Line("BS: " & Integer'Image(BReading));

                  -- State machine logic
         case Shared_Data.GetDir is
            when Stop =>
               if FLReading > 100 and FRReading > 100 then
                  Update_Direction(Forward);
               elsif FLReading > 100 and FRReading < 50 then
                  Update_Direction(Forward_Left);
               elsif FLReading < 50 and FRReading > 100 then
                  Update_Direction(Forward);
               end if;

            when Forward =>
               if FLReading < 50 or FRReading < 50 then
                  Update_Direction(Stop);
               elsif BReading > 100 then
                  Update_Direction(Backward);
               end if;

            when Backward =>
               if BReading < 50 then
                  Update_Direction(Stop);
               elsif FLReading > 100 then
                  Update_Direction(Forward);
               end if;

            when Forward_Left =>
               if FLReading > 100 and FRReading > 100 then
                  Update_Direction(Forward);
               elsif FLReading < 50 then
                  Update_Direction(Stop);
               end if;

            when Turning =>
               Update_Direction(Stop);

            when others =>
               Update_Direction(Stop);
         end case;

         delay until aclock + Milliseconds(600);
      end loop;
   end thinktask;
end think;
