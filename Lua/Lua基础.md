# 编译、执行、错误

### 编译

##### 1. 将字符串编译后以函数返回：`func = loadstring(s) `

```lua
local tblStr = "{id = 1, num = 666}"

-- 编译并执行上述table定义，返回结构存储在tbl中
local tbl = assert(loadstring("return " .. tblStr))()
for k, v in pairs(tbl) do
    print(k, v)    
end
```



# 迭代器

##### 1. **泛型for与迭代器

- 默认迭代器

  > ```lua
  > for i,v in pairs(t) do
  > 	print(i,v)	-- t[i]=v
  > end
  > ```

  - `ipairs(table)`

    > 只能识别key为标准数字的键值对，有序
  - `pairs(table)`

    > 当key为非标准数字时，无序

- 使用方法：`for <var_list> in <exp> do ... end`

- **具体步骤

  ```lua
  -- 等价代码
  do
      local iter,state,var = <exp>
      while true do 
      	local v1,v2,...,vn = iter(state,var)
          var = v1	-- 此次调用迭代器得到的第一个结果作为下次使用迭代器的参数
          if var==nil then break end
          -- 进行 v1,v2,...,vn 相关操作（如输出）
      end
  end
  ```

  - 对表达式求值（一般是调用迭代器生成函数），返回：

    > 数量不足的会用 **nil** 补齐

    - 迭代器 iter

    - 状态常量 state|

      > 一般为 table

    - 控制变量 var

      > 一般为索引 index

  - **for重复调用 iter(state,var)，直到var=nil

##### 2. 链表迭代器

> 初次迭代：getNext(head, nil) --> head
>
> 第二次：getNext(head, head) --> 第1个节点head.next
>
> 第三次：getNext(head, 第1个节点) --> 第2个节点

```lua
-- 定义
local function getNext(list,node)
    if not node then
        return list
    else
        return node.next
    end
end

function traverse(list)
    return getNext,list,nil
end

-- 使用，传入头结点
for node in traverse(head) do 
	print(node.value)
end
```





# 数据文件与持久性

### 数据文件

##### 1. 基础

> 部分数据可以用特殊的方式存储在一个lua文件里，方便后续处理
>
> 数据文件中，每一条数据都表示为一个**lua构造式**
>
> ```lua
> -- Entry({})与Entry{}等价，都算以table为参数调用Entry
> 
> Entry{"狄仕豪","23","男","青冥鸟道深"}
> Entry{"zdd","22","男","马尔西昂"}
> Entry{"wjl","22","男","小乐奇遇记"}
> Entry{"zrq","23","男","完虐助教"}
> ```

##### 2. 应用

- 定义相应的数据处理函数`Entry`

  - 求数据数量

    ```lua
    local count = 0
    
    function Entry(...)
        count = count+1
    end
    ```

  - 输出数据的部分内容

    ```lua
    function Entry(...)
        local table = ...
        print(table[#table])
    end
    ```

- 读取文件内容：`dofile("文件路径/文件名称.lua")`

  ```lua
  dofile("G:/MyProgrames/Lua/Test_Lua/data.lua")
  ```

  

### 串行化

##### 1. 一般串行化

```lua
function serialize(o)
	if type(o)=="number" then io.write(o)
    elseif type(o)=="string" then
        io.write(string.format("%q",o))
    else if 
    end
end
```







# 元表

> 以自定义集合类型为例
>
> 可用于实现类、继承、接口？

### 基础

> 可视为**存储预定义操作的table**
>
> 通过元表可修改一个值的行为，使其可以执行自定义的操作（例如table相加）
>
> 通常需要自行添加

##### 1. 查看元表：`getmetatable(t)`

##### 2. **设置元表：`setmetatable(t,metatable)`

##### 3. **元方法定义：`元表.字段 = 函数名`

##### 4. **元表的作用

