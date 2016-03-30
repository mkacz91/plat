class Timer
{
   int   prevMillis;
   int   actMillis;
   float ratio;
   float prevTime;
   float time;
   float dt;
   
   Timer()
   {
      ratio     = 0.001;
      actMillis = millis();
      time      = ratio * float(actMillis);
      dt        = 0.0;
   }
   
   void Think()
   {
      prevMillis = actMillis;
      prevTime   = time;
      
      actMillis = millis();
      time      = ratio * float(actMillis);
      dt        = time - prevTime;
   }
};
