with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with Microbit.Types; use Microbit.Types;
with protectedobjects; use protectedobjects;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body act is
   task body acttask is
      aclock : Time;
      -- Procedure to update the shared direction and log it

   begin
      Put_Line("Started acting task.");
      loop
         aclock := Clock;

         case Shared_Data.GetState is
            when Stop =>
               Put_Line("Stop");
         --        else
         --           --  Update_Direction(ServoReading);
         --            Put_Line("test ");

            when Forward =>
               Put_Line("Forward");

            --  when Servoreading =>
            --     Put_Line("Servoreading");
            --     delay(1.0);
            --     Update_Direction(Forward);
            when others =>
                   Put_Line("others");
         end case;




         delay until aclock + Seconds(1);
      end loop;
   end acttask;
end act;
