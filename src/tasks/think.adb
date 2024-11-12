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
            when Fwd =>
               if AvgFrontReading < 35 then
                  Brain.SetMoveUntil(Clock + Milliseconds(1500));
                  Brain.SetServoState(ReadRight);
                  Brain.SetRobotState(Servoreading);
               end if;
            when Servoreading =>
               case Brain.GetServoState is
                  when ReadRight =>
                     if Clock > Brain.GetMoveUntil then
                        Brain.SetMoveUntil(Clock + Milliseconds(1500));
                        Sensors(1) := Integer(Brain.GetBAvg);
                        Brain.SetServoState(ReadBack);
                     end if;
                  when ReadBack =>
                     if Clock > Brain.GetMoveUntil then
                        Brain.SetMoveUntil(Clock + Milliseconds(1500));
                        Sensors(2) := Integer(Brain.GetBAvg);
                        Brain.SetServoState(ReadLeft);
                     end if;
                  when ReadLeft =>
                     if Clock > Brain.GetMoveUntil then
                        Brain.SetMoveUntil(Clock + Milliseconds(1500));
                        Sensors(3) := Integer(Brain.GetBAvg);
                        Brain.SetServoState(ReadRight);
                        Max_Reading := 0;
                        for I in Sensors'Range loop
                           if Sensors(I) > Max_Reading then
                              Max_Reading := Sensors(I);
                              Max_Reading_Sensor := I;
                           end if;
                        end loop;
                        case Max_Reading_Sensor is
                           when 1 =>
                              Brain.SetMoveUntil(Clock + Milliseconds(Deg_90));
                              Brain.SetRobotState(Rotate_R);
                           when 2 =>
                              Brain.SetMoveUntil(Clock + Milliseconds(Deg_90 * 2));
                              Brain.SetRobotState(Rotate_180);
                           when 3 =>
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

         cpu_time := Clock - timer;
         Brain.SetThinkTime(cpu_time);
         delay until timer + robotconstants.ThinkDeadline;
      end loop;
   end thinktask;
end think;
