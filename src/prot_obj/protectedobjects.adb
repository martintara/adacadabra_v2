with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with HAL; use HAL;

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

      function GetRobotState return RobotState is
      begin
         return RState;
      end GetRobotState;

      function GetServoState return ServoState is
      begin
         return SState;
      end GetServoState;

      function GetMoveUntil return Time is
      begin
         return MoveUntil;
      end GetMoveUntil;

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

      function GetSenseMaxTime return Time_Span is
      begin
         return SenseMaxTime;
      end GetSenseMaxTime;

      function GetThinkMaxTime return Time_Span is
      begin
         return ThinkMaxTime;
      end GetThinkMaxTime;

      function GetActMaxTime return Time_Span is
      begin
         return ActMaxTime;
      end GetActMaxTime;

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

      procedure SetRobotState(S : RobotState) is
      begin
         RState := S;
      end SetRobotState;

      procedure SetServoState(S : ServoState) is
      begin
         SState := S;
      end SetServoState;

      procedure SetMoveUntil(T : Time) is
      begin
         MoveUntil := T;
      end SetMoveUntil;

      procedure SetSenseTime(D : Time_Span) is
      begin
         SenseTime := D;
         if D > SenseMaxTime then
            SenseMaxTime := D;
         end if;
      end SetSenseTime;

      procedure SetThinkTime(D : Time_Span) is
      begin
         ThinkTime := D;
         if D > ThinkMaxTime then
            ThinkMaxTime := D;
         end if;
      end SetThinkTime;

      procedure SetActTime(D : Time_Span) is
      begin
         ActTime := D;
         if D > ActMaxTime then
            ActMaxTime := D;
         end if;
      end SetActTime;
   end Brain;
end protectedobjects;
