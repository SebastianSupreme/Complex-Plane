public class ComplexNumber {

  float real;
  float imaginary;

  public ComplexNumber(float real, float imaginary){

    this.real = real;
    this.imaginary = imaginary;
  }
  
  public ComplexNumber add(ComplexNumber c){

    float newR = this.real + c.real;
    float newI = this.imaginary + c.imaginary;


    return new ComplexNumber(newR, newI);
  }

  public ComplexNumber sub(ComplexNumber c){

    float newR = this.real - c.real;
    float newI = this.imaginary - c.imaginary;


    return new ComplexNumber(newR, newI);
  }

  public ComplexNumber multi(ComplexNumber c){

    float newR = this.real * c.real - this.imaginary * c.imaginary; 
    float newI = this.real * c.imaginary + this.imaginary * c.real; 
    return new ComplexNumber(newR, newI);
  }
  
}
