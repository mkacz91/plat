class Input
{
   Keyboard keyboard;
   
   Input()
   {
      keyboard = new Keyboard();
   }
   
   static final int keyCnt   = 256;
   static final int codedCnt = 256;
};

static class Keyboard
{
   boolean KeyState(int k)
   {
      return keys[k];
   }
   
   boolean CodedKeyState(int k)
   {
      return coded[k];
   }
   
   static final int         keyCnt   = 256;
   static final int         codedCnt = 1024;
   private static boolean[] keys     = new boolean[keyCnt];
   private static boolean[] coded    = new boolean[codedCnt];
};

void keyPressed()
{
   if(key == CODED) Keyboard.coded[keyCode] = true;
   else             Keyboard.keys [key    ] = true;
}

void keyReleased()
{
   if(key == CODED) Keyboard.coded[keyCode] = false;
   else             Keyboard.keys [key    ] = false;
}
