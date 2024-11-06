with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with Microbit.Types; use Microbit.Types;

package body act is
   task body acttask is
      aclock : Time;
   begin
      Put_Line("Started acting task.");
      loop
         aclock := Clock;

      Put_Line("acting.");
         delay until aclock + Seconds(2);
      end loop;
   end acttask;
end act;
