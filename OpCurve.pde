class OpCurve {
  int size = 2;
  float[] fpr = new float[size];
  float[] tpr = new float[size];

  OpCurve() {
   fpr[0] = 0.0; tpr[0] = 0.0;
   fpr[1] = 1.0; tpr[1] = 1.0; 
  }
  
  // Add a new ROC point to this curve
  void add(float newfpr, float newtpr) {
    // Ensure the arrays are large enough for a new point
    if(size == fpr.length) { fpr = expand(tpr); tpr = expand(tpr); }
    
    // Shift the last point up one in the array
    fpr[size] = fpr[size-1];
    tpr[size] = tpr[size-1];
    
    // Add the new coordinates
    fpr[size-1] = newfpr;
    tpr[size-1] = newtpr;
    
    size++;
  }
  
  RShape toShape() {
    s = new RShape();
  
    s.addMoveTo(fpr[0], tpr[0]);
    for(int i = 1 ; i < size ; i++) {
      s.addLineTo(fpr[i], tpr[i]);
    }
    
    return s; 
  }
}

