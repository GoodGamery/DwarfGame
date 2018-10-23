import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFieldType;
import flixel.*;

//Allows you to refer to flixel objects in your code
//600 or 672
@:meta(SWF(width="1640",height="712",backgroundColor="#000000"))
  //Set the size and color of the Flash file  
class HelloWorld extends FlxGame
{
    public function new()
    {
        super(Content.screenwidth + 400, Content.screenheight + 36, PlayState, 2, 60, 60, true);  //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState  
        
        this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseBegin);
    }
    
    public static var bPressed : Bool = false;
    
    public function onMouseBegin(evt : MouseEvent) : Void
    {
        Util.bPressed = true;
        
        Util.startx = evt.localX;
        Util.starty = evt.localY;
        
        Util.currentx = Util.startx;
        Util.currenty = Util.starty;
        
        this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        this.addEventListener(MouseEvent.MOUSE_UP, onMouseEnd);
    }
    
    public function onMouseMove(evt : MouseEvent) : Void
    {
        Util.currentx = evt.localX;
        Util.currenty = evt.localY;
        
        (try cast(FlxG.state, PlayState) catch(e:Dynamic) null).Move();
    }
    
    public function onMouseEnd(evt : MouseEvent) : Void
    {
        Util.bPressed = false;
        
        Util.currentx = evt.localX;
        Util.currenty = evt.localY;
        
        if (Util.Distance(Util.startx, Util.starty, Util.currentx, Util.currenty) < Util.nFailThreshold)
        {
            (try cast(FlxG.state, PlayState) catch(e:Dynamic) null).Tap(Util.startx, Util.starty);
        }
        
        (try cast(FlxG.state, PlayState) catch(e:Dynamic) null).Up();
        
        this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        this.removeEventListener(MouseEvent.MOUSE_UP, onMouseEnd);
    }
}

