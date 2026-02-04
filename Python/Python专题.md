# 程序基础

### 环境配置

##### Python解释器

- 安装位置示例：`C:\Users\起名难的神话\AppData\Local\Programs\Python`

- **版本检查**：`python --version`

- 环境变量：默认从上到下顺序调用，可通过 **修改顺序手动设定使用的Python版本**

  ![image-20260127091554151](Python专题.assets/image-20260127091554151.png)

##### vscode

- 插件
  ![image-20260127091137445](Python专题.assets/image-20260127091137445.png)

- 工程虚拟环境：在工程目录下，`python -m venv 虚拟环境目录名称`

  > 之后，pip调用的是Scripts下的pip，引入的包安装在 **Lib/site-packages** 中

  ![image-20260127093331150](Python专题.assets/image-20260127093331150.png)
  
- 激活虚拟环境：`.venv\Scripts\activate`

  > 注意：每次进入工程都需要进行激活，尤其是在同时安装了Anaconda进行环境管理的条件下，很可能进入后默认是使用的Anaconda管理的虚拟环境

##### Anaconda

- 版本验证：`conda --verison`

- 当前存在的虚拟环境：`conda env list`  或  `conda info --envs`
  <img src="Python专题.assets/image-20260127121630928.png" alt="image-20260127121630928" style="zoom: 80%;" />

- **虚拟环境保存位置**

  > 建议修改

  - 查看：`conda info` 所显示的信息中，envs directories的内容，第一个是当前用户专属的环境目录

  - 修改配置文件：`conda config --add envs_dirs 新的位置路径`

- **创建虚拟环境**：`conda create --name 虚拟环境名称 python=3.12`

  ```shell
  # 不安装默认包
  conda create --name myenv python=3.12 --no-default-packages
  ```

  

- 激活：`conda activate 虚拟环境名称`

  > 激活后，可以用`python -V` 、`pip -V` 等命令验证，并在该环境中安装包

- 查看当前虚拟环境安装的包：`conda list`

- 取消激活：`conda deactivate`

- 删除：`conda env remove --name myenv`

- 使用环境yaml环境配置文件

  - 导出：`conda env export > environment.yml`
  - 导入：`conda env create -f environment.yml`

- conda包管理
  ```shell
  # 查看已安装的包
  conda list
  
  # 更新numpy
  conda update numpy
  
  # 搜索可用的numpy版本
  conda search numpy
  
  # 使用conda指定版本
  conda install numpy=1.24.0
  ```

- 在虚拟环境中使用pip进行包管理

  - 确认当前使用的是虚拟环境中的工具
    ```shell
    # 在激活的环境下执行
    where python
    where pip
    python -m pip --version  # 查看当前python使用的pip
    ```

  - 若未使用

    - 检查虚拟环境下的环境变量：``
    - 虚拟环境完整性有问题，强制重装pip：`conda install --force-reinstall pip`


##### PyCharm

- 添加现有虚拟环境



### 程序基础

##### 基本结构

```python
def 函数(参数):
    # 函数程序
    return 返回值   # 无返回值时，返回None

if __name__ == '__main__':
    # 主函数
```

##### lambda匿名函数

- 定义：`lambda 参数1,参数2,参数3: 单行函数内容`

- 传递函数参数
  ```python
  # 多用于将一个临时函数作为参数传递
  def printFuncResult(func):
      result = func(1,2,3)
      print(result)
  
  printFuncResult(lambda x,y,z: x+y+z)
  ```


##### print

- 





### 程序流程控制

##### 循环

```python
for i in range(n):
    # 循环变量范围：0~n-1

for i in range(x,y):
    # 循环变量范围：x~y-1
    
for i in range(x,y,k):
    # 循环变量范围：每次循环后x+=k，且x<y或x>y
    
while 条件判断:
else: 退出循环处理

# 除了用break终止循环，也可用continue结束本轮循环
```

##### 条件分支

- if-else
  ```python
  if condition_1:
      statement_block_1
  elif condition_2:
      statement_block_2
  else:
      statement_block_3
  ```

- match-case

  > python 3.10增加

  ```python
  match subject:
      case subject的值1|值2|值3:
          <action_1>
      case _:
          <action_wildcard>
  ```

  



### 面向对象

##### 1. 创建

> 在成员方法中若要调用其他的成员方法或类成员
>
> 需要借助 **self**
>
> 类成员使用**单下划线修饰**等效于**protect修饰**

```python
class 类名称():
    '帮助文档'
    
    # 类成员
    name = ''
    
    # 构造方法
    def __init__(self, 类成员):
        self.类成员 = 传入的类成员值
        
    # get-set
    def getName(self):
        return self.name
    def setName(self,name):
        self.name = name
    
    # 类方法
    def 函数名(参数):
        # 方法程序
```

##### 2. 构造实例

> 若不在同一文件，需要先导入：`from 文件名称 import 类名称`

```python
对象名 = 类名称(参数)
```







### 字符串

> 在Python中，相同内容的字符串都是同一个对象

##### 1. 定义

- `string = "xxxxxxxxx"`
- `string = input()`

