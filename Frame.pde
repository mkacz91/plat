class Frame
{
   float l;
   float t;
   float r;
   float b;
   
   Frame()
   {/* Do nothhing */}
   
   Frame(float _l, float _t, float _r, float _b)
   {
      Set(_l, _t, _r, _b);
   }
   
   Frame(PVector center, float w, float h)
   {
      SetCenter(center, w, h);
   }
   
   void Set(float _l, float _t, float _r, float _b)
   {
      l = _l;
      t = _t;
      r = _r;
      b = _b;
   }
   
   void SetCenter(PVector center, float w, float h)
   {
      l = center.x - 0.5 * w;
      t = center.y - 0.5 * h;
      r = l + w;
      b = t + h;
   }
   
   void add(PVector v)
   {
      l += v.x;
      t += v.y;
      r += v.x;
      b += v.y;
   }
   
   void sub(PVector v)
   {
      l -= v.x;
      t -= v.y;
      r -= v.x;
      b -= v.y;
   }
};
