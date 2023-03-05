# 场景切换

###### *场景切换信息 class TeleportInfo*

###### *数据*

- ###### *int 目标场景index*

- ###### *Vector2 目标坐标* 

###### *方法*



### 工具类：SceneManage

> 代替：ChanceSceneManage、ChangeScene

##### 数据

- 场景切换目标坐标信息：HashTable<string, Vector2>  teleportTable

  > 从场景1到场景2："1To2"   -- (x,y)
  >
  > "1To2XXXXX"   -- (x,y)

##### 方法

- 切换场景：void ChangeScene(string name)

  > 取目标点坐标：Vector2 pos = teleportTable[name]
  >
  > 切换场景
  >
  > 设置Player坐标







# 背包功能

### 相关数据类

##### class ItemInfo

- int id
- string 名字
- string 描述
- Sprite 图片资源
- int 售价

##### class BagCell

- GameObject 父对象

  > *点击使用物品*

- Iamge 物品图片

- Btn 删除Btn

  > *点击删除*

- Text 数量

- ItemInfo  信息对象

- int 物品数量值



### 背包控制脚本 BackpackManage

##### 脚本数据

- List<BagCell> cells
- HashTable<int,int> cellMenu
- Image 背包背景图
- Image 说明背景图

##### 脚本操作

- 展示

  > 显示背包背景图和cells里的所有对象

- 添加物品

  - 新种类：new BagCell(id)，cells.Add(对象)，cellMenu.Add(id,cells.Count-1)
  - 旧种类：index = cellMenu[id], 数量+1

- 删除

  > index = cellMenu[id]
  >
  > 数量 - 1

- 使用

  > 删除()
  >
  > 发挥物品效果