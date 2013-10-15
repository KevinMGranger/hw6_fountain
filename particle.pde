class Particle
{
  float rad;
  
  Body body;
  color col;
  
  
  Particle(PVector pos, color col)
  {
    this(pos, new PVector(), col);
  }
  
  Particle(PVector pos, PVector vel, color col)
  {
    this(pos, vel, RAD, col);
  }

  Particle(PVector pos, PVector vel, float radius, color col)
  {
    rad = radius;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.coordPixelsToWorld(pos));
    
    body = world.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = world.scalarPixelsToWorld(radius);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.friction = FRIC;
    fd.density = DENS;
    fd.restitution = ELAS;
    
    body.createFixture(fd);
  }
  
  void display()
  {
    PVector pos = world.getBodyPixelCoordPVector(body);
    
    float ang = body.getAngle();
    
    fill(col);
    noStroke();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    ellipseMode(RADIUS);
    ellipse(0, 0, rad, rad);
    popMatrix();
  }
}
