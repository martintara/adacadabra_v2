with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body protectedobjects is
   protected body ProtObjs is
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
   end ProtObjs;
end protectedobjects;
