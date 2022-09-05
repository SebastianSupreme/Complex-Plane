float rectlength;
float rect1XPos, rect1YPos;
float rect2XPos, rect2YPos;
float gap;
String function = "z = sqrt(w)";
float offset = 35;
PVector prevInput = null;

ArrayList<PVector> inputPoints = new ArrayList<PVector>();
ArrayList<ComplexNumber> inputComplex = new ArrayList<ComplexNumber>();
ArrayList<PVector> outputPoints = new ArrayList<PVector>();
ArrayList<ComplexNumber> outputComplex = new ArrayList<ComplexNumber>();
ArrayList<PVector> outputPoints2 = new ArrayList<PVector>();
ArrayList<ComplexNumber> outputComplex2 = new ArrayList<ComplexNumber>();


void setup() {

  fullScreen(P2D);
  colorMode(HSB, 360);

  rectlength = ceil(0.5 * height);

  rect1XPos = (width / 2) + ((width / 2) - rectlength) / 2;
  rect1YPos = (height - rectlength) / 2;

  rect2XPos = ((width / 2) - rectlength) / 2;
  rect2YPos = (height - rectlength) / 2;

  gap = rect2YPos - (rect1YPos + rectlength);

for (int i = 0; i < rectlength; i++) {
    for (int j = 0; j < rectlength; j++) {
      
      float real = map(rect2XPos + i, rect2XPos, rect2XPos + rectlength, -1.5, 1.5);
      float imag = map(rect2YPos + j, rect2YPos + rectlength, rect2YPos, -1.5, 1.5);

      inputComplex.add(new ComplexNumber(real, imag));

      inputPoints.add(new PVector(rect2XPos + i, rect2YPos + j));
    }
  } 
  
}




void draw() {
  
  background(360);

  stroke(0);
  strokeWeight(8);
  noFill();

  rect(rect2XPos, height / 16, rectlength / 2, rectlength / 4);

  rect(rect1XPos + rectlength / 2, height / 16, rectlength / 2, rectlength / 4);


  rect(rect1XPos, rect1YPos, rectlength, rectlength);

  rect(rect2XPos, rect2YPos, rectlength, rectlength);

  textSize(70);
  fill(0);
  textAlign(CENTER);

  text("Clear", rect2XPos + rectlength / 4, height / 7);

  text("Function", rect1XPos + 3 * rectlength / 4, height / 7);

  textSize(100);

  if (function.equals("w = z^2")) {

    text("W", rect1XPos + rectlength / 2, height - rect1YPos / 4);
    text("Z", rect2XPos + rectlength / 2, height - rect1YPos / 4);
  } else if (function.equals("z = sqrt(w)")) {

    text("Z", rect1XPos + rectlength / 2, height - rect1YPos / 4);
    text("W", rect2XPos + rectlength / 2, height - rect1YPos / 4);
  }

  text(function, width / 2, height / 7);

  textAlign(RIGHT);
  textSize(50);

  text("0i ", rect2XPos, rect2YPos + (rectlength / 2));
  text("1.5i ", rect2XPos, rect2YPos + offset);
  text("-1.5i ", rect2XPos, rect2YPos + rectlength);

  text("0i ", rect1XPos, rect1YPos + (rectlength / 2));
  text("1.5i ", rect1XPos, rect1YPos + offset);
  text("-1.5i ", rect1XPos, rect1YPos + rectlength);

  text("0", rect2XPos + rectlength / 2, rect2YPos + rectlength + 1.5 * offset);
  text("-1.5", rect2XPos + 2 * offset, rect2YPos + rectlength + 1.5 * offset);
  text("1.5", rect2XPos + rectlength, rect2YPos + rectlength + 1.5 * offset);

  text("0", rect1XPos + rectlength / 2, rect1YPos + rectlength + 1.5 * offset);
  text("-1.5", rect1XPos + 2 * offset, rect1YPos + rectlength + 1.5 * offset);
  text("1.5", rect1XPos + rectlength, rect1YPos + rectlength + 1.5 * offset);


  for (ComplexNumber c : inputComplex) {

    if (function.equals("w = z^2")) {

      outputComplex.add(c.multi(c));
    } else if (function.equals("z = sqrt(w)")) {

      float[] f = squareroot(new ComplexNumber(c.real, c.imaginary));

      outputComplex.add(new ComplexNumber(f[0], f[1]));
      outputComplex2.add(new ComplexNumber(f[2], f[3]));
    }
  }

  for (ComplexNumber c : outputComplex) {

    float x = map(c.real, -1.5, 1.5, rect1XPos, rect1XPos + rectlength);
    float y = map(c.imaginary, -1.5, 1.5, rect1YPos + rectlength, rect1YPos);

    outputPoints.add(new PVector(x, y));
  }

  for (ComplexNumber c : outputComplex2) {

    float x = map(c.real, -1.5, 1.5, rect1XPos, rect1XPos + rectlength);
    float y = map(c.imaginary, -1.5, 1.5, rect1YPos + rectlength, rect1YPos);

    outputPoints2.add(new PVector(x, y));
  }

  float hue = 180;//0
  int nulls = 0;

  for (int i = 0; i < inputPoints.size(); i++) {

    if(i % rectlength == 0){
      hue += 60 / rectlength;
    }
    
    stroke(hue, 360, 360);
    strokeWeight(1);//20-------------------------------

    if (inputPoints.get(i) != null) {
      
      point(inputPoints.get(i).x, inputPoints.get(i).y);

      if (prevInput != null) {

        line(prevInput.x, prevInput.y, inputPoints.get(i).x, inputPoints.get(i).y);
      }

      prevInput = new PVector(inputPoints.get(i).x, inputPoints.get(i).y);


      if (outputPoints.get(i - nulls).x > rect1XPos && outputPoints.get(i - nulls).x < rect1XPos + rectlength
        && outputPoints.get(i - nulls).y > rect1YPos && outputPoints.get(i - nulls).y < rect1YPos + rectlength) {

        point(outputPoints.get(i - nulls).x, outputPoints.get(i - nulls).y);
      }

      if (function.equals("z = sqrt(w)")) {
        if (outputPoints2.get(i - nulls).x > rect1XPos && outputPoints2.get(i - nulls).x < rect1XPos + rectlength
          && outputPoints2.get(i - nulls).y > rect1YPos && outputPoints2.get(i - nulls).y < rect1YPos + rectlength) {

          point(outputPoints2.get(i - nulls).x, outputPoints2.get(i - nulls).y);
        }
      }
    } else {

      nulls++;
      prevInput = null;
    }

    //hue++;

    if (hue > 240) {
      hue = 180;
    }
  }


  outputPoints = new ArrayList<PVector>();
  outputComplex = new ArrayList<ComplexNumber>();

  outputPoints2 = new ArrayList<PVector>();
  outputComplex2 = new ArrayList<ComplexNumber>();

  prevInput = null;


  if (mouseX > rect2XPos && mouseX < rect2XPos + rectlength
    && mouseY > rect2YPos && mouseY < rect2YPos + rectlength) {

    float real = map(mouseX, rect2XPos, rect2XPos + rectlength, -1.5, 1.5);
    float imag = map(mouseY, rect2YPos + rectlength, rect2YPos, -1.5, 1.5);

    textSize(25);
    textAlign(LEFT);
    text("" + real, rect2XPos, rect2YPos - offset);
    textAlign(RIGHT);
    text("" + imag + "i", rect2XPos + rectlength, rect2YPos - offset);
  }
}


