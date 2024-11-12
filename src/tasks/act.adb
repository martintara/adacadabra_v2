with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Servos; use MicroBit.Servos;
with DFR0548;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with Microbit.Types; use Microbit.Types;
with protectedobjects; use protectedobjects;
with robotconstants;
use MicroBit;

package body act is
   task body acttask is
      timer : Time;
      cpu_time : Time_Span;
      MAX_SPEED : constant Speeds := (4095, 4095, 4095, 4095); --tired of typing 4095x4 a billion times so thats why we have this
      ServoPin : constant Servo_Pin_Id := 1;
   begin
      Put_Line("Started acting task.");
      loop
         timer := Clock;

         case Brain.GetRobotState is
            when Fwd => --move forward when told to
               MotorDriver.Drive(Forward, MAX_SPEED);
            when Bckwd => --I don't think we ever used this
               MotorDriver.Drive(Backward, MAX_SPEED);
            when Rotate_L | Rotate_R | Rotate_180 =>
               if Clock > Brain.GetMoveUntil then --if the robot has rotated long enough
                  MotorDriver.Drive(Stop, MAX_SPEED); --then stop rotating
                  Go(ServoPin, Servo_Set_Point(100.0)); --reset servo to back position
                  Brain.SetRobotState(Fwd); --start moving forward again
               elsif Brain.GetRobotState = Rotate_R then
                  MotorDriver.Drive(Rotating_Right, MAX_SPEED);
               else
                  MotorDriver.Drive(Rotating_Left, MAX_SPEED);
               end if;
            when Servoreading =>
               MotorDriver.Drive(Stop, MAX_SPEED);
               case Brain.GetServoState is
                  when ReadRight =>
                     Go(ServoPin, Servo_Set_Point(180.0)); --rotate servo to read to the right of the robot
                  when ReadBack =>
                     Go(ServoPin, Servo_Set_Point(100.0)); --rotate servo to read behind the robot
                  when ReadLeft =>
                     Go(ServoPin, Servo_Set_Point(15.0)); --rotate servo to read to the left of the robot
               end case;
         end case;
         cpu_time := Clock - timer; --get the execution time for this task
         Brain.SetActTime(cpu_time); --store it in the protected object
         delay until timer + robotconstants.ActDeadline;
      end loop;
   end acttask;
end act;
