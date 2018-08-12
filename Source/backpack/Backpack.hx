package backpack;

import haxe.ds.StringMap;
import openfl.geom.Point;

import backpack.BackpackSlot;

class Backpack {
    public var grid(default, null):StringMap<BackpackSlot>;

    public function new(grid:StringMap<BackpackSlot>) {
        this.grid = grid;
    }

    public function check(slot:BackpackSlot, item:BackpackItemInstance):Array<BackpackSlot> {
        var iterator:Iterator<Point> = item.fields.iterator();

        var occupy_fields:Array<BackpackSlot> = [];

        while (iterator.hasNext()) {
            var point:Point = iterator.next();

            var x:Int = Std.int(point.x + slot.x);
            var y:Int = Std.int(point.y + slot.y);

            var cell_raw:Dynamic = this.grid.get(x + '_' + y);
            if (null != cell_raw) {
                var cell:BackpackSlot = cast(cell_raw, BackpackSlot);

                if (null != cell) {
                    occupy_fields.push(cell);
                } else {
                    occupy_fields = new Array<BackpackSlot>();

                    break;
                }
            } else {
                occupy_fields = new Array<BackpackSlot>();

                break;
            }
        }

        return occupy_fields;
    }

    public function put(slot:BackpackSlot, item:BackpackItemInstance):Array<BackpackSlot> {
        var occupy_fields:Array<BackpackSlot> = this.check(slot, item);
        var occupy_fields_filtered:Array<BackpackSlot> = new Array<BackpackSlot>();

        if (0 < occupy_fields.length) {
            for (field in occupy_fields) {
                if (field.item == item || !field.is_occupied) {
                    occupy_fields_filtered.push(field);
                } else {
                    occupy_fields_filtered = new Array<BackpackSlot>();

                    break;
                }
            }
        }

        if (0 < occupy_fields_filtered.length) {
            for (ocfield in occupy_fields_filtered) {
                ocfield.occupy(item);
            }
        }

        return occupy_fields_filtered;
    }

    public static function slot(x:Int, y:Int):String {
        return x + '_' + y;
    }
}
