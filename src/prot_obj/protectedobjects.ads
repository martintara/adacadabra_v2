with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package protectedobjects is
   type State_Type is (Forward, Backward, Rotate_Left, Rotate_Right, Stop, Servoreading);
   protected type ProtObjs is
      function GetFRAvg return Float;
      function GetFLAvg return Float;
      function GetBAvg return Float;
      function GetState return State_Type;

      procedure SetFRAvg(F : Float);
      procedure SetFLAvg(F : Float);
      procedure SetBAvg(F : Float);
      procedure SetState(S : State_Type);
   private
      FRAvg : Float := 0.0;
      FLAvg : Float := 0.0;
      BAvg : Float := 0.0;
      State : State_Type := Stop;

   end ProtObjs;

   Shared_Data : ProtObjs;
end protectedobjects;
