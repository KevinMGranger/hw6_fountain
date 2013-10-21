class Fountain
{
  Body body;

  Vec2[] leftTrgl, rightTrgl;



  Fountain()
  {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(world.coordPixelsToWorld(width/2, height/2));

    body = world.createBody(bd);

    ChainShape cs = new ChainShape();
    float widDiv = width/8;
    float heiDiv = height/8;

    leftTrgl = new Vec2[3];
    leftTrgl[0] = new Vec2(FTN_EDGE_OFFSET, heiDiv);
    leftTrgl[1] = new Vec2(FTN_EDGE_OFFSET+widDiv, 2*heiDiv);
    leftTrgl[2] = new Vec2(FTN_EDGE_OFFSET, 2*heiDiv);

    rightTrgl = new Vec2[3];
    leftTrgl[0] = new Vec2(width-FTN_EDGE_OFFSET, heiDiv);
    leftTrgl[1] = new Vec2(width-FTN_EDGE_OFFSET-widDiv, 2*heiDiv);
    leftTrgl[2] = new Vec2(width-FTN_EDGE_OFFSET, 2*heiDiv);

    // now make the world-coordinate-based arrays

    Vec2[] leftWorld = new Vec2[3], rightWorld = new Vec2[3];


    for (int i=0; i<leftWorld.length; i++) {
      leftWorld[i] = world.coordPixelsToWorld(leftTrgl[i]);
      rightWorld[i] = world.coordPixelsToWorld(rightTrgl[i]);
    }


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
