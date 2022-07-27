## Ants

### 内容介绍

- ants.py: 蚂蚁大战蜜蜂的游戏逻辑
- ants_gui.py: 蚂蚁大战蜜蜂的原始图形用户界面
- gui.py: Ants Vs. SomeBees的新图形用户界面。
- graphics.py: 用于显示简单的二维动画的实用程序
- utils.py: 一些促进游戏界面的功能
- ucb.py: CS 61A的实用功能
- state.py: gui.py的游戏状态的抽象化
- assets: gui.py使用的图像和文件的目录。
- img: ants_gui.py使用的图片目录。
- ok: 自动跟踪器
- proj3.ok: ok配置文件。
- test: ok所使用的测试目录

## 核心类

- `GameState`
  - 代表蚁群和关于游戏的一些状态信息，包括有多少食物可用，经过了多少时间，`AntHomeBase`在哪里，以及游戏中的所有`Places`。
- `Place`
  - 代表一个容纳昆虫的单一场所。一个地方最多只能有一只`Ant`，但一个地方可以有许多`Bee`。`Place`对象在左边有一个出口`exit`，在右边有一个入口`entrance`，这也是场所。蜜蜂通过移动到一个场所`Place`的出口来穿越隧道。
- `Hive`
  - 代表`Bee`开始的地方（在隧道的右边）。
