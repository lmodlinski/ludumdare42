package backpack;

import openfl.display.Sprite;

class BackpackItemImage extends Sprite {
    public var context(default, null):BackpackItemInstance;

    public var base_x(default, null):Float;
    public var base_y(default, null):Float;

    public function new(classname:String, context:BackpackItemInstance) {
        super();

        this.context = context;

        this.addChild(Type.createInstance(Type.resolveClass(classname), []));
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
