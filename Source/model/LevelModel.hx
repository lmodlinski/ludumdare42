package model;

import backpack.BackpackItem;
import backpack.Backpack;

class LevelModel {
    public var id(default, null):String;

    public var backpack(default, null):Backpack;
    public var backpack_items(default, null):Array<BackpackItem>;

    public var total_weight(default, null):Int;

    public var hands_duration(default, null):Int;
    public var total_duration(default, null):Int;

    public var initial_score(default, null):Int;

    public function new(id:String, backpack:Backpack, backpack_items:Array<BackpackItem>, hands_duration:Int, total_duration:Int, initial_score:Int) {
        this.id = id;
        this.backpack = backpack;
        this.backpack_items = backpack_items;

        this.total_weight = 0;

        for (item in backpack_items) {
            this.total_weight += item.weight;
        }

        this.hands_duration = hands_duration;
        this.total_duration = total_duration;
        this.initial_score = initial_score;
    }

    public function randomize():BackpackItem {
        var weight:Int = 0;
        var random:Float = Math.random() * this.total_weight;

        var selected:BackpackItem = null;

        for (item in this.backpack_items) {
            selected = item;

            if (weight <= random && random < (weight += item.weight)) {
                break;
            }
        }

        return selected;
    }
}
