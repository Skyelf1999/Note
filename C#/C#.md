# 程序结构说明

##### 1. 同一命名空间的类皆可在同一项目的任意文件中调用创建实例

##### 2. 若要使用其他类的方法，必须创建实例

##### 3. 同一类的方法可以直接使用





# 基础

### 输入输出

##### 1. 输出：`Console.WriteLine("",变量)`

> 可将变量看做一个列表，从0号开始
>
> 引用变量值时，需要在输出内容中用 **{i}** 指出被引用的是哪个变量
>
> 也可以像java一样输出字符串拼接

##### 2. 输入：`Console.ReadLine()`

> 默认获取的是String类型



### 类型转换

##### 1. `(Type)`

##### 2. `Convert.ToInt32(变量)`

##### 3. `变量.ToString`



### 判断

##### 1. if、else、switch

##### 2. 条件 ? 成立执行 : 不成立执行



### 循环

> 与C语言基本一致



### 可空类型

##### `type? 变量名称 = null`

------







# 数据结构

### 数组

##### 1. 定义

- `Type[] 名称 = new Type[max]`
- `Type[] 名称 = {内容}`

##### 2. 访问

- `名称[index]`

- foreach访问

  ```c#
  foreach(Type i in 数组)
  {
      // 对每个元素进行访问
  }
  ```



### 字符串

##### 1. 创建

- 直接定义：`String 名称 = "……"`

- 将char[]构造成字符串

  ```c#
  // 构造方法将字符数组拼接成字符串
  char[] letteres = {'H','e',……};
  string hello = new string(letters);
  ```

##### 2. 相关方法

```c#
string hello = "Hello";
// 可当做字符数组访问单个字符
hello[1];

// 求长度
hello.Length;

// 是否包含
bool result = hello.Contains("e");

// 是否相等
result = hello.Equals("hello");
```



### 结构体

##### 1. 定义

> 与类很相似
>
> 但是 **值类型** ，不支持继承，不能声明默认构造函数

```c#
struct name
{
    // 变量
    
    // 方法
}
```

##### 2. 使用

> 用 **New** 操作符创建一个结构对象时，会调用适当的构造函数来创建结
>
> 若不使用 **New** ，只有在所有字段均初始化之后，才能被赋值

- `struct_type 名称 `
- `struct_type 名称 = new struct_type() `



### 枚举

##### 1. 声明：`enum 名称 {x_1, x_2, ……}`

> 列表中的每个符号代表一个整数值，后面的比前面的大
>
> 默认从0开始

##### 2. 使用：`名称.符号`

------







# 面向对象

### 类

##### 1. 关于被 private 修饰的类成员

- 自定义Get-Set

- 使用集成 Get-Set

  ```c#
  private string name
  
  public string Name
  	{
  		get { return name; }
  		set { name = value; }
  	}
  ```

##### 2. 构造函数

```c#
public 类名称(参数)
{
    // 执行语句
}
```

##### 3. 析构函数

> 无返回值，不能有参数、继承、重载
>
> 用于在结束程序时释放内存

```c#
~类名称()
{
    
}
```

##### 4. static静态修饰

- 被 **static** 修饰的类成员，无论有多少对象，只有一个该成员副本

  > 共享一个静态成员

- 被被 **static** 修饰的类方法，只能访问静态变量

##### 5. **继承

- 继承标识：`class 子类: 父类`

- 若父类有带参构造，子类必须先实现

  > 用: base(参数) 向父类构造方法传递参数

  ```c#
  class Player
  {
      private string name;
      private int age;
      // 无参构造
      public Player(){}
      // 有参构造
      public Player(string x, int y)
      {
          name = x;
          age = y;
      }
  }
  
  class Player
  {
  	private int position;
  
  	public Player_DotA() {}
      // 实现父类的有参构造
  	public Player_DotA(string x, int y,int z): base(x,y)
  	{
  		position = z;
      }
  
  	// 方法
      }
  ```

##### 6. **动态多态性

> 通过父子类中的虚方法与重写实现
>
> 调用子类重写的方法时，会先执行虚方法语句，再执行重写语句

- 父类中的虚方法定义

  ```c#
  public virtual 返回值类型 函数名称()
  {
      // 虚方法执行语句
  }
  ```

- 子类中的重写

  ```c#
  public override void getInfo()
  {
  	base.getInfo();
  	// 子类添加的执行语句
  }
  ```


##### 7. **类的运算符重载

> 可以定义两个类的运算，定义在类内
>
> 修饰：static，virtual

```c#
public 函数修饰 返回值类型 operator+ (参数) {}
```

![image-20220127094625800](C:\Users\起名难的神话\AppData\Roaming\Typora\typora-user-images\image-20220127094625800.png)



### 接口

> 只进行成员的声明，由派生类进行定义

##### 1. 接口定义

```c#
interface 接口
{
    // 成员声明
    void 方法名称();
}
```

##### 2. 实现类必须实现所有相关接口声明的成员



### 预处理器指令

##### 1. #define 符号名称

> 定义一个符号，使其传递给 #if 时会返回true

##### 2. #if(表达式)

> 用于处理 #define 定义的符号逻辑判断，若被定义则为true



### 正则表达式

> https://www.runoob.com/csharp/csharp-regular-expressions.html



### 异常处理

> https://www.runoob.com/csharp/csharp-exception-handling.html



### 文件输入输出

> https://www.runoob.com/csharp/csharp-file-io.html

















































