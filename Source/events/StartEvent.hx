package events;

import openfl.events.Event;

class StartEvent extends Event {
    public static inline var TYPE:String = 'start_event';

    public function new() {
        super(TYPE);
    }
}
