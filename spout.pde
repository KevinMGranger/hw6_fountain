class Spout
{
  Vec2 pos, vel;
  int framesToFire;
  int currentPressure = 0;
  
  Spout(Vec2 pos, Vec2 vel)
  {
    this(pos, vel, 120);
  }
  
  Spout(Vec2 pos, Vec2 vel, int framesToFire)
  {
    this.pos = pos;
    this.vel = vel;
    this.framesToFire = framesToFire;
  }
  
  void pressurize()
  {
    if (++currentPressure >= framesToFire) this.fire();
  } 
  
  void fire()
  {
    particles.add(new Particle(pos, vel));
  }
}
    