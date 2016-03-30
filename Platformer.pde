Timer  timer;
Input  input;
World  world;
Camera mainCam;
Guy    guy;

final float INFTY = 3.40282347E+38;

void setup()
{
   size(620, 480);
   rectMode(CORNER);
   noSmooth();

   timer   = new Timer();
   input   = new Input();
   world   = new World();
   mainCam = new Camera();
   
   guy = new Guy(0, 0, 20, 30, #9562A5);
   mainCam.SetFocus(guy.pos);
}

void draw()
{
   timer.Think();
   mainCam.Think();

   world.Display(mainCam);
   guy.Think();
   guy.Display(mainCam);
}

boolean abort(boolean val, String msg)
{
   println("aborting: " + msg);
   return false;
}