- `AntHomeBase`
  - 代表`Ant`正在防守的地方（在隧道的左边）。如果蜜蜂到达这里，它们就赢了:(
- `Insect`
  - `Ant`和`Bee`的一个超类。所有昆虫都有`health`属性，代表它们的剩余健康，还有一个`Place`属性，代表它们目前所在的地方。每一回合，游戏中每个活跃的`Insect`都会执行其`action`。
- `Ant`
  - 代表蚂蚁。每个`Ant`子类都有特殊的属性或特殊的`action`，以区别于其他`Ant`类型。例如，`HarvesterAnt`为蚁群获取食物，`ThrowerAnt`攻击`Bee`。每种蚂蚁类型也有一个`food_cost`属性，表示部署一个该类型的蚂蚁单位需要多少钱。
- `Bee`
  - 代表蜜蜂。每一回合，蜜蜂要么移动到其当前`Place`的`exit`，如果该位置没有被蚂蚁`blocked`的话，要么刺伤占据其同一`Place`的蚂蚁。

### 输赢

蚂蚁与蜜蜂的游戏由一系列的回合组成。在每个回合中，新的蜜蜂可以进入蚁群。然后，新的蚂蚁被放置在那里以保卫它们的蚁群。最后，所有昆虫（先是蚂蚁，后是蜜蜂）都采取个别行动。蜜蜂要么试图向隧道的尽头移动，要么刺伤挡路的蚂蚁。蚂蚁根据自己的类型采取不同的行动，如收集更多的食物或向蜜蜂投掷树叶。当一只蜜蜂到达隧道的尽头（你输了），蜜蜂摧毁了`QueenAnt`（如果它存在的话）（你输了），或者整个蜜蜂舰队被征服（你赢了），游戏就结束了。

### Problem1

#### Class

- HarvesterAnt
- ThrowerAnt

#### Meaning

- 介绍蚂蚁种类和对应的花费

  | 类             | 花费 | 初始`health`值 | Action             |
  | -------------- | ---- | :------------: | ------------------ |
  | `HarvesterAnt` | 2    |       1        |                    |
  | `ThrowerAnt`   | 3    |       1        | 增加gamestate.food |

  

#### Attention

- 此处要修改的不止`HarvesterAnt`还有`ThrowerAnt`
- 而且要记得修改他们的`food_cost`

### Problem2

#### Function

- Place.\__init__

#### Meaning

- 让一个`Place`不止能追溯到`exit`，也能追溯到`entrance`
- `entrance`默认为`None`
- 如果`place0`的`exit`是`place1`，那么，`place1`的`entrance`是`place0`

#### Attention

- `place1`的`entrance`是`place0`，此处返回的是`place0`整个对象，而不是它的名字

### Problem3

#### Class

- ThrowerAnt

#### Meaning

- 使 `ThrowerAnt `扔到(`throw_at`)离它最近的、不在`Hive`里的`Bee`。
- 改变`nearest_bee`，让它从最近的地方返回一只随机的`Bee`。
- 从`ThrowerAnt`当前的`Place`开始
- 对于每个`Place`，如果有`Bee`，返回一只随机的`Bee`;如果没有，返回当前地方的`entrance`
- 如果没有`Bee`可以攻击，返回None

#### Attention

- 有个while循环来**一直**找到对应的下一个地方，直至整列都找不到`Bee`

### Problem4

#### Class

- LongThrower
- ShortThrower

#### Meaning

- `LongThrower`只能投掷(`throw_at`)在至少5个`entrance`转换后发现的`Bee`。它不能击中与它在同一`Place`或在它前面的前四个`Place`的`Bee`。如果有两只`Bee`，一只离`LongThrower`太近，另一只在它的范围内，长投手应该只投向较远的那只`Bee`，因为它在它的范围内，而不是试图投向较近的那只`Bee`。

- `ShortThrower`只能投掷(`throw_at`)在最多3个`entrance`转换后发现的`Bee`。它不能投掷在它前面3`Place`以外的任何`Ant`。

- `LongThrower`和`ShortThrower`都不能投掷到4`place`以外的地方

- 对应Ant的花费

	- |      类      | 花费 | 初始`health` |
  | :----------: | ---- | ------------ |
  | ShortThrower | 2    | 1            |
  | LongThrower  | 2    | 1            |

- 

#### Attention

- 记得修改父类的`nearest_bee`函数

### Problem5

#### Class

- FireAnt

#### Meaning

- 如果它受到了一定`amount`的健康单位的伤害，它就会对其所在的所有蜜蜂造成一定`amount`的伤害（这被称为*反射伤害*）。如果它死了，它会造成额外的伤害，由其`damage`属性指定。

- 要实现这一点，请重写`FireAnt`的`reduce_health`方法。你的重载方法应该调用继承自`Ant`的 `reduce_health` 方法，该方法本身也是继承自`Insect`的，以减少当前 `FireAnt` 实例的健康。那个基础的`reduce_health`方法将昆虫的`health`状况减少给定的`amount`，如果`health`状况达到零或更低，则将昆虫从其位置上移除。

- 然而，你的方法还需要包括反射性伤害逻辑。

  - 确定反射伤害量`amount`，从对蚂蚁造成的伤害量`amount`开始，如果蚂蚁的健康状况降到了0，再加上伤害。
  - 对于地方上的每只蜜蜂，通过调用继承自`Insect`的`reduce_health`方法，对它们进行总伤害。

- 对应Ant的花费

  - |   类    | 花费 | 初始`health` |
    | :-----: | :--: | ------------ |
    | FireAnt |  5   | 3            |

- `FireAnt`必须在被移出其`place`之前完成其伤害，所以要仔细注意你在覆盖方法中的逻辑顺序。

#### Attention

- 记得修改父类的`nearest_bee`函数

### Problem6

#### Class

- WallAnt

#### Meaning

- 血很厚的蚂蚁

- 对应Ant的花费

  - |   类    | 花费 | 初始`health` |
    | :-----: | :--: | ------------ |
    | WallAnt |  4   | 4            |

#### Attention

- None

### Problem7

#### Class

- HungryAnt

#### Meaning

- 从自己的`place`上随机选择一只`Bee`并将其整个吃掉。

- 吃完一只`Bee`后，它必须花3个回合的时间咀嚼才能再次进食。

- 如果没有蜜蜂可以吃，它将什么也不做。

- 一个`chew_duration`类属性，用来存储`HungryAnt`需要咀嚼的回合数（设置为3）。

  - 给每个`HungryAnt`一个实例属性`chewing`，用来计算它剩余的咀嚼回合数（初始化为0，因为它一开始就没有吃过任何东西）。

- 实现`HungryAnt`的`action`方法来检查它是否在咀嚼；

  - 如果是，就递减它的`chewing`计数器。
  - 否则，在它的`place`上吃一个随机的`Bee`，将`Bee`的健康状况降低到0，并重新启动`chewing`计时器。

- 对应Ant的花费

  - |    类     | 花费 | 初始`health` |
    | :-------: | :--: | ------------ |
    | HungryAnt |  4   | 1            |

#### Attention

- None

### Problem8

#### Class

- BodyguardAnt

#### Meaning

- `BodyguardAnt`不同于普通的`Ant`，因为它是一个`ContainerAnt`；它可以容纳另一只蚂蚁并保护它，所有这些都在一个`Place`。当一只`Bee`在一个蚂蚁包含另一只蚂蚁的地方刺伤蚂蚁时，只有容器被损坏。容器中的蚂蚁仍然可以执行它原来的动作。如果容器灭亡了，被包含的蚂蚁仍然留在这个地方（然后可能会被损坏）

- 每个`ContainerAnt`都有一个实例属性`contained_ant`，用来存储它所包含的蚂蚁。它最初是以`None`开始的，以表示没有蚂蚁被保护。实现`contain_ant`方法，使其将保镖的`contain_ant`实例属性设置为传入的`ant`参数。同时实现`ContainerAnt`的`action`方法，以便在当前包含一只蚂蚁的情况下执行其`container_ant`的动作。

- - 实现`ContainerAnt.can_contain`方法，该方法接受`other`蚂蚁作为参数，并在以下情况下返回`True`
    - 这只蚂蚁还没有包含另一只蚂蚁。
    - 另一只蚂蚁不是一个容器。


  - 目前`Ant.can_contain`的返回值是False；它需要在`ContainerAnt`中被重写。

- 修改`Ant.add_to`，以允许一只容器蚂蚁和一只非容器蚂蚁按照以下规则占据同一个位置。

  - 如果原本占据一个地方的蚂蚁可以包含被添加的蚂蚁，那么这两只蚂蚁都占据了这个地方，并且原本的蚂蚁包含了被添加的蚂蚁。
  - 如果被添加的蚂蚁可以包含原来在该空间的蚂蚁，那么两只蚂蚁都占据该地方，被添加的蚂蚁包含原来的蚂蚁。
  - 如果两只蚂蚁都不能包含另一只，则引发与之前相同的断言错误（启动代码中已经存在的那个）。

- 添加一个`BodyguardAnt.__init__`，设置蚂蚁的初始health量。

- 对应Ant的花费

  - |      类      | 花费 | 初始`health` |
    | :----------: | :--: | ------------ |
    | BodyguardAnt |  4   | 2            |

#### Attention

- 实际需要完成的就是`ContainerAnt`类、`BodyguardAnt`类、`Ant`类
- `ContainerAnt`类
  - action，逐步调用`Insect`的

### Problem9

#### Class

- TankAnt

#### Meaning

- `TankAnt`是一个容器，它可以保护其所在地的一只蚂蚁，同时每回合对其所在地的所有蜜蜂造成1次伤害。

- 对应Ant的花费

  - |   类    | 花费 | 初始`health` |
    | :-----: | :--: | ------------ |
    | TankAnt |  6   | 2            |

#### Attention

- None

### Problem10

#### Class

- Water

#### Meaning

- 只有水安全的`Insect`才能被放在水里。
  - 为了确定一只`Insect`是否是水安全的，给昆虫类添加一个新的类属性，名为`is_watersafe`，设置为`False`。
  - 由于蜜蜂会飞，所以把它们的`is_waterafe`属性设置为`True`，覆盖继承的值。

- 现在，实现`Water`的`add_insect`方法。
  - 首先，将昆虫添加到该处，不管它是否是waterafe。
  - 然后，如果该昆虫不是水安全的，将该昆虫的健康状况降为0。


#### Attention

- None

### Problem11

#### Class

- ScubaThrower

#### Meaning

- `ScubaThrower`是`ThrowerAnt`的一个子类，成本更高，对`Water`更安全，但其他方面与基类相同。

- 当`ScubaThrower`被放置在`Water`中时，它不应该失去健康。

- 对应Ant的花费

  - |      类      | 花费 | 初始`health` |
    | :----------: | :--: | ------------ |
    | ScubaThrower |  6   | 1            |

#### Attention

- None

### Extra Credit

#### Class

- QueenAnt

#### Meaning

- `QueenAnt`是一个防水的`ScubaThrower`，通过她的勇敢来激励她的同伴。除了标准的`ScubaThrower`行动外，`QueenAnt`每次执行行动时，她身后的所有蚂蚁的伤害都会加倍。一旦一只蚂蚁的伤害被加倍，它在接下来的回合中就不会再被加倍。

- 蚁后受三个特殊规则的制约。

  - 如果蚁后的健康状况降低到0，蜜蜂就会赢。如果有任何蜜蜂到达隧道的尽头，蜜蜂也仍然会赢。你可以调用`bees_win()`来向模拟器发出游戏结束的信号。
  - 只能有一个真正的蚁后。任何超过第一个女王的实例化都是一个冒牌货，在采取第一次行动时，它的健康状况应该被降低到0，而不会使任何蚂蚁的伤害翻倍或投掷任何东西。如果一个冒牌货死了，游戏仍应照常进行。
  - 真正的（第一个）蚁后不能被移除。试图移除蚁后应该没有效果（但不应该导致错误）。你需要在`QueenAnt`中覆盖`Ant.remove_from`来执行这个条件。

- 对应Ant的花费

  - |    类    | 花费 | 初始`health` |
    | :------: | :--: | ------------ |
    | QueenAnt |  7   | 1            |

#### Attention

- 需要在`Ant`类中添加buffed类属性（相当于一个Flag）
- 修改其父类为`ScubaThrower`
- 因为有真假蚁后的存在，所以设置`is_truequeen`类变量来判断
- 第二个蚁后出现以后，均为假蚁后，故在初始化时处理
- 重构`remove_from`函数