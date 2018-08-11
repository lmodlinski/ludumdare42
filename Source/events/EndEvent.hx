package events;

import openfl.events.Event;

class EndEvent extends Event {
    public static inline var TYPE:String = 'end_event';

    public var score(default, null):Int;

    public function new(score:Int) {
        super(TYPE);

        this.score = score;
    }
}
