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

int SCREEN_BORDER_SIZE = 400;

color BLACK, WHITE, BLUE;
float BACK_ALPHA = 50, BALL_SATURATION = 100, BALL_BRIGHTNESS = 100;

// particle values
final float RAD = 6, FRIC = 0.3, DENS = 1.0, ELAS = 0.5;

// management stuff
PBox2D world;
Fountain fountain;
ArrayList<Particle> particles;

// time tracking for perlin noise
float time = 0;

int FTN_EDGE_OFFSET = 25;

void setup()
{
  size(displayWidth - SCREEN_BORDER_SIZE, displayHeight - SCREEN_BORDER_SIZE, P2D);

  setupVisual();

  particles = new ArrayList<Particle>();

  world = new PBox2D(this);
  world.createWorld();

  // setup fountain
  fountain = new Fountain(width/2, height/2);
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
  return (pos.x<width) && (pos.x>0) && (pos.y>height) && (pos.y<0);
}


void draw()
{
//  background(WHITE, BACK_ALPHA);
   background(WHITE);
  world.step();



  if (mousePressed)
  {
    particles.add(new Particle(new Vec2(mouseX, mouseY)));
  }

  fountain.display();
  for (Particle p : particles) { 
    p.display();
  }
}
