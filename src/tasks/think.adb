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
      BReading : Integer;

      -- Procedure to update the shared direction and log it
      procedure Update_State(S : State_Type) is
      begin
         Brain.SetState(S);
         Put_Line("New State: " & State_Type'Image(S));
      end Update_State;

   begin
      Put_Line("Started thinking task.");
      loop
         timer := Clock;
         FLReading := Integer(Brain.GetFLAvg);
         FRReading := Integer(Brain.GetFRAvg);
         BReading := Integer(Brain.GetBAvg);
         --  Put_Line("FLS: " & Integer'Image(FLReading));
         --  Put_Line("FRS: " & Integer'Image(FRReading));
         --  Put_Line("BS: " & Integer'Image(BReading));

                  --  State machine logic
         case Brain.GetState is
            when Stop =>
               --  Put_Line("test ");
               if FLReading > 100 and FRReading > 100 then
                  Update_State(Forward);
               else
                  Update_State(Servoreading);
               end if;
           when Forward =>
               if FLReading < 100 and FRReading < 100 then
                  Update_State(Stop);
               end if;

           when Servoreading =>
                   Put_Line("Reading servos");
                   delay 3.0;
                   Update_State(Forward);

           when others =>
                   Put_Line("others");
         end case;

         cpu_time := Clock - timer;
         Brain.SetThinkTime(cpu_time);
         delay until timer + Milliseconds(600);
      end loop;
   end thinktask;
end think;
