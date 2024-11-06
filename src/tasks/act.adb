with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with Microbit.Types; use Microbit.Types;
with protectedobjects; use protectedobjects;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body act is
   task body acttask is
      timer : Time;
      cpu_time : Time_Span;
      -- Procedure to update the shared direction and log it

   begin
      Put_Line("Started acting task.");
      loop
         timer := Clock;

         case Brain.GetState is
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
         cpu_time := Clock - timer;
         Brain.SetActTime(cpu_time);
         delay until timer + Seconds(1);
      end loop;
   end acttask;
end act;