> 当两个值进行未被默认定义的运算时，会根据运算对应字段在值的元表中寻找元方法
>
> 如下例，调用Set.new会创建**带有元表mt**的table
>
> 当两个通过此方法的table进行相加运算时
>
> Lua就会去元表mt中寻找加法字段 **__add 对应的元方法**（此例中是Set.union）
>
> 并将参与运算的两个变量自动传入该方法
>
> ```lua
> Set = {}
> local mt = {}   -- 元表
> 
> -- 根据传入的数据，创建新的集合
> -- 处于集合中的元素表现为：set[data]=true
> function Set.new(l)
>  local set = {}
>  setmetatable(set,mt)    -- 将mt设置为当前所创建的table的元表
>  for _,v in ipairs(l) do
>      set[v] = true
>  end
>  return set
> end
> 
> -- 并集
> function Set.union(a,b)
>  local res = {}
>  for k in pairs(a) do res[k]=true end
>  for k in pairs(b) do res[k]=true end
>  return res
> end
> 
> -- 交集
> function Set.intersection(a,b)
>  local res = Set.new{}
>  for k in pairs(a) do
>      res[k] = b[k]
>  end
>  return res
> end
> 
> -- 输出
> function Set.tostring(set)
>  local l = {}
>  for e in pairs(set) do
>      l[#l+1] = e
>  end
>  return "{" .. table.concat(l,",") .. "}"
> end
> function Set.print(s)
>  print(Set.tostring(s))
> end
> 
> -- 元方法
> mt.__add = Set.union
> ```

##### 5. **总体创建方法

- 创建元表：`mt = {}`

- 定义元表字段对应的方法：`mt.元方法字段 = 元方法`

  > 可现场定义函数、table或直接引用函数名称

- 将元表与目标table绑定：`setmetatable(t,mt)`

  > 类的构造方法就可以将基本信息存储在元表中
  >
  > **每次创建**新对象都将元表与其绑定



### 算数类的元方法

> 当两个table进行运算时，优先调用前一个table的元表
>
> ```lua
> -- 集合算术运算元方法
> metatable_Set.__add = Set.union
> metatable_Set.__mul = Set.intersection
> ```

##### 1. 四则运算

- `__add`

  > 例如集合的“+”可定义为求并集

- `__sub`

- `__mul`

- `__div`

##### 2. 其他

- 相反数：`__unm`
- 取模：`__mod`
- 乘方：`__pow`
- 连接：`__concat`



### 关系类的元方法

##### 1. 等于：`__eq`

```lua
-- 集合相等判断
metatable_Set.__eq = function(a,b)
    return a<=b and b<=a
end
```

##### 2. 小于：`__lt`

```lua
-- 真子集判断
metatable_Set.__lt = function(a,b)
    return a<=b and not (b<=a)
end
```

##### 3. 小于等于：`__le`

```lua
-- 子集判断
metatable_Set.__le = function(a, b)
    for k in pairs(a) do
        if not b(k) then return false end
    end
    return true     -- a是b的子集
end
```



### 库定义的元方法

##### 1. **格式化输出：`__tostring`

> print函数总是会调用输出目标元表中该字段对应的元方法

```lua
-- table-->字符串
function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l+1] = e
    end
    return "{" .. table.concat(l,",") .. "}"
end
```

##### 2. 元表保护：`mt.__metatable = "提示"`

> 设置后，用户无法再用get、set访问该元表



### table访问的元方法

##### 1. **不存在的字段处理：`__index`

> 使用**当前table和字段作为参数**，调用__index
>
> 新创建的w中没有width字段，于是调用元表中的 __index
>
> - 当__index对应一个方法时，传入table和字段
> - 当__idnex对一个table时，在此table中寻找字段对应的值
>
> 在此例中，程序将在 Window.prototype 中寻找此字段
>
> 如果不想涉及__index，则可以使用 rawget(t,i) 
>
> 可实现表的**默认值**实现

```lua
Window = {}

-- 窗体原型：存储默认属性、默认元表
Window.prototype = {x=0, y=0, width=100, height=100}
Window.mt = {}

--构造函数（传入一个table）
function Window.new(o)
    setmetatable(o,Window.mt)
    return o
end

------------------------------------------------------------------

-- __index：当目标字段不在table中时的处理办法
Window.mt.__index = function(table, key)
    return Window.prototype[key]
end

-- 创建新的窗口
w = Window.new{x=10,y=20}
print(w.width)
```

##### 2. 更新方法：`__newindex`

##### 3. table默认值设置实现

```lua
-- 调用此方法将默认值与table绑定，使__index字段返回默认值
function setDefault(t,d)
    local mt = {__index = function() return d  end}
    setmetatable(t,mt)
end

new_table = {x=10,y=20}
setDefault(new_table,999)
print(new_table.z)  -->999
```

##### 4. **只读table的实现

