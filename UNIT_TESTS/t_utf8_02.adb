with Ada.Streams.Stream_IO;
with Serial_IO;
with Test;

procedure T_UTF8_02 is
  package Stream_IO renames Ada.Streams.Stream_IO;

  type S_t is new Serial_IO.UTF8_String_t (1 .. 8);

  S : S_t;
  T : S_t;

  Output : Stream_IO.File_Type;
  Input  : Stream_IO.File_Type;
begin
  Stream_IO.Create
    (Name => "t_utf8_02.dat",
     Mode => Stream_IO.Out_File,
     File => Output);

  S (1 .. 8) := ('A', 'B', 'C', 'D', '1', '2', '3', '4');

  S_t'Output (Stream_IO.Stream (Output), S);

  pragma Warnings (Off);
  Stream_IO.Close (Output);
  pragma Warnings (On);

  Stream_IO.Open
    (Name => "t_utf8_02.dat",
     Mode => Stream_IO.In_File,
     File => Input);

  T := S_t'Input (Stream_IO.Stream (Input));
  Test.Assert (S = T);

  pragma Warnings (Off);
  Stream_IO.Close (Input);
  pragma Warnings (On);

end T_UTF8_02;
