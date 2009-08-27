with Ada.Streams.Stream_IO;
with Serial_IO;
with Test;

procedure T_UTF8_01 is
  package Stream_IO renames Ada.Streams.Stream_IO;

  type S_t is new Serial_IO.UTF8_String_t (1 .. 8);

  S : S_t;
  T : S_t;

  Output : Stream_IO.File_Type;
  Input  : Stream_IO.File_Type;
begin
  Stream_IO.Create
    (Name => "t_utf8_01.dat",
     Mode => Stream_IO.Out_File,
     File => Output);

  S (1 .. 8) := ('д', 'a', 'ц', 'a', '1', '2', '3', '4');

  S_t'Output (Stream_IO.Stream (Output), S);

  Stream_IO.Close (Output);

  Stream_IO.Open
    (Name => "t_utf8_01.dat",
     Mode => Stream_IO.In_File,
     File => Input);

  T := S_t'Input (Stream_IO.Stream (Input));
  Test.Assert (S = T);

  Stream_IO.Close (Input);
end T_UTF8_01;