##### 2. 基本操作

- 访问单个字符：`string[index]`
- 拼接：`string + "xxx"`
- **判断字符相等：`str1 == str2`

##### 3. **将输入转换为list

- 输入格式：元素之间以空格分隔

- 转换方法：`list  = input().split()`

  > 常用于一组数据的输入处理
  >
  > 注意：输入的元素数据类型必须一致，必须**全是数字才能作为数组**，否则会被当做无法转成数字的str类型

##### 4. 将对象转换为1个字符串：`"拼接方式".join(对象)`

> 对象可以是列表、字符串，得到一个新的字符串

##### 5. 获取包含的字符：`chars = list(set(string))`

> 将字符串拆分、去除相同元素
>
> 配合使用numerate构造的字典或原始字符串，或split，即可轻松获取某字符出现的次数
>
> ```python
> # 存储每个字符
> str_list = list("s s s s s t t t t r r r".split())
> # 存储出现过的字符
> chars = list(set("sssssttttrrr"))
> # 出现次数统计
> print(str_list.count(chars[0]))
> ```
>



### 集合{}

> https://www.runoob.com/python3/python3-set.html

##### 1. 定义

- 空集合：`set = set()`

- 直接赋值：`set = {value1, value2, ……}`

- 转换：`set = set(object)`

  > 若是object列表/字符串，则还可以去重

##### 2. 基本操作

- 增：
  - `s.add(x)`
  - `s.update(添加对象)`， 可以是多个列表、元组、字典等

- 删：`s.remove(x)` 或 `s.discard(x)`，后者在x不存在时不会报错
- 判存：`x in set`
- 计数：`len(s)`
- 清空：`s.clear()`

##### 3. 集合运算



### 列表[]

> 和字符串复合输出时要先转换成字符串：`str(list)`
>
> 求长度：`len(list)`

##### 基本操作

- 定义
  - 一般初始化：`list = []`
  - 赋值初始化：`list = [value]*n`
- 基本操作

```python
'''
    Python中，list可实现线性表、堆栈
    操作方法：list.xxxx
        1. append(x)：添加到末尾
        2. insert(index,x)：插入到指定位置
        3. extend(L)：与另一个列表进行拼接
        4. remove(x)：删除第一个值为x的元素
        5. pop(index)：删除并返回指定位置的元素，默认删除最后一个元素
        6. clear()：清空
        7. index(x)：查找并返回第一个值为x的元素的索引
        8. count(x)：计算x出现的次数
        9. sort()：排序
        10. reverse()：倒序
        11. copy()：返回列表的复制
'''
```

##### 访问

- 访问单个元素：`list[index]`，索引从0开始

- 访问多个元素：`list[x,y]`

  > 返回一个**新的list**，元素为 **list[x]~list[y-1]**
  
- **遍历**：`for i,value in enumerate(list)`

##### **扩展操作

- **将输入的字符串转换成列表：`list = input().split("分隔符",分割次数)`

  > .split()：默认分隔符为 **空格**，默认分割次数为 每次

- **元素求和：`sum(list)`

- 判断**是否包含**元素：`值 in list`

  > 这种方式省去了自己编写查找算法的工作，适合简单列表的处理

- 将列表元素转换为 **序号-数据**：`enumerate(list)`

  > 原先：[a, b, c, d]
  >
  > list(enumerate(list))：[(0,a), (1,b), (2,c), (3,d)]
  >
  > 使用for循环访问：`for i, element in enumerate(list)`

- 去重：`list(set(list_origin))`

  > 借助集合即可去重

##### 二维数组

- 初始化

  ```python
  arr = [[0]*n for x in range(n)]
  ```

- **快速遍历求和

  ```python
  '''
  	使用product(x,y)生成笛卡尔积元组
  	(x[0],y[0])
  	(x[0],y[1])
  	……
  	(x[m],y[n])
  ''' 
  
  sum(关于arr[i][j]的求和条件 for i,j in product(range(len(arr)),range(len(arr[0])))
  ```



### 字典{}

> 字典

##### 定义

- 一般定义：`dic = {k:v, k:v}`

  > 值可以取任何数据类型，但键必须是字符串，数字或元组。

- **从列表转化

  > 可通过此方式把列表的index作为值，把原来的数据作为键
  >
  > 以此方式可达成 值-->index 的映射

  ```python
  # hash = {data_1:index_1, data_2:index_2, ....}
  for index,data in enumerate(list):
  	hash[data] = index
  ```

##### 基本操作

- 访问：`dic[key]` 
- 添加：`dic[new_key] = new_value`
- 删除
  - 删除单个：`del dic[key]`
  - 清空：`dic.clear()`
  
- 遍历
  ```python
  for key in dict:
  
  for value in dict.values():
      
  for k,v in dict.items():
  ```

  


##### 相关方法

- 求长度：`len(dic)`

- **根据key查找：`dic.get(key)`

  > 与访问不同的是，若无目标k-v，则返回None



### 链表

##### 节点类

