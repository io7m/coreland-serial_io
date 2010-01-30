with GNAT.Encode_String;  -- GNAT specific
with GNAT.Decode_String;  -- GNAT specific
with System.WCh_Con;      -- GNAT specific

with Ada.Unchecked_Conversion;

package body Serial_IO is

  use type Interfaces.Unsigned_16;
  use type Interfaces.Unsigned_32;
  use type Interfaces.Unsigned_64;
  use type Ada.Streams.Stream_Element_Offset;

  --
  -- 16
  --

  --
  -- Packing.
  --

  procedure Pack_16_LE
    (Input  : in     Unsigned_16_t;
     Output :    out Unsigned_16_Packed_t)
  is
    Input_Copy : Interfaces.Unsigned_16;
  begin
    Input_Copy := Interfaces.Unsigned_16 (Input);

    Output (1) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (2) := Unsigned_8_t (Input_Copy and 16#ff#);
  end Pack_16_LE;

  procedure Pack_16_BE
    (Input  : in     Unsigned_16_t;
     Output :    out Unsigned_16_Packed_t)
  is
    Input_Copy : Interfaces.Unsigned_16;
  begin
    Input_Copy := Interfaces.Unsigned_16 (Input);

    Output (2) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (1) := Unsigned_8_t (Input_Copy and 16#ff#);
  end Pack_16_BE;

  --
  -- Unpacking.
  --

  procedure Unpack_16_BE
    (Input  : in     Unsigned_16_Packed_t;
     Output :    out Unsigned_16_t)
  is
    Output_Copy : Interfaces.Unsigned_16;
  begin
    Output_Copy := 0;

    Output_Copy := Output_Copy + Interfaces.Unsigned_16 (Input (1));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_16 (Input (2));

    Output := Unsigned_16_t (Output_Copy);
  end Unpack_16_BE;

  procedure Unpack_16_LE
    (Input  : in     Unsigned_16_Packed_t;
     Output :    out Unsigned_16_t)
  is
    Output_Copy : Interfaces.Unsigned_16;
  begin
    Output_Copy := 0;

    Output_Copy := Output_Copy + Interfaces.Unsigned_16 (Input (2));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_16 (Input (1));

    Output := Unsigned_16_t (Output_Copy);
  end Unpack_16_LE;

  --
  -- Read/Write attributes.
  --

  procedure Attribute_Write_16_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Unsigned_16_t)
  is
    subtype Source_t is Unsigned_16_Packed_t;
    subtype Target_t is Ada.Streams.Stream_Element_Array (1 .. 2);

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Unsigned_16_Packed_t;
  begin
    Pack_16_BE (Item, Packed);
    Ada.Streams.Write
      (Stream => Stream.all,
       Item   => Convert (Packed));
  end Attribute_Write_16_BE;

  procedure Attribute_Read_16_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unsigned_16_t)
  is
    subtype Source_t is Ada.Streams.Stream_Element_Array (1 .. 2);
    subtype Target_t is Unsigned_16_Packed_t;

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Source_t;
    Last   : Ada.Streams.Stream_Element_Offset;
  begin
    Ada.Streams.Read
      (Stream => Stream.all,
       Item   => Packed,
       Last   => Last);
    if Last /= 2 then
      raise Constraint_Error;
    end if;
    Unpack_16_BE
      (Input  => Convert (Packed),
       Output => Item);
  end Attribute_Read_16_BE;

  --
  -- 32
  --

  --
  -- Packing.
  --

  procedure Pack_32_LE
    (Input  : in     Unsigned_32_t;
     Output :    out Unsigned_32_Packed_t)
  is
    Input_Copy : Interfaces.Unsigned_32;
  begin
    Input_Copy := Interfaces.Unsigned_32 (Input);
    Output (1) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (2) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (3) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (4) := Unsigned_8_t (Input_Copy and 16#ff#);
  end Pack_32_LE;

  procedure Pack_32_BE
    (Input  : in     Unsigned_32_t;
     Output :    out Unsigned_32_Packed_t)
  is
    Input_Copy : Interfaces.Unsigned_32;
  begin
    Input_Copy := Interfaces.Unsigned_32 (Input);

    Output (4) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (3) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (2) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (1) := Unsigned_8_t (Input_Copy and 16#ff#);
  end Pack_32_BE;

  --
  -- Unpacking.
  --

  procedure Unpack_32_BE
    (Input  : in     Unsigned_32_Packed_t;
     Output :    out Unsigned_32_t)
  is
    Output_Copy : Interfaces.Unsigned_32;
  begin
    Output_Copy := 0;

    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (1));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (2));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (3));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (4));

    Output := Unsigned_32_t (Output_Copy);
  end Unpack_32_BE;

  procedure Unpack_32_LE
    (Input  : in     Unsigned_32_Packed_t;
     Output :    out Unsigned_32_t)
  is
    Output_Copy : Interfaces.Unsigned_32;
  begin
    Output_Copy := 0;

    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (4));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (3));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (2));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_32 (Input (1));

    Output := Unsigned_32_t (Output_Copy);
  end Unpack_32_LE;

  --
  -- Read/Write attributes.
  --

  procedure Attribute_Write_32_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Unsigned_32_t)
  is
    subtype Source_t is Unsigned_32_Packed_t;
    subtype Target_t is Ada.Streams.Stream_Element_Array (1 .. 4);

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Unsigned_32_Packed_t;
  begin
    Pack_32_BE (Item, Packed);
    Ada.Streams.Write
      (Stream => Stream.all,
       Item   => Convert (Packed));
  end Attribute_Write_32_BE;

  procedure Attribute_Read_32_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unsigned_32_t)
  is
    subtype Source_t is Ada.Streams.Stream_Element_Array (1 .. 4);
    subtype Target_t is Unsigned_32_Packed_t;

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Source_t;
    Last   : Ada.Streams.Stream_Element_Offset;
  begin
    Ada.Streams.Read
      (Stream => Stream.all,
       Item   => Packed,
       Last   => Last);
    if Last /= 4 then
      raise Constraint_Error;
    end if;
    Unpack_32_BE
      (Input  => Convert (Packed),
       Output => Item);
  end Attribute_Read_32_BE;

  --
  -- 64
  --

  --
  -- Packing.
  --

  procedure Pack_64_LE
    (Input  : in     Unsigned_64_t;
     Output :    out Unsigned_64_Packed_t)
  is
    Input_Copy : Interfaces.Unsigned_64;
  begin
    Input_Copy := Interfaces.Unsigned_64 (Input);

    Output (1) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (2) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (3) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (4) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (5) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (6) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (7) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (8) := Unsigned_8_t (Input_Copy and 16#ff#);
  end Pack_64_LE;

  procedure Pack_64_BE
    (Input  : in     Unsigned_64_t;
     Output :    out Unsigned_64_Packed_t)
  is
    Input_Copy : Interfaces.Unsigned_64;
  begin
    Input_Copy := Interfaces.Unsigned_64 (Input);

    Output (8) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (7) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (6) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (5) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (4) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (3) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (2) := Unsigned_8_t (Input_Copy and 16#ff#);
    Input_Copy := Interfaces.Shift_Right (Input_Copy, 8);
    Output (1) := Unsigned_8_t (Input_Copy and 16#ff#);
  end Pack_64_BE;

  --
  -- Unpacking.
  --

  procedure Unpack_64_BE
    (Input  : in     Unsigned_64_Packed_t;
     Output :    out Unsigned_64_t)
  is
    Output_Copy : Interfaces.Unsigned_64;
  begin
    Output_Copy := 0;

    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (1));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (2));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (3));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (4));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (5));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (6));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (7));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (8));

    Output := Unsigned_64_t (Output_Copy);
  end Unpack_64_BE;

  procedure Unpack_64_LE
    (Input  : in     Unsigned_64_Packed_t;
     Output :    out Unsigned_64_t)
  is
    Output_Copy : Interfaces.Unsigned_64;
  begin
    Output_Copy := 0;

    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (8));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (7));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (6));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (5));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (4));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (3));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (2));
    Output_Copy := Interfaces.Shift_Left (Output_Copy, 8);
    Output_Copy := Output_Copy + Interfaces.Unsigned_64 (Input (1));

    Output := Unsigned_64_t (Output_Copy);
  end Unpack_64_LE;

  --
  -- Read/Write attributes.
  --

  procedure Attribute_Write_64_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Unsigned_64_t)
  is
    subtype Source_t is Unsigned_64_Packed_t;
    subtype Target_t is Ada.Streams.Stream_Element_Array (1 .. 8);

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Unsigned_64_Packed_t;
  begin
    Pack_64_BE (Item, Packed);
    Ada.Streams.Write
      (Stream => Stream.all,
       Item   => Convert (Packed));
  end Attribute_Write_64_BE;

  procedure Attribute_Read_64_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unsigned_64_t)
  is
    subtype Source_t is Ada.Streams.Stream_Element_Array (1 .. 8);
    subtype Target_t is Unsigned_64_Packed_t;

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Source_t;
    Last   : Ada.Streams.Stream_Element_Offset;
  begin
    Ada.Streams.Read
      (Stream => Stream.all,
       Item   => Packed,
       Last   => Last);
    if Last /= 8 then
      raise Constraint_Error;
    end if;
    Unpack_64_BE
      (Input  => Convert (Packed),
       Output => Item);
  end Attribute_Read_64_BE;

  --
  -- Float_32
  --

  function Float_To_Integer_32 is new Ada.Unchecked_Conversion
    (Source => Float_32_t,
     Target => Unsigned_32_t);

  function Integer_32_To_Float is new Ada.Unchecked_Conversion
    (Source => Unsigned_32_t,
     Target => Float_32_t);

  procedure Pack_Float_32_BE
    (Input  : in     Float_32_t;
     Output :    out Unsigned_32_Packed_t) is
  begin
    Pack_32_BE
      (Input  => Float_To_Integer_32 (Input),
       Output => Output);
  end Pack_Float_32_BE;

  procedure Pack_Float_32_LE
    (Input  : in     Float_32_t;
     Output :    out Unsigned_32_Packed_t) is
  begin
    Pack_32_LE
      (Input  => Float_To_Integer_32 (Input),
       Output => Output);
  end Pack_Float_32_LE;

  procedure Unpack_Float_32_BE
    (Input  : in     Unsigned_32_Packed_t;
     Output :    out Float_32_t)
  is
    Temporary : Unsigned_32_t;
  begin
    Unpack_32_BE
      (Input  => Input,
       Output => Temporary);
    Output := Integer_32_To_Float (Temporary);
  end Unpack_Float_32_BE;

  procedure Unpack_Float_32_LE
    (Input  : in     Unsigned_32_Packed_t;
     Output :    out Float_32_t)
  is
    Temporary : Unsigned_32_t;
  begin
    Unpack_32_LE
      (Input  => Input,
       Output => Temporary);
    Output := Integer_32_To_Float (Temporary);
  end Unpack_Float_32_LE;

  procedure Attribute_Write_Float_32_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Float_32_t)
  is
    subtype Source_t is Unsigned_32_Packed_t;
    subtype Target_t is Ada.Streams.Stream_Element_Array (1 .. 4);

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Unsigned_32_Packed_t;
  begin
    Pack_Float_32_BE (Item, Packed);
    Ada.Streams.Write
      (Stream => Stream.all,
       Item   => Convert (Packed));
  end Attribute_Write_Float_32_BE;

  procedure Attribute_Read_Float_32_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Float_32_t)
  is
    subtype Source_t is Ada.Streams.Stream_Element_Array (1 .. 4);
    subtype Target_t is Unsigned_32_Packed_t;

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Source_t;
    Last   : Ada.Streams.Stream_Element_Offset;
  begin
    Ada.Streams.Read
      (Stream => Stream.all,
       Item   => Packed,
       Last   => Last);
    if Last /= 4 then
      raise Constraint_Error;
    end if;
    Unpack_Float_32_BE
      (Input  => Convert (Packed),
       Output => Item);
  end Attribute_Read_Float_32_BE;

  --
  -- Float_64
  --

  function Float_To_Integer_64 is new Ada.Unchecked_Conversion
    (Source => Float_64_t,
     Target => Unsigned_64_t);

  function Integer_64_To_Float is new Ada.Unchecked_Conversion
    (Source => Unsigned_64_t,
     Target => Float_64_t);

  procedure Pack_Float_64_BE
    (Input  : in     Float_64_t;
     Output :    out Unsigned_64_Packed_t) is
  begin
    Pack_64_BE
      (Input  => Float_To_Integer_64 (Input),
       Output => Output);
  end Pack_Float_64_BE;

  procedure Pack_Float_64_LE
    (Input  : in     Float_64_t;
     Output :    out Unsigned_64_Packed_t) is
  begin
    Pack_64_LE
      (Input  => Float_To_Integer_64 (Input),
       Output => Output);
  end Pack_Float_64_LE;

  procedure Unpack_Float_64_BE
    (Input  : in     Unsigned_64_Packed_t;
     Output :    out Float_64_t)
  is
    Temporary : Unsigned_64_t;
  begin
    Unpack_64_BE
      (Input  => Input,
       Output => Temporary);
    Output := Integer_64_To_Float (Temporary);
  end Unpack_Float_64_BE;

  procedure Unpack_Float_64_LE
    (Input  : in     Unsigned_64_Packed_t;
     Output :    out Float_64_t)
  is
    Temporary : Unsigned_64_t;
  begin
    Unpack_64_LE
      (Input  => Input,
       Output => Temporary);
    Output := Integer_64_To_Float (Temporary);
  end Unpack_Float_64_LE;

  procedure Attribute_Write_Float_64_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Float_64_t)
  is
    subtype Source_t is Unsigned_64_Packed_t;
    subtype Target_t is Ada.Streams.Stream_Element_Array (1 .. 8);

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Unsigned_64_Packed_t;
  begin
    Pack_Float_64_BE (Item, Packed);
    Ada.Streams.Write
      (Stream => Stream.all,
       Item   => Convert (Packed));
  end Attribute_Write_Float_64_BE;

  procedure Attribute_Read_Float_64_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Float_64_t)
  is
    subtype Source_t is Ada.Streams.Stream_Element_Array (1 .. 8);
    subtype Target_t is Unsigned_64_Packed_t;

    function Convert is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Packed : Source_t;
    Last   : Ada.Streams.Stream_Element_Offset;
  begin
    Ada.Streams.Read
      (Stream => Stream.all,
       Item   => Packed,
       Last   => Last);
    if Last /= 8 then
      raise Constraint_Error;
    end if;
    Unpack_Float_64_BE
      (Input  => Convert (Packed),
       Output => Item);
  end Attribute_Read_Float_64_BE;

  --
  -- Optional data element package.
  --

  package body Optional_Element is

    procedure Data_Attribute_Write
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Item   : in Data_t) is
    begin
      if Item.Present then
        Attribute_Write_32_BE (Stream, 1);
        Data_Type'Write (Stream, Item.Contents);
      else
        Attribute_Write_32_BE (Stream, 0);
      end if;
    end Data_Attribute_Write;

    procedure Data_Attribute_Read
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Item   : out Data_t)
    is
      use type Unsigned_32_t;
      Temporary_Present : Unsigned_32_t;
    begin
      Unsigned_32_t'Read (Stream, Temporary_Present);
      if Temporary_Present >= 1 then
        Item.Present := True;
        Data_Type'Read (Stream, Item.Contents);
      else
        Item.Present := False;
      end if;
    end Data_Attribute_Read;

  end Optional_Element;

  --
  -- UTF8_String
  --

  package UTF8_Encode is new GNAT.Encode_String
    (Encoding_Method => System.WCh_Con.WCEM_UTF8);

  package UTF8_Decode is new GNAT.Decode_String
    (Encoding_Method => System.WCh_Con.WCEM_UTF8);

  -- Encode Item to UTF8 and write to Stream.
  procedure UTF8_String_Attribute_Output
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in UTF8_String_t)
  is
    Temporary : constant String := UTF8_Encode.Encode_Wide_String (Wide_String (Item));
  begin
    -- Write lower bound of original string.
    Attribute_Write_32_BE (Stream, Item'First);

    -- Write upper bound of original string.
    Attribute_Write_32_BE (Stream, Item'Last);

    -- Write length of encoded data to stream.
    Attribute_Write_32_BE (Stream, Temporary'Length);

    -- Write encoded data to stream.
    String'Write (Stream, Temporary);
  end UTF8_String_Attribute_Output;

  -- Decoded UTF8 data from Stream, saving into Item.
  procedure UTF8_String_Attribute_Read
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out UTF8_String_t)
  is
    Length : Unsigned_32_t;
    First  : Unsigned_32_t;
    Last   : Unsigned_32_t;
  begin
    -- Read lower bound of original string.
    Attribute_Read_32_BE (Stream, First);

    if Item'First /= First then
      raise Constraint_Error with "lower bound mismatch";
    end if;

    -- Read upper bound of original string.
    Attribute_Read_32_BE (Stream, Last);

    if Item'Last /= Last then
      raise Constraint_Error with "upper bound mismatch";
    end if;

    -- Read length of encoded data from stream.
    Attribute_Read_32_BE (Stream, Length);

    declare
      subtype Input_UTF8_Data_t is String (1 .. Positive (Length));
      UTF8_Data : Input_UTF8_Data_t;
    begin
      Input_UTF8_Data_t'Read (Stream, UTF8_Data);
      Item := UTF8_String_t (UTF8_Decode.Decode_Wide_String (UTF8_Data));
    end;
  end UTF8_String_Attribute_Read;

  -- Return decoded UTF8 data from Stream.
  function UTF8_String_Attribute_Input
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class)
      return UTF8_String_t
  is
    Length : Unsigned_32_t;
    First  : Unsigned_32_t;
    Last   : Unsigned_32_t;
  begin
    -- Read lower bound of original string.
    Attribute_Read_32_BE (Stream, First);

    -- Read upper bound of original string.
    Attribute_Read_32_BE (Stream, Last);

    -- Read length of encoded data from stream.
    Attribute_Read_32_BE (Stream, Length);

    declare
      subtype Input_UTF8_Data_t is String (1 .. Positive (Length));
      UTF8_Data : Input_UTF8_Data_t;
    begin
      Input_UTF8_Data_t'Read (Stream, UTF8_Data);
      return UTF8_String_t (UTF8_Decode.Decode_Wide_String (UTF8_Data));
    end;
  end UTF8_String_Attribute_Input;

  --
  -- Enumeration IO.
  --

  package body Serializable_Enumeration is

    procedure Data_Attribute_Write
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Item   : in Data_t) is
    begin
      Attribute_Write_32_BE
        (Stream => Stream,
         Item   => Data_t'Pos (Item));
    end Data_Attribute_Write;

    procedure Data_Attribute_Read
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Item   : out Data_t)
    is
      Temporary : Unsigned_32_t;
    begin
      Attribute_Read_32_BE
        (Stream => Stream,
         Item   => Temporary);
      Item := Data_t'Val (Temporary);
    end Data_Attribute_Read;

  end Serializable_Enumeration;

end Serial_IO;
