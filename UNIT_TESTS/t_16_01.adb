with Ada.Streams.Stream_IO;
with Serial_IO;
with Test;

procedure T_16_01 is
  package Stream_IO renames Ada.Streams.Stream_IO;

  use type Serial_IO.Unsigned_16_t;

  Output : Stream_IO.File_Type;
  Input  : Stream_IO.File_Type;
  V      : Serial_IO.Unsigned_16_t;
begin
  Stream_IO.Create
    (Name => "t_16_01.dat",
     Mode => Stream_IO.Out_File,
     File => Output);

  Serial_IO.Unsigned_16_t'Output (Stream_IO.Stream (Output), 16#ffff#);
  Serial_IO.Unsigned_16_t'Output (Stream_IO.Stream (Output), 16#7fff#);
  Serial_IO.Unsigned_16_t'Output (Stream_IO.Stream (Output), 16#00ff#);
  Serial_IO.Unsigned_16_t'Output (Stream_IO.Stream (Output), 16#007f#);
  Serial_IO.Unsigned_16_t'Output (Stream_IO.Stream (Output), 16#0000#);

  pragma Warnings (Off);
  Stream_IO.Close (Output);
  pragma Warnings (On);

  Stream_IO.Open
    (Name => "t_16_01.dat",
     Mode => Stream_IO.In_File,
     File => Input);

  V := Serial_IO.Unsigned_16_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#ffff#);
  V := Serial_IO.Unsigned_16_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#7fff#);
  V := Serial_IO.Unsigned_16_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#00ff#);
  V := Serial_IO.Unsigned_16_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#007f#);
  V := Serial_IO.Unsigned_16_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000#);

  pragma Warnings (Off);
  Stream_IO.Close (Input);
  pragma Warnings (On);

end T_16_01;
