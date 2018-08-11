package;


import haxe.ds.StringMap;

import backpack.BackpackItemInstance;
import backpack.BackpackItem;
import backpack.BackpackSlot;
import backpack.Backpack;

import openfl.geom.Point;
import openfl.display.Sprite;

class Main extends Sprite {

    public function new() {
        super();

        var grid:Array<Array<BackpackSlot>> = new Array<Array<BackpackSlot>>();

        for (i in 0...3) {
            grid[i] = new Array<BackpackSlot>();

            for (j in 0...3) {
                grid[i][j] = new BackpackSlot(i, j, null);
            }
        }

        var backpack:Backpack = new Backpack(grid);

        var slot:BackpackSlot = new BackpackSlot(1, 0, null);

        var backpack_item_fields:StringMap<Point> = new StringMap<Point>();
        backpack_item_fields.set('0_0', new Point(0, 0));
        backpack_item_fields.set('0_1', new Point(0, 1));
        backpack_item_fields.set('0_2', new Point(0, 2));

        var backpack_item:BackpackItem = new BackpackItem('test_object', 15, null, backpack_item_fields, 1, 3);
        var backpack_item_instance:BackpackItemInstance = new BackpackItemInstance(backpack_item);

        js.Browser.console.log('Result is: ' + backpack.check(slot, backpack_item_instance));

        backpack_item_instance.rotate();
        backpack_item_instance.rotate();
        backpack_item_instance.rotate();

        js.Browser.console.log('Result (+270) is: ' + backpack.check(slot, backpack_item_instance));

        backpack.put(slot, backpack_item_instance);

        js.Browser.console.log('After puting: ' + backpack.check(slot, backpack_item_instance));
    }
}