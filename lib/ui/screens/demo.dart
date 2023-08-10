// Define an interface for objects that can be resized
abstract class Resizable {
  void resize();
}

// Define an abstract class for shapes
abstract class Shape {
  void draw();
}

// Define a concrete subclass of Shape for circles
class Circle implements Resizable,Shape {
  @override
  void draw() {
    // TODO: implement draw
  }

  @override
  void resize() {
    // TODO: implement resize
  }



}