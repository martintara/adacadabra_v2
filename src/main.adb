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
with MicroBit.Buttons; use MicroBit.Buttons;
with HAL; use HAL;
with tasklist;
with protectedobjects; use protectedobjects;
use MicroBit;

procedure Main with Priority => 0 is
   procedure print_cpu_times is
      timer : Time;
   begin
      timer := Clock;
      Put("sense_time: " & Duration'Image(To_Duration(Brain.GetSenseTime)) & " seconds");
      Put_Line(" max value: " & Duration'Image(To_Duration(Brain.GetSenseMaxTime)) & " seconds.");
      Put("think_time: " & Duration'Image(To_Duration(Brain.GetThinkTime)) & " seconds");
      Put_Line(" max value: " & Duration'Image(To_Duration(Brain.GetThinkMaxTime)) & " seconds.");
      Put("act_time: " & Duration'Image(To_Duration(Brain.GetActTime)) & " seconds");
      Put_Line(" max value: " & Duration'Image(To_Duration(Brain.GetActMaxTime)) & " seconds.");
      delay until timer + Seconds(1);
   end print_cpu_times;

   procedure buttons is
   begin
      if MicroBit.Buttons.State(Button_A) = Pressed then
         Brain.ClearMaxTimes;
      elsif MicroBit.Buttons.State(Button_B) = Pressed then
         Brain.SetUseExceptions(not Brain.GetUseExceptions);
      end if;
   end buttons;
begin
   Put_Line("Starting main loop.");
   loop
      print_cpu_times;
      buttons;
      null;
   end loop;
end Main;