> 这种table实际上不含任何值，其数据全都在元表中的__index字段里
>
> 访问时，由于本体为空，会调用__index进行访问
>
> 更新时，会调用__newindex，返回错误

```lua
function readOnly(t)
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function (t,k,v)
            error("不能更新只读table")
        end
    }
    setmetatable(proxy,mt)
    return proxy
end

names = readOnly({"dsh", "zdd", "zrq", "wjl"})
```

------







# 环境

### **基础

> Lua将全局变量保存在一个常规的table中，这个table就是环境
>
> 而环境又被保存在个全局变量 **_G** 中
>
```lua
-- 查看全部的全局变量及其类型
for var in pairs(_G) do
	print(var,type(var))
end
```



### 全局变量

##### 1. 动态全局变量

> 基本含义：
>
> ​	一个全局变量的名称存储于另一个全局变量，类似于间接寻址
>
> ​	或使用复杂的嵌套字段

- 定义赋值

  ```lua
  var_1.a.b = 10
  
  function setfield(f,v)
      local t = _G
      for w,d in string.gmatch(f,"([%w_]+)(%.?)") do
          if d == "." then
              t[w] = t[w] or {}
              t = t[w]    -- 向深处走
          else
              t[w] = v    -- 到达目标，赋值
          end
      end
  end
  
  setfield("var_1.a.c",20)
  ```

- 访问

  ```lua
  -- 用于访问类似"a.b.c.......z"的变量
  function getfield(f)
      local v = _G
      for w in string.gmatch(f,"[%w_]+") do
          v = v[w]
      end
      return v
  end
  
  print(getfield("var_1.a.b"))    --> 10
  print(getfield("var_1.a.c"))    --> 20
  ```

##### 2. **全局变量声明控制

> 大型程序中，全局变量可能十分繁杂，随意定义全局变量是十分危险的

- 不存在的的全局变量访问控制限制

  > 借助元表，重定义 **__index** 和 **__newindex**

  ```lua
  setmetatable(_G,{
      __newindex = function(_,n)
          error("尝试修改未声明的全局变量" .. n,2)
      end,
      __index = function(_,n)
          error("尝试读取未声明的全局变量" .. n,2)
      end
  })
  
  print(var_x)    --> 未声明的x
  ```

- 声明新的全局变量

  - 绕过元表进行定义：`rawset`

    ```lua
    function declare(name,v)
        rawset(_G,name,v or false)
    end
    ```

  - 只允许主程序块进行定义

    ```Lua
    setmetatable(_G,{
        __newindex = function(t,n,v)
            local w = debug.getinfo(2,"S").what
            if w~="main" and w~="C" then
                error("尝试修改未声明的全局变量" .. n,2)
            end
            rawset(t,n,v)
        end,
        __index = function(_,n)
            error("尝试读取未声明的全局变量" .. n,2)
        end
    })
    ```

  - 值为nil的全局变量

    > 通常值为nil的全局变量会被认定为未声明

    ```lua
    setmetatable(_G,{
        __newindex = function(t,n,v)
            if not declared[n] then
                local w = debug.getinfo(2,"S").what
                if w~="main" and w~="C" then
                    error("尝试修改未声明的全局变量" .. n,2)
                end
                declared[n]  =true
            end
            rawset(t,n,v)
        end,
        __index = function(_,n)
            if not declared[n] then
                error("尝试读取未声明的全局变量" .. n,2)
            else
                return nil	--> 定义过，返回nil
            end
        end
    })
    ```

 

### **非全局的环境

##### 1. 函数环境设置：`setfenv(func,environment)`

> 将一个table作为环境
>
> 第一个参数除了制定函数，也可以传递数字
>
> 1：当前函数
>
> 2：当前函数的函数

```lua
a = 10				-- a作为全局变量被保存在_G中
setfenv(1,{g=_G})	-- a被封装
g.print(a)      	--> nil
g.print(g.a)    	--> 10
```

##### 2. **使用继承组装新环境

```lua
a = 1				-- 旧环境
local new_env = {}  -- 新环境
-- 若无法在新环境中找到对应字段，就去_G中找
setmetatable(new_env,{__index = _G})
setfenv(1,new_env)	-- a被封装到new_env

a,b = 10,20
print("新环境的变量：" .. a .. "，" ..b)	--> 10, 20
print("原先环境的变量a = " .. _G.a)		 --> 1
```

