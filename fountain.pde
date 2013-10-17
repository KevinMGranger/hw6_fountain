class Fountain
{
  Body body;

  Vec2[][] topLayer, botLayer;



  Fountain()
  {
    this(new Vec2(width/2, height/2));
  }

  Fountain(float x, float y)
  {
    this(new Vec2(x, y));
  }

  Fountain(Vec2 pos)
  {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(world.coordPixelsToWorld(pos));

    body = world.createBody(bd);

    ChainShape cs = new ChainShape();
    float widDiv = width/8;
    float heiDiv = height/8;
    topLayer = {
      {
        new Vec2(FTN_EDGE_OFFSET, heiDiv), 
        new Vec2(FTN_EDGE_OFFSET+widDiv, 2*heiDiv),
      }
      , 
      {
        new Vec2(2*FTN_EDGE_OFFSET+widDiv, 2*heiDiv), 
        new Vec2(2*FTN_EDGE_OFFSET+2*widDiv, heiDiv),
      }
    }
    
    botLayer = new Vec2[topLayer.length];
    for (int i=0; i<botLayer.length; i++) {
      botLayer[i] = new Vec2




    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.friction = FRIC;
    fd.density = DENS;
    fd.restitution = ELAS;

    body.createFixture(fd);
  }

  void display()
  {
    Vec2 pos = world.getBodyPixelCoord(body);


    noStroke();
    fill(BLACK);

    pushMatrix();
    translate(pos.x, pos.y);
    rectMode(RADIUS);
    rect(0, 0, WIDTH, HEIGHT);
    popMatrix();
  }
}

