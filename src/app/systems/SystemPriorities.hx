package app.systems;

//In dieser Klasse ist die Priorität, d.h. die Reinfolge, in der die System aufgerufen werden, festgelegt.
//Je kleiner die Zahl, desto früher wird ein System aufgerufen.
class SystemPriorities {

    public static inline var preUpdate:Int = 1;
    public static inline var update:Int = 2;
    public static inline var collisions:Int = 3;
    public static inline var render:Int = 4;
    public static inline var last:Int = 4;
}