------







# 模块与包

### require函数

##### 1. **使用方法：`require("名称")`

- 返回由模块函数组成的table，并定义包含该table的全局变量

  > 这些由模块完成，而非table

- Lua自动预先加载标准库

##### 2. 具体行为

>  初次require时，结果保存在package.loaded中
>
> 之后再次require时，直接从package.loaded中获取

```lua
function require(name)
	if not package.loaded[name] then 		-- 如果未加载
    	local loader = findloader(name)
        if loader==nil then 
        	error("无法加载模块：" .. name)
        end
        package.loaded[name] = true
        local res = loader(name)			-- 初始化
        if res~=nil then 
        	package.loaded[name] = res
        end
    end
    return package.loaded[name]
end
```

##### 3. 搜索路径

- 路径存放

  - Lua文件路径：`package.path`
  - C程序库：`package.cpath`

- 路径规则：替换 ? 

  > 路径：?;?.lua;c:\windows\?
  >
  > 根据require替换后：
  >
  > ​	模块名
  >
  > ​	模块名.lua
  >
  > ​	c:\windows\模块名



### **创建模块

> 必须显式将模块名放到每个函数的名称中

```lua
local M = {}

--complex = M
local modname = ...			-- 避免写模块名，require会将模块名作为参数传入
_G[modname] = M                 
package.loaded[modname] = M    -- 直接将模块table赋予package.loaded，不必再return

M.i = {r=0, i=1}

-- 复数构造
function M.new(r,i)
    local new_c = {r=r, i=i}
    local mt = {__tostring = function(c)
        return r.. ",  " ..i.." *i"
    end
    }
    setmetatable(new_c,mt)
    return new_c
end

-- 复数相加
function M.add(c1,c2)
    return M.new(c1.r+c2.r, c1.i+c2.i)
end

--return complex
```



### 模块与环境

##### 1. 作用

> 让模块的主程序有一个独占的环境
>
> 让所有函数都可共享一个环境table，所有全局变量也都记录在这个table中
>
> 模块中的函数在定义、引用时不必再声明模块名称

##### 2. 使用示例

```lua
------------------------------- 模块设置 -------------------------------

local modname = ...             -- 避免写模块名，require会将模块名作为参数传入
local M = {}
complex = M
_G[modname] = M
package.loaded[modname] = M     -- 直接将模块table赋予package.loaded，不必再return
------------------------------- 模块设置 -------------------------------


------------------------------- 其他模块导入 -------------------------------
local sqrt = math.sqrt
local io = io
------------------------------- 其他模块导入 -------------------------------

setfenv(1,M)
```



### module函数

- 定义模块：`module("模块名",package.seeall)`

  > 使用module函数替代基础配置
  >
  > 模块不必再return用于访问的table

  ```lua
  module("complex_2",package.seeall)
  
  i = {r=0, i=1}
  
  -- 复数构造
  function new(r,i)
      local new_c = {r=r, i=i}
      local mt = {__tostring = function(c)
          return r.. ", " ..i.." *i"
      end
      }
      setmetatable(new_c,mt)
      return new_c
  end
  
  -- 复数相加
  function add(c1,c2)
      return new(c1.r+c2.r, c1.i+c2.i)
  end
  ```

- 访问：`模块名.方法`

  ```lua
  require("test_modul.complex_2")
  c_3 = complex_2.new(1,3)
  print(c_3)		--> 1, 3 *i
  ```

  



### 子模块与包



------







# 面向对象

### 注意事项

##### 1. 对象方法定义

> 尽量不在对象的方法中使用全局变量，否则容易使该方法将与全局变量相关，而非对象本身

```lua
Account = {balance=0}
function Account.withdraw(v)
	Account.balance = Account.balance - v    
end

a = Account; Account = nil
a.withdraw(100)		-- 错误，因为方法与Account有关，而Account已被回收
```

##### 2. **操作接受者：self

```lua
Account = {balance=0}
-- 使用self接受操作
function Account.withdraw(self,v)
	self.balance = self.balance - v    
end

a = Account; Account = nil
a.withdraw(a,100)		-- 正确
```

##### 3. **隐藏self：利用“ : ”替代“ . ”

