# 数组

### 数组创建

##### 1. **自定义创建：`np.array(数据, 可选参数)`

> ndarray对象

- dtype：数组元素的数据类型

  - 复数：complex

    ```python
    a = np.array([1,  2,  3], dtype = complex)
    # [1.+0.j 2.+0.j 3.+0.j]
    ```

  - float

  - int

- copy：对象是否需要复制

- order：创建数组的样式，**C为行方向**，F为列方向，A为任意方向（默认）

- subok：默认返回一个与基类类型一致的数组

- **ndmin：指定生成数组的最小维度

##### 2. 空数组：`np.empty(shape, dtype, order)`

> 数组元素为随机值，因为它们未初始化。
>
> shape用列表存储

##### 3. 零数组：`np.zeros(shape, dtype, order)`

##### 4. 1数组：`np.ones(shape, dtype, order)`

##### 5. **根据数值范围创建：`np.arange(start, stop, step, dtype)`

> 一维数组，start<=数组元素<stop，step为步长
>
> 建议：**stop = 目标上限 + step**

##### 6. **根据采样量创建：`np.linspace(min,max,nums)`

> 在范围内等间隔地取nums个数
>
> 一般建议：**nums = (max-min)*10+1**



### 数组信息访问

##### 1. 构造信息访问

- 秩：`ndarray.ndim`

- **维度：`ndarray.shape`

  > 一个二维数组，其维度表示"行数"和"列数"。
  >
  > 也可以用于调整数组大小。

- **元素总个数：`ndarray.size`

- 元素类型：`ndarray.dtype`

##### 2. **元素访问

- ndarray[index]

  - x,y,z

  - i:j

    > i~j-1

  - i:

    > i及之后

- 高级索引：索引以列表存放

  > ```python
  > y = x[[0,1,2], [0,1,0]]  	# 访问(0,0)(1,1)(2,0)
  > rows = np.array([[0,0],[3,3]]) 
  > cols = np.array([[0,2],[0,2]]) 
  > y = x[rows,cols]
  > # 访问 (0,0)(0,3)
  > #     (3,0)(3,2)
  > ```

- **条件访问：`ndarray[条件]`

  > 例如：输出大于i的元素



### 数组操作

##### 1. 构造调整：`a.reshape(x, y, z)`

> ```python
> a = np.arange(24)
> print(a.reshape(2,4,3))		# 2 X 4 X 3
> ```
>
> ![image-20220405195140789](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405195140789.png)

##### 2. 数组展开：`np.ravel(a, order)`或 `ndarray.ravel(order)`

> 通常将高维展开成1维

##### 3. **矩阵转置

- `np.transpose(array, axes)`
- `ndarray.T`

##### 4. 数组连接

- 连接沿现有轴的数组序列：`np.concatenate((a,b,c, ....), axis)`

  > ![image-20220405203445191](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203445191.png)![image-20220405203448850](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203448850.png)

- 沿着新的轴加入一系列数组：`np.stack((arr_1,arr_2)), axis)`

  > ![image-20220405203620075](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203620075.png)![image-20220405203625178](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203625178.png)

- 水平堆叠序列中的数组（列方向）：`np.hstack`

  > ![image-20220405203645955](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203645955.png)![image-20220405203649942](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203649942.png)

- 竖直堆叠序列中的数组（行方向）：`np.vstack`

  > ![image-20220405203710094](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203710094.png)![image-20220405203713843](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220405203713843.png)





# 数学运算

### 三角函数

> Numpy可以直接对数组矩阵进行运算

##### 1. 弧度角度互换

- 角度 --> 弧度：`b = a/180`

  >  以π为单位
  >
  > 若计算π，则需乘np.pi

- 弧度 --> 角度：`a = np.degrees(b)`

  > 必须是对带π的弧度制进行转换
  >
  > 不是 (x)π，而是 (xπ)

##### 2. 三角函数

> 假设度数以弧度存储

- sin：`np.sin(a)`
- arcsin：`np.arcsin(a)`



### 舍入

##### 1. 四舍五入：`np.around(arr,decimals)`

- arr：数组或单个数字

- 取整位数：decimals

  > 默认取整
  >
  > decimals>0：取到小数点后第n位
  >
  > decimals<0：取到小数点前第n位

##### 2. 取整

- 向下：`np.floor(arr)`
- 向上：`np.ceil(arr)`



### 算数操作

> 对应位置进行运算，必须有相同或相似形状
>
> 例如 3X3 和 1X3（按行运算）、3X1（按列运算）
>
> 也可以直接与单个数运算

##### 1. 加：`np.add(a,b)`

##### 2. 减：`np.subtract(a,b)`

##### 3. 乘：`np.multiply(a,b)`

##### 4. 乘方：`np.power(a,n)`

##### 5. 除：`np.divide(a,b)`

##### 6. 取余：`np.mod(a,b)`

> 当b为数组时，对应位置乘方

##### 7. 取倒数：`np.reciprocal(arr)`



### **矩阵操作

> 矩阵和数组进行数学运算时有区别！！！

##### 0. 转换成矩阵：`np.matrix(arr)`

##### 1. **转置：`a.T`

##### 2. 单位对角线阵：`np.eye(n,M,k,dtype)`

- n,M：行、列
- k：从第0行第k号开始，对角线都是1
  - k=1
    ![image-20220406111013568](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220406111013568.png)
  - k=-1
    ![image-20220406111003916](C:\Users\14563\AppData\Roaming\Typora\typora-user-images\image-20220406111003916.png)

##### 3. **单位阵：`np.identity(k,dtype)`

##### 4. 点乘：`np.dot(a,b)`

> 常规的矩阵相乘
>
> c(i,j) = 第i行 · 第j列

##### 5. 向量点乘：`np.vdot(a,b)`

> 对应位置元素的乘积的和

##### 6. 内积：`np.inner(a,b)`

> c(i,j) = 第i行 · 第j行

##### 7. **矩阵相乘：`np.matmul(a,b)`

> **当n=2时，matmul与dot效果相同**
>
> 虽然它返回二维数组的正常乘积，但如果任一参数的维数大于2，则将其视为存在于最后两个索引的矩阵的栈，并进行相应广播。
>
> 另一方面，如果任一参数是一维数组，则通过在其维度上附加 1 来将其提升为矩阵，并在乘法之后被去除。

##### 8. **行列式：`np.linalg.det(arr)`

##### 9. **求逆：`np.linalg.inv(arr)`

##### 10. 线性方程组求解：`np.linalg.solve(a,b)`

> 系数矩阵必须可逆
>
> 表示结果要按列有限排？







# 数据处理

### 数据拟合

##### 1. 多项式拟合：`np.polyfit(x,y,deg)`

- x、y：坐标列表

- deg：多项式次数

- 返回：多项式参数列表

  > 需要联合 np.polyval(poly, x) 来获得多项式代入值

  ```python
  # 获取x、y数据列表
  x = np.linspace(300,400,20)
  y = x + np.random.random_integers(5,20,20) #随机取5到10中间20个数
  # 获取多项式参数
  poly = np.polyfit(x,y,deg=1)
  # 获取多项式代入值列表
  z = np.polyval(poly, x)
  # 画图
  plt.plot(x, y, 'o')
  plt.plot(x, z)
  plt.show()
  ```

  









