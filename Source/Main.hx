package;


import interfaces.FrameInterface;
import screens.BackpackScreen;

import openfl.events.Event;
import openfl.display.Sprite;

class Main extends Sprite {
    private var time:Float;
    private var dt:Float;

    private var screen(null, null):FrameInterface;

    public function new() {
        super();

        var backpack_screen:BackpackScreen = new BackpackScreen();
        this.addChild(backpack_screen);

        this.screen = backpack_screen;

        this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(e:Event):Void {
        var _time:Float = Date.now().getTime();

        this.dt += (_time - this.time);
        this.time = _time;

        if (null != this.screen) {
            this.screen.onFrame(this.dt);
        }
    }
}