typealias PyList = @python.PyList

//fn main {
//  let x = Array::makei(100, fn (i) { i.to_double() })
//  let y = x.map(@math.ln)
//
//  let x = PyList::from(x)
//  let y = PyList::from(y)
//
//  @plt.plot(x, y)
//  @plt.show()
//}

typealias QApplication = @qt.QApplication
typealias QMainWindow = @qt.QMainWindow
typealias QLabel = @qt.QLabel

fn main {
  let app = QApplication::new()
  let window = QMainWindow::new()
  window.setWindowTitle("Hello World")
  window.setGeometry(100, 100, 400, 300)

  let label = QLabel::new("Hello, World!", window)

  label.moveTo(100, 50)
  label.setStyleSheet("font-size: 20px;")

  window.show()
  let _ = app.exec()
}
