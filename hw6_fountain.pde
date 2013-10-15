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

final color BLACK = color(0), WHITE = color(255);

float BACK_ALPHA = 0.5;

// particle values
final float RAD = 12, FRIC = 0.3, DENS = 1.0, ELAS = 0.5;

PBox2D world;
Fountain fountain;
ArrayList<Particle> particles;

void setup()
{
    size(displayWidth - SCREEN_BORDER_SIZE, displayHeight - SCREEN_BORDER_SIZE, P2D);
    
    particles = new ArrayList<Particle>();
    
    world = new PBox2D(this);
    world.createWorld();
}


void draw()
{
  background(BLACK, BACK_ALPHA);
  world.step();
  fountain.display();
  for (Particle p : particles) { p.display(); }
}
