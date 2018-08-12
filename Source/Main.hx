package;

import screens.SummaryScreen;
import scores.Score;
import events.AgainEvent;
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

    private var highscore_1(null, null):Int;
    private var highscore_2(null, null):Int;
    private var highscore_3(null, null):Int;

    public function new() {
        super();

        this.highscore_1 = 0;
        this.highscore_2 = 0;
        this.highscore_3 = 0;

        this.time = Date.now().getTime();

        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);

        this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);

        this.startScreen();
    }

    private function startScreen():Void {
        this.screen = new MainScreen(this.highscore_1, this.highscore_2, this.highscore_3);
        this.screen.addEventListener(StartEvent.TYPE, this.onStart);

        this.addChild(this.screen);
    }

    private function summaryScreen(score:Score):Void {
        this.screen = new SummaryScreen(score);
        this.screen.addEventListener(AgainEvent.TYPE, this.onAgain);

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

    private function onStart(e:StartEvent):Void {
        if (null != this.screen) {
            if (this.screen.parent == this) {
                this.removeChild(this.screen);
            }

            this.screen = null;
        }

        switch(e.id){
            case 'level_1' | 'level_2' | 'level_3':
                this.screen = new BackpackScreen(JSONLoader.createLevel('models/' + e.id + '.json'));
                this.screen.addEventListener(EndEvent.TYPE, this.onEnd);

                this.addChild(this.screen);
        }
    }

    private function onEnd(e:EndEvent):Void {
        if (null != this.screen) {
            if (this.screen.parent == this) {
                this.removeChild(this.screen);
            }

            this.screen = null;
        }

        switch(e.score.level){
            case 'level_1':
                this.highscore_1 = Std.int(Math.max(e.score.score, this.highscore_1));
            case 'level_2':
                this.highscore_2 = Std.int(Math.max(e.score.score, this.highscore_2));
            case 'level_3':
                this.highscore_3 = Std.int(Math.max(e.score.score, this.highscore_3));
        }

        this.summaryScreen(e.score);
    }

    private function onAgain(e:AgainEvent):Void {
        if (null != this.screen) {
            if (this.screen.parent == this) {
                this.removeChild(this.screen);
            }

            this.screen = null;
        }

        switch(e.score.level){
            case 'level_1':
                this.highscore_1 = Std.int(Math.max(e.score.score, this.highscore_1));
            case 'level_2':
                this.highscore_2 = Std.int(Math.max(e.score.score, this.highscore_2));
            case 'level_3':
                this.highscore_3 = Std.int(Math.max(e.score.score, this.highscore_3));
        }

        this.startScreen();
    }
}