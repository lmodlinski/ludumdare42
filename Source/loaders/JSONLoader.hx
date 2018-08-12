package loaders;

import backpack.BackpackSlot;
import haxe.ds.StringMap;
import openfl.geom.Point;
import backpack.BackpackItem;
import backpack.Backpack;
import model.LevelModel;
import openfl.Assets;
import haxe.Json;
class JSONLoader {
    public function new() {
    }

    public static function createLevel(json_path:String = 'models/model.json'):LevelModel {
        var json = Json.parse(Assets.getText(json_path));

        var items:Array<BackpackItem> = new Array<BackpackItem>();
        for (item_raw in cast(json.items, Array<Dynamic>)) {
            var fields:StringMap<Point> = new StringMap<Point>();

            var width:Int = 0;
            var height:Int = 0;

            for (field_raw in cast(item_raw.fields, Array<Dynamic>)) {
                fields.set(field_raw.x + '_' + field_raw.y, new Point(field_raw.x, field_raw.y));

                if (field_raw.x + 1 > width) {
                    width = field_raw.x + 1;
                }

                if (field_raw.y + 1 > height) {
                    height = field_raw.y + 1;
                }
            }

            items.push(new BackpackItem(
            item_raw.id,
            item_raw.image,
            item_raw.score,
            item_raw.weight,
            fields,
            width,
            height
            ));

        }

        var backpack = json.backpack;

        var grid:StringMap<BackpackSlot> = new StringMap<BackpackSlot>();
        for (grid_raw in cast(backpack.fields, Array<Dynamic>)) {
            grid.set(grid_raw.x + '_' + grid_raw.y, new BackpackSlot(grid_raw.x, grid_raw.y));
        }

        var general = json.general;

        return new LevelModel(
        backpack.id,
        new Backpack(grid),
        items,
        general.hands_duration,
        general.total_duration,
        general.initial_score
        );
    }
}
