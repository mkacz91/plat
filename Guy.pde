final byte COL_LEFT   = 0x01;
final byte COL_RIGHT  = 0x02;
final byte COL_TOP    = 0x04;
final byte COL_BOTTOM = 0x08;
final byte COL_HORIZ  = 0x10;
final byte COL_VERT   = 0x20;

class Guy
{
   PVector pos;
   PVector vel;
   float   w;
   float   h;
   Frame   frame;
   color   bodyColor;
   boolean jumpAllowed;
   
   Guy(float _x, float _y, float _w, float _h, color _bodyColor)
   {
      pos       = new PVector(_x, _y);
      vel       = new PVector();
      w         = _w;
      h         = _h;
      frame     = new Frame(pos, w, h);
      bodyColor = _bodyColor;
      jumpAllowed = true;
   }
   
   void Think()
   {
      PVector acc = new PVector(world.gravAccel.x, world.gravAccel.y);
      
      if(input.keyboard.CodedKeyState(LEFT )) acc.x -= 600.0;
      if(input.keyboard.CodedKeyState(RIGHT)) acc.x += 600.0;
      if(jumpAllowed && input.keyboard.CodedKeyState(UP))
      {
         vel.y      -= 550.0;
         jumpAllowed = false;
      }
      
      acc.mult(timer.dt);
      vel.add(acc);
      vel.limit(450.0);
      pos.add(PVector.mult(vel, timer.dt));
      frame.SetCenter(pos, w, h);
      
      if(pos.x < -world.tileMap.tileWidth)
      {
         pos.x = -world.tileMap.tileWidth;
         vel.x = 0.0;
      }
      
      if(pos.x > world.tileMap.tileWidth * (world.tileMap.mapWidth + 1))
      {
         pos.x = world.tileMap.tileWidth  * (world.tileMap.mapWidth + 1);
         vel.x = 0.0;
      }
      
      if(pos.y < -world.tileMap.tileHeight)
      {
         pos.y = -world.tileMap.tileHeight;
         vel.y = 0.0;
      }
      
      if(pos.y > world.tileMap.tileHeight * (world.tileMap.mapHeight + 1)) 
      {
         pos.y       = world.tileMap.tileHeight * (world.tileMap.mapHeight + 1);
         vel.y       = 0.0;
         jumpAllowed = true;
      }
      
      int xMap    = world.tileMap.TransXBound(frame.l);
      int yMapBeg = world.tileMap.TransYBound(frame.t);
      int xMapEnd = world.tileMap.TransXBound(frame.r);
      int yMapEnd = world.tileMap.TransYBound(frame.b);
      
      int yMap;
      while(xMap <= xMapEnd)
      {
         yMap = yMapBeg;
         while(yMap <= yMapEnd)
         {
            if(world.tileMap.tiles[xMap][yMap].type == 1)
               Collide(world.tileMap.GetFrame(xMap, yMap), world.tileMap.tiles[xMap][yMap].flags);
               
            ++yMap;
         }
         
         ++xMap;
      }
      
      vel.x *= 0.95;
   }
   
   void Display(Camera cam)
   {
      noStroke();
      fill(bodyColor);
      rect(frame.l - cam.frame.l, frame.t - cam.frame.t, w, h);
   }
   
   void MoveBy(PVector dis)
   {
      pos.add(dis);
      frame.SetCenter(pos, w, h);
   }
   
   boolean Collide(Frame obstFrame, byte obstFlags)
   {
      Frame colFrame = new Frame();
      byte  colFlags = 0x00;
      
      if(frame.l > obstFrame.r) return false;
      if(frame.t > obstFrame.b) return false;
      if(frame.r < obstFrame.l) return false;
      if(frame.b < obstFrame.t) return false;
      
      if(frame.l > obstFrame.l && vel.x < 0.0)
      {
         colFrame.l = frame.l;
         if((obstFlags & Tile.SOLID_RIGHT) != 0) colFlags |= COL_LEFT | COL_HORIZ;
      }
      else colFrame.l = obstFrame.l;
      
      if(frame.t > obstFrame.t && vel.y < 0.0)
      {
         colFrame.t = frame.t;
         if((obstFlags & Tile.SOLID_BOTTOM) != 0) colFlags |= COL_TOP | COL_VERT;
      }
      else colFrame.t = obstFrame.t;
      
      if(frame.r < obstFrame.r && vel.x > 0.0)
      {
         colFrame.r = frame.r;
         if((obstFlags & Tile.SOLID_LEFT) != 0) colFlags |= COL_RIGHT | COL_HORIZ;
      }
      else colFrame.r = obstFrame.r;
      
      if(frame.b < obstFrame.b && vel.y > 0.0)
      {
         colFrame.b = frame.b;
         if((obstFlags & Tile.SOLID_TOP) != 0) colFlags |= COL_BOTTOM | COL_VERT;
      }
      else colFrame.b = obstFrame.b;
      
      float colHorizDepth = colFrame.r - colFrame.l;
      float colVertDepth  = colFrame.b - colFrame.t;
      float colHorizTime  = ((colFlags & COL_HORIZ) != 0 ? abs(colHorizDepth / vel.x) : INFTY);
      float colVertTime   = ((colFlags & COL_VERT ) != 0 ? abs(colVertDepth  / vel.y) : INFTY);
      
      if(colHorizTime < colVertTime)
      {
         vel.x = 0.0;
         if((colFlags & COL_LEFT) != 0) pos.x += colHorizDepth;
         else                           pos.x -= colHorizDepth;
      }
      else if(colVertTime < colHorizTime)
      {
         vel.y = 0.0;
         if((colFlags & COL_TOP) != 0) pos.y += colVertDepth;
         else
         {
            pos.y      -= colVertDepth;
            jumpAllowed = true;
         }
      }
      
      return true;
   }
};
