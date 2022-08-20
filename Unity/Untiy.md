# 基础

### 界面

> 资源 --> 项目窗口、层级窗口 --> 场景，检查器、控制台

##### 布局设置

![image-20220321153506501](Untiy.assets/image-20220321153506501.png)

##### 场景窗口

- 快捷键Q~Y可切换不同工具
- 按住右键即可使用WASD控制视角

<img src="Untiy.assets/image-20220314165527658.png" alt="image-20220314165527658" style="zoom:67%;" />

##### 层级窗口 Hierarchy

- 可查看场景内所有游戏对象

![image-20220314165726639](Untiy.assets/image-20220314165726639.png)

- 右键可快速创建对象

##### 检查器 Inspector

- 查看选中游戏对象的详细信息、组件
- 可将脚本直接拖拽到窗口进行挂载

![image-20220314165858108](Untiy.assets/image-20220314165858108.png)

##### 项目文件窗口 Project

- 存放项目的所有资源

![image-20220314171023071](Untiy.assets/image-20220314171023071.png)

##### 控制台 Console

- 输出报错、警告信息
- 可通过代码向控制台输出信息
- **双击**提示信息可**定位对应代码位置**



### 项目内容

##### 场景 Scene

- 切割游戏的单位

- 一个游戏至少一个场景

- 场景跳转常用加载页面过渡，无缝大地图则是实时加载、卸载游戏资源

- **默认存储位置**：`Assets/Scenes`

  > 只保存场景中的对象、挂载的组件、组件参数等信息，不保存资源

##### 游戏对象 Game Object

- 场景中的一切物体都是游戏对象

  > 模型、灯光、特效、相机、UI、脚本

- 可以互相组成父子关系

- 可在游戏运行时动态增删改查

##### 组件 Component

- 组件本质是**脚本**，通过**挂载在游戏对象上**，决定游戏对象的功能
- Unity自带很多常用组件，用户编写的C#脚本也可作为组件



### 生命周期

> 同一脚本的生命周期执行顺序固定
>
> 但 **不同脚本的顺序不固定**

##### 1. Awake()

##### 2. Start()

##### 3. Update() / FixedUpdate()

> 按帧/时间执行

##### 4. LateUpdate()

> 每次Update之后执行

------







# 脚本 Script

### 基本特性

- 挂载在游戏对象上
- 一个脚本只能有1个类，**继承MonoBehaviour**，名称与脚本名一致
- 类中定义的变量可在界面中看到



### 创建

##### 1. 编译器设置

<img src="Untiy.assets/image-20220314171723442.png" alt="image-20220314171723442" style="zoom: 80%;" />

##### 2. 添加脚本组件

![image-20220314171822876](Untiy.assets/image-20220314171822876.png)

![image-20220314172400370](Untiy.assets/image-20220314172400370.png)



### 基础结构

```c#
public class FirstSpell : MonoBehaviour
{
    // 该函数在第一次刷新之前调用
    void Start()
    {

    }

    // 每次刷新时调用
    void Update()
    {
        
    }
}
```





# Transform

> 属性信息为 **Vector3** 向量类型
>
> 将对象拖拽到另一对象上，即可进行父子关系的设置
>
> 子对象以父对象位置为原点

### 向量 Vector

> 结构体
>
> 可以进行加减操作！！

- 属性

  - float x
  - float y
  - float z

- 赋值：`vec = new Vector3(x,y,z)`

- 单位向量

  > 还有向左、向右

  - 向前：`Vector3 v = Vector3.forward` 
  - 向后： `Vector3 v = Vector3.back`

- **距离计算**：`float dis = Vector3.Distance(v1,v2)`

### 基础属性

> 不能对向量的单个属性进行操作，**必须同一赋值**

##### 位置

- 绝对：`transform.position`
- 相对：`transform.local`
- 移动
  - 向量累加：`transform.position += new Vector3(0.01f,0,0)`
  - 直接移动：`transform.Translate(x,y,z)`

##### 姿态

- 绝对：`transform.eulerAngles`
- 相对：`transform.localEulerAngles`
- 旋转：`transform.Rotate(1,0,0)`

##### 缩放

- 绝对：`transform.lossyScale`
- 相对：`transform.localScale`





# Bolt可视化编程

















