with Ada.Real_Time; use Ada.Real_Time;

package robotconstants is
   --LOWER number = LESS important = LOWER priority
   SensePriority : constant Integer := 1;
   ThinkPriority : constant Integer := 2;
   ActPriority : constant Integer := 3;

   SenseDeadline : constant Time_Span := Milliseconds(160);
   ThinkDeadline : constant Time_Span := Milliseconds(100);
   ActDeadline : constant Time_Span := Milliseconds(100);

   ObstacleDistanceTolerance : constant Integer := 20;
end robotconstants;