> 定义方法时，用 **:** 相当于隐藏了传入的self
>
> 当实例调用方法时，传入的就是实例了
>
> 得益于调用对象会以self传入，当调用与对象未重定义的基类属性后，**会给对象添加相应字段**，之后访问该字段就**不用去 元表.__index 里寻找了**

```lua
Account = {balance=0}
-- 使用self接受操作
function Account.withdraw(self,v)
	self.balance = self.balance - v    
end

a = Account; Account = nil
-- a.withdraw(a,100)		
a:withdraw(100)		-- 正确
```



### 类的构造

##### 1. **构造方法

> 这种方式构造，当调用新的对象没有的字段时，会执行一下操作
>
> ​	例子：a.withdraw(v)，步骤如下
>
> ​	a中没有withdraw，去元表的__index里寻找
>
> ​	getmetatable(a).__index.withdraw(a,v)
>
> ​	--> Account.__index.withdraw(a,v)
>
> ​	--> Account.withdraw(a,v)，相当于调用了基类的方法

```lua
-- Account类
Account = {balance=0}		-- 默认属性
function Account:new(o)     -- 构造方法
    o = o or {}
    setmetatable(o,self)    -- 将Account作为新对象的元表，将基本属性附加给新对象
    self.__index = self     -- Account.__index = Account
    return o
end
```

##### 2. 类方法

```lua
-- 取钱
function Account:withdraw(v)
    self.balance = self.balance - v
end
-- 存钱
function Account:deposit(v)
    self.balance = self.balance + v
end
```

##### 3. 对象创建

> 得益于借助元表和其__index的构造方法是有参、无参构造的综合

```lua
-- 若不设置新的balance，后续调用则会去对象的元表（即Account基类）中找balance
a = Account:new({balance=10})
```



### 多重继承

> 用函数作为__index元字段，完成多重继承

##### 1. 创建多重继承类







# 弱引用table

> Lua垃圾收集只会收集它认为的“垃圾”
>
> 比如栈，弹出栈顶元素实际上只是索引递减，但实际的对象并没有被Lua回收
>
> 这时需要用户手动将对象赋值为nil

### 基础

##### 1. 存在意义：解决回收被阻碍问题

> 例如当值处于数组中时，无法被回收，因为数组仍在引用它
>
> ```lua
> t = {}
> key = "name"
> t[key] = "dsh"
> key = nil			-- 回收key
> print(t["name"])	-- 仍会输出，回收无用
> ```
>
> 

##### 2. 弱引用：weak reference

> 不会阻碍垃圾回收的引用

##### 3. 弱引用table：weak table

- 作用

  > 用来告诉Lua一个引用是不是该阻碍其引用对象的回收
  >
  > 本质上是**具有弱引用条目的table**

- 分类

  - 具有弱引用key
  - 具有弱引用value
  - 同时有两种弱引用

##### 4. 实现：设置元表相应字段

> table的弱引用类型由其 **元表中的__mode字段** 决定
>
> - 具有弱引用key：`__mode = "k"`
> - 具有弱引用value：`__mode = "v"`

##### 5. 示例

> 此例中，第二个key={}会覆盖第一个key
>
> 垃圾收集时，第一个key和table中相应的条目都会被回收，最后输出的只有 2
>
> 若不是弱引用key，则会输出：1和2

```lua
a = {}
b = {__mode="k"}
setmetatable(a,b)
key = {}
a[key] = 1
key = {}
a[key] = 2
collectgarbage()    -- 强制垃圾收集
for k,v in pairs(a) do
    print(v)
end
```



### 

### 备忘录函数

##### 1. 含义：存储曾经的运行结果

```lua
local result = {}
setmetatable(result,{__mode = "kv"})
function mem_loadstring(s)
    local res = result[s]
    -- 如果该语句未被编译过，则进行编译并存储结果
    if res==nil then
        res = assert(loadstring(s))
        result[s] = res
    end
    return res
end
```

##### 2. 弱引用备忘录

> 每次垃圾收集时，非正在使用的运行结果都会从result表中被回收
>
> 若非弱引用，则不会被回收，因为被正在被result引用



### 弱引用与表的默认值

##### 1. 使用弱引用key

> 重复设置默认值时，由于是弱引用key，之前的table与对应的默认值的字段会被覆盖
>
> 回收表后，由于defaults是弱引用key表，**相应的 表-默认值 也会从 defaults中回收**

