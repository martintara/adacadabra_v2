with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body protectedobjects is
   protected body Brain is
      function GetFRAvg return Float is
      begin
         return FRAvg;
      end GetFRAvg;

      function GetFLAvg return Float is
      begin
         return FLAvg;
      end GetFLAvg;

      function GetBAvg return Float is
      begin
         return BAvg;
      end GetBAvg;

      function GetState return State_Type is
      begin
         return State;
      end GetState;

      function GetSenseTime return Time_Span is
      begin
         return SenseTime;
      end GetSenseTime;

      function GetThinkTime return Time_Span is
      begin
         return ThinkTime;
      end GetThinkTime;

      function GetActTime return Time_Span is
      begin
         return ActTime;
      end GetActTime;

      procedure SetFRAvg(F : Float) is
      begin
         FRAvg := F;
      end SetFRAvg;

      procedure SetFLAvg(F : Float) is
      begin
         FLAvg := F;
      end SetFLAvg;

      procedure SetBAvg(F : Float) is
      begin
         BAvg := F;
      end SetBAvg;

      procedure SetState(S : State_Type) is
      begin
         State := S;
      end SetState;

      procedure SetSenseTime(D : Time_Span) is
      begin
         SenseTime := D;
      end SetSenseTime;

      procedure SetThinkTime(D : Time_Span) is
      begin
         ThinkTime := D;
      end SetThinkTime;

      procedure SetActTime(D : Time_Span) is
      begin
         ActTime := D;
      end SetActTime;
   end Brain;
end protectedobjects;
