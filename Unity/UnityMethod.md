# 基础方法

### 程序

##### 输出

- 简单输出：`print(Object message)` 和 `Debug.Log(Object message)`

- 格式化输出：`Debug.LogFormat`

  > 与 `Console.WriteLine` 类似

##### 定时调用

```c#
// 只能调用无需参数的函数
Invoke("AttackEnd", f1.0);

public void AttackEnd()
{
    
}
```

##### **委托判存与发布

```c#
// 委托若存在，执行
委托?.Invoke()
```

##### 访问其他脚本成员

- 设置目标成员为静态成员

  > 适用于少量允许访问的对象

- 在目标脚本中设置静态访问实例

  > 适用于允许访问的对象较多时

  ```c#
  // 此脚本为需要在其他位置访问的脚本
  public class A: MonoBehaviour 
  {
  	public static A instance; // 提供给外部用于访问的静态实例
   
   	// 使用Awake()确保单例模式在使用前已被初始化
  	void Awake()
      {
  		instance = this;
  	}
   	
   	// 其他脚本通过 A.instance.成员 即可访问
   	public int name;
  
  }
  
  ```

  



### 组件

##### **获得组件

```c#
// 组件类 变量名称 = 游戏对象.GetComponent<组件类>()
Rigidbody rb = other.gameObject.GetComponent<Rigidbody>();
```

##### 获取对象

- 本体：`GameObject 任意组件.gameObject`
- 子对象
  - 

##### 颜色Color

- 创建：`Color color = new Color(float r, float g, float b, float a);`

------



### 位置

##### 获取位置

##### 坐标变换

- 镜头-->世界：`Vector3 position = Camera.main.ScreenToWorldPoint(Vector3 pos)`



### 数学工具 Mathf

##### 变量控制

- 防止越界：`float Mathf.Clamp(float x,float min,float max)`

  > 常用于防止数据越界
  >
  > x<min，返回min
  >
  > x>max，返回max
  >
  
- 步长趋近：`float Mathf.MoveTowards(float x,float y,float delta)`

  > 将x向y最大移动delta

------







# 检测

### 碰撞检测

##### 使用刚体、碰撞体

##### 射线检测

> 缺点：不能从对象身上发射，否则会先碰到本对象

- 射线命中信息：`RaycastHit2D hitInfo;`

  - 碰撞对象Collider：`collider`
  - 碰撞对象刚体：`rigidbody`

- 射线检测：`RaycastHit2D Raycast(Vector2 origin, Vector2 direction, float distance);`

- 使用示例

  ```c#
  // 通过射线检测判断玩家是否在地面上
  void GroundCheckRay()
  {
      // 不能从玩家身上发射，否则会先碰撞到玩家
      Debug.DrawRay(transform.position+new Vector3(0,-0.505f,0),new Vector2(0,-0.2f),Color.cyan);
      hitInfo = Physics2D.Raycast(transform.position+new Vector3(0,-0.505f,0),new Vector2(0,-1),0.1f);
      if(hitInfo)
      {
          // print(hitInfo.collider.name);
          if(hitInfo.collider.tag=="Ground" && isJump)
          {
              // print("落地");
              isJump = false;
          }
      }
  }
  ```

##### Physics图层检测

> 指定检测对象所在的Layer

- 相关方法

  - 获取图层：`LayerMask layerMask = LayerMask.GetMask(string layerName);`

  - 盒形检测：`Physics.OverlapBox`

    - 检测中心点：`Vector3 center`

      > 通常与主体position相关

    - Vector3 halfExtents

    - Quaternion orientation

    - 目标图层：`LayerMask layerMask`

    - QueryTriggerInteraction queryTriggerInteraction

  - `Physics.OverlapCapsule`

  - `Physics.OverlapSphere`

- 示例

  - 子弹检测

    ```c#
    public class Bullet : MonoBehaviour
    {
        LayerMask layerMask;
        
        void Start()
        {
            // 指定检测哪些Layer
            layerMask = LayerMask.GetMask("图层1","图层2");
        }
        
        void FixedUpdate()
        {
            // 获取碰撞对象
            var collider = Physics2D.OverlapBox(transform.position, transform.localScale, 0, layerMask);
            if(collider)
            {
                // 碰撞处理
            }
        }
    }
    ```

  - 地面检测

    ```c#
    LayerMask groundLM = LayerMask.GetMask("Ground");
    
    void GroundCheckLayer()
    {
    	if(Physics2D.OverlapBox(
            transform.position+colliderHeight*0.5f*Vector3.down,
            Vector3.one*0.02f,
            0,groundLM)
          )
        {
            if(isJump) print("落地");
            isJump = false;
        }
    }
    ```

    


