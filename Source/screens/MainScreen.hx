package screens;

import events.StartEvent;
import openfl.events.MouseEvent;
import interfaces.FrameInterface;
import openfl.display.Sprite;

class MainScreen extends Sprite implements FrameInterface {
    private var asset(null, null):MainScreenAsset;

    private var button_start(null, null):ButtonStartAsset;

    public function new(score:Int) {
        super();

        this.addChild(this.asset = new MainScreenAsset());

        this.addChild(this.button_start = new ButtonStartAsset());
        this.button_start.x = 358.0;
        this.button_start.y = 517.0;
        this.button_start.addEventListener(MouseEvent.CLICK, this.onClick);
        this.button_start.buttonMode = true;

        this.asset.label_highscore.text = score;
    }

    private function onClick(e:MouseEvent):Void {
        this.dispatchEvent(new StartEvent());
    }

    public function onFrame(dt:Float):Void {

    }
}
