
typealias Window = @tkinter.Window
typealias Label = @tkinter.Label

fn main {
  let window = Window::new()
  window.set_title("Hello, World!")

  let label = Label::new(window, "Hello, World!")
  label.pack()

  window.mainloop()
}