void mousePressed() {

  if (mouseX > rect2XPos && mouseX < rect2XPos + rectlength
    && mouseY > rect2YPos && mouseY < rect2YPos + rectlength) {

    float real = map(mouseX, rect2XPos, rect2XPos + rectlength, -1.5, 1.5);
    float imag = map(mouseY, rect2YPos + rectlength, rect2YPos, -1.5, 1.5);

    inputComplex.add(new ComplexNumber(real, imag));

    inputPoints.add(new PVector(mouseX, mouseY));
  }


  if (mouseX > rect2XPos && mouseX < rect2XPos + rectlength / 2 && 
    mouseY > height / 16 && mouseY < height / 16 + rectlength / 4) {

    clean();
  }

  if (mouseX > rect1XPos + rectlength / 2 && mouseX < rect1XPos + rectlength &&
    mouseY > height / 16 && mouseY < height / 16 + rectlength / 4) {

    if (function.equals("w = z^2")) {
      function = "z = sqrt(w)";
    } else if (function.equals("z = sqrt(w)")) {
      function = "w = z^2";
    }

    clean();
  }
}

void mouseDragged() {

  if (mouseX > rect2XPos && mouseX < rect2XPos + rectlength
    && mouseY > rect2YPos && mouseY < rect2YPos + rectlength
    && mousePressed == true) {

    float real = map(mouseX, rect2XPos, rect2XPos + rectlength, -1.5, 1.5);
    float imag = map(mouseY, rect2YPos + rectlength, rect2YPos, -1.5, 1.5);

    inputComplex.add(new ComplexNumber(real, imag));

    inputPoints.add(new PVector(mouseX, mouseY));
  }
}

void mouseReleased() {

  inputPoints.add(null);
}

void clean() {

  inputPoints = new ArrayList<PVector>();
  inputComplex = new ArrayList<ComplexNumber>();
  outputPoints = new ArrayList<PVector>();
  outputComplex = new ArrayList<ComplexNumber>();
  outputPoints2 = new ArrayList<PVector>();
  outputComplex2 = new ArrayList<ComplexNumber>();
}

float[] squareroot(ComplexNumber c) {

  float[] numbers = new float[4];

  float[] f = pq(-1 * c.real, -1 * (pow(c.imaginary, 2) / 4));

  float a_p = 0, a_n = 0, b_1 = 0, b_2 = 0;

  if (f[0] > 0) {

    a_p = sqrt(f[0]);
    a_n = -1 * sqrt(f[0]);

    b_1 = c.imaginary / (2 * a_p);
    b_2 = c.imaginary / (2 * a_n);
  } else if (f[0] < 0) {

    a_p = sqrt(abs(f[0]));//*i
    a_n = -1 * sqrt(abs(f[0]));//*i

    b_1 = a_p;
    b_2 = a_n;

    a_p = 0;
    a_n = 0;
  } else if (f[1] > 0) {

    a_p = sqrt(f[1]);
    a_n = -1 * sqrt(f[1]);

    b_1 = c.imaginary / (2 * a_p);
    b_2 = c.imaginary / (2 * a_n);
  } else if (f[1] < 0) {

    a_p = sqrt(abs(f[1]));//*i
    a_n = -1 * sqrt(abs(f[1]));//*i

    b_1 = a_p;
    b_2 = a_n;

    a_p = 0;
    a_n = 0;
  }


  numbers[0] = a_p;
  numbers[1] = b_1;
  numbers[2] = a_n;
  numbers[3] = b_2;

  return numbers;
}

float[] pq(float p, float q) {

  float result1 = -1 * p/2 + sqrt(pow(p/2, 2) - q);

  float result2 = -1 * p/2 - sqrt(pow(p/2, 2) - q);

  float[] f = {result1, result2};

  return f;
}
