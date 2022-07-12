# 绘图基础

> ```python
> import numpy as np
> import matplotlib.pyplot as plt
> from pylab import mpl
> import random
> ```

### 基本流程

```python
import numpy as np
import matplotlib.pyplot as plt
from pylab import mpl
import random


# 设置显示中文字体
mpl.rcParams["font.sans-serif"] = ['SimHei']
# 设置正常显示符号
mpl.rcParams["axes.unicode_minus"] = False


# 0.准备数据
x = range(60)
y_sh = [random.uniform(15, 18) for i in x]     # random.uniform:返回一个随机浮点数 N ，当 a <= b 时 a <= N <= b ，当 b < a 时 b <= N <= a
y_bj = [random.uniform(1, 3) for i in x]

'''
DPI（Dots Per Inch，每英寸点数）是一个量度单位，用于点阵数码影像，指每一英寸长度中，取样、可显示或输出点的数目。
DPI是打印机、鼠标等设备分辨率的度量单位。是衡量打印机打印精度的主要参数之一，一般来说，DPI值越高，表明打印机的打印精度高。
'''
# 1.创建画布
# plt.figure(figsize=(20, 8), dpi=200)  # 画布大小，dpi：清晰度
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(20, 8), dpi=100)  # 画布fig对象，区域axes对象（）


# 2.绘制图像（折线图）
# plt.plot(x, y_sh, label='上海')
axes[0].plot(x, y_sh, label='上海')
# plt.plot(x, y_bj, color='r', linestyle='--', label='北京')
axes[1].plot(x, y_bj, color='r', linestyle='--', label='北京')


# 2.1 添加描述信息
# plt.xlabel('时间')
# plt.ylabel('温度')
# plt.title('中午11点-12点某城市温度变化图', fontsize=20)
axes[0].set_xlabel('时间')
axes[0].set_ylabel('温度')
axes[0].set_title('中午11点-12点城市1温度变化图', fontsize=20)
axes[1].set_xlabel('时间')
axes[1].set_ylabel('温度')
axes[1].set_title('中午11点-12点城市2温度变化图', fontsize=20)


# 2.2 添加x，y轴刻度
x_ticks_label = ['11点{}分'.format(i) for i in x]
y_ticks = range(40)
# 修改x，y轴刻度显示
# plt.xticks(x_ticks_label[::5])  坐标刻度不可以直接通过字符串进行修改
# tick：对号; 钩号; 记号
# plt.xticks(x[::5], x_ticks_label[::5])  # 先修改为数字刻度，之后替换中文刻度
# plt.yticks(y_ticks[::5])
axes[0].set_xticks(x[::5])
axes[0].set_xticklabels(x_ticks_label[::5])
axes[0].set_yticks(y_sh[::5])
axes[1].set_xticks(x[::5])
axes[1].set_xticklabels(x_ticks_label[::5])
axes[1].set_yticks(y_bj[::5])


# 2.3 添加网格显示
# plt.grid(True, linestyle='--', alpha=0.5)
axes[0].grid(True, linestyle='--', alpha=0.5)
axes[1].grid(True, linestyle='--', alpha=0.5)




# 2.4 图像保存（放在show前面，show()会释放figure资源，如果显示图像之后保存图片只能保存空图片）
# plt.savefig('./test.png')


# 2.5 显示图例
# plt.legend(loc="best")  # 0
axes[0].legend(loc="best")
axes[1].legend(loc="best")


# 3.图像显示
plt.show()
```



##### 0. 基础配置

```python
# 设置显示中文字体
mpl.rcParams["font.sans-serif"] = ['SimHei']
# 设置正常显示符号
mpl.rcParams["axes.unicode_minus"] = False
```

##### 1. 创建画布

- 单张图：`plt.figure(figsize, dpi)`
  - figsize：画布大小，用元组表示

  - dpi：分辨率

    > DPI（Dots Per Inch，每英寸点数）是一个量度单位，用于点阵数码影像，指每一英寸长度中，取样、可显示或输出点的数目。
    > DPI是打印机、鼠标等设备分辨率的度量单位。是衡量打印机打印精度的主要参数之一，一般来说，DPI值越高，表明打印机的打印精度高。

- **单画布分隔：`plt.subplot(m,n,k)`

  > 将画布分割成 **mxn** 下一张图画在 **第k个位置**（从1开始）
  >
  > ```python
  > #将画布分为2行2列，将图画到画布的1区域
  > plt.subplot(2,2,1)
  > plt.plot(x,np.sin(x))
  > plt.subplot(2,2,3)
  > plt.plot(x,np.cos(x))
  > plt.show()
  > ```

