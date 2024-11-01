with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Types; use MicroBit.Types;

package Ringbuffer is
      Max_Size : constant Integer := 10;

      type Buffer_Array is array (0 .. Max_Size - 1) of Distance_cm;

      type Ringbuffer is record
         Buffer : Buffer_Array;
         Head : Integer := 0;
         Count : Integer := 0;
      end record;

      procedure Initialize(RB : out Ringbuffer);

      procedure Add_Reading(RB : in out Ringbuffer; R : Distance_cm);

      function Average(RB : Ringbuffer) return Float;
end Ringbuffer;