------







# 角色控制

### 键盘控制移动

##### 获取输入

- 按键：`Input.GetKey(KeyCode.W)`
- 轴输入：`Input.GetAxisRaw("Horizontal")`

##### 使用 transform

```c#
float v = 1.0f;
float dt = Time.fixedDeltaTime;
// 键盘控制
public void MoveNormal()
{
    if (Input.GetKey(KeyCode.W)) transform.Translate(Vector3.forward * dt * v);
    else if (Input.GetKey(KeyCode.S)) transform.Translate(Vector3.back * dt * v);
    else if (Input.GetKey(KeyCode.A)) transform.Translate(Vector3.left * dt * v);
    else if (Input.GetKey(KeyCode.D)) transform.Translate(Vector3.right * dt * v);
    if (Input.GetKey(KeyCode.Q)) transform.Rotate(Vector3.down);
    else if (Input.GetKey(KeyCode.E)) transform.Rotate(Vector3.up);
}

// 运动倾斜
public void MoveSmooth()
{
    vertical = Input.GetAxis("Vertical");
    horizontal = Input.GetAxis("Horizontal");
    transform.Translate(new Vector3(horizontal*dt*v,0,vertical*dt*v));
    transform.Rotate(Vector3.up * Input.GetAxis("Mouse X")*v*5);
    // 倾斜（只倾斜模型）
    transform.GetChild(0).localEulerAngles = new Vector3(vertical * 20, 0, -horizontal * 20);
}
```

##### 刚体速度设置

- 设置速度

  ```c#
  void MoveStandard()
  {
      // 跳跃
      if (Input.GetKey(KeyCode.Space)&&!isJump)    
      {
          rb.velocity = new Vector2(rb.velocity.x, jumpVelocity);
          // print("跳跃！");
          isJump = true;
      }
  	// 水平移动
      float curDir = Input.GetAxisRaw("Horizontal");
      if(dir+curDir==0)
      {
          dir = (int)curDir;
      }
      rb.velocity = new Vector2(curDir * vScale, rb.velocity.y);
  }
  ```

- 平滑移动

  ```c#
  void MoveSmooth()
  {
      // 水平移动
      float curDir = Input.GetAxisRaw("Horizontal");
      if(curDir!=0)
      {
          float vx = Mathf.Clamp(rb.velocity.x+curDir*accDelta,-vScale,vScale);
          rb.velocity = new Vector2(vx, rb.velocity.y);
      }
      else if(curDir==0)
      {
          // 减速
          print("减速中");
          rb.velocity = new Vector2(Mathf.MoveTowards(rb.velocity.x,0,decDelta), rb.velocity.y);
      }
      dir = (int)curDir;
  }
  ```

  



### 鼠标控制移动

##### 锁定鼠标运动

> 将鼠标锁定在屏幕中央，并隐藏

```c#
private void MouseLock(bool choice)
{
    if(choice)
    {
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }
    else
    {
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }
}
```

##### 点击移动

> 需要先进行 **导航地形处理**

```c#
Ray mouseRay;			// 射线变量
RaycastHit hitInfo;		// 存储射线检测信息
NavMeshAgent agent = GetComponent<NavMeshAgent>();

private void MouseClickRayDetect(Ray ray)
{
    if (Physics.Raycast(ray, out hitInfo))
    {
        print("鼠标点击到了：" + hitInfo.point);
    }
}
private void MouseClick()
{
    if(Input.GetMouseButtonDown(1))
    {
        // 创建射线
        mouseRay = Camera.main.ScreenPointToRay(Input.mousePosition);
        // 探测
        MouseClickRayDetect(mouseRay);
        // 绘制
    	Debug.DrawRay(mouseRay.origin, mouseRay.direction*20, Color.cyan);
    	// 移动
    	agent.SetDestination(hitInfo.point);
    }
}
```



### 角色位移状态

##### 跳跃

```c#
bool isJump = false;
void PlayerJump()
{
    if(isJump)		// 防止连续跳跃
    {
        Debug.LogError("正在跳跃，无法再次跳跃");
        return;
    }
    rb.velocity = new Vector2(rb.velocity.x, jumpVelocity);
    StartCoroutine("setJump");
}
// 为防止跳跃起始时离地面过近导致地面检测判断为落地，在跳跃之后再设置为跳跃状态
IEnumerator setJump()
{
    yield return new WaitForEndOfFrame();
    isJump = true;
    Debug.Log("正在跳跃");
}
```



