package screens;

import backpack.BackpackItemImage;
import backpack.BackpackSlot;
import openfl.events.MouseEvent;
import interfaces.FrameInterface;
import openfl.geom.Point;
import haxe.ds.StringMap;
import backpack.BackpackItem;
import backpack.BackpackSlot;
import backpack.BackpackItemInstance;
import backpack.Backpack;
import openfl.display.Sprite;

class BackpackScreen extends Sprite implements FrameInterface {
    private static inline var GRID_X:Float = 245.0;
    private static inline var GRID_Y:Float = 245.0;

    private static inline var GRID_WIDTH:Int = 18;
    private static inline var GRID_HEIGHT:Int = 8;

    private static inline var HANDS_X:Float = 60.0;
    private static inline var HANDS_Y:Float = 40.0;

    private static inline var TILE_WIDTH:Float = 54.0;
    private static inline var TILE_HEIGHT:Float = 54.0;

    private var asset(null, null):BackpackScreenAsset;
    private var hands(null, null):BackpackItemInstance;

    private var backpack(null, null):Backpack;

    public function new() {
        super();

        this.addChild(this.asset = new BackpackScreenAsset());

        var grid:StringMap<BackpackSlot> = new StringMap<BackpackSlot>();
        for (i in 0...18) {
            for (j in 0...8) {
                grid.set(i + '_' + j, new BackpackSlot(i, j, null));
            }
        }

        this.backpack = new Backpack(grid);

        var backpack_iterator:Iterator<BackpackSlot> = this.backpack.grid.iterator();
        while (backpack_iterator.hasNext()) {
            var backpack_slot:BackpackSlot = backpack_iterator.next();

            var tile:TileAsset = new TileAsset();
            this.addChild(tile);

            tile.x = GRID_X + backpack_slot.x * tile.width;
            tile.y = GRID_Y + backpack_slot.y * tile.height;
        }

        var item_fields:StringMap<Point> = new StringMap<Point>();
        item_fields.set('0_0', new Point(0, 0));
        item_fields.set('0_1', new Point(0, 1));
        item_fields.set('0_2', new Point(0, 2));
        item_fields.set('1_0', new Point(1, 0));
        item_fields.set('1_1', new Point(1, 1));
        item_fields.set('1_2', new Point(1, 2));

        var item:BackpackItem = new BackpackItem('test_object', 'Item2Asset', 15, item_fields, 1, 3);

        this.fillHandsWith(item);
    }

    public function onFrame(dt:Float):Void {

    }

    public function fillHandsWith(item:BackpackItem):Void {
        this.hands = new BackpackItemInstance(item);

        this.addChild(this.hands.item_image);
        this.hands.item_image.x = HANDS_X;
        this.hands.item_image.y = HANDS_Y;

        this.hands.item_image.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.hands.item_image.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }

    public function preserveHandsItem(slot:BackpackSlot, item:BackpackItemInstance):Void {
        item.item_image.x = GRID_X + slot.x * TILE_WIDTH;
        item.item_image.y = GRID_Y + slot.y * TILE_HEIGHT;
        item.item_image.setBase();
    }

    public function removeHandsItem():Void {
        if (null != this.hands) {
            if (this.hands.item_image.parent == this) {
                this.removeChild(this.hands.item_image);
            }

            this.hands.item_image.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.hands.item_image.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
    }

    private function onMouseDown(e:MouseEvent):Void {
        cast(e.currentTarget, Sprite).startDrag();
    }

    private function onMouseUp(e:MouseEvent):Void {
        var image:BackpackItemImage = cast(e.currentTarget, BackpackItemImage);
        image.stopDrag();

        var context:BackpackItemInstance = image.context;

        var slot:BackpackSlot = null;

        var x:Float = image.x + TILE_WIDTH * 0.5;
        var y:Float = image.y + TILE_HEIGHT * 0.5;

        if (GRID_X <= x && x <= GRID_X + GRID_WIDTH * TILE_WIDTH && GRID_Y <= y && y <= GRID_Y + GRID_HEIGHT * TILE_HEIGHT) {
            slot = this.backpack.grid.get(Std.int((x - GRID_X) / TILE_WIDTH) + '_' + Std.int((y - GRID_Y) / TILE_HEIGHT));
        }

        if (null != slot && this.backpack.check(slot, context)) {
            var slots:Array<BackpackSlot> = this.backpack.put(slot, context);
            if (0 < slots.length) {
                context.free();
                context.occupy(slots);
            }

            this.preserveHandsItem(slot, context);
            this.fillHandsWith(context.item);
        } else if (this.hands == context) {
            image.x = HANDS_X;
            image.y = HANDS_Y;
        } else {
            image.returnToBase();
        }
    }
}
