class Tile
{
   int  type;
   byte flags;
   
   Tile()
   {/* Do nothing. */}
   
   Tile(int _type, byte _flags)
   {
      type  = _type;
      flags = _flags;
   }
   
   static final byte SOLID_LEFT   = 0x01;
   static final byte SOLID_RIGHT  = 0x02;
   static final byte SOLID_TOP    = 0x04;
   static final byte SOLID_BOTTOM = 0x08;
}
