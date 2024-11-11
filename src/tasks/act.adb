with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Servos; use MicroBit.Servos;
with DFR0548;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with Microbit.Types; use Microbit.Types;
with protectedobjects; use protectedobjects;
use MicroBit;

package body act is
   task body acttask is
      timer : Time;
      cpu_time : Time_Span;
      MAX_SPEED : Speeds := (4095, 4095, 4095, 4095);
      ServoPin : constant Servo_Pin_Id := 1;
   begin
      Put_Line("Started acting task.");
      loop
         timer := Clock;

         case Brain.GetRobotState is
            when Fwd =>
               MotorDriver.Drive(Forward, MAX_SPEED);
            when Bckwd =>
               MotorDriver.Drive(Backward, MAX_SPEED);
            when Rotate_L =>
               if Clock > Brain.GetMoveUntil then
                  MotorDriver.Drive(Stop, MAX_SPEED);
                  Brain.SetRobotState(Fwd);
               else
                  MotorDriver.Drive(Rotating_Left, MAX_SPEED);
               end if;
            when Rotate_R =>
               if Clock > Brain.GetMoveUntil then
                  MotorDriver.Drive(Stop, MAX_SPEED);
                  Brain.SetRobotState(Fwd);
               else
                  MotorDriver.Drive(Rotating_Right, MAX_SPEED);
               end if;
            when Rotate_180 =>
               if Clock > Brain.GetMoveUntil then
                  MotorDriver.Drive(Stop, MAX_SPEED);
                  Brain.SetRobotState(Fwd);
               else
                  MotorDriver.Drive(Rotating_Left, MAX_SPEED);
               end if;
            when Servoreading =>
               MotorDriver.Drive(Stop, MAX_SPEED);
               case Brain.GetServoState is
                  when ReadRight =>
                     Go(ServoPin, Servo_Set_Point(180.0));
                  when ReadBack =>
                     Go(ServoPin, Servo_Set_Point(100.0));
                  when ReadLeft =>
                     Go(ServoPin, Servo_Set_Point(15.0));
               end case;
         end case;
         cpu_time := Clock - timer;
         Brain.SetActTime(cpu_time);
         delay until timer + Milliseconds(100);
      end loop;
   end acttask;
end act;
