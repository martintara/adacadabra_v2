with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Ada.Real_Time; use Ada.Real_Time;

package protectedobjects is
   type RobotState is (Fwd, Bckwd, Rotate_L, Rotate_R, Rotate_180, Stp, Servoreading);
   type ServoState is (ReadRight, ReadBack, ReadLeft);
   protected Brain is
      function GetFRAvg return Float;
      function GetFLAvg return Float;
      function GetBAvg return Float;
      function GetRobotState return RobotState;
      function GetServoState return ServoState;
      function GetSenseTime return Time_Span;
      function GetThinkTime return Time_Span;
      function GetActTime return Time_Span;

      procedure SetFRAvg(F : Float);
      procedure SetFLAvg(F : Float);
      procedure SetBAvg(F : Float);
      procedure SetRobotState(S : RobotState);
      procedure SetServoState(S : ServoState);
      procedure SetSenseTime(D : Time_Span);
      procedure SetThinkTime(D : Time_Span);
      procedure SetActTime(D : Time_Span);
   private
      FRAvg : Float := 0.0;
      FLAvg : Float := 0.0;
      BAvg : Float := 0.0;
      RState : RobotState := Stp;
      SState : ServoState := ReadRight;

      SenseTime : Time_Span := Milliseconds(0);
      ThinkTime : Time_Span := Milliseconds(0);
      ActTime : Time_Span := Milliseconds(0);
   end Brain;
end protectedobjects;
