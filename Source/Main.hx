package;

import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import events.StartEvent;
import events.EndEvent;
import screens.MainScreen;
import screens.BackpackScreen;
import loaders.JSONLoader;
import interfaces.FrameInterface;

import openfl.events.Event;
import openfl.display.Sprite;

class Main extends Sprite {
    private var time:Float;
    private var dt:Float;

    private var screen(null, null):Sprite;

    private var highscore(null, null):Int;

    public function new() {
        super();

        this.highscore = 0;
        this.time = Date.now().getTime();

        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);

        this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);

        this.startScreen();
    }

    private function startScreen():Void {
        this.screen = new MainScreen(this.highscore);
        this.screen.addEventListener(StartEvent.TYPE, this.onStart);

        this.addChild(this.screen);
    }

    private function backpackScreen():Void {
        this.screen = new BackpackScreen(JSONLoader.createLevel('models/model_test.json'));
        this.screen.addEventListener(EndEvent.TYPE, this.onEnd);

        this.addChild(this.screen);
    }

    public function onKeyDown(e:KeyboardEvent):Void {
        if (Std.is(this.screen, BackpackScreen)) {
            cast(this.screen, BackpackScreen).onKeyDown(e);
        }
    }

    public function onKeyUp(e:KeyboardEvent):Void {
        if (Std.is(this.screen, BackpackScreen)) {
            cast(this.screen, BackpackScreen).onKeyUp(e);
        }
    }

    private function onEnterFrame(e:Event):Void {
        var _time:Float = Date.now().getTime();

        this.dt = (_time - this.time);
        this.time = _time;

        if (null != this.screen && Std.is(this.screen, FrameInterface)) {
            cast(this.screen, FrameInterface).onFrame(this.dt);
        }
    }

    private function onStart(e:EndEvent):Void {
        if (null != this.screen) {
            if (this.screen.parent == this) {
                this.removeChild(this.screen);
            }

            this.screen = null;
        }

        this.backpackScreen();
    }

    private function onEnd(e:EndEvent):Void {
        if (null != this.screen) {
            if (this.screen.parent == this) {
                this.removeChild(this.screen);
            }

            this.screen = null;
        }

        this.highscore = Std.int(Math.max(e.score, this.highscore));

        this.startScreen();
    }
}