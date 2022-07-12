# 基础

##### 0. pi的区别

> 两个pi不能进行运算！！！
>
> 解决办法：（推荐第2种）
>
>  1. 使用 **float()** 转换sympy.pi
>
>  2. 在利用等差数列生成的x计算y时，**每次计算结果使用float()转换**
>
>     ```python
>     y = sin(x + sympy.pi/3)
>     results = [float(y.subs(x,k)) for k in [sympy.pi/6,sympy.pi/3,sympy.pi/2]]
>     ```
>
>     

- sympy：输出时作为字符“pi”，可用于与同类pi计算，但不支持作为numpy相关运算的参数。
- numpy：本质是浮点数

##### 1. 导入

```python
from sympy import diff
from sympy import symbols
```

##### 2. 变量定义

> 函数可以作为字符串输出，但只有sympy的表达式可以自动转为字符串
>
> 例如：sympy.sin()可显示为“sin”，但若是混用了np.sin()则会报错

```python
# 二元函数、方程组需要定义y
x=sympy.Symbol('x')
y=sympy.Symbol('y')
```

##### 3. **变量替换：`new_func = func.subs(变量替换)`

> 可用于求值
>
> a = (1 + x*y).subs(x, pi)
>
> 可以借助sympy计算值，再用pyplot画图

- 单变量单值：`new_func = func.subs(x,t)`

  > 令 x=t

- **单变量多值：`result = [func.subs(x,k) for k in list]`

  > 用列表存储代入值，例如用 **np.linspace()** 生成
  >
  > 一个一个代入，并将代入结果存储于新的列表

- 多变量：`new_func = func.subs([(x,t),(y,k)])`

  > 令 x=t, y=k



# 求导：`sympy.diff(func,x,n)`

```python
#求导使用diff方法
x=sympy.Symbol('x')
f1=2*x**4+3*x+6
#参数是函数与变量
f1_=sympy.diff(f,x)
print(f1_)
 
f2=sympy.sin(x)
f2_=sympy.diff(f2,x)
print(f2_)
 
#求偏导
y=sympy.Symbol('y')
f3=2*x**2+3*y**4+2*y
#对x，y分别求导，即偏导
f3_x=sympy.diff(f3,x)
f3_y=sympy.diff(f3,y)
print(f3_x)
print(f3_y)
```

