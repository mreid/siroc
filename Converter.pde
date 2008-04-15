/**
 * Implements conversions between ROC points to SI lines, etc.
 */
class Converter {
  
  float pi = 0.5;
  
  Point rocToSi(Line rocLine) {
    return new Point();
  }
  
  Line rocToSi(Point rocPoint) {
    float fn = 1 - rocPoint.y;
    float fp = rocPoint.x;
    
    return new Line(1, -1*((1-pi)*fp - pi*fn), -pi*fn);
  }
}