```lua
-- 弱引用表，存储目标table的字段统一默认值
local defaults = {}
setmetatable(defaults,{__mode="k"})
-- 当表中没有时，从defaults中寻找
local mt = {__index = function(t) return defaults[t] end}

function setDefault(t,d)
    defaults[t] = d     -- 表-默认值
    setmetatable(t,mt)
end
```

- **建议：table少时使用**
- 备忘录保存：表-默认值
- 本质：绑定元表{__index = 根据t去defaults中找到默认值再返回}

##### 2. 使用弱引用value

> 每次将默认值对应的__index搜索策略保存在 metas 中

```lua
-- 存储：默认值-指示搜索策略的元表
local metas = {}
setmetatable(meta,{__mode="v"})
function setDefault_2(t,d)
    local mt = metas[d]
    if mt==nil then
        mt = {__index = function() return d end}
        metas[d] = mt
    end
    setmetatable(t,mt)
end
```

- **建议：table多时使用**
- 备忘录保存：默认值-{__index = 返回默认值}
- 本质：绑定元表{__index = 返回默认值}

------







# Lua库函数

### 数学库

##### 1. 三角函数

- 引入

  ```lua
  local sin,asin,cos = math.sin,math.asin,math.cos
  local deg,rad = math.deg,math.rad
  ```

- 弧度-角度转换

  - 转换成角度：`deg(a)`
  - 转换成弧度：`rad(a)`

##### 2. 指数、对数

- 引入

  ```lua
  local exp,log,log10 = math.exp,math.log,math.log10
  ```

- e指数：`exp(x)`

- 对数：`log(x)`

##### 3. 处理

- 引入

  ```lua
  local floor,ceil = math.floor,math.ceil
  local max,min = math.max,math.min
  ```

- 取整

  - 向下：`floor(x)`
  - 向上：`ceil(x)`

- 最值

  - `max(x,y,z,...)`
  - `min(x,y,z,...)`

##### 4. 随机数

- `math.random(m，n)`

  > 无输入：[0,1)的随机数
  >
  > 有n：[1,n]内的随机整数
  >
  > m, n：[m,n]的随机整数

- 设置为随机数生成器种子：`math.randomseed(x)`

  > 建议：x = os.time()



### **table库

##### 1. 插入：`table.insert(t,index,value)`

> 默认插入队尾

##### 2. 删除：`table.remove(t,index)`

> 默认从队尾删除

##### 3. **排序：`table.sort(t, f)`

> 只能对数组排序
>
> 若想对索引table排序，可以先将索引保存在数组中**将索引排序**

```lua
--索引排序迭代器
--索引排序迭代器
function paris_key(t,compare_func)
    local a = {}
    for n in pairs(t) do a[#a+1]=n end
    table.sort(a,f)
    local i = 0         -- 将保存入closure
    return function()   -- 迭代器函数
        i = i+1
        return a[i],t[a[i]]
    end
end
```

##### 4. 字符串数组连接：`table.concat(t)`

- 普通连接

  ```lua
  str_table = {"I'm","a","student"}
  str = table.concat(str_table," ")
  print("数组中的字符串连接后："..str)	--> I'm a student
  ```

- 可处理嵌套字符串数组的连接

  ```lua
  function rconcat(l) 
  	if type
  end
  ```



### **字符串库

##### 1. 模式

- 字符分类

  > 大写形式表示补集
  
  | 字符 | 含义              | 补充                               |
  | ---- | ----------------- | ---------------------------------- |
  | %a   | 字母              | %a+表示所有单词                    |
  | %c   | 控制字符          |                                    |
  | %d   | 整数              | %0xd表示至少有x位的数，不足用0补齐 |
  | %f   | 浮点数            | %.xf表示小数点后保留x位            |
  | %l   | 小写字母          |                                    |
  | %p   | 标点              |                                    |
  | %s   | 字符              |                                    |
  | %u   | 大写字母          |                                    |
  | %w   | 字母和数字字符    |                                    |
| %x   | 十六进制数字      |                                    |
  | %z   | 内部表示为0的字符 |                                    |

- 魔法字符

  - %：转义字符

  - []：自定义字符集

    > 加入^即可得到补集
    >
    > 用 - 连接字符范围的首位

    - 同时匹配数字、字母、下划线：`[%w_]`
    - 二进制：`[01]`
    - 元音字母：`[AEIOUaeiou]`
    - 8进制：`[0-7]`

