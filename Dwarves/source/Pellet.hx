import flixel.*;

class Pellet extends FlxSprite
{
    public var parent : PlayState = null;
    public var iSpeed : Int = 50;
    public var bAlive : Bool = true;
    public var grav : Int = 420;
    public function new(p : PlayState, X : Int, Y : Int, bRight : Bool)
    {
        super(30, 30);
        
        loadGraphic(Content.cPellet, true, true, 7, 7);
        
        animation.add("d", [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 
                8, 8, 8, 8, 8, 8, 8, 8, 8, 8
        ], 20, false);
        
        this.x = X;
        this.y = Y;
        
        animation.play("d");
        
        if (bRight)
        {
            facing = Content.RIGHT;
            velocity.x = iSpeed;
        }
        else
        {
            facing = Content.LEFT;
            velocity.x = -iSpeed;
        }
        
        acceleration.y = grav;  //gravity  
        maxVelocity.y = 800;
        
        velocity.y = grav * -0.4;
    }
    
    public var wasfalling : Float = 0;
    public var wastraveling : Float = 0;
    override public function update(elapsed : Float) : Void
    {
        if (isTouching(Content.DOWN))
        {
            if (wasfalling > 3)
            {
                velocity.y = wasfalling * -0.4;
                
                if (velocity.y < grav * -0.6)
                {
                    velocity.y = grav * -0.6;
                }
            }
            
            velocity.x *= 0.85;
        }
        
        if (isTouching(Content.LEFT))
        {
            if (wastraveling < 0)
            {
                velocity.x = wastraveling * -1;
            }
            
            velocity.x *= 0.99;
        }
        else if (isTouching(Content.RIGHT))
        {
            if (wastraveling > 0)
            {
                velocity.x = wastraveling * -1;
            }
            
            velocity.x *= 0.99;
        }
        
        velocity.x *= 0.995;
        
        if (Math.abs(velocity.x) < 12)
        {
            velocity.x = 0;
        }
        
        if (velocity.x < 0)
        {
            facing = Content.LEFT;
        }
        
        if (velocity.x > 0)
        {
            facing = Content.RIGHT;
        }
        
        if (velocity.y == 0)
        {
            bAlive = false;
        }
        else
        {
            bAlive = true;
        }
        
        wastraveling = velocity.x;
        wasfalling = velocity.y;
    }
}

