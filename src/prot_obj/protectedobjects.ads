with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Ada.Real_Time; use Ada.Real_Time;

package protectedobjects is
   type RobotState is (Fwd, Bckwd, Rotate_L, Rotate_R, Rotate_180, Servoreading);
   type ServoState is (ReadRight, ReadBack, ReadLeft);
   protected Brain is
      function GetFRAvg return Float;
      function GetFLAvg return Float;
      function GetBAvg return Float;
      function GetRobotState return RobotState;
      function GetServoState return ServoState;
      function GetMoveUntil return Time;
      function GetSenseTime return Time_Span;
      function GetThinkTime return Time_Span;
      function GetActTime return Time_Span;
      function GetSenseMaxTime return Time_Span;
      function GetThinkMaxTime return Time_Span;
      function GetActMaxTime return Time_Span;
      function GetUseExceptions return Boolean;

      procedure SetFRAvg(F : Float);
      procedure SetFLAvg(F : Float);
      procedure SetBAvg(F : Float);
      procedure SetRobotState(S : RobotState);
      procedure SetServoState(S : ServoState);
      procedure SetMoveUntil(T : Time);
      procedure SetSenseTime(D : Time_Span);
      procedure SetThinkTime(D : Time_Span);
      procedure SetActTime(D : Time_Span);
      procedure ClearMaxTimes;
      procedure SetUseExceptions(B : Boolean);

   private
      FRAvg : Float := 0.0;
      FLAvg : Float := 0.0;
      BAvg : Float := 0.0;
      RState : RobotState := Fwd;
      SState : ServoState := ReadRight;
      MoveUntil : Time := Clock;

      SenseTime : Time_Span := Milliseconds(0);
      ThinkTime : Time_Span := Milliseconds(0);
      ActTime : Time_Span := Milliseconds(0);
      SenseMaxTime : Time_Span := Milliseconds(0);
      ThinkMaxTime : Time_Span := Milliseconds(0);
      ActMaxTime : Time_Span := Milliseconds(0);
      UseExceptions : Boolean := False;
   end Brain;
end protectedobjects;
