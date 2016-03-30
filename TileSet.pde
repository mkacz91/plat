class TileSet
{
   color[] tiles;
   
   TileSet(int _size)
   {
      tiles = new color[_size];
   }
   
   TileSet(String filename)
   {
      if(!Load(filename))
      {
         tiles = new color[0];
      }
   }
   
   boolean Load(String filename)
   {
      String[] lines = loadStrings(filename);
      if(lines.length < 3)      return abort(false, filename + " is too short.");
      //if(lines[0] != "TILESET") return abort(false, filename + " is not a tileset, but a " + lines[0] + ".");
      
      tiles = new color[int(lines[1])];
      if(lines.length < tiles.length + 2) return abort(false, filename + " has too few color entries.");
      
      String[] tokens;
      for(int t = 0; t < tiles.length; ++t)
      {
         tokens = splitTokens(lines[t + 2]);
         if(tokens.length < 3) return abort(false, filename + " contains incomplete color entry.");
         tiles[t] = color(int(tokens[0]), int(tokens[1]), int(tokens[2]));
      }
      print("\n");
      return true;
   }
};
