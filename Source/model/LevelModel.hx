package model;

import Random;
import backpack.BackpackItem;
import backpack.Backpack;

class LevelModel {
    public var backpack(default, null):Backpack;
    public var backpack_items(default, null):Array<BackpackItem>;

    public var hands_duration(default, null):Int;
    public var total_duration(default, null):Int;

    public var initial_score(default, null):Int;

    public function new(backpack:Backpack, backpack_items:Array<BackpackItem>, hands_duration:Int, total_duration:Int, initial_score:Int) {
        this.backpack = backpack;
        this.backpack_items = backpack_items;

        this.hands_duration = hands_duration;
        this.total_duration = total_duration;
        this.initial_score = initial_score;
    }

    public function randomize():BackpackItem {
        return this.backpack_items[Random.int(0, this.backpack_items.length - 1)];
    }
}
