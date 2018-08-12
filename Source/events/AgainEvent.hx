package events;

import scores.Score;
import openfl.events.Event;

class AgainEvent extends Event {
    public static inline var TYPE:String = 'summary_event';

    public var score(default, null):Score;

    public function new(score:Score) {
        super(TYPE);

        this.score = score;
    }
}
