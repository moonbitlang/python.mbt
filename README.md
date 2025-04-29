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

# Locate development headers
python3-config --prefix
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
  ],
  "link": {
    "native": {
      "cc": "$CC",
      "cc-flags": "$CC_FLAGS",
      "cc-link-flags": "$CC_LINK_FLAGS"
    }
  }
}
```

### Environment Variables

**Linux/macOS** (`env.sh`):

```bash
#!/bin/bash
export PY_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
export CC=clang  # Recommended for better performance
export CC_FLAGS="-I$(python3-config --prefix)/include/python$PY_VERSION -O2 -DNDEBUG"
export CC_LINK_FLAGS="$(python3-config --ldflags) -lpython$PY_VERSION"
export C_INCLUDE_PATH="$(python3-config --prefix)/include/python$PY_VERSION:$C_INCLUDE_PATH"
```

**Windows PowerShell** (`env.ps1`):

```powershell
$PY_PATH = (python -c "import sys; print(sys.prefix)") | Out-String
$env:PY_VERSION = python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
$env:CC = "clang"
$env:CC_FLAGS = "-I$($PY_PATH.Trim())\include -O2 -DNDEBUG"
$env:CC_LINK_FLAGS = "-L$($PY_PATH.Trim())\libs -lpython$env:PY_VERSION"
```

## 🚀 Quick Start

### Example: Using collections.Counter

```moonbit
typealias PyInteger = @python.PyInteger
typealias PyList = @python.PyList
typealias PyTuple = @python.PyTuple

fn main {
  // It's equivalent to `nums = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]`
  let nums = [1L, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
  let py_nums = nums.map(PyInteger::from) |> PyList::from
  println(py_nums) // Output: [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

  // It's equivalent to `import collections`
  guard @python.pyimport("collections") is Some(collections)

  // It's equivalent to `from collections import Counter`
  guard collections.get_attr("Counter") is Some(@python.PyCallable(counter))

  let args = PyTuple::new(1) .. set(0, py_nums)

  // It's equivalent to `cnt = Counter(nums)`
  let cnt = counter.invoke(args~).unwrap()
  guard cnt is @python.PyDict(cnt)

  // `print(cnt)`
  println(cnt) // Output: Counter({4: 4, 3: 3, 2: 2, 1: 2})
}
```

Equivalent Python implementation:

```python
from collections import Counter

l = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
print(Counter(l))  # Counter({4: 4, 3: 3, 2: 2, 1: 2})
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

# 获取Python开发头文件路径
python3-config --prefix
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
  ],
  "link": {
    "native": {
      "cc": "$CC",
      "cc-flags": "$CC_FLAGS",
      "cc-link-flags": "$CC_LINK_FLAGS"
    }
  }
}
```

### 环境变量配置

**Linux/macOS** (`env.sh`)：

```bash
#!/bin/bash
export PY_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
export CC=clang  # 推荐使用clang以获得更好性能
export CC_FLAGS="-I$(python3-config --prefix)/include/python$PY_VERSION -O2 -DNDEBUG"
export CC_LINK_FLAGS="$(python3-config --ldflags) -lpython$PY_VERSION"
export C_INCLUDE_PATH="$(python3-config --prefix)/include/python$PY_VERSION:$C_INCLUDE_PATH"
```

**Windows PowerShell** (`env.ps1`)：

```powershell
$PY_PATH = (python -c "import sys; print(sys.prefix)") | Out-String
$env:PY_VERSION = python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
$env:CC = "clang"
$env:CC_FLAGS = "-I$($PY_PATH.Trim())\include -O2 -DNDEBUG"
$env:CC_LINK_FLAGS = "-L$($PY_PATH.Trim())\libs -lpython$env:PY_VERSION"
```

## 🚀 快速入门

一个使用python 中Counter的例子

```moonbit
typealias PyInteger = @python.PyInteger
typealias PyList = @python.PyList
typealias PyTuple = @python.PyTuple

fn main {
  // It's equivalent to `nums = [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]`
  let nums = [1L, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
  let py_nums = nums.map(PyInteger::from) |> PyList::from
  println(py_nums) // Output: [1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

  // It's equivalent to `import collections`
  guard @python.pyimport("collections") is Some(collections)

  // It's equivalent to `from collections import Counter`
  guard collections.get_attr("Counter") is Some(@python.PyCallable(counter))

  let args = PyTuple::new(1) .. set(0, py_nums)

  // It's equivalent to `cnt = Counter(nums)`
  let cnt = counter.invoke(args~).unwrap()
  guard cnt is @python.PyDict(cnt)

  // `print(cnt)`
  println(cnt) // Output: Counter({4: 4, 3: 3, 2: 2, 1: 2})
}
```

等效Python代码：

```python
from collections import Counter

l = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
print(l) # [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

cnt = Counter(l)
print(cnt) # Out: Counter({1: 2, 2: 2, 3: 3, 4: 4})
```


## 🤝 参与贡献

我们欢迎任何形式的贡献，包括但不限于：

1. 提交Issue报告问题
2. 发起Pull Request改进代码
3. 编写生态库扩展文档

---

📜 **许可证**：Apache-2.0 License（详见LICENSE文件）
