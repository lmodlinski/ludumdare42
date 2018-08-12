package screens;

import openfl.Assets;
import openfl.media.SoundChannel;
import events.StartEvent;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import interfaces.FrameInterface;

class MainScreen extends Sprite implements FrameInterface {
    private var asset(null, null):MainScreenAsset;

    private var ambient_sound(null, null):SoundChannel;

    public function new(h1:Int, h2:Int, h3:Int) {
        super();

        this.addChild(this.asset = new MainScreenAsset());

        this.asset.button_level_1.buttonMode = this.asset.button_level_2.buttonMode = this.asset.button_level_3.buttonMode = true;
        this.asset.button_level_1.addEventListener(MouseEvent.CLICK, this.onLevel1Click);
        this.asset.button_level_2.addEventListener(MouseEvent.CLICK, this.onLevel2Click);
        this.asset.button_level_3.addEventListener(MouseEvent.CLICK, this.onLevel3Click);

        this.asset.label_highscore_1.text = h1;
        this.asset.label_highscore_2.text = h2;
        this.asset.label_highscore_3.text = h3;

        this.ambient_sound = Assets.getSound('assets/Sounds/lobby_music.mp3').play();
    }

    private function onLevel1Click(e:MouseEvent):Void {
        if (null != this.ambient_sound) {
            this.ambient_sound.stop();
            this.ambient_sound = null;
        }

        this.dispatchEvent(new StartEvent('level_1'));
    }

    private function onLevel2Click(e:MouseEvent):Void {
        if (null != this.ambient_sound) {
            this.ambient_sound.stop();
            this.ambient_sound = null;
        }

        this.dispatchEvent(new StartEvent('level_2'));
    }

    private function onLevel3Click(e:MouseEvent):Void {
        if (null != this.ambient_sound) {
            this.ambient_sound.stop();
            this.ambient_sound = null;
        }

        this.dispatchEvent(new StartEvent('level_3'));
    }

    public function onFrame(dt:Float):Void {

    }
}
