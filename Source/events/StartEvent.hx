package events;

import openfl.events.Event;

class StartEvent extends Event {
    public static inline var TYPE:String = 'start_event';

    public var id(default, null):String;

    public function new(id:String) {
        super(TYPE);

        this.id = id;
    }
}