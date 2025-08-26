///| Represents a turtle pen object, capable of drawing on the screen.
/// corresponds to `turtle.Pen` or the default turtle instance in Python.
pub struct Pen {
  priv pen : PyObject
  methods : Map[String, PyCallable] // Caches method lookups
}

///| Retrieves a callable Python method from the cached methods or the underlying Python object.
/// - name: The name of the method.
/// Returns Some(PyCallable) if the method is found, None otherwise.
fn Pen::get_method(self : Pen, name : String) -> PyCallable? {
  match self.methods.get(name) {
    Some(m) => Some(m)
    None =>
      match self.pen.get_attr(name) {
        Some(PyCallable(m)) => {
          self.methods.set(name, m) // Cache the method
          Some(m)
        }
        _ => None
      }
  }
}

///| Creates a new turtle pen instance.
/// In Python, this might correspond to `turtle.Pen()` or obtaining the default instance.
/// This Moonbit function creates a new `turtle.Pen()` instance.
pub fn Pen::new() -> Pen {
  let lib = singleton()
  guard lib.turtle.get_attr("Pen") is Some(PyCallable(createPen))
  guard (try? createPen.invoke()).unwrap() is Some(PyClass(pen))
  Pen::{ pen, methods: Map::new() }
}

///| Moves the pen to the home position (0,0) and sets heading to 0 degrees.
/// corresponds to `pen.home()` in Python.
pub fn Pen::home(self : Pen) -> Unit {
  guard self.get_method("home") is Some(func) else {
    println("Failed to get Pen::home method")
    panic()
  }
  let _ = try? func.invoke()
  ()
}

