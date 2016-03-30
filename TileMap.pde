class TileMap
{
   int   mapWidth;
   int   mapHeight;
   float tileWidth;
   float tileHeight;

   Tile[][] tiles;

   TileMap(int _mapWidth, int _mapHeight, float _tileWidth, float _tileHeight)
   {
      Set(_mapWidth, _mapHeight, _tileWidth, _tileHeight);
   }

   TileMap(String filename)
   {
      if(!Load(filename))
      {
         Set(0, 0, 0, 0);
      }
   }

   TileMap()
   {
      Set(0, 0, 0, 0);
   }
   
   void Set(int _mapWidth, int _mapHeight, float _tileWidth, float _tileHeight)
   {
      mapWidth   = _mapWidth;
      mapHeight  = _mapHeight;
      tileWidth  = _tileWidth;
      tileHeight = _tileHeight;
      tiles      = new Tile[mapWidth][mapHeight];
      
      for(int x = 0; x < mapWidth; ++x)
         for(int y = 0; y < mapHeight; ++y)
            tiles[x][y] = new Tile();
   }

   boolean Load(String filename)
   {
      String lines[] = loadStrings(filename);
      if(lines.length < 6)      return abort(false, filename + " is to short.");
      //if(lines[0] != "TILEMAP") return abort(false, filename + " is not a tilemap, but a " + lines[0] + ".");

      int ln = 1;
      Set(int(lines[ln++]), int(lines[ln++]), float(lines[ln++]), float(lines[ln++]));
      if(lines.length - ln < mapHeight) return abort(false, filename + " has to few row entries.");

      int y = 0;
      while(ln < lines.length)
      {
         if(lines[ln].length() < mapWidth) return abort(false, filename + " - row " + y + " is too short");
         for(int x = 0; x < mapWidth; ++x)
            tiles[x][y].type = int(lines[ln].charAt(x) + "");

         ++ln;
         ++y;
      }
      
      GenObstFlags(1);

      return true;
   }
   
   void GenObstFlags(int solid)
   {
      for(int x = 0; x < mapWidth; ++x)
         for(int y = 0; y < mapHeight; ++y)
            if(tiles[x][y].type == solid)
            {
               if(x     >= 0         && tiles[x - 1][y    ].type != solid) tiles[x][y].flags |= Tile.SOLID_LEFT;
               if(x + 1 <  mapWidth  && tiles[x + 1][y    ].type != solid) tiles[x][y].flags |= Tile.SOLID_RIGHT;
               if(y     >= 0         && tiles[x    ][y - 1].type != solid) tiles[x][y].flags |= Tile.SOLID_TOP;
               if(y + 1 <  mapHeight && tiles[x    ][y + 1].type != solid) tiles[x][y].flags |= Tile.SOLID_BOTTOM;
            }
   }

   Frame GetFrame(int x, int y)
   {
      if(x < 0 || x >= mapWidth || y < 0 || y >= mapHeight) return null;
      return new Frame(x * tileWidth, y * tileHeight, (x + 1) * tileWidth, (y + 1) * tileHeight); 
   }

   int TransX(float x)
   {
      return int(x / tileWidth);
   }

   int TransY(float y)
   {
      return int(y / tileHeight);
   }
   
   int TransXBound(float x)
   {
      int res = TransX(x);
      if(res <  0)        return 0;
      if(res >= mapWidth) return mapWidth - 1;
      return res;
   }
   
   int TransYBound(float y)
   {
      int res = TransY(y);
      if(res <  0)         return 0;
      if(res >= mapHeight) return mapHeight - 1;
      return res;
   }

   void Display(Camera cam, TileSet tileSet)
   {
      int xMap    = TransXBound(cam.frame.l);
      int yMapBeg = TransYBound(cam.frame.t);
      int xMapEnd = TransXBound(cam.frame.r);
      int yMapEnd = TransYBound(cam.frame.b);

      float xScr    = xMap * tileWidth - cam.frame.l;
      float yScrBeg = yMapBeg * tileHeight - cam.frame.t;
      float yScr;
      int   yMap;
      
      noStroke();
      while(xMap <= xMapEnd)
      {
         yMap = yMapBeg;
         yScr = yScrBeg;
         while(yMap <= yMapEnd)
         {
            fill(tileSet.tiles[tiles[xMap][yMap].type]);
            rect(xScr, yScr, tileWidth, tileHeight);
            
            ++yMap;
            yScr += tileHeight;
         }

         ++xMap;
         xScr += tileWidth;
      }
   }
};

