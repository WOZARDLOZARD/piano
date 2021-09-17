/*
 
 * Click the keys to play the note, and press space to get a random white key color
 
 */

import ddf.minim.*; // Import the entire Minim library (* means all)

int blackKeysX = 20; // Set the coordinates of key positions to prepare the drawing of the keyboard
int keyBorders = 40;
int tileX = -40;

int keyR = int(random(255)); // Picks a random color to color the keys when the sketch first starts
int keyG = int(random(255));
int keyB = int(random(255));

boolean changeKeys = true; 

boolean blackKeys = false; // The user isn't playing a black key when the sketch launches

boolean pianoFLowPlaying = false; // These notes are not playing when the sketch launches
boolean pianoGLowPlaying = false;
boolean pianoAPlaying = false;
boolean pianoBPlaying = false;
boolean pianoCPlaying = false;
boolean pianoDPlaying = false;
boolean pianoEPlaying = false;
boolean pianoFPlaying = false;
boolean pianoGPlaying = false;

boolean pianoBFlatPlaying = false; // These sharp and flat notes aren't playing when the sketch launches
boolean pianoCSharpPlaying = false;
boolean pianoEFlatPlaying = false;
boolean pianoFSharpPlaying = false;
boolean pianoGSharpPlaying = false;

String previousNote = "";

Minim minim;

AudioPlayer pianoFLow, pianoGLow, pianoA, pianoB, pianoC, pianoD, pianoE, pianoF, pianoG; // Create Minim audio players for these notes

AudioPlayer pianoBFlat, pianoCSharp, pianoEFlat, pianoFSharp, pianoGSharp; // Create Minim audio players for these sharp and flat notes

void setup() {
  size(800, 400);
  background(255);

  minim = new Minim(this); // This line of code is based on the official Minim documentation that I read in order to get the audio players working.

  // Load in all the sound files
  pianoFLow = minim.loadFile("piano-f-low.wav");
  pianoGLow = minim.loadFile("piano-g-low.wav");
  pianoA = minim.loadFile("piano-a.wav"); 
  pianoB = minim.loadFile("piano-b.wav");
  pianoC = minim.loadFile("piano-c.wav");
  pianoD = minim.loadFile("piano-d.wav");
  pianoE = minim.loadFile("piano-e.wav");
  pianoF = minim.loadFile("piano-f.wav");
  pianoG = minim.loadFile("piano-g.wav");

  pianoBFlat = minim.loadFile("piano-b-flat.wav");
  pianoCSharp = minim.loadFile("piano-c-sharp.wav");
  pianoEFlat = minim.loadFile("piano-e-flat.wav");
  pianoFSharp = minim.loadFile("piano-f-sharp.wav");
  pianoGSharp = minim.loadFile("piano-g-sharp.wav");
}

