import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

/* Remember, kids:
 * 1. world
 * 2. body (type, position), -> world
 * 3. shape (type, that stuff)
 * 4. fixture (shape <- shape, fric dens res) -> body
 */

PImage img;

color BLACK, WHITE, BLUE;
float BACK_ALPHA = 50, BALL_SATURATION = 100, BALL_BRIGHTNESS = 100;

// particle values
final float RAD = 6, FRIC = 0.3, DENS = 1.0, ELAS = 0.5;

// management stuff
PBox2D world;
Fountain fountain;
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Spout> spouts = new ArrayList<Spout>();
Spout mouseSpout = new Spout(new Vec2(), new Vec2(), 30);

// time tracking for perlin noise
float time = 0;

int FTN_EDGE_OFFSET = 25;

void setup()
{
  size(800, 600, P2D);

  setupVisual();

  world = new PBox2D(this);
  world.createWorld();

  img = loadImage("bkrnd.jpg");

  // setup fountain
  fountain = new Fountain();

  // set up spouts
  float x, y;
  x = FTN_EDGE_OFFSET * 2.5;
  y = FTN_EDGE_OFFSET * 1.7;
  spouts.add(new Spout(new Vec2(x, y), new Vec2(width/5, -10)));
  spouts.add(new Spout(new Vec2(width-x, y), new Vec2(-width/6, -10)));
}

void setupVisual()
{
  BLACK = color(0);
  WHITE = color(255);

  colorMode(HSB, 360, 100, 100);
  BLUE = color(192, 69, 100);
}

color getNextBallColor()
{
  float hue = map(noise(time), 0, 1, 0, 260);
  time++;
  return color( hue, BALL_SATURATION, BALL_BRIGHTNESS);
}

boolean isInScreen(Vec2 pos)
{  
  return (pos.x<width) && (pos.x>0) && (pos.y<height) && (pos.y>0);
}


void draw()
{
  image(img, 0, 0);

  world.step();

  for (Spout s : spouts) {
    s.pressurize();
  }

  if (mousePressed)
  {
    mouseSpout.pos.set(mouseX, mouseY);
    mouseSpout.pressurize();
//    particles.add(new Particle(new Vec2(mouseX, mouseY)));
  }

  //check if any particles are off screen first
  for (int i=0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    if (!isInScreen(world.getBodyPixelCoord(p.body)))
    {
      world.destroyBody(p.body);
      particles.remove(p);
    }
  }

  fountain.display();
  for (Particle p : particles) { 
    p.display();
  }
}
