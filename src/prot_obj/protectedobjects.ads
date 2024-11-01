with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package protectedobjects is
   protected type ProtObjs is
      function GetFRAvg return Float;
      function GetFLAvg return Float;
      function GetBAvg return Float;
      function GetDir return Directions;

      procedure SetFRAvg(F : Float);
      procedure SetFLAvg(F : Float);
      procedure SetBAvg(F : Float);
      procedure SetDir(D : Directions);
   private
      FRAvg : Float := 0.0;
      FLAvg : Float := 0.0;
      BAvg : Float := 0.0;
      Dir : Directions := Stop;

   end ProtObjs;

   Shared_Data : ProtObjs;
end protectedobjects;
