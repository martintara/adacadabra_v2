pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

package body ada_main is

   E082 : Short_Integer; pragma Import (Ada, E082, "ada__tags_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "ada__strings__text_buffers_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "system__bb__timing_events_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "ada__exceptions_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "system__soft_links_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__exception_table_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "ada__streams_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__finalization_root_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "ada__finalization_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "system__storage_pools_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "system__finalization_masters_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "ada__real_time_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "system__pool_global_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "system__tasking__protected_objects_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "system__tasking__restricted__stages_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "hal__gpio_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "hal__i2c_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "hal__spi_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "hal__uart_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "lsm303agr_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "memory_barriers_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "cortex_m__nvic_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "nrf__events_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "nrf__gpio_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "nrf__gpio__tasks_and_events_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "nrf__interrupts_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "nrf__rtc_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "nrf__spi_master_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "nrf__tasks_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "nrf__adc_E");
   E265 : Short_Integer; pragma Import (Ada, E265, "nrf__clock_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "nrf__ppi_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "nrf__timers_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "nrf__twi_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "nrf__uart_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "nrf__device_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "microbit__console_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "dfr0548_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "microbit__i2c_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "microbit__accelerometer_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "microbit__iosfortasking_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "microbit__motordriver_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "microbit__servos_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "microbit__timehighspeed_E");
   E261 : Short_Integer; pragma Import (Ada, E261, "microbit__ultrasonic_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "protectedobjects_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "act_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "ringbuffer_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "sense_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "think_E");

   Sec_Default_Sized_Stacks : array (1 .. 4) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := 0;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 4;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Ada.Strings.Text_Buffers'Elab_Spec;
      E071 := E071 + 1;
      System.Bb.Timing_Events'Elab_Spec;
      E069 := E069 + 1;
      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      Ada.Tags'Elab_Body;
      E082 := E082 + 1;
      System.Exception_Table'Elab_Body;
      E039 := E039 + 1;
      E041 := E041 + 1;
      E010 := E010 + 1;
      Ada.Streams'Elab_Spec;
      E160 := E160 + 1;
      System.Finalization_Root'Elab_Spec;
      E167 := E167 + 1;
      Ada.Finalization'Elab_Spec;
      E165 := E165 + 1;
      System.Storage_Pools'Elab_Spec;
      E169 := E169 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E164 := E164 + 1;
      Ada.Real_Time'Elab_Body;
      E141 := E141 + 1;
      System.Pool_Global'Elab_Spec;
      E171 := E171 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E248 := E248 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E255 := E255 + 1;
      HAL.GPIO'ELAB_SPEC;
      E162 := E162 + 1;
      HAL.I2C'ELAB_SPEC;
      E198 := E198 + 1;
      HAL.SPI'ELAB_SPEC;
      E191 := E191 + 1;
      HAL.UART'ELAB_SPEC;
      E202 := E202 + 1;
      LSM303AGR'ELAB_SPEC;
      LSM303AGR'ELAB_BODY;
      E206 := E206 + 1;
      E221 := E221 + 1;
      E219 := E219 + 1;
      E238 := E238 + 1;
      Nrf.Gpio'Elab_Spec;
      Nrf.Gpio'Elab_Body;
      E157 := E157 + 1;
      E240 := E240 + 1;
      E242 := E242 + 1;
      E186 := E186 + 1;
      Nrf.Spi_Master'Elab_Spec;
      Nrf.Spi_Master'Elab_Body;
      E189 := E189 + 1;
      E225 := E225 + 1;
      E223 := E223 + 1;
      E265 := E265 + 1;
      E244 := E244 + 1;
      Nrf.Timers'Elab_Spec;
      Nrf.Timers'Elab_Body;
      E193 := E193 + 1;
      Nrf.Twi'Elab_Spec;
      Nrf.Twi'Elab_Body;
      E196 := E196 + 1;
      Nrf.Uart'Elab_Spec;
      Nrf.Uart'Elab_Body;
      E200 := E200 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E147 := E147 + 1;
      Microbit.Console'Elab_Body;
      E204 := E204 + 1;
      DFR0548'ELAB_SPEC;
      DFR0548'ELAB_BODY;
      E143 := E143 + 1;
      E210 := E210 + 1;
      Microbit.Accelerometer'Elab_Body;
      E208 := E208 + 1;
      Microbit.Iosfortasking'Elab_Spec;
      Microbit.Iosfortasking'Elab_Body;
      E216 := E216 + 1;
      Microbit.Motordriver'Elab_Body;
      E212 := E212 + 1;
      E214 := E214 + 1;
      Microbit.Timehighspeed'Elab_Body;
      E263 := E263 + 1;
      E261 := E261 + 1;
      protectedobjects'elab_spec;
      E272 := E272 + 1;
      act'elab_spec;
      act'elab_body;
      E268 := E268 + 1;
      E276 := E276 + 1;
      sense'elab_spec;
      sense'elab_body;
      E274 := E274 + 1;
      think'elab_spec;
      think'elab_body;
      E278 := E278 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   procedure main is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
   end;

--  BEGIN Object file/option list
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/protectedobjects.o
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/act.o
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/ringbuffer.o
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/sense.o
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/think.o
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/tasklist.o
   --   /home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/main.o
   --   -L/home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/
   --   -L/home/martin/adacadabra/Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/adacadabra_v2/obj/
   --   -L/home/martin/adacadabra/Code/libs/Ada_Drivers_Library/boards/MicroBit_v2/obj/full_lib_Debug/
   --   -L/home/martin/.local/share/alire/toolchains/gnat_arm_elf_14.1.3_f019f928/arm-eabi/lib/gnat/embedded-nrf52833/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
