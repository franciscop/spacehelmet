// Handle the detections 
class Scene {
  int[] pix;
  // Load all the pixels  
  Scene (int[] allpix) {  
    pix = allpix;
    }
  
  Coor[] find(Shape newShape)
    {
    pix = filterColor(pix, newShape.baseColor, newShape.margin);
    
    Coor[] test = new Coor[2];
    
    int x = getCoor(pix, 'x');
    int y = getCoor(pix, 'y');
    
    Coor a = new Coor(x, y);
    
    test[0] = a;
    test[1] = a;
    
    return test;
    }
  
  void put(Coor[] positions)
    {
    for (int num = 0; num < positions.length; num++)
      {
      int pos = positions[num].y * width + positions[num].x;
      
      pix[pos] = color(255, 0, 0);
      pix[pos - 1] = color(255, 0, 0);
      pix[pos - 2] = color(255, 0, 0);
      pix[pos + 1] = color(255, 0, 0);
      pix[pos + 2] = color(255, 0, 0);
      pix[pos - 1 * width] = color(255, 0, 0);
      pix[pos - 2 * width] = color(255, 0, 0);
      pix[pos + 1 * width] = color(255, 0, 0);
      pix[pos + 2 * width] = color(255, 0, 0);
      }
    }
  
  // Filter the image for black or white
  int[] filterColor(int pixels[], color filterColor, int margin)
    {
    int[] newpixels = new int[pixels.length];
    
    for (int i = 0; i < pixels.length; i++)
      {
      newpixels[i] = color(getColor(pixels[i], filterColor, margin));
      }
    
    return newpixels;
    }
  
  // Find if the pixel passed is in range or not
  int getColor(color pixel, color filterColor, int margin) {
    color capture = filterColor; 
    
    if (red(pixel) > red(capture) - margin &&
        red(pixel) < red(capture) + margin &&
        green(pixel) > green(capture) - margin &&
        green(pixel) < green(capture) + margin &&
        blue(pixel) > blue(capture) - margin &&
        blue(pixel) < blue(capture) + margin
        ) {
      return 255;
      }
    return 0;
    }
  
  // Get the coordinates of the given point
  int getCoor(int[] pixels, char coor)
    {
    long sum = 0;
    int counter = 0;
    
    for (int i = 0; i < pixels.length; i++)
      {
      // Obtain the X
      if (coor == 'x')
        sum += brightness(pixels[i]) * (i % width);
      // Obtain the Y
      if (coor == 'y')
        sum += brightness(pixels[i]) * i / width;
      
      counter += brightness(pixels[i]);
      }
    
    // If found on the screen
    if (sum > pixels.length * 0.01)
      return int(sum / float(counter));
    
    return -1;
    }
  } 
