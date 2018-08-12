package screens;

import events.AgainEvent;
import flash.events.MouseEvent;
import scores.Score;
import interfaces.FrameInterface;
import openfl.display.Sprite;

class SummaryScreen extends Sprite implements FrameInterface {
    private var asset(null, null):SummaryScreenAsset;

    private var score(null, null):Score;

    public function new(score:Score) {
        super();

        this.score = score;

        this.addChild(this.asset = new SummaryScreenAsset());

        this.asset.label_score.text = score.score;
        this.asset.label_items.text = score.items;

        this.asset.button_again.addEventListener(MouseEvent.CLICK, this.onAgainClick);
    }

    private function onAgainClick(e:MouseEvent):Void {
        this.dispatchEvent(new AgainEvent(this.score));
    }

    public function onFrame(dt:Float):Void {

    }
}
