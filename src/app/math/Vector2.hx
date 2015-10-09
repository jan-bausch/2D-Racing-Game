package app.math;


class Vector2Type {
    public var x:Float;
    public var y:Float;
    
    public function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
    }
    
    public function toString():String {
        return '($x, $y)';
    }
}


@:forward(x, y)
abstract Vector2(Vector2Type) from Vector2Type to Vector2Type {

    
    //Betrag
    public var length(get, never):Float;
    
    //Winkel zwischen Vektor und Y-Achse (Im Uhrzeigersinn aufsteigend)
    public var angle(get, never): Float;
    

    public inline function new(x:Float, y:Float) this = new Vector2Type(x, y);

    
    //Bildet Vektor aus einem Winkel und Radius
    public static inline function fromPolar(angle:Float, radius:Float = 1):Vector2 {

    	angle = (angle-90)*(Math.PI / 180);
        return new Vector2(radius * Math.cos(angle), radius * Math.sin(angle));
    }
    

    
    //Skalarprodukt
    @:op(A * B)
    public static inline function dot(a:Vector2, b:Vector2) : Float {
        return
            a.x * b.x +
            a.y * b.y;
    }
    
    //Multiplikation mit einem Skalar
    @:op(A * B)
    @:commutative
    public static inline function multiply(a:Vector2, s:Float) : Vector2 {
        return new Vector2(a.x * s, a.y * s);
    }
    
    //Division mit einem Skalar
    @:op(A / B)
    public static inline function divide(a:Vector2, s:Float) : Vector2 {
        return new Vector2(a.x / s, a.y / s);
    }
    
    //Addition
    @:op(A + B)
    public static inline function add(a:Vector2, b:Vector2) : Vector2 {
        return new Vector2(a.x + b.x, a.y + b.y);
    }
    
    //Division
    @:op(A - B)
    public static inline function subtract(a:Vector2, b:Vector2) : Vector2 {
        return new Vector2(a.x - b.x, a.y - b.y);
    }
    
    //Negativ
    @:op(-A)
    public static inline function negate(a:Vector2) : Vector2 {
        return new Vector2(
            -a.x,
            -a.y);
    }
    
    //Prüft, ob zwei Vektoren gleich sind
    @:op(A == B)
    public static inline function equals(a:Vector2, b:Vector2) : Bool {
        return (a == null && b == null) ||
            a != null &&
            b != null &&
            a.x == b.x &&
            a.y == b.y;
    }
    
    
    //Kopie des Vektors, der nicht auf den Vektor verweist
    public inline function clone() : Vector2 {
        var self:Vector2 = this;
        return new Vector2(self.x, self.y);
    }


    //Winkel zu einem anderen Vektor
    public inline function angleTo(b:Vector2):Float
    {
        return (b - this).angle;
    }
    

    //Abstand zu einem anderen Vektor
    public inline function distanceTo(b:Vector2) : Float {
        var self:Vector2 = this;
        
        return (self - b).length;
    }
    
    //Normalisieren
    public inline function normalize() : Vector2 {
        var self:Vector2 = this;
        
        var length = self.length;
        
        if (length > 0.0)
        {
            self /= length;
        }
        
        return self;
    }
    

    


    //Rotation im Uhrzeigersinn (ggf. um einen anderen Drehpunkt)
    public inline function rotate(angle:Float, ?pivot:Vector2) : Vector2 {
        var self:Vector2 = this;
        
        angle = (angle)*(Math.PI / 180);

        var dx = self.x;
        var dy = self.y;
        
        if (pivot != null) {
            dx -= pivot.x;
            dy -= pivot.y;
        }

        self.x = dx * Math.cos(angle) - dy * Math.sin(angle);
        self.y = dx * Math.sin(angle) + dy * Math.cos(angle);
        
        return self;
    }
    
    //Drehen um 90° gegen den Uhrzeigersinn
    public inline function rotateLeft() : Vector2 {
        var self:Vector2 = this;
        
        var newX = -self.y;
        self.y = self.x;
        self.x = newX;
        
        return self;
    }
    
    //Drehen um 90° im Uhrzeigersinn 
    public inline function rotateRight() :Vector2 {
        var self:Vector2 = this;
        
        var newX = self.y;
        self.y = -self.x;
        self.x = newX;
        
        return self;
    }
    
    
    private inline function get_length():Float
    {
        var self:Vector2 = this;
        return Math.sqrt(
            self.x * self.x +
            self.y * self.y);
    }

    
    private inline function get_angle():Float
    {
        var self:Vector2 = this;
        return Math.atan2(self.y, self.x) *(180/Math.PI) + 90;
    }
    
}
