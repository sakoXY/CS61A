## Hog

### Problem1

#### Function

- roll_dice

#### Meaning

- 求和，求掷出的所有骰子的和（掷非0次）
  - sow sad规则
    - 如果掷到1，则返回1
  - 否则，返回和

#### Attention

- 有1不能直接退出，要掷完所有的次数再退出

### Problem2

#### Function

- piggy_points

#### Meaning

- 求掷0次的结果
  - piggy points规则
    - 本轮分数为`k+3`
    - `k`为对手分数的平方得到的各位数字中的最小数字

#### Attention

- None

### Problem3

#### Function

- take_turn

#### Meaning

- 求和
  - 联合roll_dice和piggy_points
  - 即考虑掷0次和非0次的所有情况

#### Attention

- None

### Problem4

#### Function

- more_boar

#### Meaning

- 看看能不能多掷一次
  - 返回结果为True和False两个布尔值
  - 比较第一位和第二位的大小，不足补0


#### Attention

- 直接做成字符串类型
  - 如果是1位的话，前补0
  - 然后直接比较字符串的0位和1位即可

### Problem5

#### Function

- play

#### Meaning

- 进行游戏，即开始
  - 前提条件，二者都未达到目标值
    - 直接用take_turn函数来求和
    - 用more_boar函数来找下一个人



#### Attention

- strategy函数的参量
  - strategy(自己，对手)

### Problem6

#### Function

- play

#### Meaning

- 打印当前状况


#### Attention

- None

### Problem7

#### Function

- announce_highest

#### Meaning

- 打印当前玩家是否达到了最高分数


#### Attention

- local variable，注意局部变量running_high和running_high_latest

### Problem8

#### Function

- make_averaged

#### Meaning

- 返回当前抛掷的骰子的平均成绩
  - 依次求和再取平均即可



#### Attention

- ```python
  dice = make_test_dice(4,2,2,1)
  averaged_dice = make_averaged(roll_dice, trial_counts)
  averaged_dice(number, dice)
  ```

- 上述式子中最后一句表示，抛number个骰子，其中，骰子的规格为dice

### Problem9

#### Function

- max_scoring_number_rolls

#### Meaning

- 得到产生最大平均分数的最小投掷次数


#### Attention

- None

### Problem10

#### Function

- piggypoints_strategy

#### Meaning

- 判断piggy points规则能不能让骰子获得超过cutoff的值
  - 若可以，就返回0
  - 否则，返回num_rolls



#### Attention

- None

### Problem11

#### Function

- more_boar_strategy

#### Meaning

- 判断piggy points规则能不能让骰子再掷一次
  - 若可以，就返回0
  - 否则，按照piggypoints_strategy来判断即可


#### Attention

- None