# 基础方法

### 程序

##### 输出：print

##### 定时调用

```c#
// 只能调用无需参数的函数
Invoke("AttackEnd", 1);

public void AttackEnd()
{
    
}
```



### 组件

##### **获得组件

```c#
// 组件类 变量名称 = 游戏对象.GetComponent<组件类>()
Rigidbody rb = other.gameObject.GetComponent<Rigidbody>();
```

##### 颜色Color

##### **委托判存与发布

```c#
// 委托若存在，执行
委托?.Invoke()
```









# 角色控制

### 键盘控制移动

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



### 