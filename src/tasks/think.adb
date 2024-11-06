with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with protectedobjects; use protectedobjects;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

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
         FLReading := Integer(Shared_Data.GetFLAvg);
         FRReading := Integer(Shared_Data.GetFRAvg);
         BReading := Integer(Shared_Data.GetBAvg);
         Put_Line("FLS: " & Integer'Image(FLReading));
         Put_Line("FRS: " & Integer'Image(FRReading));
         Put_Line("BS: " & Integer'Image(BReading));

                  -- State machine logic
         --  case Shared_Data.GetDir is
         --     when Stop =>
         --        --  Put_Line("test ");
         --        if FLReading > 100 and FRReading > 100 then
         --           Update_Direction(Forward);
         --  --        else
         --  --           --  Update_Direction(ServoReading);
         --  --            Put_Line("test ");
         --        end if;

         --    when Forward =>
         --        if FLReading < 100 and FRReading < 100 then
         --           Update_Direction(Stop);
         --        end if;
         --    when others =>
         --            Put_Line("others");
         --  end case;

         delay until aclock + Milliseconds(600);
      end loop;
   end thinktask;
end think;
