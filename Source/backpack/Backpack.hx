package backpack;

import haxe.ds.StringMap;
import openfl.geom.Point;

import backpack.BackpackSlot;

class Backpack {
    public var grid(default, null):StringMap<BackpackSlot>;

    public function new(grid:StringMap<BackpackSlot>) {
        this.grid = grid;
    }

    public function check(slot:BackpackSlot, item:BackpackItemInstance):Bool {
        var iterator:Iterator<Point> = item.fields.iterator();
        var result:Bool = true;

        while (iterator.hasNext()) {
            var point:Point = iterator.next();

            var x:Int = Std.int(point.x + slot.x);
            var y:Int = Std.int(point.y + slot.y);

            var cell_raw:Dynamic = this.grid.get(x + '_' + y);
            if (null != cell_raw) {
                var cell:BackpackSlot = cast(cell_raw, BackpackSlot);

                if (null == cell || (cell.item != item && cell.is_occupied)) {
                    result = false;

                    break;
                }
            } else {
                result = false;

                break;
            }
        }

        return result;
    }

    public function put(slot:BackpackSlot, item:BackpackItemInstance):Array<BackpackSlot> {
        var iterator:Iterator<Point> = item.fields.iterator();

        var occupy_fields:Array<BackpackSlot> = [];
        var occupied_already = false;

        while (iterator.hasNext()) {
            var point:Point = iterator.next();

            var x:Int = Std.int(point.x + slot.x);
            var y:Int = Std.int(point.y + slot.y);

            var cell_raw:Dynamic = this.grid.get(x + '_' + y);
            if (null != cell_raw) {
                var cell:BackpackSlot = cast(cell_raw, BackpackSlot);

                if (null != cell && (cell.item == item || !cell.is_occupied)) {
                    occupy_fields.push(cell);
                } else {
                    occupied_already = true;
                    occupy_fields = new Array<BackpackSlot>();

                    break;
                }
            } else {
                occupied_already = true;
                occupy_fields = new Array<BackpackSlot>();

                break;
            }
        }

        if (!occupied_already) {
            for (field in occupy_fields) {
                field.occupy(item);
            }
        }

        return occupy_fields;
    }
}
