with Ada.Real_Time; use Ada.Real_Time;

package robotconstants is
   SensePriority : constant Integer := 1;
   ThinkPriority : constant Integer := 2;
   ActPriority : constant Integer := 3;

   SenseDeadline : Time_Span := Milliseconds(160);
   ThinkDeadline : Time_Span := Milliseconds(100);
   ActDeadline : Time_Span := Milliseconds(100);
end robotconstants;
