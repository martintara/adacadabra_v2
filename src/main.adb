with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.Ultrasonic;
with MicroBit.Types; use MicroBit.Types;
with LSM303AGR; use LSM303AGR;
with MicroBit.Accelerometer;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Real_Time; use Ada.Real_Time;
with DFR0548;
with MicroBit.Console; use MicroBit.Console;
with HAL; use HAL;
with tasklist;
with protectedobjects; use protectedobjects;
use MicroBit;

procedure Main with Priority => 0 is
   procedure print_cpu_times is
      timer : Time;
   begin
      loop
         timer := Clock;
         Put_Line("sense_time: " & Duration'Image(To_Duration(Brain.GetSenseTime)) & " seconds");
         Put_Line("think_time: " & Duration'Image(To_Duration(Brain.GetThinkTime)) & " seconds");
         Put_Line("act_time: " & Duration'Image(To_Duration(Brain.GetActTime)) & " seconds");
         delay until timer + Seconds(2);
      end loop;
   end print_cpu_times;
begin
   Put_Line("Starting main loop.");
   loop
      --print_cpu_times;
      null;
   end loop;
end Main;