- 修饰符

  - +：重复>=1次

    - 一个或多个字符：`%a+`

      > 单词

    - 一个或多个数字：`%d+`

      > 整数

  - *：重复>=0次

  - -：重复>=0次

    > 会匹配最短子串

    - 匹配字符串中的注释

      > 若不用-，会使得第一个注释符号与最后一个注释符号匹配

      ```lua
      string.gsub(text,"/%*.-%*/","注释")
      ```

  - ?：可选部分（0次或1次）

    - 寻找可带符号的整数：`[+-]?%d+`

- %b：匹配成对字符

  - 匹配()及其中的字符：`"%b()"`


##### 2. 匹配模式

- 寻找匹配模式的内容的位置：`string.find(str,mod)`

  > 还可以传入第3个参数，指定**开始搜索的位置**

  - 根据内容寻找

    > ```lua
    > local str_1 = "What's your name?"
    > local i,j = string.find(str_1,"name")
    > print("“name”的位置："..i..", "..j)
    > ```

  - 寻找匹配模式的内容：
  
- **寻找匹配模式的内容：`string.match(str,mod)`

  > 返回字符串中与模式匹配的**部分字符串**
  >
  > 一般用**变量格式**进行匹配才有意义

  ```lua
  local str_2 = "Today is 2022/5/15"
  local date = string.match(str_2,"%d+/%d+/%d+")
  print("字符串中的日期：" .. date)		--> 2022/5/15
  ```

- 对字符串中匹配格式的所有部分进行替换：`string.gsub(str,mode,replace_str)`

  > 可加入第4个参数，限制替换的次数
  >
  > 替换内容不能为变量格式
  >
  > 因此一般用于**内容替换**

  ```lua
  local str_3 = str_2 .. ", tomorrow is 2022/5/16"
  local new_str3 = string.gsub(str_3,"2022","二零二二")
  print("替换后的str_3：" .. new_str3)
  
  -- 也可用于统计内容出现次数
  count = select(2,string.gsub(str,"内容","替换方式"))
  ```

- 匹配模式内容迭代器：`string.gmatch(str,pattern)`

  > %a+表示单词

  ```lua
  local str_4 = "苹果的英文是apple，刀塔原名DotA，SC是星际争霸的简称"
  for w in string.gmatch(str_4,"%a+") do
      print(w)	--> apple,DotA,SC
  end
  
  
  -- 模拟require寻找模块的策略
  function search(modname,path)
      -- 将 . 替换成 /
      modname = string.gsub(modname,"%.","/")
      for c in string.gmatch(path,"[^;]+") do
          -- 用模块名替换路径用分号分开的各部分中的?
          local fname = string.gsub(c,"?",modname)
          local f = io.open(fname)
          if f then
              f:close()
              return fname
          end
      end
      return nil      -- 未找到
  end
  ```

##### 3. 格式化输出：`string.format(mod,str)`

> ```lua
> print(string.format("format实例：\n\tpi = %.2f",math.pi))
> -- pi = 3.14
> ```

##### 4. 捕获：

- 使用()将match匹配到的内容分割

  - 匹配相应格式后的字符

    ```lua
    local str_5 = "name = dsh, 出生日期：1999/08/14"
    -- 匹配字段和等号后的内容
    local name = string.match(str_5,"%a+%s*=%s*(%a+)")
    local year,month,day = string.match(str_5,"(%d+)/(%d+)/(%d+)")
    ```

  - 匹配引号中的内容：`"([\"'])(.-)%l"`

    > 先捕获引号本身
    >
    > 再捕获引号中的内容

  - 匹配长字符串：`"%[(=*)%[(.-)%]%l%]"`

    > 匹配：[，0个或多个=，另一个[，任意内容，]，相同数量的=，]

- **使用gsub对匹配内容进行格式化替换

  - 替换日期格式

    ```lua
    local new_str5 = 
    	string.gsub("出生日期：1999/08/14","(%d+)/(%d+)/(%d+)","%1-%2-%3")
    print(new_str5)		-- 1999-08-14
    ```

  - **交换相邻字符

    ```lua
    string.gsub(text,"(.)(.)","%2%1")
    ```

  - 剔除字符串两端的空格

    > ^和$表示操作整个字符串

    ```
    string.gsub(text,"^%s*(.-)%s*$","%l")
    ```

    



























