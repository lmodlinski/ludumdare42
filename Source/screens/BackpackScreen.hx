package screens;

import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import events.EndEvent;
import model.LevelModel;
import backpack.BackpackItemImage;
import backpack.BackpackSlot;
import backpack.BackpackItem;
import backpack.BackpackItemInstance;
import interfaces.FrameInterface;
import openfl.events.MouseEvent;
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

    private var model(null, null):LevelModel;

    private var hands_time(null, null):Float;

    private var dragged(null, null):BackpackItemInstance;
    private var dragging(null, null):Bool;

    private var score(null, null):Int;

    public function new(model:LevelModel) {
        super();

        this.addChild(this.asset = new BackpackScreenAsset());

        this.model = model;
        this.dragging = false;
        this.hands_time = 0.0;

        this.score = this.model.initial_score;

        var backpack_iterator:Iterator<BackpackSlot> = this.model.backpack.grid.iterator();
        while (backpack_iterator.hasNext()) {
            var backpack_slot:BackpackSlot = backpack_iterator.next();

            var tile:TileAsset = new TileAsset();
            this.addChild(tile);

            tile.x = GRID_X + backpack_slot.x * tile.width;
            tile.y = GRID_Y + backpack_slot.y * tile.height;
        }

        this.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);

        this.fillHandsWith(this.model.randomize());
    }

    public function onKeyDown(e:KeyboardEvent):Void {
        if (Keyboard.SPACE == e.keyCode && null != this.dragged) {
            this.dragged.rotate();

            var image:BackpackItemImage = this.dragged.item_image;
            image.x = this.stage.mouseX - image.width * 0.5;
            image.y = this.stage.mouseY - image.height * 0.5;
        }
    }

    public function onKeyUp(e:KeyboardEvent):Void {

    }

    public function onFrame(dt:Float):Void {
        this.asset.label_time.text = Std.int(this.hands_time / 1000.0);

        if ((this.hands_time += dt) > this.model.hands_duration) {
            this.dispatchEvent(new EndEvent(this.score));
        }
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
        if (null == this.dragged) {
            var image:BackpackItemImage = cast(e.currentTarget, BackpackItemImage);
            this.dragged = image.context;
        }
    }

    private function onMouseMove(e:MouseEvent):Void {
        if (null != this.dragged) {
            var image:BackpackItemImage = this.dragged.item_image;
            image.x = this.stage.mouseX - image.width * 0.5;
            image.y = this.stage.mouseY - image.height * 0.5;
        }
    }

    private function onMouseUp(e:MouseEvent):Void {
        if (null != this.dragged) {
            var context:BackpackItemInstance = this.dragged;
            this.dragged = null;

            var image:BackpackItemImage = context.item_image;
            var slot:BackpackSlot = null;

            var x:Float = image.x + TILE_WIDTH * 0.5;
            var y:Float = image.y + TILE_HEIGHT * 0.5;

            if (GRID_X <= x && x <= GRID_X + GRID_WIDTH * TILE_WIDTH && GRID_Y <= y && y <= GRID_Y + GRID_HEIGHT * TILE_HEIGHT) {
                slot = this.model.backpack.grid.get(Std.int((x - GRID_X) / TILE_WIDTH) + '_' + Std.int((y - GRID_Y) / TILE_HEIGHT));
            }

            if (null != slot && this.model.backpack.check(slot, context)) {
                var slots:Array<BackpackSlot> = this.model.backpack.put(slot, context);
                if (0 < slots.length) {
                    context.free();
                    context.occupy(slots);

                    this.preserveHandsItem(slot, context);

                    if (context == this.hands) {
                        this.score += context.item.score;
                        this.hands_time = 0.0;

                        this.fillHandsWith(this.model.randomize());

                        this.asset.label_score.text = this.score;
                    }
                } else {
                    image.returnToBase();
                }
            } else if (this.hands == context) {
                image.x = HANDS_X;
                image.y = HANDS_Y;
            } else {
                image.returnToBase();
            }
        }
    }
}
