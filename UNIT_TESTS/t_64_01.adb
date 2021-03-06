with Ada.Streams.Stream_IO;
with Serial_IO;
with Test;

procedure T_64_01 is
  package Stream_IO renames Ada.Streams.Stream_IO;

  use type Serial_IO.Unsigned_64_t;

  Output : Stream_IO.File_Type;
  Input  : Stream_IO.File_Type;
  V      : Serial_IO.Unsigned_64_t;
begin
  Stream_IO.Create
    (Name => "t_64_01.dat",
     Mode => Stream_IO.Out_File,
     File => Output);

  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#ffff_ffff_ffff_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#7fff_ffff_ffff_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_ffff_ffff_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_7fff_ffff_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_0000_ffff_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_0000_7fff_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_0000_0000_ffff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_0000_0000_7fff#);
  Serial_IO.Unsigned_64_t'Output (Stream_IO.Stream (Output), 16#0000_0000_0000_0000#);

  pragma Warnings (Off);
  Stream_IO.Close (Output);
  pragma Warnings (On);

  Stream_IO.Open
    (Name => "t_64_01.dat",
     Mode => Stream_IO.In_File,
     File => Input);

  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#ffff_ffff_ffff_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#7fff_ffff_ffff_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_ffff_ffff_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_7fff_ffff_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_0000_ffff_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_0000_7fff_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_0000_0000_ffff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_0000_0000_7fff#);
  V := Serial_IO.Unsigned_64_t'Input (Stream_IO.Stream (Input));
  Test.Assert (V = 16#0000_0000_0000_0000#);

  pragma Warnings (Off);
  Stream_IO.Close (Input);
  pragma Warnings (On);

end T_64_01;