```python
class ListNode:
    # value = 0
    # next = None
    def __init__(self,value=0, next=None):
        self.value = value
        self.next = next

    def __str__(self):
        hasNext = False
        if self.next:hasNext=True
        return str(self.value) + ", " + str(hasNext)

```



### 异常处理

> 本质：if 异常

- 基础捕获
  ```python
  try:
      # 可能出错的代码
  except:
      # 处理方式
  ```

- 针对捕获
  ```python
  except 异常名称 as 存储捕获到的异常的变量名:
      # 处理方式
  
  # 捕获多个
  except (异常1,异常2,...) as 存储捕获到的异常的变量名:
  
  # 全部异常的通用名：Exception
  ```

- 示例

  ```python
  try:
      # 测试代码
  except Exception as e:
      print("异常：",e)
  else: print("无异常")
  finally: print("无论是否有异常，都执行")
  ```

- 函数调用中异常的传递性
  <img src="Python专题.assets/image-20260129154227343.png" alt="image-20260129154227343" style="zoom:50%;" />



------







# 算法

### 查找

##### 数据结构

```python
class Data_struct:
    def __init__(self,key):
        self.key = key

    def getKey(self):
        return self.key
    def setKey(self,key):
        self.key = key
```

##### 顺序查找

```python
def sequential(list,key):
    func_type("顺序查找",1)
    index = len(list)-1
    # 查找条件
    while list[index].key != key:
        index = index-1
        if index<0: break
    print("目标数据序号为：" + str(index))
    func_type("顺序查找",0)
    return
```

##### 折半查找

```python
def half(list,key):
    func_type("折半查找", 1)
    low = 0
    high = len(list)
    while low<=high:
        mid = int((low + high)/2)
        if list[mid].key == key:
            break
        # 判断向左还是向右，若key非整型则需要修改判断条件
        else:
            if key<mid: high = mid-1
            else: low = mid+1
    if low>high: mid = -1
    print("目标数据序号为：" + str(index))
    func_type("折半查找", 0)
    return
```



### 插入排序

##### 数据结构

```python
class Data_struct:
    data = None
    def __init__(self,key):
        self.key = key

    def getKey(self):
        return self.key
    def setKey(self,key):
        self.key = key
```

##### 直接插入

```python
def direct_insert(list):
    func_type("直接插入排序",1)
    # 将当前对象插入到前面的有序列表中
    for i in range(len(list)):
        if i>0 and list[i].key<list[i-1].key:
            temp = list[i]
            for j in range(i - 1, -1, -1):
                if temp.key < list[j].key:
                    list[j + 1] = list[j]
                    list[j] = temp
    print("\n排序结果：",end="")
    for data in list:
        print(data.key, end=" ")
    func_type("直接插入排序",0)
    return
```

##### 折半插入

```python
def half_insert(list):
    func_type("折半插入排序", 1)
    length = len(list)
    if length <= 1:
        print("无需排序")
        return
    for i in range(length):
        if i>0 and list[i].key < list[i-1].key:
            temp = list[i]
            low = 0
            high = i-1
            # 找到当前排序对象正确位置，类似折半查找
            # 不同的是，折半排序的正确位置是导致循环条件不成立的low
            while low <= high:
                mid = int((low + high)/2)
                if list[mid].key == temp.key: break
                elif list[mid].key > temp.key:
                    high = mid - 1
                else:
                    low = mid + 1
            # 将较大项向后移
            for j in range(i - 1, low - 1, -1):
                list[j + 1] = list[j]
            list[low] = temp
    print("\n排序结果：", end="")
    for data in list:
        print(data.key, end=" ")
    func_type("折半插入排序", 0)
    return
```

##### 希尔排序

```python
def shell(list):
    func_type("希尔排序", 1)
    length = len(list)
    # 初始步长
    gap = length // 2
    while gap > 0:
        for i in range(gap, length):
            # 把小的挪到前面
            for j in range(i,gap-1,-gap):
                temp = list[j]
                if list[j-gap].key > temp.key:
                    list[j] = list[j-gap]
                    list[j-gap] = temp
        # 得到新的步长
        gap = gap // 2
    print("\n排序结果：", end="")
    for data in list:
        print(data.key, end=" ")
    func_type("希尔排序", 0)
    return
```



### 交换排序

##### 1. 冒泡排序

```python

```

##### 2. 快速排序

- Python

  ```python
  # 最表层：start=0，end=len(nums)-1
  def quick_sort(nums, start, end):
      if start >= end: return
      base = nums[start]
      right = end
      left = start
  
      while left < right:
          while left < right and nums[right] < base: right -= 1
          else: nums[left] = nums[right]
          # 换方向扫描
          while left < right and nums[left] > base: left += 1
          else: nums[right] = nums[left]
  
      # left 或者 right 对应的位置 赋值为基准值
      nums[left] = base
      quick_sort(nums, start, left-1)
      quick_sort(nums, left+1, end)
  ```




### 选择排序



### 二路归并

------







# 常用包

### Pip包管理

- 安装：`pip install 包名称`
- 查看：`pip list`
- 删除：`pip uninstall xxx`























