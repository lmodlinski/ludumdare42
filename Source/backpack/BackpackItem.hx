package backpack;

import openfl.geom.Point;
import haxe.ds.StringMap;

class BackpackItem {
    public var id(default, null):String;
    public var image_classname(default, null):String;

    public var score(default, null):Int;

    public var fields(default, null):StringMap<Point>;

    public var width(default, null):Int;
    public var height(default, null):Int;

    public function new(id:String, image_classname:String, score:Int, fields:StringMap<Point>, width:Int, height:Int) {
        this.id = id;
        this.image_classname = image_classname;

        this.score = score;

        this.fields = fields;

        this.width = width;
        this.height = height;
    }
}