///| Sets the pen size (thickness).
/// - size: The pen thickness. Must be positive.
/// corresponds to `pen.pensize(size)` in Python.
pub fn Pen::pensize(self : Pen, size : Double) -> Unit {
  guard size > 0.0 else {
    println("Pensize must be positive")
    return
  }
  guard self.get_method("pensize") is Some(func) else {
    println("Failed to get Pen::pensize method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(size))
  let _ = try? func.invoke(args~)

}

///| Returns the current x-coordinate of the pen.
/// corresponds to `pen.xcor()` in Python.
pub fn Pen::xcor(self : Pen) -> Double {
  guard self.get_method("xcor") is Some(func) else {
    println("Failed to get Pen::xcor method") // Return a default value
    return 0.0
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyFloat(x))
  x.to_double()
}

///| Returns the current y-coordinate of the pen.
/// corresponds to `pen.ycor()` in Python.
pub fn Pen::ycor(self : Pen) -> Double {
  guard self.get_method("ycor") is Some(func) else {
    println("Failed to get Pen::ycor method") // Return a default value
    return 0.0
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyFloat(y))
  y.to_double()
}

///| Returns the current position as a tuple of (x, y) coordinates.
/// corresponds to `pen.position()` or `pen.pos()` in Python.
pub fn Pen::position(self : Pen) -> (Double, Double) {
  guard self.get_method("position") is Some(func) else {
    println("Failed to get Pen::position method")
    return (0.0, 0.0) // Return a default value
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyTuple(tup)) else {
    println("Pen::position did not return a tuple")
    return (0.0, 0.0) // Return a default value
  }
  guard tup.len() == 2 else {
    println("Pen::position returned a tuple of incorrect length")
    return (0.0, 0.0) // Return a default value
  }
  let x = tup.get(0)
  guard x is Some(PyFloat(x_py)) else {
    println("Pen::position tuple element 0 is not a float")
    return (0.0, 0.0) // Return a default value
  }
  let y = tup.get(1)
  guard y is Some(PyFloat(y_py)) else {
    println("Pen::position tuple element 1 is not a float")
    return (0.0, 0.0) // Return a default value
  }
  (x_py.to_double(), y_py.to_double())
}

///| Returns the current heading of the pen in degrees.
/// corresponds to `pen.heading()` in Python.
pub fn Pen::heading(self : Pen) -> Double {
  guard self.get_method("heading") is Some(func) else {
    println("Failed to get Pen::heading method") // Return a default value
    return 0.0
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyFloat(h)) else {
    println("Pen::heading did not return a float") // Return a default value
    return 0.0
  }
  h.to_double()
}

///| Returns the current unit for angles set by the `degrees()` or `radians()` methods.
/// Note: This method name might be slightly misleading in Python's turtle documentation.
/// corresponds to `pen.radians()` in Python (when radians are used).
/// If using degrees, you might check `turtle.degrees()` which is usually global.
/// This encapsulation assumes it checks the current angle unit setting.
pub fn Pen::radians(self : Pen) -> Double {
  guard self.get_method("radians") is Some(func) else {
    println("Failed to get Pen::radians method") // Return a default value
    return 0.0
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyFloat(r)) else {
    println("Pen::radians did not return a float") // Return a default value
    return 0.0
  }
  r.to_double()
}

///| Sets the pen speed.
/// - speed: An enum representing the desired drawing speed.
/// corresponds to `pen.speed(speed)` in Python, where speed is an integer.
pub fn Pen::speed(self : Pen, speed : Speed) -> Unit {
  guard self.get_method("speed") is Some(func) else {
    println("Failed to get Pen::speed method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, speed.to_pynum()) // speed.to_pynum() converts enum to PyInteger
  let _ = try? func.invoke(args~)

}

///| Sets the pen color.
/// - color: The pen color.
/// corresponds to `pen.pencolor(color)` in Python.
pub fn Pen::pencolor(self : Pen, color : Color) -> Unit {
  guard self.get_method("pencolor") is Some(func) else {
    println("Failed to get Pen::pencolor method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyString::from(color.to_string().to_lower())) // Ensure lowercase
  let _ = try? func.invoke(args~)

}

///| Sets the pen width.
/// - width: The pen width. Must be positive.
/// corresponds to `pen.width(width)` in Python.
pub fn Pen::width(self : Pen, width : Double) -> Unit {
  guard width > 0.0 else {
    println("Width must be positive")
    return
  }
  guard self.get_method("width") is Some(func) else {
    println("Failed to get Pen::width method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(width))
  let _ = try? func.invoke(args~)

}

///| Moves the pen forward by the specified distance.
/// - distance: The distance to move forward. Must be positive.
/// corresponds to `pen.forward(distance)` or `pen.fd(distance)` in Python.
pub fn Pen::forward(self : Pen, distance : Double) -> Unit {
  guard distance > 0.0 else {
    println("Distance must be positive")
    return
  }
  guard self.get_method("forward") is Some(func) else {
    println("Failed to get Pen::forward method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(distance))
  let _ = try? func.invoke(args~)

}

///| Moves the pen backward by the specified distance.
/// - distance: The distance to move backward. Must be positive.
/// corresponds to `pen.backward(distance)` or `pen.bk(distance)` or `pen.ba(distance)` in Python.
pub fn Pen::backward(self : Pen, distance : Double) -> Unit {
  guard distance > 0.0 else {
    println("Distance must be positive")
    return
  }
  // Corrected from self.pen.get_attr to self.get_method for caching
  guard self.get_method("backward") is Some(func) else {
    println("Failed to get Pen::backward method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(distance))
  let _ = try? func.invoke(args~)

}

///| Turns the pen left by the specified angle.
/// - angle: The angle in degrees to turn left.
/// corresponds to `pen.left(angle)` or `pen.lt(angle)` in Python.
pub fn Pen::left(self : Pen, angle : Double) -> Unit {
  guard self.get_method("left") is Some(func) else {
    println("Failed to get Pen::left method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(angle))
  let _ = try? func.invoke(args~)

}

///| Turns the pen right by the specified angle.
/// - angle: The angle in degrees to turn right.
/// corresponds to `pen.right(angle)` or `pen.rt(angle)` in Python.
pub fn Pen::right(self : Pen, angle : Double) -> Unit {
  guard self.get_method("right") is Some(func) else {
    println("Failed to get Pen::right method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(angle))
  let _ = try? func.invoke(args~)

}

///| Moves the pen to an absolute position (x, y).
/// - x: The target x-coordinate.
/// - y: The target y-coordinate.
/// corresponds to `pen.goto(x, y)` or `pen.setpos(x, y)` or `pen.setposition(x, y)` in Python.
pub fn Pen::goto(self : Pen, x : Double, y : Double) -> Unit {
  guard self.get_method("goto") is Some(func) else {
    println("Failed to get Pen::goto method")
    return
  }
  let args = PyTuple::new(2)
  args..set(0, PyFloat::from(x))..set(1, PyFloat::from(y))
  let _ = try? func.invoke(args~)

}

///| Makes the turtle invisible.
/// corresponds to `pen.hideturtle()` or `pen.ht()` in Python.
pub fn Pen::hide(self : Pen) -> Unit {
  guard self.get_method("hideturtle") is Some(func) else {
    println("Failed to get Pen::hideturtle method")
    return
  }
  let _ = try? func.invoke()

}

///| Lifts the pen up. No drawing will occur when the pen moves.
/// corresponds to `pen.penup()` or `pen.pu()` or `pen.up()` in Python.
pub fn Pen::penup(self : Pen) -> Unit {
  guard self.get_method("penup") is Some(func) else {
    println("Failed to get Pen::penup method")
    return
  }
  let _ = try? func.invoke()

}

///| Puts the pen down. Drawing will occur when the pen moves.
/// corresponds to `pen.pendown()` or `pen.pd()` or `pen.down()` in Python.
pub fn Pen::pendown(self : Pen) -> Unit {
  guard self.get_method("pendown") is Some(func) else {
    println("Failed to get Pen::pendown method")
    return
  }
  let _ = try? func.invoke()

}

///| Draws a dot at the current position.
/// - size: The diameter of the dot. Must be positive.
/// - color: The color of the dot.
/// corresponds to `pen.dot(size, color)` in Python.
pub fn Pen::dot(self : Pen, size : Double, color : Color) -> Unit {
  guard size > 0.0 else {
    println("Dot size must be positive")
    return
  }
  guard self.get_method("dot") is Some(func) else {
    println("Failed to get Pen::dot method")
    return
  }
  let args = PyTuple::new(2)
  args
  ..set(0, PyFloat::from(size))
  ..set(1, PyString::from(color.to_string().to_lower())) // Ensure lowercase
  // The return value of dot is the turtle object itself, which we ignore and drop.
  // The original code had a 'guard func.invoke(args~) is Some(PyClass(r)) r.drop()', which is correct for ignoring the return value.
  let _ = try? func.invoke(args~)
  // Simpler way to ignore return value
}

///| Deletes the pen's drawings from the screen, but does not move the pen.
/// corresponds to `pen.clear()` in Python.
pub fn Pen::clear(self : Pen) -> Unit {
  guard self.get_method("clear") is Some(func) else {
    println("Failed to get Pen::clear method")
    return
  }
  let _ = try? func.invoke()

}

// Add more Pen methods

///| Sets the fill color.
/// - color: The color used for filling.
/// corresponds to `pen.fillcolor(color)` in Python.
pub fn Pen::fillcolor(self : Pen, color : Color) -> Unit {
  guard self.get_method("fillcolor") is Some(func) else {
    println("Failed to get Pen::fillcolor method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyString::from(color.to_string().to_lower()))
  let _ = try? func.invoke(args~)

}

///| Sets the pen color and fill color.
/// - color: The color used for pen and fill.
/// corresponds to `pen.color(color)` in Python. Can also take two colors, but we simplify here.
pub fn Pen::color(self : Pen, color : Color) -> Unit {
  guard self.get_method("color") is Some(func) else {
    println("Failed to get Pen::color method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyString::from(color.to_string().to_lower()))
  let _ = try? func.invoke(args~)

}

///| Returns True if the pen is down, False otherwise.
/// corresponds to `pen.isdown()` in Python.
pub fn Pen::isdown(self : Pen) -> Bool {
  guard self.get_method("isdown") is Some(func) else {
    println("Failed to get Pen::isdown method") // Return a default value
    return false
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyBool(b))
  b.to_bool()
}

///| Makes the turtle visible.
/// corresponds to `pen.showturtle()` or `pen.st()` in Python.
pub fn Pen::show(self : Pen) -> Unit {
  guard self.get_method("showturtle") is Some(func) else {
    println("Failed to get Pen::showturtle method")
    return
  }
  let _ = try? func.invoke()

}

///| Returns True if the turtle is visible, False otherwise.
/// corresponds to `pen.isvisible()` in Python.
pub fn Pen::isvisible(self : Pen) -> Bool {
  guard self.get_method("isvisible") is Some(func) else {
    println("Failed to get Pen::isvisible method") // Return a default value
    return false
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyBool(b))
  b.to_bool()
}

///| Starts color filling.
/// corresponds to `pen.begin_fill()` in Python.
pub fn Pen::begin_fill(self : Pen) -> Unit {
  guard self.get_method("begin_fill") is Some(func) else {
    println("Failed to get Pen::begin_fill method")
    return
  }
  let _ = try? func.invoke()

}

///| Stops color filling and fills the area bounded by the last begin_fill() and this call.
/// corresponds to `pen.end_fill()` in Python.
pub fn Pen::end_fill(self : Pen) -> Unit {
  guard self.get_method("end_fill") is Some(func) else {
    println("Failed to get Pen::end_fill method")
    return
  }
  let _ = try? func.invoke()

}

///| Draws a circle.
/// - radius: The radius of the circle. A positive radius means counterclockwise, negative means clockwise.
/// - extent: Optional. An angle in degrees. If given, only part of the circle is drawn.
/// - steps: Optional. An integer. The number of steps to use for approximating the circle.
/// corresponds to `pen.circle(radius, extent=None, steps=None)` in Python.
pub fn Pen::circle(
  self : Pen,
  radius : Double,
  extent~ : Double? = None,
  steps~ : Int? = None,
) -> Unit {
  guard self.get_method("circle") is Some(func) else {
    println("Failed to get Pen::circle method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(radius))
  let kwargs = PyDict::new()
  match extent {
    Some(e) => kwargs.set("extent", PyFloat::from(e))
    None => ()
  }
  match steps {
    Some(s) => kwargs.set("steps", PyInteger::from(s.to_int64()))
    None => ()
  }
  let _ = try? func.invoke(args~, kwargs~)

}

///| Leaves a copy of the turtle shape at the current location.
/// Returns a stamp_id which can be used later with clearstamp() or clearstamps().
/// corresponds to `pen.stamp()` in Python.
/// Note: The return value (stamp_id) is an integer in Python, we return it as Int.
pub fn Pen::stamp(self : Pen) -> Int {
  guard self.get_method("stamp") is Some(func) else {
    println("Failed to get Pen::stamp method") // Return a default error value
    return -1
  }
  let res = (try? func.invoke()).unwrap()
  guard res is Some(PyInteger(i)) else {
    println("Pen::stamp did not return an integer") // Return a default error value
    return -1
  }
  i.to_int64().to_int() // Convert to Int
}

///| Deletes the stamp with the given stampid.
/// - stamp_id: The id of the stamp to delete, as returned by stamp().
/// corresponds to `pen.clearstamp(stampid)` in Python.
pub fn Pen::clearstamp(self : Pen, stamp_id : Int) -> Unit {
  guard self.get_method("clearstamp") is Some(func) else {
    println("Failed to get Pen::clearstamp method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyInteger::from(stamp_id.to_int64()))
  let _ = (try? func.invoke(args~)).unwrap()

}

///| Deletes all or the first/last n stamps.
/// - n: Optional. If None, delete all stamps. If n > 0, delete the first n stamps. If n < 0, delete the last abs(n) stamps.
/// corresponds to `pen.clearstamps(n=None)` in Python.
pub fn Pen::clearstamps(self : Pen, n~ : Int? = None) -> Unit {
  guard self.get_method("clearstamps") is Some(func) else {
    println("Failed to get Pen::clearstamps method")
    return
  }
  let kwargs = PyDict::new()
  match n {
    Some(num) => kwargs.set("n", PyInteger::from(num.to_int64()))
    None => () // If n is None, we don't add it to kwargs, defaulting to None in Python
  }

  // Although Python's clearstamps takes n as positional or keyword,
  // passing it as keyword is safer with Option handling.
  // We invoke with an empty args tuple and the kwargs dictionary.
  let _ = (try? func.invoke(kwargs~)).unwrap()

}

///| Resets the pen's and screen's state. Deletes drawings, recenters pen, resets variables.
/// corresponds to `pen.reset()` in Python.
pub fn Pen::reset(self : Pen) -> Unit {
  guard self.get_method("reset") is Some(func) else {
    println("Failed to get Pen::reset method")
    return
  }
  let _ = try? func.invoke()

}

///| Sets the turtle shape.
/// - name: The name of the shape. Use the Shape enum for common shapes.
/// corresponds to `pen.shape(name)` in Python.
pub fn Pen::shape(self : Pen, name : Shape) -> Unit {
  guard self.get_method("shape") is Some(func) else {
    println("Failed to get Pen::shape method")
    return
  }
  let args = PyTuple::new(1)
  args..set(0, PyString::from(name.to_string().to_lower())) // Assuming Shape enum with Show derived
  let _ = try? func.invoke(args~)

}

///| Sets the shape's stretches and outline.
/// - stretch_width: Stretchfactor for width, perpendicular to orientation.
/// - stretch_len: Stretchfactor for length, in direction of orientation.
/// - outline: Optional outline thickness.
/// corresponds to `pen.shapesize(stretch_wid=None, stretch_len=None, outline=None)` in Python.
pub fn Pen::shapesize(
  self : Pen,
  stretch_width~ : Double? = None,
  stretch_len~ : Double? = None,
  outline~ : Int? = None,
) -> Unit {
  guard self.get_method("shapesize") is Some(func) else {
    println("Failed to get Pen::shapesize method")
    return
  }
  let kwargs = PyDict::new()
  match stretch_width {
    Some(w) => kwargs.set("stretch_wid", PyFloat::from(w))
    None => ()
  }
  match stretch_len {
    Some(l) => kwargs.set("stretch_len", PyFloat::from(l))
    None => ()
  }
  match outline {
    Some(o) => kwargs.set("outline", PyInteger::from(o.to_int64()))
    None => ()
  }
  let _ = try? func.invoke(kwargs~)

}
