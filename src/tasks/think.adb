with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with protectedobjects; use protectedobjects;
with robotconstants;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body think is
   task body thinktask is
      timer : Time;
      cpu_time : Time_Span;
      AvgFrontReading : Integer := 0;
      type Sensor_Array is array (1 .. 3) of Integer;
      Sensors : Sensor_Array := (0, 0, 0);
      Max_Reading : Integer := 0;
      Max_Reading_Sensor : Integer := 0;
      Deg_90 : constant Integer := 800; --should be approx 90 degrees if turning for this many milliseconds

   begin
      Put_Line("Started thinking task.");
      loop
         timer := Clock;
         AvgFrontReading := (Integer(Brain.GetFLAvg) + Integer(Brain.GetFRAvg)) / 2;

         -- State machine logic
         case Brain.GetRobotState is
            when Fwd => --normal mode, just drive forward
               if AvgFrontReading < robotconstants.ObstacleDistanceTolerance then --if there is an obstacle within the limit
                  Brain.SetMoveUntil(Clock + Milliseconds(1500)); --prepare to stop moving in 1.5 seconds
                  Brain.SetServoState(ReadRight); --look to the right
                  Brain.SetRobotState(Servoreading); --switch to the servo reading state
               end if;
            when Rotate_L | Rotate_R | Rotate_180 =>
               if Clock > Brain.GetMoveUntil then --if the robot has rotated long enough
                  Brain.SetRobotState(Fwd); --go back to moving forward
               end if;
            when Servoreading => --read from the rear sensor on a servo
               case Brain.GetServoState is
                  when ReadRight =>
                     if Clock > Brain.GetMoveUntil then --if 1.5 seconds have passed
                        Brain.SetMoveUntil(Clock + Milliseconds(1500)); --prepare to wait another 1.5 seconds
                        Sensors(1) := Integer(Brain.GetBAvg); --store rear sensor avg value in first index of array
                        Brain.SetServoState(ReadBack); --switch to reading from the rear
                     end if;
                  when ReadBack =>
                     if Clock > Brain.GetMoveUntil then --if 1.5 seconds have passed
                        Brain.SetMoveUntil(Clock + Milliseconds(1500)); --prepare to wait yet another 1.5 seconds
                        Sensors(2) := Integer(Brain.GetBAvg); --store rear sensor avg value in second index of array
                        Brain.SetServoState(ReadLeft); --switch to reading from the left side
                     end if;
                  when ReadLeft =>
                     if Clock > Brain.GetMoveUntil then --more of the same
                        Brain.SetMoveUntil(Clock + Milliseconds(1500));
                        Sensors(3) := Integer(Brain.GetBAvg);
                        Brain.SetServoState(ReadRight);
                        Max_Reading := 0; --value for finding the direction with the highest distance between the robot and an obstacle
                        for I in Sensors'Range loop --loop through the array of sensor readings to find the max dist
                           if Sensors(I) > Max_Reading then --is the current reading greater?
                              Max_Reading := Sensors(I); --update max reading value
                              Max_Reading_Sensor := I; --also keep track of which sensor was used
                           end if;
                        end loop;
                        case Max_Reading_Sensor is --decide which sensor had the longest distance reading
                           when 1 => --if right side
                              Brain.SetMoveUntil(Clock + Milliseconds(Deg_90)); --turning around for this long should be approx 90 degrees
                              Brain.SetRobotState(Rotate_R); --set movement state to rotate right
                           when 2 => --if back side
                              Brain.SetMoveUntil(Clock + Milliseconds(Deg_90 * 2)); --multiply by 2 to get 180 degrees
                              Brain.SetRobotState(Rotate_180);
                           when 3 => --if left side
                              Brain.SetMoveUntil(Clock + Milliseconds(Deg_90));
                              Brain.SetRobotState(Rotate_L);
                           when others =>
                              null;
                        end case;
                     end if;
               end case;
            when others =>
               null;
         end case;

         cpu_time := Clock - timer; --get the execution time for this task
         Brain.SetThinkTime(cpu_time); --store it in the protected object
         delay until timer + robotconstants.ThinkDeadline;
      end loop;
   end thinktask;
end think;
