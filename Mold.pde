PImage img;
int TH; //threshold
int DIM = 20;
ArrayList<Pix> pix;

void settings() {
  //img = loadImage("buddha_480-360.jpg");
  img = loadImage("silvio_3.jpg");
  size(img.width, img.height);
  DIM = min(img.width, img.height)/35;
  println(DIM);
}
void setup() {
  colorMode(HSB);
  init();
}

void init() {
  pix = new ArrayList<Pix>();
  image(img, 0, 0);
  loadPixels();
  for (int i= 0; i< floor(width/DIM)*DIM; i+=DIM) {
    for (int j=0; j < floor(height/DIM)*DIM; j+=DIM) {
      float sum = 33;
      for (int k= 0; k<DIM; k++) {
        for (int h = 0; h< DIM; h++) {
          int index = (i + k) + (j+h)*width;
          color c = color(pixels[index]);
          float b = brightness(c);
          sum += b;
        }
      }
      sum /= (DIM * DIM);
      pix.add(new Pix(i+DIM/2, j+DIM/2, sum));
    }
  }
  updatePixels();
  
}



void mousePressed() {
  DIM = floor(map(mouseX, 0, width, 0, min(img.width, img.height)/40));
  
  init();
  println(DIM);
  redraw();
  
}


void draw() {
  background(255);
  //noLoop();

  for (Pix p : pix) {
    p.show();
  }
  filter(BLUR, 1);
  //filter(BLUR);
  //filter(BLUR);
  //filter(BLUR);
  save("muffa.jpg");
}


class Pix {
  PVector loc;
  float bri;
  Pix(int i, int j, float bri_ ) {
    loc = new PVector(i, j); 
    bri= bri_; //average brightness
  }

  void show() {
    strokeWeight(1);
    noFill();
    stroke(0, 0, bri);
    if (bri > 10 && bri < 255) {
      for (int i = 0; i < map(bri, 0, 255, DIM*DIM, 0); i++) {
        strokeWeight(1);
        point(randomGaussian()*DIM+loc.x-DIM/2, randomGaussian()*DIM+loc.y-DIM/2);
      }
    } else if (bri<200) {
      for (int i = 0; i < map(bri, 0, 255, DIM, 0); i++) {
        strokeWeight(2);
        point(randomGaussian()*DIM+loc.x-DIM/2, randomGaussian()*DIM+loc.y-DIM/2);
      }
    }
  }
}
