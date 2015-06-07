package app.math;

typedef Vector2Shape =
{
    public var x:Float;
    public var y:Float;
}

/**
 * The default underlying type.
 */
class Vector2Default
{
    public var x:Float;
    public var y:Float;
    
    public function new(x:Float, y:Float)
    {
        this.x = x;
        this.y = y;
    }
    
    public function toString():String
    {
        return '($x, $y)';
    }
}

#if HXMATH_USE_OPENFL_STRUCTURES
typedef Vector2Type = flash.geom.Point;
#else
typedef Vector2Type = Vector2Default;
#end

/**
 * A 2D vector.
 */
@:forward(x, y)
abstract Vector2(Vector2Type) from Vector2Type to Vector2Type
{
    // The number of elements in this structure
    public static inline var elementCount:Int = 2;
    
    // Zero vector (v + 0 = v)
    public static var zero(get, never):Vector2;
    
    // X axis (1, 0)
    public static var xAxis(get, never):Vector2;
    
    // Y axis (0, 1)
    public static var yAxis(get, never):Vector2;
    
    // Magnitude
    public var length(get, never):Float;
    
    // Vector dotted with itself
    public var lengthSq(get, never):Float;
    
    // The angle between this vector and the X axis
    public var angle(get, never):Float;
    
    // The normalized vector
    public var normal(get, never):Vector2;
    
    // 90 degree rotation to the left
    public var rotatedLeft(get, never):Vector2;
    
    // 90 degree rotation to the right
    public var rotatedRight(get, never):Vector2;
    
    /**
     * Constructor.
     * 
     * @param x
     * @param y
     */
    public inline function new(x:Float, y:Float)
    {
        #if HXMATH_USE_OPENFL_STRUCTURES
        this = new flash.geom.Point(x, y);
        #else
        this = new Vector2Default(x, y);
        #end
    }
    
    
    /**
     * Create a new Vector2 from polar coordinates.
     * Example angle-to-vector direction conversions:
     *   0       radians -> +X axis
     *   (1/2)pi radians -> +Y axis
     *   pi      radians -> -X axis
     *   (3/2)pi radians -> -Y axis
     * 
     * @param angle     The angle of the vector (counter-clockwise from the +X axis) in radians.
     * @param radius    The length of the vector.
     * @return          The vector.
     */
    public static inline function fromPolar(angle:Float, radius:Float):Vector2
    {
    	angle = (angle-90)*(Math.PI / 180);
        return new Vector2(radius * Math.cos(angle), radius * Math.sin(angle));
    }
    

    
    /**
     * Dot product.
     * 
     * @param a
     * @param b
     * @return      sum_i (a_i * b_i)
     */
    @:op(A * B)
    public static inline function dot(a:Vector2, b:Vector2):Float
    {
        return
            a.x * b.x +
            a.y * b.y;
    }
    
    /**
     * Multiply a scalar with a vector.
     * 
     * @param a
     * @param s
     * @return      s * a
     */
    @:op(A * B)
    @:commutative
    public static inline function multiply(a:Vector2, s:Float):Vector2
    {
        return a.clone()
            .multiplyWith(s);
    }
    
    /**
     * Divide a vector by a scalar.
     * 
     * @param s
     * @param a
     * @return      a / s
     */
    @:op(A / B)
    public static inline function divide(a:Vector2, s:Float):Vector2
    {
        return a.clone()
            .divideWith(s);
    }
    
    /**
     * Add two vectors.
     * 
     * @param a
     * @param b
     * @return      a + b
     */
    @:op(A + B)
    public static inline function add(a:Vector2, b:Vector2):Vector2
    {
        return a.clone()
            .addWith(b);
    }
    
    /**
     * Subtract one vector from another.
     * 
     * @param a
     * @param b
     * @return      a - b
     */
    @:op(A - B)
    public static inline function subtract(a:Vector2, b:Vector2):Vector2
    {
        return a.clone()
            .subtractWith(b);
    }
    
    /**
     * Create a negated copy of a vector.
     * 
     * @param a
     * @return      -a
     */
    @:op(-A)
    public static inline function negate(a:Vector2):Vector2
    {
        return new Vector2(
            -a.x,
            -a.y);
    }
    
    /**
     * Test element-wise equality between two vectors.
     * False if one of the inputs is null and the other is not.
     * 
     * @param a
     * @param b
     * @return     a_i == b_i
     */
    @:op(A == B)
    public static inline function equals(a:Vector2, b:Vector2):Bool
    {
        return (a == null && b == null) ||
            a != null &&
            b != null &&
            a.x == b.x &&
            a.y == b.y;
    }
    
    /**
     * Linear interpolation between two vectors.
     * 
     * @param a     The value at t = 0
     * @param b     The value at t = 1
     * @param t     A number in the range [0, 1]
     * @return      The interpolated value
     */
    public static inline function lerp(a:Vector2, b:Vector2, t:Float):Vector2
    {
        return new Vector2(
            (1.0 - t) * a.x + t * b.x,
            (1.0 - t) * a.y + t * b.y);
    }
    
    /**
     * Returns a vector built from the componentwise max of the input vectors.
     * 
     * @param a
     * @param b
     * @return      max(a_i, b_i)
     */
    public static inline function max(a:Vector2, b:Vector2):Vector2
    {
        return a.clone()
            .maxWith(b);
    }
    
    /**
     * Returns a vector built from the componentwise min of the input vectors.
     * 
     * @param a
     * @param b
     * @return      min(a_i, b_i)
     */
    public static inline function min(a:Vector2, b:Vector2):Vector2
    {
        return a.clone()
            .minWith(b);
    }
    

    
    
    /**
     * Multiply a vector with a scalar in place.
     * Note: *= operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i *= s
     */
    public inline function multiplyWith(s:Float):Vector2
    {
        var self:Vector2 = this;
        
        self.x *= s;
        self.y *= s;
        
        return self;
    }
    
    /**
     * Divide a vector by a scalar in place.
     * Note: /= operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i /= s
     */
    public inline function divideWith(s:Float):Vector2
    {
        var self:Vector2 = this;
        
        self.x /= s;
        self.y /= s;
        
        return self;
    }
    
    /**
     * Add a vector in place.
     * Note: += operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i += a_i
     */
    public inline function addWith(a:Vector2):Vector2
    {
        var self:Vector2 = this;
        
        self.x += a.x;
        self.y += a.y;
        
        return self;
    }
    
    /**
     * Subtract a vector in place.
     * Note: -= operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i -= a_i
     */
    public inline function subtractWith(a:Vector2):Vector2
    {
        var self:Vector2 = this;
        
        self.x -= a.x;
        self.y -= a.y;
        
        return self;
    }
    
    /**
     * Returns a vector built from the componentwise max of this vector and another.
     * 
     * @param a
     * @param b
     * @return      self_i = max(self_i, a_i)
     */
    public inline function maxWith(a:Vector2):Vector2
    {
        var self:Vector2 = this;
        
        self.x = Math.max(self.x, a.x);
        self.y = Math.max(self.y, a.y);
        
        return self;
    }
    
    /**
     * Returns a vector built from the componentwise min of this vector and another.
     * 
     * @param a
     * @param b
     * @return      self_i = min(self_i, a_i)
     */
    public inline function minWith(a:Vector2):Vector2
    {
        var self:Vector2 = this;
        
        self.x = Math.min(self.x, a.x);
        self.y = Math.min(self.y, a.y);
        
        return self;
    }
    

    


    
    
    /**
     * Clone.
     * 
     * @return  The cloned object.
     */
    public inline function clone():Vector2
    {
        var self:Vector2 = this;
        return new Vector2(self.x, self.y);
    }


    

    public inline function angleWith(b:Vector2):Float
    {
        var self:Vector2 = this;
        return (Math.acos((self * b) / (self.length * b.length))) *(180/Math.PI);
    }
    
    public inline function angleTo(b:Vector2):Float
    {
        return (b - this).angle;
    }
    

    /**
     * Get the distance between this vector and another.
     * 
     * @param b
     * @return      |self - b|
     */
    public inline function distanceTo(b:Vector2):Float
    {
        var self:Vector2 = this;
        
        return (self - b).length;
    }
    
    /**
     * Normalize this vector.
     * 
     * @return  The modified object.
     */
    public inline function normalize():Vector2
    {
        var self:Vector2 = this;
        
        var length = self.length;
        
        if (length > 0.0)
        {
            self.divideWith(length);
        }
        
        return self;
    }
    
    /**
     * Normalize this vector and scale it to the specified length.
     * 
     * @param newLength     The new length to normalize to.
     * @return              The modified object.
     */
    public inline function normalizeTo(newLength:Float):Vector2
    {
        var self:Vector2 = this;
        
        self.normalize();
        self.multiplyWith(newLength);
        
        return self;
    }
    


    /**
     * Rotate this point counter-clockwise around a pivot point.
     * 
     * @param angle     The signed angle in radians.
     * @param pivot     The pivot point to rotate around.
     * @return          The modified object.
     */
    public inline function rotate(angle:Float, pivot:Vector2):Vector2
    {
        var self:Vector2 = this;
        
        angle = (angle-90)*(Math.PI / 180);

        var cos = Math.cos(angle);
        var sin = Math.sin(angle);
        var dx = self.x - pivot.x;
        var dy = self.y - pivot.y;
        
        self.x = dx * Math.cos(angle) - dy * Math.sin(angle);
        self.y = dx * Math.sin(angle) + dy * Math.cos(angle);
        
        return self;
    }
    
    /**
     * Rotate this vector by 90 degrees to the left/counterclockwise.
     * 
     * @return  The modified object. (-y, x)
     */
    public inline function rotateLeft():Vector2
    {
        var self:Vector2 = this;
        
        var newX = -self.y;
        self.y = self.x;
        self.x = newX;
        
        return self;
    }
    
    /**
     * Rotate this vector by 90 degrees to the right/clockwise.
     * 
     * @return  The modified object. (y, -x)
     */
    public inline function rotateRight():Vector2
    {
        var self:Vector2 = this;
        
        var newX = self.y;
        self.y = -self.x;
        self.x = newX;
        
        return self;
    }
    
    private static inline function get_zero():Vector2
    {
        return new Vector2(0.0, 0.0);
    }
    
    private static inline function get_xAxis():Vector2
    {
        return new Vector2(1.0, 0.0);
    }
    
    private static inline function get_yAxis():Vector2
    {
        return new Vector2(0.0, 1.0);
    }
    
    private inline function get_length():Float
    {
        var self:Vector2 = this;
        return Math.sqrt(
            self.x * self.x +
            self.y * self.y);
    }
    
    private inline function get_lengthSq():Float
    {
        var self:Vector2 = this;
        return
            self.x * self.x +
            self.y * self.y;
    }
    
    private inline function get_angle():Float
    {
        var self:Vector2 = this;
        return Math.atan2(self.y, self.x) *(180/Math.PI) + 90;
    }
    
    private inline function get_normal():Vector2
    {
        var self:Vector2 = this;
        
        return self.clone()
            .normalize();
    }
    
    private inline function get_rotatedLeft():Vector2
    {
        var self:Vector2 = this;
        return self.clone()
            .rotateLeft();
    }
    
    private inline function get_rotatedRight():Vector2
    {
        var self:Vector2 = this;
        return self.clone()
            .rotateRight();
    }
}
