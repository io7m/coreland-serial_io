with Ada.Streams;
with Interfaces;

package Serial_IO is

  --
  -- 8
  --

  type Unsigned_8_t is mod 2 ** 8;
  for  Unsigned_8_t'Size use 8;
  for  Unsigned_8_t'Alignment use 8;

  --
  -- 16
  --

  type Unsigned_16_t is new Interfaces.Unsigned_16;
  type Unsigned_16_Packed_Index_t is range 1 .. 2;
  type Unsigned_16_Packed_t is array (Unsigned_16_Packed_Index_t) of Unsigned_8_t;
  pragma Pack (Unsigned_16_Packed_t);

  procedure Pack_16_BE
    (Input  : in     Unsigned_16_t;
     Output :    out Unsigned_16_Packed_t);

  procedure Pack_16_LE
    (Input  : in     Unsigned_16_t;
     Output :    out Unsigned_16_Packed_t);

  procedure Unpack_16_BE
    (Input  : in     Unsigned_16_Packed_t;
     Output :    out Unsigned_16_t);

  procedure Unpack_16_LE
    (Input  : in     Unsigned_16_Packed_t;
     Output :    out Unsigned_16_t);

  procedure Attribute_Write_16_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Unsigned_16_t);

  procedure Attribute_Read_16_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unsigned_16_t);

  for Unsigned_16_t'Write use Attribute_Write_16_BE;
  for Unsigned_16_t'Read  use Attribute_Read_16_BE;

  --
  -- 32
  --

  type Unsigned_32_t is new Interfaces.Unsigned_32;
  type Unsigned_32_Packed_Index_t is range 1 .. 4;
  type Unsigned_32_Packed_t is array (Unsigned_32_Packed_Index_t) of Unsigned_8_t;
  pragma Pack (Unsigned_32_Packed_t);

  procedure Pack_32_BE
    (Input  : in     Unsigned_32_t;
     Output :    out Unsigned_32_Packed_t);

  procedure Pack_32_LE
    (Input  : in     Unsigned_32_t;
     Output :    out Unsigned_32_Packed_t);

  procedure Unpack_32_BE
    (Input  : in     Unsigned_32_Packed_t;
     Output :    out Unsigned_32_t);

  procedure Unpack_32_LE
    (Input  : in     Unsigned_32_Packed_t;
     Output :    out Unsigned_32_t);

  procedure Attribute_Write_32_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Unsigned_32_t);

  procedure Attribute_Read_32_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unsigned_32_t);

  for Unsigned_32_t'Write use Attribute_Write_32_BE;
  for Unsigned_32_t'Read  use Attribute_Read_32_BE;

  --
  -- 64
  --

  type Unsigned_64_t is new Interfaces.Unsigned_64;
  type Unsigned_64_Packed_Index_t is range 1 .. 8;
  type Unsigned_64_Packed_t is array (Unsigned_64_Packed_Index_t) of Unsigned_8_t;
  pragma Pack (Unsigned_64_Packed_t);

  procedure Pack_64_BE
    (Input  : in     Unsigned_64_t;
     Output :    out Unsigned_64_Packed_t);

  procedure Pack_64_LE
    (Input  : in     Unsigned_64_t;
     Output :    out Unsigned_64_Packed_t);

  procedure Unpack_64_BE
    (Input  : in     Unsigned_64_Packed_t;
     Output :    out Unsigned_64_t);

  procedure Unpack_64_LE
    (Input  : in     Unsigned_64_Packed_t;
     Output :    out Unsigned_64_t);

  procedure Attribute_Write_64_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in Unsigned_64_t);

  procedure Attribute_Read_64_BE
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unsigned_64_t);

  for Unsigned_64_t'Write use Attribute_Write_64_BE;
  for Unsigned_64_t'Read  use Attribute_Read_64_BE;

  --
  -- UTF-8 encoded Wide_String type.
  --

  subtype UTF8_String_Size_t  is Unsigned_32_t;
  subtype UTF8_String_Index_t is UTF8_String_Size_t range 1 .. UTF8_String_Size_t'Last;
  type    UTF8_String_t is array (UTF8_String_Index_t range <>) of Wide_Character;
  pragma Pack (UTF8_String_t);

  procedure UTF8_String_Attribute_Output
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in UTF8_String_t);

  procedure UTF8_String_Attribute_Write
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : in UTF8_String_t)
    renames UTF8_String_Attribute_Output;

  procedure UTF8_String_Attribute_Read
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out UTF8_String_t);

  function UTF8_String_Attribute_Input
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class)
      return UTF8_String_t;

  for UTF8_String_t'Output use UTF8_String_Attribute_Output;
  for UTF8_String_t'Write  use UTF8_String_Attribute_Write;
  for UTF8_String_t'Input  use UTF8_String_Attribute_Input;
  for UTF8_String_t'Read   use UTF8_String_Attribute_Read;

  --
  -- Serializable UTF-8 bounded string type.
  --

  generic
    First : UTF8_String_Index_t;
    Last  : UTF8_String_Index_t;

  package Serializable_Bounded is

    subtype Index_t  is UTF8_String_Index_t range First .. Last;
    subtype String_t is UTF8_String_t (UTF8_String_Index_t);

    type Data_t is record
      Data : String_t;
      Used : Index_t;
    end record;

  end Serializable_Bounded;

  --
  -- Optional data element.
  --

  generic
    type Data_Type is private;

  package Optional_Element is

    type Data_t is record
      Present  : Boolean;
      Contents : Data_Type;
    end record;

    procedure Data_Attribute_Write
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Item   : in Data_t);

    procedure Data_Attribute_Read
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Item   : out Data_t);

    for Data_t'Read use Data_Attribute_Read;
    for Data_t'Write use Data_Attribute_Write;

  end Optional_Element;

end Serial_IO;