void draw() {  

  if (changeKeys == true) {
    pianoFLowPlaying = false;
    pianoGLowPlaying = false;
    pianoAPlaying = false;
    pianoBPlaying = false;
    pianoCPlaying = false;
    pianoDPlaying = false;
    pianoEPlaying = false;
    pianoFPlaying = false;
    pianoGPlaying = false;

    pianoBFlatPlaying = false;
    pianoCSharpPlaying = false;
    pianoEFlatPlaying = false;
    pianoFSharpPlaying = false;
    pianoGSharpPlaying = false;

    changeKeys = false;
  }

  int j;
  int i;
  int z;

  // Draw the keyboard
  for (j = -40; j < width; j += 80) { // Draws the white keys 
    fill(255); // White fill
    rect(tileX, 0, 80, height); // Draws the keys with a width of 80 and as tall as the height of the sketch at the position of the integer tileX 
    tileX += 80; // Add 80 to tileX every time the loop runs
  }
  for (i = 20; i < width; i += 80) { // Draws the black keys
    fill(0); // Black fill
    if (blackKeysX != 260 && blackKeysX != 500) { // Checks if the black key coordinates are not equal to the following coordinates
      rect(blackKeysX, 0, 40, 210); // If they are NOT, then draw black keys; this makes the piano seem more realistic
    }
    blackKeysX += 80; // Increment the coordinate of the black keys' X position by 80
  }
  for (z = 40; z < width; z += 80) { // Draws the key borders
    fill(0); // Black fill
    line(keyBorders, 180, keyBorders, height); // Draw lines to create borders between the keys at the position of keyBorders
    keyBorders += 80; // Add 80 to the keyBorders integer
  }
  // Extend the lines at the places where there are no black keys
  stroke(0); // Black stroke
  // Draws two lines at the places where there are no black keys that vertically span the entire height of the sketch
  line(280, 0, 280, height); 
  line(520, 0, 520, height);

  if (mousePressed) {
    // The following for loop checker sets the value of i to 20, the starting coordinate of the
    // black keys, and as long as i is less than the width of the screen, it'll add 80 
    // pixels to the value of i so that it moves on to the next black key

    int a;
    int b;
    int c;
    int d;
    int x;
    int e;

    for (a = 20; a < width; a += 80) { 
      if (mouseX > a && mouseX < a + 40) { // Checks if the user's mouse position is greater than i and if it's less than i + 40 (the width of each black key)
        tileX = -40; // Reset all position variables
        blackKeysX = 20;
        keyBorders = 40;

        // Draws a new keyboard
        for (b = -40; b < width; b += 80) {
          fill(255);
          rect(tileX, 0, 80, height);
          tileX += 80;
        }
        for (x = 20; x < width; x += 80) {
          fill(0);
          if (blackKeysX != 260 && blackKeysX != 500) { // Doesn't run the code if the blackKeysX position has reached a point where there aren't supposed to be black keys
            rect(blackKeysX, 0, 40, 210);
          }
          blackKeysX += 80;
        }
        for (c = 40; c < width; c += 80) {
          fill(0);
          line(keyBorders, 180, keyBorders, height);
          keyBorders += 80;
        }

        if (mouseY <= 210) {
          fill(255, 225, 0); // Yellow fill
          if (mouseX < 260 || mouseX > 300 && mouseX < 500 || mouseX > 540) { // Checks if the user's mouse is not over the places where there aren't supposed to be black keys; if it is, don't run the code
            blackKeys = true; // The user is now pressing a black key
            rect(a, 0, 40, 210); // Draws a yellow rectangle over the pressed black key to indicate that it's pressed
          }
        }
      }
    }

    for (e = -40; e < width; e += 80) { // For loop to check for mouse coordinates
      if (mouseX > e && mouseX < e + 80 && mouseY > 210) { // Checks if mouseX is greater than the for loop variable and if mouseX is less than the full width and if mouseY is greater than the height of a black key
        blackKeysX = 20; // Reset the black key position variable
        blackKeys = false; // The user isn't pressing a black key
        fill(keyR, keyG, keyB, 128); // Fills the rectangle with a random color
        rect(e, 0, 80, height); // Draws a rectangle over the white key with a random color and not full transparency to make a "fade in" effect as well as indicate how center the key is pressed
      } else if (mouseX > e + 20 && mouseX < e + 60 && mouseY <= 210) { // Checks if mouseX is greater than the for loop variable plus half the width of a black key (which is the width that carries onto the white key) and if mouseX is less than the for loop variable plus 60 (the distance between two black keys) and if mouseX is less than or equal to the height of a black key
        blackKeysX = 20; // Reset the black key position variable
        blackKeys = false; // The user isn't pressing a black key
        fill(keyR, keyG, keyB, 128); // Fills the rectangle with a random color
        rect(e, 0, 80, height); // Does the same thing as the line of code in the above block
      }

      for (d = 20; d < width; d += 80) {
        fill(0);
        if (blackKeysX != 260 && blackKeysX != 500) {
          rect(blackKeysX, 0, 40, 210);
        }
        blackKeysX += 80;
      }
    }

    stroke(0);
    line(280, 0, 280, height);
    line(520, 0, 520, height);

    if (mouseX <= 40 && blackKeys == false) {
      if (previousNote != "f-low") pianoFLowPlaying = false;
      
      if (pianoFLowPlaying == false) {
        pianoFLow.rewind();
        pianoFLow.play();
        pianoFLowPlaying = true;
        previousNote = "f-low";
      }
    } else if (mouseX > 40 && mouseX <= 120 && blackKeys == false) {
      if (previousNote != "g-low") pianoGLowPlaying = false;
      
      if (pianoGLowPlaying == false) {
        pianoGLow.rewind();
        pianoGLow.play();
        pianoGLowPlaying = true;
        previousNote = "g-low";
      }
    } else if (mouseX > 120 && mouseX <= 200 && blackKeys == false) {
      if (previousNote != "a") pianoAPlaying = false;
      
      if (pianoAPlaying == false) {
        pianoA.rewind();
        pianoA.play();
        pianoAPlaying = true;
        previousNote = "a";
      }
    } else if (mouseX > 200 && mouseX <= 280 && blackKeys == false) {
      if (previousNote != "b") pianoBPlaying = false;
      
      if (pianoBPlaying == false) {
        pianoB.rewind();
        pianoB.play();
        pianoBPlaying = true;
        previousNote = "b";
      }
    } else if (mouseX > 280 && mouseX <= 360 && blackKeys == false) {
      if (previousNote != "c") pianoCPlaying = false;
      
      if (pianoCPlaying == false) {
        pianoC.rewind();
        pianoC.play();
        pianoCPlaying = true;
        previousNote = "c";
      }
    } else if (mouseX > 360 && mouseX <= 440 && blackKeys == false) { 
      if (previousNote != "d") pianoDPlaying = false;
      
      if (pianoDPlaying == false) {
        pianoD.rewind();
        pianoD.play();
        pianoDPlaying = true;
        previousNote = "d";
      }
    } else if (mouseX > 440 && mouseX <= 520 && blackKeys == false) {
      if (previousNote != "e") pianoEPlaying = false;
      
      if (pianoEPlaying == false) {
        pianoE.rewind();
        pianoE.play();
        pianoEPlaying = true;
        previousNote = "e";
      }
    } else if (mouseX > 520 && mouseX <= 600 && blackKeys == false) { 
      if (previousNote != "f") pianoFPlaying = false;
      
      if (pianoFPlaying == false) {
        pianoF.rewind();
        pianoF.play();
        pianoFPlaying = true;
        previousNote = "f";
      }
    } else if (mouseX > 600 && mouseX <= 680 && blackKeys == false) {
      if (previousNote != "g") pianoGPlaying = false;
      
      if (pianoGPlaying == false) {
        pianoG.rewind();
        pianoG.play();
        pianoGPlaying = true;
        
        previousNote = "g";
      }
    } 

    // All sharp and flat notes
    if (mouseX > 180 && mouseX <= 220 && blackKeys == true) {
      if (previousNote != "bf") pianoBFlatPlaying = false;
      
      if (pianoBFlatPlaying == false) {
        pianoBFlat.rewind();
        pianoBFlat.play();
        pianoBFlatPlaying = true;
        
        previousNote = "bf";
      }
    } else if (mouseX > 340 && mouseX <= 380 && blackKeys == true) {
      if (previousNote != "cs") pianoCSharpPlaying = false;
      
      if (pianoCSharpPlaying == false) {
        pianoCSharp.rewind();
        pianoCSharp.play();
        pianoCSharpPlaying = true;
        previousNote = "cs";
      }
    } else if (mouseX > 420 && mouseX <= 460 && blackKeys == true) {
      if (previousNote != "ef") pianoEFlatPlaying = false;
      
      if (pianoEFlatPlaying == false) {
        pianoEFlat.rewind();
        pianoEFlat.play();
        pianoEFlatPlaying = true;
        previousNote = "ef";
      }
    } else if (mouseX > 580 && mouseX <= 620 && blackKeys == true) {
      if (previousNote != "fs") pianoFSharpPlaying = false;
      
      if (pianoFSharpPlaying == false) {
        pianoFSharp.rewind();
        pianoFSharp.play();
        pianoFSharpPlaying = true;
        previousNote = "fs";
      }
    } else if (mouseX > 100 && mouseX <= 140 && blackKeys == true) {
      if (previousNote != "gs") pianoGSharpPlaying = false;
      
      if (pianoGSharpPlaying == false) {
        pianoGSharp.rewind();
        pianoGSharp.play();
        pianoGSharpPlaying = true;
        previousNote = "gs";
      }
    }
  } // End of mousePressed if statement

  if (keyPressed) {
    fill(keyR, keyG, keyB, 128);
    if (key == 'f' && blackKeys == false) {
      if (pianoFLowPlaying == false) {
        pianoFLow.rewind();
        pianoFLow.play();
        pianoFLowPlaying = true;
        rect(0, 0, 40, height);
      }
    } else if (key == 'g' && blackKeys == false) {
      if (pianoGLowPlaying == false) {
        pianoGLow.rewind();
        pianoGLow.play();
        pianoGLowPlaying = true;
        rect(40, 0, 80, height);
      }
    } else if (key == 'a') {
      if (pianoAPlaying == false) {
        pianoA.rewind();
        pianoA.play();
        pianoAPlaying = true;
        rect(120, 0, 80, height);
      }
    } else if (key == 'b') {
      if (pianoBPlaying == false) {
        pianoB.rewind();
        pianoB.play();
        pianoBPlaying = true;
        rect(200, 0, 80, height);
      }
    } else if (key == 'c') {
      if (pianoCPlaying == false) {
        pianoC.rewind();
        pianoC.play();
        pianoCPlaying = true;
        rect(280, 0, 80, height);
      }
    } else if (key == 'd') { 
      if (pianoDPlaying == false) {
        pianoD.rewind();
        pianoD.play();
        pianoDPlaying = true;
        rect(360, 0, 80, height);
      }
    } else if (key == 'e') {
      if (pianoEPlaying == false) {
        pianoE.rewind();
        pianoE.play();
        pianoEPlaying = true;
        rect(440, 0, 80, height);
      }
    } else if (key == 'f') { 
      if (pianoFPlaying == false) {
        pianoF.rewind();
        pianoF.play();
        rect(520, 0, 80, height);
        pianoFPlaying = true;
      }
    } else if (key == 'g') {
      if (pianoGPlaying == false) {
        pianoG.rewind();
        pianoG.play();
        rect(600, 0, 80, height);
        pianoGPlaying = true;
      }
    } // End of key checker
  } // End of keyPressed if statement
} // End of draw()

