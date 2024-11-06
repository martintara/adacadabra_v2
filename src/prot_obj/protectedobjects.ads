with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Ada.Real_Time; use Ada.Real_Time;

package protectedobjects is
   type State_Type is (Forward, Backward, Rotate_Left, Rotate_Right, Stop, Servoreading);
   protected Brain is
      function GetFRAvg return Float;
      function GetFLAvg return Float;
      function GetBAvg return Float;
      function GetState return State_Type;
      function GetSenseTime return Time_Span;
      function GetThinkTime return Time_Span;
      function GetActTime return Time_Span;

      procedure SetFRAvg(F : Float);
      procedure SetFLAvg(F : Float);
      procedure SetBAvg(F : Float);
      procedure SetState(S : State_Type);
      procedure SetSenseTime(D : Time_Span);
      procedure SetThinkTime(D : Time_Span);
      procedure SetActTime(D : Time_Span);
   private
      FRAvg : Float := 0.0;
      FLAvg : Float := 0.0;
      BAvg : Float := 0.0;
      State : State_Type := Stop;

      SenseTime : Time_Span := Milliseconds(0);
      ThinkTime : Time_Span := Milliseconds(0);
      ActTime : Time_Span := Milliseconds(0);
   end Brain;
end protectedobjects;
