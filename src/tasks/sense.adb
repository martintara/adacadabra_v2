with Ada.Real_Time; use Ada.Real_Time;
with MicroBit; use MicroBit;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Console; use MicroBit.Console;
with protectedobjects; use protectedobjects;
with MicroBit.Ultrasonic;
with Ringbuffer; use Ringbuffer;

package body sense is
   task body sensetask is
      aclock : Time;
      package FLS is new Ultrasonic(MB_P14, MB_P13); --FrontLeft Sensor
      package FRS is new Ultrasonic(MB_P12, MB_P8); --FrontRight Sensor
      package BS is new Ultrasonic(MB_P16, MB_P15); --Back Sensor
      FLBuf : Ringbuffer.Ringbuffer; --FrontLeft Ringbuffer
      FRBuf : Ringbuffer.Ringbuffer; --FrontRight Ringbuffer
      BBuf : Ringbuffer.Ringbuffer; --Back Ringbuffer
   begin
      Put_Line("Started sensing task.");
      loop
         aclock := Clock;
         Add_Reading(FLBuf, FLS.Read);
         Add_Reading(FRBuf, FRS.Read);
         Add_Reading(BBuf, BS.Read);
         Shared_Data.SetFLAvg(Average(FLBuf));
         Shared_Data.SetFRAvg(Average(FRBuf));
         Shared_Data.SetBAvg(Average(BBuf));
         --HC-SR04 datasheet suggests a sensor reading interval of 60ms
         delay until aclock + Milliseconds(60);
      end loop;
   end sensetask;
end sense;