### InputSystem

##### 移动处理

> 要考虑手柄的平滑取值

```c#
public void OnMove(InputAction.CallbackContext context)
{
    // 构造Event并发送
    if(context.performed)
    {
        // Move的ActionType是Value
        Vector2 input = context.ReadValue<Vector2>();
        // 不同设备输入处理
        switch(curDeviceId)
        {
            case MyInputDevice.Keyboard:
                moveDir.x = input.x;
                moveDir.y = input.y;
                break;
            case MyInputDevice.Gamepad:
                moveDir.x = Math.Abs(input.x)>sensitive?input.x:0f;
                moveDir.y = Math.Abs(input.y)>sensitive ? input.y : 0f;
                break;
        }
        this.SendEvent(moveDir);
        Debug.Log(input);
    }
    else if(context.canceled)
    {
        switch(curDeviceId)
        {
            /*  
                键盘需要进行多方向键处理
                    当同时按下多个方向键时，松开其中一个就会触发context.canceled
                    但是此时可能别的方向键仍然被按压
                    需要判断是否还有按下的按键
                例如：松开A，若仍然按着D，则直接向右而不是停下
            */
            case MyInputDevice.Keyboard:
                var keyboard = Keyboard.current;
                switch(moveDir.x)
                {
                    case -1:
                        moveDir.x = keyboard.dKey.wasPressedThisFrame || keyboard.rightArrowKey.wasPressedThisFrame ? 1 : 0;
                        break;
                    case 1:
                        moveDir.x = keyboard.aKey.wasPressedThisFrame || keyboard.leftArrowKey.wasPressedThisFrame ? -1 : 0;
                        break;
                }
                switch(moveDir.y)
                {
                    case -1:
                        moveDir.y = keyboard.wKey.wasPressedThisFrame || keyboard.upArrowKey.wasPressedThisFrame ? 1 : 0;
                        break;
                    case 1:
                        moveDir.y = keyboard.sKey.wasPressedThisFrame || keyboard.downArrowKey.wasPressedThisFrame ? -1 : 0;
                        break;
                }
                break;
            default:
                moveDir.x = 0;
                moveDir.y = 0;
                break;
        }
        this.SendEvent(moveDir);
    }

}
```



------







# 多媒体管理

### 音频管理

##### 意义

- 便于统一管理
- 防止音频播放混乱
- 防止因对象销毁而音频播放不完全

------





# 自定义框架

### 工具类 PublicUtil



### 动态系统 Public System



### 静态管理模型 Public Manager

### 



# QFramework

### 基础

##### 底层Architecture

##### IController 

> 表现层
>
> 一般情况下，MonoBehaviour 均为表现层

- 接收底层状态变化

-  更新UI

- 获取 System、Model

- 接收、监听Event

- **发送Command**

  > 实现表现层和底层的交互逻辑

##### ISystem

- 封装多个表现层的共享逻辑

  > 游戏计时
  >
  > 成就

- 获取 System、Model

- 接收、发送Event

##### IModel

> 数据层
>
> 负责数据的定义、数据的 **增删查改** 方法的提供

- 数据操作
- 获取Utility
- 发送Event

##### IUtility

> 区分对象工具和静态工具
>
> 负责提供基础设施，比如存储方法、序列化方法、网络连接方法、蓝牙方法、SDK、框架继承等
>
> 可以集成第三方库，或者封装API

##### ICommand

* 可以获取System
* 可以获取Model
* 可以发送Event
* 可以发送Command

##### **通信机制

![QFrame基础机制](UnityMethod.assets/QFrame基础机制.png)

- 表层对象可获取底层对象
- IController 对 System、Model 操作只能用Command
- IController之间只能通过 Command--Event 交互
- 底层控制 IController 只能用 Event
- 只有 ISystem、IModel 能够注册Event
- 只有 ISystem、IController 能够监听Event



##### 安装

* QFramework.cs 
  * 直接复制[此代码](QFramework.cs)到自己项目中的任意脚本中
* QFramework.cs 与 官方示例
  * [点此下载 unitypackage](./QFramework.cs.Examples.unitypackage)

* QFramework.ToolKits
  * [点此下载 unitypackage](./QFramework.Toolkits.unitypackage)
