class World
{
   color   voidColor;
   TileSet tileSet;
   TileMap tileMap;
   PVector gravAccel;
   
   World()
   {
      voidColor = #000000;
      tileSet   = new TileSet("tileset.txt");
      tileMap   = new TileMap("tilemap.txt");
      gravAccel = new PVector(0.0, 500.0);
   }
   
   void Display(Camera cam)
   {
      background(voidColor);
      tileMap.Display(cam, tileSet);
   }
};
