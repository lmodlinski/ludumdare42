package scores;

class Score {
    public var level(default, null):String;

    public var score(default, null):Int;
    public var items(default, null):Int;

    public function new(level:String, score:Int, items:Int) {
        this.level = level;

        this.score = score;
        this.items = items;
    }
}