* QFramework.ToolKitsPro
  * 从 [AssetStore](http://u3d.as/SJ9) 安装



### 数据类 BindableProperty

##### 关系图

##### 源码

```c#
public class BindableProperty<T> : IBindableProperty<T>
{
    public BindableProperty(T defaultValue = default)
    {
        mValue = defaultValue;
    }

    protected T mValue;

    public T Value
    {
        get => GetValue();
        set
        {
            if (value == null && mValue == null) return;
            if (value != null && value.Equals(mValue)) return;

            SetValue(value);
            mOnValueChanged?.Invoke(value);
        }
    }

    protected virtual void SetValue(T newValue)
    {
        mValue = newValue;
    }

    protected virtual T GetValue()
    {
        return mValue;
    }

    public void SetValueWithoutEvent(T newValue)
    {
        mValue = newValue;
    }

    private Action<T> mOnValueChanged = (v) => { };

    public IUnRegister Register(Action<T> onValueChanged)
    {
        mOnValueChanged += onValueChanged;
        return new BindablePropertyUnRegister<T>()
        {
            BindableProperty = this,
            OnValueChanged = onValueChanged
        };
    }

    public IUnRegister RegisterWithInitValue(Action<T> onValueChanged)
    {
        onValueChanged(mValue);
        return Register(onValueChanged);
    }

    public static implicit operator T(BindableProperty<T> property)
    {
        return property.Value;
    }

    public override string ToString()
    {
        return Value.ToString();
    }

    public void UnRegister(Action<T> onValueChanged)
    {
        mOnValueChanged -= onValueChanged;
    }
}
```

##### 主要成员

- 数据：`T Value`

  > 本身为protected
  >
  > 提供了对外的get、set

- 值变动监听：`private Action<T> mOnValueChanged = (v) => { };`

  > 在对数据进行set时，若存在对应Action，调用

##### 常用方法

- 创建对象：`BindableProperty<T> 变量名 {get;set;} = new BindableProperty<T>(T 初始值);`

- 访问数据：`变量.Value`

- 注册值监听

  - `变量.Register(Action<T> onValueChanged)`

  - `变量.RegisterWithInitValue`

    > 与前者区别在于会在注册时先用当前数据调用一次监听Action

##### 示例

```c#
using UnityEngine;

namespace QFramework.Example
{
    public class BindablePropertyExample : MonoBehaviour
    {
        // 创建变量
        private BindableProperty<int> mSomeValue = new BindableProperty<int>(0);
        private BindableProperty<string> mName = new BindableProperty<string>("QFramework");
        
        // 注册监听
        void Start()
        {
            mSomeValue.Register(newValue =>
            {
                Debug.Log(newValue);
            }).UnRegisterWhenGameObjectDestroyed(gameObject);

            mName.RegisterWithInitValue(newName =>
            {
                Debug.Log(mName);
            }).UnRegisterWhenGameObjectDestroyed(gameObject);
        }
        
        void Update()
        {

            if (Input.GetMouseButtonDown(0))
            {
                mSomeValue.Value++;
            }
        }
    }
}


// 输出结果
// QFramework
// 按下鼠标左键,输出:
// 1
// 按下鼠标左键,输出:
// 2
```



### Event

> 本质上是结构体？？

##### 定义

```c#
public struct ActiveDestinationEvt
{
	public bool active;
}
```

##### 使用

- 获得发送Event功能：`ICanSendEvent`

  > 可以让Contoller实现此接口来获得发送Event的能力

- 发送Event：

  - `this.SendEvent<Event结构体类型>();`
  - `this.SendEvent<>(Event结构体对象);`



### ICommand

##### 定义

> 如果想创建支持参数的Command
>
> 可以 **自建构造函数接受参数**，并在发送Command的时候使用创建Command对象发方式创建

```c#
public class ActiveDestinationCmd : AbstractCommand
{
    // 必须实现的方法
    protected override void OnExecute()
    {
        this.SendEvent<ActiveDestinationEvt>();
    }
}
```

##### 发送Command

- 按类别：`this.SendCommand<Cmd类>();`

  > 此方式发送的Cmd一般不具有变动参数
- 按对象：`this.SendCommand(Cmd对象);`



### IModel

> 一般用于保存本次游戏的相关数据

##### 预定义虚Model类

> QFrame中定义的抽象类，实现IModel
>
> 可视为一个简略的Model，方便创建自定义Model

```c#
public abstract class AbstractModel : IModel
{
    // 架构
    private IArchitecture mArchitecturel;

    // IModel所需实现的架构类相关方法
    // 继承了此类的Model不必再自己写一遍相关方法
    IArchitecture IBelongToArchitecture.GetArchitecture()
    {
        return mArchitecturel;
    }
    void ICanSetArchitecture.SetArchitecture(IArchitecture architecture)
    {
        mArchitecturel = architecture;
    }

    void IModel.Init()
    {
        OnInit();
    }
	
    // 继承该抽象类的Model必须实现其相应的初始化方法
    protected abstract void OnInit();
}
```

##### 自定义Model规范与实现

> 项目内不同的Model有各自的规范，通过定义接口来规定这些规范
>
> 用这种方式可以清晰地将自定义Model的属性、方法列在接口中，并在类里实现

```c#
// 通过接口规定本项目中的 GameModel 规范
public interface IGameModel : IModel
{
    // 规定属性
    BindableProperty<int> Score {get;}
}


public class GameModel : AbstractModel, IGameModel
{
    // 实现接口规定的属性
    BindableProperty<int> IGameModel.Score {get;} = new BindableProperty<int>(0);
	
    // 实现AbstractModel的抽象方法
    protected override void OnInit()
    {
        // throw new NotImplementedException();
    }
}
```



### IArchitecture

> 底层框架

##### 定义

```c#
public class 框架类名称 : Architecture<框架类名称>
{
    protected override void Init()
    {
        
    }
}
```

##### 常用方法

- 注册Model：`RegisterModel<自定义IModel>(new 自定义Model());`
- 注册System：``

##### 示例

```c#
// 实现QF底层类
public class PlatformShootingGame : Architecture<PlatformShootingGame>
{
    protected override void Init()
    {
        // 注册本项目的 IModel
        RegisterModel<IGameModel>(new GameModel());
    }
}
```



### IController

> 挂载在游戏对象上，直接控制游戏对象

##### 定义

```c#
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using QFramework;

namespace QFPlatformShooting
{
    public class QFUIManager : MonoBehaviour, IController
    {
		// 必须实现的底层类相关方法：返回本项目框架接口
        IArchitecture IBelongToArchitecture.GetArchitecture()
        {
            return PlatformShootingGame.Interface;
        }

        void Start()
        {
            
        }

        // Update is called once per frame
        void Update()
        {

        }
        
    }
    
    
}
```

##### 常用方法

- 获取Model：`this.GetModel<T>()`

  ```c#
  using System;
  using System.Collections;
  using System.Collections.Generic;
  using UnityEngine;
  using UnityEngine.UI;
  using QFramework;
  
  namespace QFPlatformShooting
  {
      public class QFUIManager : MonoBehaviour, IController
      {
          public Text ScoreText;
  
          IArchitecture IBelongToArchitecture.GetArchitecture()
          {
              return PlatformShootingGame.Interface;
          }
  
  
          void Start()
          {
              if (ScoreText == null) ScoreText = GameObject.Find("UI/Canvas/ScoreText").GetComponent<Text>();
              this.GetModel<IGameModel>().Score.Register(OnScoreChanged).UnRegisterWhenGameObjectDestroyed(gameObject);
          }
  
  
          ///////////////////////// UI相关方法 /////////////////////////
          // 当前分数增加
          // 注册为BindableProperty的监听时间，每当值变更时，也改变UI
          void OnScoreChanged(int score)
          {
              ScoreText.text = ScoreText.text.Substring(0,3) + score.ToString();
              print("当前分数："+score);
              if(score==2) this.SendCommand<ActiveDestinationCmd>();
          }
  
          
      }
  }
  ```

- 获取System：`this.GetSystem<T>()`

  ```c#
  this.GetSystem<ICameraSystem>().SetTarget(transform);
  ```
- 注册监听的Event：`this.RegisterEvent<Event结构体类型>(处理方法)`

  > 事件发生时，会将事件结构体传入处理方法

  ```c#
  // 关卡终点
  public class QFDestination : MonoBehaviour , IController
  {
      IArchitecture IBelongToArchitecture.GetArchitecture()
      {
          return PlatformShootingGame.Interface;
      }
  
      // Start is called before the first frame update
      void Start()
      {
          gameObject.SetActive(false);
          // 注册监听的Event
          this.RegisterEvent<ActiveDestinationEvt>(OnActiveDestination);
      }
  
      // 事件处理方法
      // 当事件“激活终点”发生时，激活游戏对象
      private void OnActiveDestination(ActiveDestinationEvt obj)
      {
          gameObject.SetActive(true);
      }
  }
  ```

- 发送Command

  - `this.SendCommand<Command类名>();`
  - `this.SendCommand(new Command类名());`
  
    > 这种方式可以调用对应Command的构造函数
    >
    > 因此支持传递参数


##### 示例



### ISystem

##### 定义

##### 常用方法

- 发送Event
- 获取Model

------



















