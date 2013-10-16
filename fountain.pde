class Fountain
{
  Body body;
  
  float HEIGHT = height/16, WIDTH = width/8;

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

    PolygonShape ps = new PolygonShape();
    float w = world.scalarPixelsToWorld(WIDTH);
    float h = world.scalarPixelsToWorld(HEIGHT);
    ps.setAsBox(w, h);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
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
