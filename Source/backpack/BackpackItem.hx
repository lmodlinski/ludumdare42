package backpack;

import openfl.geom.Point;
import haxe.ds.StringMap;

import openfl.display.Sprite;

class BackpackItem {
    public var id(default, null):String;

    public var score(default, null):Int;
    public var image(default, null):Sprite;

    public var fields(default, null):StringMap<Point>;

    public var width(default, null):Int;
    public var height(default, null):Int;

    public function new(id:String, score:Int, image:Sprite, fields:StringMap<Point>, width:Int, height:Int) {
        this.id = id;

        this.score = score;
        this.image = image;

        this.fields = fields;

        this.width = width;
        this.height = height;
    }
}
