import processing.video.*;
Capture cam;
int camCounter = 0;

import processing.serial.*;
Serial arduino;
int ldr = 0;
int temp = 0;
int serialCounter = 0;

color original = color(30, 200, 100);
int margin = 50;

String text = "";

int position = 0;
int counterPosition = 0;

boolean showPlanet = true;

PImage back;

void setup()
  {
  size(1280, 960);

  String[] cameras = Capture.list();
  
  while (cameras.length == 0)
    {
    println("There are no cameras available for capture.");
    delay(100);
    cameras = Capture.list();
    }
  println("Camera engaged");
  cam = new Capture(this);
  cam.start();
  
  
  String[] serials = Serial.list();
  while (serials.length == 0) {
    println("Please connect the arduino");
    delay(100);
    serials = Serial.list();
    }
  println("Arduino engaged");
  //arduino = new Serial(this, Serial.list()[0], 9600);
  
  // Background
  back = loadImage("back.jpg");
  }

void draw()
  {
  // Si la camara esta disponible
  if (cam.available() == true)
    {
    cam.read();
    cam.loadPixels();
    int[] pix = cam.pixels;
    
    // Load the current screen pixels
    loadPixels();
    
    int[] mask = cam.pixels;
    
    for (int i = 0; i < pix.length; i++)
      mask[i] = pix[i];
    
    int sumX = 0;
    int counterX = 0;
    int sumY = 0;
    int counterY = 0;
    
    for(int i = 0; i < pix.length; i++)
      {
      int cur = pix[i];
      
      if (red(cur) > red(original) - margin &&
          red(cur) < red(original) + margin &&
          green(cur) > green(original) - margin &&
          green(cur) < green(original) + margin &&
          blue(cur) > blue(original) - margin &&
          blue(cur) < blue(original) + margin
          )
        {
        sumX += i % 1280;
        counterX++;
        
        sumY += floor(i / 1280);
        counterY++;
        
        mask[i] = color(255);
        }
      else
        mask[i] = color(0);
      
      }
    
    if (counterX == 0)
      counterX = 1;
    int positionX = sumX / counterX;
    
    if (counterY == 0)
      counterY = 1;
    int positionY = sumY / counterY;
    
    // The current position
    int newPosition;
    // Si no hay ninguno o hay muy pocos
    if (positionX <= 0 || positionY <= 0 || counterX < 50 || counterY < 50)
      {
      text = "";
      newPosition = 0;
      }
    else
      {
      // Right
      if (positionX < 1280 / 2)
        {
        // Bottom
        if (positionY > 960 / 2)
          {
          text = "Space Apps";
          newPosition = 4;
          }
        // Top
        else
          {
          text = "La Luna";
          newPosition = 2;
          }
        }
      // Left
      else
        {
        // Bottom
        if (positionY > 960 / 2)
          {
          text = "El Sol";
          newPosition = 3;
          }
        // Top
        else
          {
          text = "La Tierra";
          newPosition = 1;
          }
        }
      }
    
    if (position != newPosition)
      {
      // Llamada a la web
      //loadStrings("http://spacehelmet.info/data?show=" + position);
      
      position = newPosition;
      println("/**** Position " + counterPosition + " ****/");
      println("New:" + newPosition);
      counterPosition++;
      }
    
    for (int i = 0; i < pixels.length; i++)
      pixels[i] = pix[i];
    updatePixels();
    
    if (showPlanet)
      background(back);
    
    textSize(60);
    text(text, width / 2 - 100, height / 2);
    }
  
  
  // Si recibimos datos del USB
  if (false && arduino.available() > 0)
    {
    // Comprobar que estamos en el inicio de llamada
    // Si no hay inicio de llamada, se produce un delay correcto, ya que la palabra es de 5 y leemos solo 3
    if (arduino.read() == 200 &&
        arduino.read() == 200 &&
        arduino.read() == 200)
      {
      // Leer los datos de arduino
      int newLDR = arduino.read();
      int newTemp = arduino.read();
      newTemp = temp / 5;
      
      // Si los datos no son erroneos
      if (newLDR != -1 && newTemp != -1)
        {
        // Si son diferentes a los antiguos
        if (newTemp != temp && newLDR != ldr)
          {
          // Mostrarlos por pantalla
          println("/**** Serial " + serialCounter + " ****/");
          println("LDR: " + newLDR);
          println("Temperature: " + newTemp);
          
          // Cargarlos en la web
          loadStrings("http://spacehelmet.info/data?ldr=" + newLDR + "&temp=" + newTemp);
          ldr = newLDR;
          temp = newTemp;
          }
        serialCounter++;
        }
      }
    }
  }


void keyPressed()
  {
  // If the return key is pressed, save the String and clear it
  if (showPlanet)
    {
    showPlanet = false; 
    }
  else
    {
    showPlanet = true; 
    }
  }
