# 🐍 Python.mbt

[🇨🇳简体中文](#-pythonmbt-1)

⚠️ **Project Status Notice**
This project is currently in early development. API changes may occur without backward compatibility. Not recommended for production use. Contributors and testers welcome!

## ✨ Key Features

Moonbit-Python is the first CPython-based bridge for Moonbit language, offering:

* **Python Ecosystem Integration** - Directly interoperate with top Python libraries like Numpy, Matplotlib, and PyTorch
* **Type-Safe Interactions** - Strongly-typed interfaces ensuring safe object handling

## 📦 Environment Setup

### Python Installation

Requires Python 3.9+. Recommended installation methods:

**Linux (Debian/Ubuntu)**

```bash
sudo apt-get update && sudo apt-get install python3.13 python3.13-dev
```

**macOS (Homebrew)**

```bash
brew install python@3.13
```

**Windows**

1. Visit [Python Official Download Page](https://www.python.org/downloads/windows/)
2. Download latest 3.x installer
3. Enable "Add Python to PATH" during installation

### Environment Verification

```bash
# Verify Python version
python3 --version
```

## 🔧 Project Configuration

### Add Dependency

Update package index and install core library:

```bash
moon update
moon add Kaida-Amethyst/python
```

💡 **Note**: Current package manager has known issues with native-only libraries. Ignore related error messages. Track official fixes at [Moonbitlang](https://www.moonbitlang.cn/)

### Build Configuration

Add to your project's `moon.pkg.json`:

```json
{
  "import": [
    "Kaida-Amethyst/python"
  ]
}
```

## 🚀 Quick Start

### Example: Using collections.Counter

```moonbit
typealias @python.(PyInteger, PyList, PyTuple)

fn main {
  // It's equivalent to `nums = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]`
  let nums = [1L, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
  let py_nums = nums.map(PyInteger::from) |> PyList::from
  println(py_nums) // Output: [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

  // It's equivalent to `import collections`
  guard @python.pyimport("collections") is Some(collections)

  // It's equivalent to `from collections import Counter`
  guard collections.get_attr("Counter") is Some(PyCallable(counter))

  let args = PyTuple::new(1)
  args.. set(0, py_nums)

  // It's equivalent to `cnt = Counter(nums)`
  guard counter.invoke?(args~) is Ok(Some(cnt))
  guard cnt is PyDict(cnt)

  // `print(cnt)`
  println(cnt) // Output: Counter({4: 4, 3: 3, 1: 2, 2: 2})
}
```

### Running the Example

```bash
moon run main --target native
```

Equivalent Python implementation:

```python
from collections import Counter

l = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
print(Counter(l))  # Counter({4: 4, 3: 3, 1: 2, 2: 2})
```

## 🤝 Contributing

We welcome contributions through:

1. Issue reporting
2. Pull requests
3. Ecosystem documentation improvements

---

📜 **License**: Apache-2.0 License (See LICENSE file)


# 🐍 Python.mbt

⚠️ **项目状态提示**
本项目目前处于早期开发阶段，API可能发生不兼容变更，暂不建议用于生产环境。欢迎开发者参与测试和功能建议！


## 🌟项目亮点

Moonbit-Python 是首个基于CPython的Moonbit语言桥接工具，具有以下核心优势：

* **无缝调用Python生态** - 直接操作Numpy、Matplotlib、PyTorch等顶级Python库
* **类型安全交互** - 提供强类型接口保障与Python对象的安全交互

## 📦 环境准备

### Python安装指南

要求Python 3.9+版本，推荐使用最新稳定版：

**Linux (Debian/Ubuntu)**

```bash
sudo apt-get update && sudo apt-get install python3.13 python3.13-dev
```

**macOS (Homebrew)**

```bash
brew install python@3.13
```

**Windows**

1. 访问[Python官方网站](https://www.python.org/downloads/windows/)
2. 下载最新3.x版本安装包
3. 安装时勾选 "Add Python to PATH"

### 环境验证

```bash
# 验证Python版本
python3 --version
```

## 🔧 项目配置

### 添加依赖

更新包索引并安装核心库：

```bash
moon update
moon add Kaida-Amethyst/python
```

💡 **注意**：当前包管理器对纯Native库的支持存在已知问题，可忽略相关错误提示。官方修复进度请关注[Moonbitlang](https://www.moonbitlang.cn/)

### 构建配置

在项目根目录的 `moon.pkg.json` 中添加：

```json
{
  "import": [
    "Kaida-Amethyst/python"
  ]
}
```

## 🚀 快速入门

一个使用python 中Counter的例子

```moonbit
typealias @python.(PyInteger, PyList, PyTuple)

fn main {
  // It's equivalent to `nums = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]`
  let nums = [1L, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
  let py_nums = nums.map(PyInteger::from) |> PyList::from
  println(py_nums) // Output: [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

  // It's equivalent to `import collections`
  guard @python.pyimport("collections") is Some(collections)

  // It's equivalent to `from collections import Counter`
  guard collections.get_attr("Counter") is Some(PyCallable(counter))

  let args = PyTuple::new(1)
  args.. set(0, py_nums)

  // It's equivalent to `cnt = Counter(nums)`
  guard counter.invoke?(args~) is Ok(Some(cnt))
  guard cnt is PyDict(cnt)

  // `print(cnt)`
  println(cnt) // Output: Counter({4: 4, 3: 3, 1: 2, 2: 2})
}
```

### 运行示例

```bash
moon run main --target native
```

等效Python代码：

```python
from collections import Counter

l = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
print(Counter(l))  # Counter({4: 4, 3: 3, 1: 2, 2: 2})
```

## 🤝 参与贡献

我们欢迎任何形式的贡献，包括但不限于：

1. 提交Issue报告问题
2. 发起Pull Request改进代码
3. 编写生态库扩展文档

---

📜 **许可证**：Apache-2.0 License（详见LICENSE文件）
