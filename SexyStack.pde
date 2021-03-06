class SexyStack 
{
  //CONTROL PANLE
  final float NOISE_DELTA = 0.04;
  final int MAX_VELOCITY = 1;
  final float Tendency_TO_RIGHT = 1.6;
  final int STACK_DIAMETER = 25;
  final int STACK_FOOD_DIAMETER = 10;
  final int STACK_FOOD_LEFT_BOUNDARY = 773;
  final int STACK_FOOD_RIGHT_BOUNDARY = 990;
  final int STACK_FOOD_TOP_BOUNDARY = 525;
  final int STACK_FOOD_BOTTOM_BOUNDARY = 685; 

  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector tendency; //wind to right
  float xOffset;

  public SexyStack(PVector initialLocation)  //constr intoalize var ... initiallocation is var pass in 
  {
    this.location  = initialLocation;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    tendency = new PVector(Tendency_TO_RIGHT, 0);
    xOffset = 0.0;
  }

  public void stackMotion()
  {
    acceleration = PVector.fromAngle(noise(xOffset) * TWO_PI); //noise need give a number
    velocity.add(acceleration);
    velocity.add(tendency);
    location.add((velocity));
    velocity.limit(MAX_VELOCITY); //limit is limit the mag of the vector

    xOffset += NOISE_DELTA;

    //Boundary reaction
    if (location.x < FUCKERS_MOTION_LEFT_BOUNDARY) location.x = FUCKERS_MOTION_RIGHT_BOUNDARY;
    if (location.x > FUCKERS_MOTION_RIGHT_BOUNDARY)location.x = FUCKERS_MOTION_LEFT_BOUNDARY;
    if (location.y < FUCKERS_MOTION_TOP_BOUNDARY) location.y = FUCKERS_MOTION_BOTTOM_BOUNDARY;
    if (location.y > FUCKERS_MOTION_BOTTOM_BOUNDARY)location.y = FUCKERS_MOTION_TOP_BOUNDARY;
  }


  public void drawStack() 
  {
    //draw Stack itself
    ellipse(stack.location.x, stack.location.y, STACK_DIAMETER, STACK_DIAMETER);

    //draw Stack's food
    for (Food f : stackData)
    {
      fill(f.foodColor);
      ellipse(f.foodLocation.x, f.foodLocation.y, STACK_FOOD_DIAMETER, STACK_FOOD_DIAMETER);
    }
  }

  public void applyForce(PVector f)
  {
    velocity.add(f);
  }

  boolean isTouching (Food f)
  {
    return dist(location.x, location.y, f.foodLocation.x, f.foodLocation.y ) < (STACK_DIAMETER/2 +f.diameter/2);
  }

  void eat(Food f)
  {//885 688
    println("stack is eating");
    stackData.push(f);
    f.foodLocation.x = 885;
    //f.foodLocation.y = random(STACK_FOOD_TOP_BOUNDARY, STACK_FOOD_BOTTOM_BOUNDARY);
    for (int i = 0; i < stackData.size(); i++)
    {
      f.foodLocation.y = 688 - i*15;
    }
  }

  void shitOut(Food f)
  {
    stackData.remove(f);
    f.foodLocation.x = random(STACK_FOOD_LEFT_BOUNDARY, STACK_FOOD_RIGHT_BOUNDARY);
    f.foodLocation.y = random(STACK_FOOD_TOP_BOUNDARY, STACK_FOOD_BOTTOM_BOUNDARY);
  }
} //end Walker class