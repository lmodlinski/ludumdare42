package backpack;

class BackpackSlot {
    public var x(default, null):Int;
    public var y(default, null):Int;

    public var item(default, null):BackpackItemInstance;

    public var is_occupied(get, never):Bool;

    public function new(x:Int, y:Int, ?item:BackpackItemInstance) {
        this.x = x;
        this.y = y;

        this.item = item;
    }

    public function occupy(item:BackpackItemInstance):Void {
        this.item = item;
    }

    public function free():Void {
        this.item = null;
    }

    public function get_is_occupied():Bool {
        return null != this.item;
    }
}
