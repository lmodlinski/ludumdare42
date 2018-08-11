package backpack;

import openfl.geom.Point;

import backpack.BackpackSlot;

class Backpack {
    public var grid(default, null):Array<Array<BackpackSlot>>;

    public function new(grid:Array<Array<BackpackSlot>>) {
        this.grid = grid;
    }

    public function check(slot:BackpackSlot, item:BackpackItemInstance):Bool {
        var iterator:Iterator<Point> = item.fields.iterator();
        var result:Bool = true;

        while (iterator.hasNext()) {
            var point:Point = iterator.next();

            var x:Int = Std.int(point.x + slot.x);
            var y:Int = Std.int(point.y + slot.y);

            if (null == this.grid[x] || null == this.grid[x][y] || this.grid[x][y].is_occupied) {
                result = false;

                break;
            }
        }

        return result;
    }

    public function put(slot:BackpackSlot, item:BackpackItemInstance):Void {
        var iterator:Iterator<Point> = item.fields.iterator();

        var occupy_fields:Array<BackpackSlot> = [];
        var occupied_already = false;

        while (iterator.hasNext()) {
            var point:Point = iterator.next();

            var x:Int = Std.int(point.x + slot.x);
            var y:Int = Std.int(point.y + slot.y);

            if (null != this.grid[x] && null != this.grid[x][y] && !this.grid[x][y].is_occupied) {
                occupy_fields.push(this.grid[x][y]);
            } else {
                occupied_already = true;

                break;
            }
        }

        if (!occupied_already) {
            for (field in occupy_fields) {
                field.occupy(item);
            }
        }
    }
}