- **多张画布：`fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(20, 8), dpi=100)  `

  > 返回：画布对象列表fig，区域对象列表axes

##### 2. **绘制图像

- 单张图：`plt.plot(x, y, linewidth, linestyle, color, label)`

  > 针对2维
  >
  > x、y是存放坐标的列表，对应位置数据组合成一个点的坐标，相邻点进行连线
  >
  > 可以对一张图进行多次plot或一次plot传入多组参数，将多个线条绘制在同一张图上
  >
  > 具体参数与下文的grid相似
  - label：线的标签，用于图例显示

- 多张图：`axes[i].plot(参数与单张图类似)`

  > axes为创建多张图时返回的区域对象列表
  >
  > 但也可多次调用plot来在一张画布上画多个图

##### 3. 图像结构配置

> 具体内容见下文

##### 4. 保存图像：`plt.savefig("路径")`

> show()会释放figure资源，如果显示图像之后保存图片只能保存空图片

##### 5. 图像显示：`plt.show()`



### 图像结构

![img](https://img-blog.csdnimg.cn/20210630215440797.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ2MDkyMDYx,size_16,color_FFFFFF,t_70#pic_center)

##### 1. 标题设置

- 单张图：`plt.title("名称",fontsize)`
- 多张图：`axes[i].set_title("", fontsize)`

##### 2. 坐标轴标签

- 单张图：`plt.xlabel('x轴',fontsize)`
- 多张图：`axes[i].set_xlabel("",fontsize)`

##### 3. **坐标轴范围

- 统一设置：`plt.axis([xmin, xmax, ymin, ymax])`
- 单独设置：`plt.xlim(xmin, xmax)，plt.ylim(ymin, ymax)`

##### 4. **坐标轴刻度

- 单张图

  ```python
  # 构造x轴刻度标签
  x_ticks_label = ["11点{}分".format(i) for i in x]
  # 构造y轴刻度
  y_ticks = range(15,25)
  # 修改x,y轴坐标的刻度显示
  # ::5表示间隔使用列表中的数据，步长为5
  plt.xticks(x[::5], x_ticks_label[::5])	# 先修改为数字刻度，之后替换中文刻度
  plt.yticks(y_ticks[::1])
  ```

  - `plt.xticks(ticks,label)`

- 多张图

  - `axes[i].set_xticks(x[::k])`
  - `axes[0].set_xticklabels(x_ticks_label[::k])`

##### 5. 网格显示：

- 单张图：`plt.grid(visible, which, axis, color, linestyle, linewidth, alpha)`

  > 除 visible 皆非必要

  - bool visible：是否可见

  - which
    - "major"（默认）
    - "both"
    - "minor"

  - axis："x"、"y"、"both"（默认）

    > 以哪个轴生成网格

  - color："r"、"g"、"b"

  - linestyle："--"、"-."、

  - linewidth

  - alpha：不透明度

- 多张图：`axes[i].grid(参数类似)`

##### 6. 图例显示

![image-20220410171437902](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220410171437902.png)

- 单张图：``plt.legend(loc)``
- 多张图：`axes[i].legend(loc)`



# 基本图像

> 使用plot绘制

### **函数图像变量形式

> 注意：复合函数本质上还是以Symbol创建的自变量构成的函数表达式
>
> 代入计算复合函数还是需要代入最底层变量的值

##### 1. 定义点

```python
x = [5,6,7]
y = 2*x
plot(x,y)		# (5,10)(6,12)(7,14)
```

##### 2. `x = range(min,max)`

##### 3. **等差数列

> 此方法绘制更为平滑

- `x = np.linspace(min, max, nums)`
- `x = np.arange(min, max, step)`

##### 4. 随机量：`y = [random.uniform(a, b) for i in x]`

> 基于x列表中的数据生成随机数，生成的数据大小介于a、b之间

##### 5. 抛物线

- `y = np.pow(x,n)`
- `y = [i**2 for i in x]`

##### 6. 三角函数

- `y = np.sin(x)`
- `y = np.cos(x)`

##### 7. **自定义函数

> 与sympy结合使用

```python
theta = Symbol("θ")		# 自变量
x = 5*cos(theta)
y = 5*sin(theta)
# 代入值计算
theta_data = np.linspace(0,2*np.pi,50)
x_data = [float(x.subs(theta,i)) for i in theta_data]
y_data = [float(y.subs(theta,i)) for i in theta_data]

plt.plot(x_data,y_data)
plt.show()
```





### 散点图







### 柱状图







### 饼状图







### 直方图







# 等高线







# 三维图

































