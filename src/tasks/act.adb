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
      ServoPin : constant Servo_Pin_Id := 1;
      Deg_90 : constant Integer := 800; --should be approx 90 degrees if turning for this many milliseconds
   begin
      Put_Line("Started acting task.");
      loop
         timer := Clock;

         case Brain.GetRobotState is
            when Stp =>
               MotorDriver.Drive(Stop, (4095,4095,4095,4095));
            when Fwd =>
               MotorDriver.Drive(Forward, (4095,4095,4095,4095));
            when Bckwd =>
               MotorDriver.Drive(Backward, (4095,4095,4095,4095));
            when Rotate_L =>
               Go(ServoPin, Servo_Set_Point(180.0)); --reset servo to the position it first reads from
               MotorDriver.Drive(Rotating_Left, (4095,4095,4095,4095));
               delay until Clock + Milliseconds(Deg_90);
               Brain.SetRobotState(Stp);
            when Rotate_R =>
               Go(ServoPin, Servo_Set_Point(180.0)); --reset servo to the position it first reads from
               MotorDriver.Drive(Rotating_Right, (4095,4095,4095,4095));
               delay until Clock + Milliseconds(Deg_90);
               Brain.SetRobotState(Stp);
            when Rotate_180 =>
               Go(ServoPin, Servo_Set_Point(180.0)); --reset servo to the position it first reads from
               MotorDriver.Drive(Rotating_Left, (4095,4095,4095,4095));
               delay until Clock + Milliseconds(Deg_90 * 2);
               Brain.SetRobotState(Stp);
            when Servoreading =>
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