void mouseReleased() {
  //println(mouseX, mouseY);

  blackKeys = false;

  pianoFLowPlaying = false;
  pianoGLowPlaying = false;
  pianoAPlaying = false;
  pianoBPlaying = false;
  pianoCPlaying = false;
  pianoDPlaying = false;
  pianoEPlaying = false;
  pianoFPlaying = false;
  pianoGPlaying = false;

  pianoBFlatPlaying = false;
  pianoCSharpPlaying = false;
  pianoEFlatPlaying = false;
  pianoFSharpPlaying = false;
  pianoGSharpPlaying = false;

  tileX = -40;
  blackKeysX = 20;
  keyBorders = 40;

  int j;
  int i;
  int z;

  for (j = -40; j < width; j += 80) { // Draws the entire keyboard again
    fill(255);
    rect(tileX, 0, 80, height);
    tileX += 80;
  }
  for (i = 20; i < width; i += 80) {
    fill(0);
    if (blackKeysX != 260 && blackKeysX != 500) {
      rect(blackKeysX, 0, 40, 210);
    }
    blackKeysX += 80;
  }
  for (z = 40; z < width; z += 80) {
    fill(0);
    line(keyBorders, 180, keyBorders, height);
    keyBorders += 80;
  }

  stroke(0);
  line(280, 0, 280, height);
  line(520, 0, 520, height);
}

