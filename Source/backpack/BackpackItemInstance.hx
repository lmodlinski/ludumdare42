package backpack;

import openfl.geom.Point;
import haxe.ds.StringMap;

class BackpackItemInstance {
    public var item(default, null):BackpackItem;

    public var fields(default, null):StringMap<Point>;

    public var width(default, null):Int;
    public var height(default, null):Int;

    public function new(item:BackpackItem) {
        this.item = item;

        this.width = item.width;
        this.height = item.height;

        this.fields = new StringMap<Point>();
        
        for (field in item.fields) {
            this.fields.set(field.x + '_' + field.y, field.clone());
        }
    }

    public function rotate():Void {
        var fields:StringMap<Point> = new StringMap<Point>();

        for (field in this.fields) {
            var point:Point = new Point(field.y, this.width - 1 - field.x);

            fields.set(point.x + '_' + point.y, point);
        }

        var swap:Int = this.width;
        this.width = this.height;
        this.height = swap;

        this.fields = fields;
    }
}
