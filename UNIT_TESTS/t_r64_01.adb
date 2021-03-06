with Ada.Streams.Stream_IO;
with Serial_IO;
with Test;

procedure T_R64_01 is
  package Stream_IO renames Ada.Streams.Stream_IO;

  use type Serial_IO.Unsigned_64_t;

  Output : Stream_IO.File_Type;
  Input  : Stream_IO.File_Type;

  type R_t is record
    A : Serial_IO.Unsigned_64_t;
    B : Serial_IO.Unsigned_64_t;
    C : Serial_IO.Unsigned_64_t;
    D : Serial_IO.Unsigned_64_t;
    E : Serial_IO.Unsigned_64_t;
    F : Serial_IO.Unsigned_64_t;
    G : Serial_IO.Unsigned_64_t;
    H : Serial_IO.Unsigned_64_t;
    I : Serial_IO.Unsigned_64_t;
  end record;

  R : R_t;
  S : R_t;

begin
  Stream_IO.Create
    (Name => "t_r64_01.dat",
     Mode => Stream_IO.Out_File,
     File => Output);

  R.A := 16#ffff_ffff_ffff_ffff#;
  R.B := 16#7fff_ffff_ffff_ffff#;
  R.C := 16#0000_ffff_ffff_ffff#;
  R.D := 16#0000_7fff_ffff_ffff#;
  R.E := 16#0000_0000_ffff_ffff#;
  R.F := 16#0000_0000_7fff_ffff#;
  R.G := 16#0000_0000_0000_ffff#;
  R.H := 16#0000_0000_0000_7fff#;
  R.I := 16#0000_0000_0000_0000#;

  R_t'Output (Stream_IO.Stream (Output), R);

  pragma Warnings (Off);
  Stream_IO.Close (Output);
  pragma Warnings (On);

  Stream_IO.Open
    (Name => "t_r64_01.dat",
     Mode => Stream_IO.In_File,
     File => Input);

  S := R_t'Input (Stream_IO.Stream (Input));

  Test.Assert (S = R);

  pragma Warnings (Off);
  Stream_IO.Close (Input);
  pragma Warnings (On);

end T_R64_01;
