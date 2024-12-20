with Ada.Real_Time; use Ada.Real_Time;
with MicroBit; use MicroBit;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Console; use MicroBit.Console;
with protectedobjects; use protectedobjects;
with MicroBit.Ultrasonic;
with MicroBit.DisplayRT; use MicroBit.DisplayRT;
with Ringbuffer; use Ringbuffer;

package body sense is
   task body sensetask is
      timer : Time;
      cpu_time : Time_Span;
      package FLS is new Ultrasonic(MB_P14, MB_P13); --FrontLeft Sensor
      package FRS is new Ultrasonic(MB_P12, MB_P8); --FrontRight Sensor
      package BS is new Ultrasonic(MB_P16, MB_P15); --Back Sensor
      FLBuf : Ringbuffer.Ringbuffer; --FrontLeft Ringbuffer
      FRBuf : Ringbuffer.Ringbuffer; --FrontRight Ringbuffer
      BBuf : Ringbuffer.Ringbuffer; --Back Ringbuffer

      procedure sense_with_exceptions is
      begin
         begin
            Add_Reading(FLBuf, FLS.Read, True); --store sensor reading in ringbuffer
            MicroBit.DisplayRT.Clear(3, 1); --if it went well, clear the bad reading led
         exception
            when Ringbuffer.Bad_Reading =>
               --set a led on the microbit led matrix to indicate bad reading on this sensor
               MicroBit.DisplayRT.Set(3, 1);
            when others =>
               null;
         end;

         begin
            Add_Reading(FRBuf, FRS.Read, True);
            MicroBit.DisplayRT.Clear(1, 1);
         exception
            when Ringbuffer.Bad_Reading =>
               MicroBit.DisplayRT.Set(1, 1);
            when others =>
               null;
         end;

         begin
            Add_Reading(BBuf, BS.Read, True);
            MicroBit.DisplayRT.Clear(2, 3);
         exception
            when Ringbuffer.Bad_Reading =>
               MicroBit.DisplayRT.Set(2, 3);
            when others =>
               null;
         end;
      end sense_with_exceptions;

      procedure sense_without_exceptions is
      begin
         Add_Reading(FLBuf, FLS.Read, False);
         Add_Reading(FRBuf, FRS.Read, False);
         Add_Reading(BBuf, BS.Read, False);
      end sense_without_exceptions;
   begin
      Put_Line("Started sensing task.");
      Initialize(FLBuf);
      Initialize(FRBuf);
      Initialize(BBuf);
      loop
         timer := Clock;

         if Brain.GetUseExceptions then --do we raise exceptions when the sensor returns 0?
            sense_with_exceptions;
         else --no? then we just return instead of raising an exception
            sense_without_exceptions;
         end if;

         --compute average sensor reading and store them in the protected object
         Brain.SetFLAvg(Average(FLBuf));
         Brain.SetFRAvg(Average(FRBuf));
         Brain.SetBAvg(Average(BBuf));

         cpu_time := Clock - timer; --get the execution time for this task
         Brain.SetSenseTime(cpu_time); --store it in the protected object
         delay until timer + robotconstants.SenseDeadline;
      end loop;
   end sensetask;
end sense;
