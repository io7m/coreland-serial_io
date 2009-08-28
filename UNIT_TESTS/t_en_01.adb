with Ada.Streams.Stream_IO;
with Serial_IO;
with Test;

procedure T_en_01 is
  package Stream_IO renames Ada.Streams.Stream_IO;

  -- Triggers 'literal not referenced' bug in GCC 4.4.0, 4.3.4
  pragma Warnings (Off);
  type En_Base_t is (Apple, Banana, Carrot, Durian, Eggplant, Fennel);
  pragma Warnings (On);

  package Serial_En is new Serial_IO.Serializable_Enumeration
    (Enumeration_Base => En_Base_t);

  type En_t is new Serial_En.Data_t;

  Output : Stream_IO.File_Type;
  Input  : Stream_IO.File_Type;
  V      : En_t;
begin
  Stream_IO.Create
    (Name => "t_en_01.dat",
     Mode => Stream_IO.Out_File,
     File => Output);

  En_t'Write (Stream_IO.Stream (Output), Apple);
  En_t'Write (Stream_IO.Stream (Output), Banana);
  En_t'Write (Stream_IO.Stream (Output), Carrot);
  En_t'Write (Stream_IO.Stream (Output), Durian);
  En_t'Write (Stream_IO.Stream (Output), Eggplant);
  En_t'Write (Stream_IO.Stream (Output), Fennel);

  Stream_IO.Close (Output);

  Stream_IO.Open
    (Name => "t_en_01.dat",
     Mode => Stream_IO.In_File,
     File => Input);

  En_t'Read (Stream_IO.Stream (Input), V);
  Test.Assert (V = Apple);
  En_t'Read (Stream_IO.Stream (Input), V);
  Test.Assert (V = Banana);
  En_t'Read (Stream_IO.Stream (Input), V);
  Test.Assert (V = Carrot);
  En_t'Read (Stream_IO.Stream (Input), V);
  Test.Assert (V = Durian);
  En_t'Read (Stream_IO.Stream (Input), V);
  Test.Assert (V = Eggplant);
  En_t'Read (Stream_IO.Stream (Input), V);
  Test.Assert (V = Fennel);

  Stream_IO.Close (Input);
end T_en_01;
