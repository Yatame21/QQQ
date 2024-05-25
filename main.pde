Sprite bobik;

String img1;
String img2;
String img3;
String img4;

final static String player = "data/toad-1.png";
final static float SPRITE_SIZE = 50f;
final static float SPRITE_SCALE = SPRITE_SIZE/64;
final static float MOVE_SPEED = 3f;
final static float GRAVITY = 0.5;
final static float LEFT_MARGIN = 50f;
final static float RIGHT_MARGIN = 500f;
final static float VERTICAL_MARGIN = 50f;
final static float GROUND = SPRITE_SIZE * 12;
final static float WIN_LENGTH = SPRITE_SIZE * 32;

float view_x;
float view_y;

boolean gameOver;

ArrayList<Sprite> platforms;

void setup()
{
  gameOver = false;
  view_x = 0;
  view_y = 0;  
  imageMode(CENTER);
  size(810, 700);
  bobik = new Sprite(player, 300,370, 1f);
  platforms = new ArrayList<Sprite>();
  
  img1="data/1.png";
  img2="data/2.png";
  img3="data/3.png";
  img4="data/4.png";
  
  createPlatforms("data/map.csv");
  
}

void draw()
{
  background(#8AB6FC);
  scroll();

    update();
}

void update()
{
  resolvePlatformCollisions(bobik, platforms);
  checkDeath();
  checkWin();
  show();
}

void checkDeath()
{
  if (bobik.getBottom() > GROUND)
  {
    gameOver = true;
  }
}

void checkWin()
{
  if(bobik.getRight() > WIN_LENGTH)
  {
    gameOver = true;
  }
}

void show()
{
   bobik.show(); 
   for(Sprite sprite: platforms)
    sprite.show();
    
   if (gameOver)
   {
     textSize(32);
     fill(0, 102, 153);
     text("Игра завершена!", view_x + width/2 - 100, view_y + height/2 - 10);
     if (bobik.getBottom() > GROUND)
     {
       text("Бобик погиб!", view_x + width/2 - 100, view_y +  height/2 - 60);
     }
     else
     {
       text("Вы прошли игру!", view_x + width/2 - 100, view_y + height/2 - 60);
     }
   }
}

void keyPressed()
{
  if(keyCode == RIGHT)
  {
    bobik.set_step_x(MOVE_SPEED);
  }
  else if(keyCode == LEFT)
  {
    bobik.set_step_x(-MOVE_SPEED);
  }  
  if(keyCode == UP)
  {
    bobik.set_step_y(-MOVE_SPEED);
  }
  else if(keyCode == DOWN)
  {
    bobik.set_step_y(MOVE_SPEED);
  }
  else if (gameOver && keyCode == ENTER)
  {
    setup();
  }
}  

void keyReleased()
{
  if(keyCode == RIGHT)
  {
    bobik.set_step_x(0);
  }
  else if(keyCode == LEFT)
  {
    bobik.set_step_x(0);
  }  
  if(keyCode == UP)
  {
    bobik.set_step_y(0);
  }
  else if(keyCode == DOWN)
  {
    bobik.set_step_y(0);
  }
}

void createPlatforms(String ff)
{
  String[] lines = loadStrings(ff);
  
  for(int row = 0; row < lines.length; row++)
  {
    String[] cells = split(lines[row], ",");
    
    for(int col = 0; col <cells.length;col++)
    {
      if(cells[col].equals("1"))
      {
        Sprite sp = new Sprite(img1,0,0,SPRITE_SCALE);
        sp.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sp.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sp);
      }
      else if(cells[col].equals("2"))
      {
        Sprite sp = new Sprite(img2,0,0,SPRITE_SCALE);
        sp.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sp.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sp);
      }
      else if(cells[col].equals("3"))
      {
        Sprite sp = new Sprite(img3,0,0,SPRITE_SCALE);
        sp.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sp.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sp);
      }
      else if(cells[col].equals("4"))
      {
        Sprite sp = new Sprite(img4,0,0,SPRITE_SCALE);
        sp.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sp.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sp);
      }
    }
  }
}
public ArrayList<Sprite> checkCollisionsList(Sprite sprite, ArrayList<Sprite> list)
{
  ArrayList<Sprite> collisions_list = new ArrayList<Sprite>();
  for(Sprite s: list)
  {
    if (checkCollision(sprite, s))
    {
      collisions_list.add(s);
    }
  }
  return collisions_list;
}
      
boolean checkCollision(Sprite sprite1, Sprite sprite2)
{
  boolean noXCross = sprite1.getRight() <= sprite2.getLeft() || sprite1.getLeft() >= sprite2.getRight();
  boolean noYCross = sprite1.getBottom() <= sprite2.getTop() || sprite1.getTop() >= sprite2.getBottom();
  
  if (noXCross || noYCross)
  {
    return false;
  }
  else
  {
    return true;
  }
}

public void resolvePlatformCollisions(Sprite sprite, ArrayList<Sprite> platfs)
{
  sprite.set_step_y(sprite.get_step_y() + GRAVITY);
  sprite.set_position_y(sprite.get_position_y() + sprite.get_step_y());
  
  ArrayList<Sprite> collisions_list = checkCollisionsList(sprite, platfs);
  
  if(collisions_list.size() > 0)
  {
    Sprite collided = collisions_list.get(0);
    if(sprite.get_step_y() > 0 )
    {
       sprite.setBottom(collided.getTop());
    }
    else if(sprite.get_step_y() < 0)
    {
      sprite.setTop(collided.getBottom());
    }
    sprite.set_step_y(0);
  }
  
  sprite.set_position_x(sprite.get_position_x() + sprite.get_step_x());
  collisions_list = checkCollisionsList(sprite, platfs);
  
  if(collisions_list.size() > 0)
  {
    Sprite collided = collisions_list.get(0);
    if(sprite.get_step_x() > 0 )
    {
       sprite.setRight(collided.getLeft());
    }
    else if(sprite.get_step_x() < 0)
    {
      sprite.setLeft(collided.getRight());
    }
  }
}

void scroll()
{
  float right_bound = view_x + width - RIGHT_MARGIN;
  if(bobik.getRight() > right_bound)
  {
    view_x += bobik.getRight() - right_bound;
  }
  
  float left_bound = view_x + LEFT_MARGIN;
  if(bobik.getLeft() < left_bound)
  {
    view_x -= left_bound - bobik.getLeft();
  }
  
  float bottom_bound = view_y + height - VERTICAL_MARGIN;
  if(bobik.getBottom() > bottom_bound)
  {
    view_y  += bobik.getBottom() - bottom_bound;
  }
  
  float top_bound = view_y + VERTICAL_MARGIN;
  if(bobik.getTop() < top_bound)
  {
    view_y  -= top_bound - bobik.getTop();
  }
  translate(-view_x, -view_y);
}
