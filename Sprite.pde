public class Sprite
{
  private PImage img;
  private float position_x;
  private float position_y;
  private float step_x;
  private float step_y;
  private float s_width;
  private float s_height;
  
  
  public Sprite(String ff, float p_x, float p_y, float scale)
  {
    img = loadImage(ff);
    position_x = p_x;
    position_y = p_y;
    s_width = img.width * scale;
    s_height = img.height * scale;
  }
  public void set_step_x(float step)
  {
    step_x = step;
  }
  public void set_step_y(float step)
  {
    step_y = step;
  }
  public void set_position_x(float position)
  {
    position_x = position;
  }
  public void set_position_y(float position)
  {
    position_y = position;
  }
  
  public void show()
  {
    image(img, position_x, position_y, s_width, s_height);
  }
  
  public void update_position()
  {
    position_x += step_x;
    position_y += step_y;
  }
  void setLeft(float left)
  {
    position_x = left + s_width/2;
  }
  void setRight(float right)
  {
    position_x = right - s_width/2;
  }
  void setTop(float top)
  {
    position_x = top + s_height/2;
  }
  void setBottom(float bottom)
  {
    position_y = bottom - s_height/2;
  }
  float getLeft()
  {
    return position_x - s_width/2;
  }
  float getRight()
  {
    return position_x + s_width/2;
  }
  float getTop()
  {
    return position_y - s_height/2;
  }
  float getBottom()
  {
    return  position_y + s_height/2;
  }
  float get_step_x()
  {
    return step_x;
  }
  float get_step_y()
  {
    return step_y;
  }
  float get_position_x()
  {
    return position_x;
  }
  float get_position_y()
  {
    return position_y;
  }
}
