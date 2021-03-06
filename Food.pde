class Food
{
  //CONTROL PANLE
  float diameter = 15.0;

  PVector foodLocation = new PVector(0, 0);
  color foodColor;

  public Food(PVector foodLoc, color foodCol)
  {

    this.foodLocation = foodLoc;
    this.foodColor = foodCol;
  }

  void drawFoodEllipse()
  {
    noStroke();
    fill(foodColor);
    ellipse(foodLocation.x, foodLocation.y, diameter, diameter);
  }

  color getFoodColor()
  {
    return this.foodColor;
  }
}//end Food class