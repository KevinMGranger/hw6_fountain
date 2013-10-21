class Fountain //<>// //<>//
{
  Body body;

  Vec2[] leftTrgl, rightTrgl, lowLeft, lowRight;

  ArrayList<Vec2[]> shapes = new ArrayList<Vec2[]>();


  Fountain()
  {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(world.coordPixelsToWorld(width/2, height/2));

    body = world.createBody(bd);


    float widDiv = width/8;
    float heiDiv = height/8;

    leftTrgl = new Vec2[3];
    leftTrgl[0] = new Vec2(FTN_EDGE_OFFSET, heiDiv);
    leftTrgl[1] = new Vec2((width/2)-FTN_EDGE_OFFSET, 2*heiDiv);
    leftTrgl[2] = new Vec2(FTN_EDGE_OFFSET, 2*heiDiv);

    rightTrgl = new Vec2[3];
    rightTrgl[0] = new Vec2(width-FTN_EDGE_OFFSET, heiDiv);
    rightTrgl[1] = new Vec2((width/2)+FTN_EDGE_OFFSET, 2*heiDiv);
    rightTrgl[2] = new Vec2(width-FTN_EDGE_OFFSET, 2*heiDiv);

    float trglheight = 2*heiDiv;
    Vec2 shiftDown = new Vec2(0, 2 * trglheight);

    lowLeft = new Vec2[3];
    lowRight = new Vec2[3];
    for (int i=0; i < leftTrgl.length; i++) {
      lowLeft[i] = leftTrgl[i].add(shiftDown);
      lowRight[i] = rightTrgl[i].add(shiftDown);
    }

    // now make the world-coordinate-based arrays

    Vec2[] leftWorld = new Vec2[3], rightWorld = new Vec2[3];
    Vec2[] lowLeftWorld = new Vec2[3], lowRightWorld = new Vec2[3];


    for (int i=0; i<leftWorld.length; i++) {
      leftWorld[i] = world.coordPixelsToWorld(leftTrgl[i]);
      rightWorld[i] = world.coordPixelsToWorld(rightTrgl[i]);
      lowRightWorld[i] = world.coordPixelsToWorld(lowRight[i]);
      lowLeftWorld[i] = world.coordPixelsToWorld(lowLeft[i]);
    }

    ChainShape cs = new ChainShape();
    cs.createLoop(leftWorld, leftWorld.length);
    body.createFixture(cs, 1);

    PolygonShape ps = new PolygonShape();
    ps.set(rightWorld, rightWorld.length);
    body.createFixture(ps, 1);

    ps.set(lowRightWorld, lowRightWorld.length);
    body.createFixture(ps, 1.0);

    ps.set(lowLeftWorld, lowLeftWorld.length);
    body.createFixture(ps, 1.0);

    //now for easy drawing
    shapes.add(leftTrgl);
    shapes.add(rightTrgl);
    shapes.add(lowLeft);
    shapes.add(lowRight);
  }

  void display()
  {
    noStroke();
    fill(WHITE);

    for (Vec2[] vs : shapes)
    {
      beginShape();
      for (Vec2 v : vs) {
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
  }
}
