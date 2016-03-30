class Camera
{
   PVector pos;
   PVector vel;
   Frame   frame;
   
   Camera(PVector _pos)
   {
      pos = _pos;
      vel = new PVector();
   }
   
   Camera()
   {
      pos   = new PVector(0, 0);
      vel   = new PVector(0, 0);
      frame = new Frame(pos, width, height);
   }
   
   void SetFocus(PVector _focus)
   {
      focus = _focus;
   }
   
   void Think()
   {
      if(focus != null)
      {
         //PVector acc = new PVector();
         
         vel = PVector.sub(focus, pos);
         /*if(input.keyboard.CodedKeyState(LEFT )) acc.x -= 400.0;
         if(input.keyboard.CodedKeyState(RIGHT)) acc.x += 400.0;
         if(input.keyboard.CodedKeyState(UP   )) acc.y -= 400.0;
         if(input.keyboard.CodedKeyState(DOWN )) acc.y += 400.0;*/
         
         //acc.mult(timer.dt);
         //vel.add(acc);
         //vel.limit(300.0);
         pos.add(PVector.mult(vel, timer.dt));
         frame.SetCenter(pos, width, height);
         
         //vel.mult(0.99);
      }
   }
   
   private PVector focus;
};
