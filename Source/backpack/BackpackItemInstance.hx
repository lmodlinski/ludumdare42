package backpack;

import openfl.geom.Point;
import haxe.ds.StringMap;

class BackpackItemInstance {
    public var item(default, null):BackpackItem;
    public var item_image(default, null):BackpackItemImage;

    public var fields(default, null):StringMap<Point>;
    public var slots(default, null):Array<BackpackSlot>;

    public var width(default, null):Int;
    public var height(default, null):Int;

    public function new(item:BackpackItem) {
        this.item = item;
        this.item_image = new BackpackItemImage(item.image_classname, this);

        this.width = item.width;
        this.height = item.height;

        this.slots = new Array<BackpackSlot>();
        this.fields = new StringMap<Point>();

        for (field in item.fields) {
            this.fields.set(field.x + '_' + field.y, field.clone());
        }
    }

    public function free():Void {
        for (slot in this.slots) {
            slot.free();
        }

        this.slots = new Array<BackpackSlot>();
    }

    public function occupy(slots:Array<BackpackSlot>):Void {
        this.slots = slots;
    }

    public function rotate():Void {
        var fields:StringMap<Point> = new StringMap<Point>();

        for (field in this.fields) {
            var point:Point = new Point(field.y, this.width - 1 - field.x);

            fields.set(point.x + '_' + point.y, point);
        }

        this.item_image.rotate();

        var swap:Int = this.width;
        this.width = this.height;
        this.height = swap;

        this.fields = fields;
    }
}
