typealias Screen = @turtle.Screen
typealias Pen = @turtle.Pen
fnalias @math.(sin, cos)
const PI : Double = @math.PI
const G: Double = 600
const Dt: Double = 1.0/60.0

struct PhysicState {
    m1: Double;
    m2: Double;
    l1: Double;
    l2: Double;
    pivot_x: Double;
    pivot_y: Double;
}

// 快速定义类型
type Position (Double, Double, Double, Double)
type Update (Double, Double, Double, Double)

fn animate(
  phys: PhysicState,
  theta1: Double, theta2: Double, 
  omega1: Double, omega2: Double
) -> (Position, Update) {
    // 优雅的结构体解包
    let {m1, m2, l1, l2, pivot_x, pivot_y} = phys

    // --- 计算角加速度 (alpha1, alpha2) ---
    // 这些公式是双摆运动方程的标准形式之一
    let num1_1 = -G * (2.0 * m1 + m2) * sin(theta1)
    let num1_2 = -m2 * G * sin(theta1 - 2.0 * theta2)
    let num1_3 = -2.0 * sin(theta1 - theta2) * m2 * (omega2*omega2 * l2 + omega1*omega1 * l1 * cos(theta1 - theta2))
    let den1 = l1 * (2.0 * m1 + m2 - m2 * cos(2.0 * theta1 - 2.0 * theta2))
    let alpha1 = match den1.abs() < 1.0e-9 {
        true => 0.0 // 避免除以非常小的值，增强稳定性
        false => (num1_1 + num1_2 + num1_3) / den1
    }

    let num2_1 = 2.0 * sin(theta1 - theta2)
    let num2_2 = (omega1*omega1 * l1 * (m1 + m2))
    let num2_3 = G * (m1 + m2) * cos(theta1)
    let num2_4 = omega2*omega2 * l2 * m2 * cos(theta1 - theta2)
    let den2 = l2 * (2.0 * m1 + m2 - m2 * cos(2.0 * theta1 - 2.0 * theta2))
    let alpha2 = match den2.abs() < 1.0e-9 {
        true => 0.0 // 避免除以非常小的值，增强稳定性
        false => (num2_1 * (num2_2 + num2_3 + num2_4)) / den2
    }
    // --- 更新角速度和角度 (欧拉积分) ---
    let omega1 = omega1 + alpha1 * Dt
    let omega2 = omega2 + alpha2 * Dt
    let theta1 = theta1 + omega1 * Dt
    let theta2 = theta2 + omega2 * Dt

    // --- 计算节点和球的位置 ---
    // 节点1 (连接点)
    let x1 = pivot_x + l1 * sin(theta1)
    let y1 = pivot_y - l1 * cos(theta1) // Turtle Y轴向上为正，角度0向下

    // 球 (摆锤2)
    let x2 = x1 + l2 * sin(theta2)
    let y2 = y1 - l2 * cos(theta2)

    let position = (x1, y1, x2, y2)
    let update = (theta1, theta2, omega1, omega2)

    (position, update)
}

fn main {
  let screen = Screen::new()..setup(800, 700)..bgcolor(Black)
             ..title("Double Pendulum Simulation")
             ..tracer(0)

  let rod = Pen::new()..hide()..speed(Fastest)..pensize(3)..pencolor(Silver)
  let masses = Pen::new()..hide()..speed(Fastest)

  let (pivot_x, pivot_y) = (0.0, 200.0)

  // --- 长度和质量
  let (l1, l2, m1, m2) = (150.0, 120.0, 10.0, 40.0)

  // --- 初始角度和角速度 ---
  let (theta1, theta2) = (PI / 1.5, PI/2)
  let (omega1, omega2) = (0.0, 0.0)

  // --- 设置初始物理量 ---
  let phys = PhysicState::{m1, m2, l1, l2, pivot_x, pivot_y}

  // 函数式循环，更清晰
  loop theta1 , theta2, omega1, omega2, 0.0 {
    theta1, theta2, omega1, omega2, total_time if total_time < 10.0 => {
      let (positions, updates) = animate(phys, theta1, theta2, omega1, omega2)
      let Position((x1, y1, x2, y2)) = positions
      let Update((theta1, theta2, omega1, omega2)) = updates

      rod.clear()
      masses.clear()

      // --- 绘制杆1 ---
      rod..penup()..goto(pivot_x, pivot_y)..pendown().goto(x1, y1)

      // --- 绘制杆2 ---
      rod..penup()..goto(x1, y1)..pendown().goto(x2, y2)

      // --- 绘制节点 (质量m1) ---
      masses..penup()..goto(x1, y1).dot(15, Orange)

      // --- 绘制球 (质量m2) ---
      masses..penup()..goto(x2, y2).dot(20, Blue)

      // --- 更新屏幕 ---
      screen.update()
      @time.sleep(Dt)
      continue theta1, theta2, omega1, omega2, total_time + Dt
    }
    _,_,_,_,_ => break
  }
}
