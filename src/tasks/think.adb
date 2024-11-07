with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with protectedobjects; use protectedobjects;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body think is
   task body thinktask is
      timer : Time;
      cpu_time : Time_Span;
      FLReading : Integer;
      FRReading : Integer;
      type Sensor_Array is array (1 .. 3) of Integer;
      Sensors : Sensor_Array := (0, 0, 0);
      Max_Reading : Integer := 0;
      Max_Reading_Sensor : Integer := 0;

      -- Procedure to update the shared direction and log it
      procedure Update_State(S : RobotState) is
      begin
         Brain.SetRobotState(S);
         --Put_Line("think: changed state to: " & RobotState'Image(S));
      end Update_State;

   begin
      Put_Line("Started thinking task.");
      loop
         timer := Clock;
         FLReading := Integer(Brain.GetFLAvg);
         FRReading := Integer(Brain.GetFRAvg);

                  --  State machine logic
         case Brain.GetRobotState is
            when Stp =>
               delay until Clock + Milliseconds(800);
               if ((FLReading + FRReading) / 2) > 50 then
                  Update_State(Fwd);
               else
                  Update_State(Servoreading);
               end if;
            when Fwd =>
               if ((FLReading + FRReading) / 2) < 50 then
                  Update_State(Stp);
               end if;
            when Servoreading =>
               Brain.SetServoState(ReadRight);
               delay until Clock + Milliseconds(1500);
               Sensors(1) := Integer(Brain.GetBAvg);
               Brain.SetServoState(ReadBack);
               delay until Clock + Milliseconds(1500);
               Sensors(2) := Integer(Brain.GetBAvg);
               Brain.SetServoState(ReadLeft);
               delay until Clock + Milliseconds(1500);
               Sensors(3) := Integer(Brain.GetBAvg);
               Max_Reading := 0;
               for I in Sensors'Range loop
                  if Sensors(I) > Max_Reading then
                     Max_Reading := Sensors(I);
                     Max_Reading_Sensor := I;
                  end if;
               end loop;
               case Max_Reading_Sensor is
                  when 1 =>
                     Update_State(Rotate_R);
                  when 2 =>
                     Update_State(Rotate_180);
                  when 3 =>
                     Update_State(Rotate_L);
                  when others =>
                     Put_Line("think: something very strange happened");
               end case;
            when others =>
               null;
         end case;

         cpu_time := Clock - timer;
         Brain.SetThinkTime(cpu_time);
         delay until timer + Milliseconds(600);
      end loop;
   end thinktask;
end think;
