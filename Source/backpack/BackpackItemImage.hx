package backpack;

import openfl.display.MovieClip;
import openfl.display.Sprite;

class BackpackItemImage extends Sprite {
    public var context(default, null):BackpackItemInstance;

    public var base_x(default, null):Float;
    public var base_y(default, null):Float;

    public var insides(default, null):MovieClip;
    public var angle(default, null):Int;

    public function new(classname:String, context:BackpackItemInstance) {
        super();

        this.angle = 0;

        this.context = context;

        this.insides = Type.createInstance(Type.resolveClass(classname), []);
        this.insides.stop();

        this.addChild(this.insides);
    }

    public function rotate():Void {
        this.insides.gotoAndStop('angle_' + (270 == angle ? angle = 0 : angle += 90));
    }

    public function setBase():Void {
        this.base_x = this.x;
        this.base_y = this.y;
    }

    public function returnToBase():Void {
        this.x = this.base_x;
        this.y = this.base_y;
    }
}