void keyReleased() {
  blackKeys = false;

  pianoFLowPlaying = false;
  pianoGLowPlaying = false;
  pianoAPlaying = false;
  pianoBPlaying = false;
  pianoCPlaying = false;
  pianoDPlaying = false;
  pianoEPlaying = false;
  pianoFPlaying = false;
  pianoGPlaying = false;

  pianoBFlatPlaying = false;
  pianoCSharpPlaying = false;
  pianoEFlatPlaying = false;
  pianoFSharpPlaying = false;
  pianoGSharpPlaying = false;

  tileX = -40;
  blackKeysX = 20;
  keyBorders = 40;

  int j;
  int i;
  int z;

  for (j = -40; j < width; j += 80) { // Draws the entire keyboard again
    fill(255);
    rect(tileX, 0, 80, height);
    tileX += 80;
  }
  for (i = 20; i < width; i += 80) {
    fill(0);
    if (blackKeysX != 260 && blackKeysX != 500) {
      rect(blackKeysX, 0, 40, 210);
    }
    blackKeysX += 80;
  }
  for (z = 40; z < width; z += 80) {
    fill(0);
    line(keyBorders, 180, keyBorders, height);
    keyBorders += 80;
  }

  stroke(0);
  line(280, 0, 280, height);
  line(520, 0, 520, height);

  if (key == ' ') {
    keyR = int(random(255));
    keyG = int(random(255));
    keyB = int(random(255));
  }
}
