class Fountain
{
  Body body;
  float w, h;

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
    w = world.scalarPixelsToWorld(width);
    h = world.scalarPixelsToWorld(height/16);
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
    //    rotate(-ang);
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
    popMatrix();
  }
}
