## Cat

### 内容介绍

- cats.py: 打字测试逻辑。
- utils.py: 用于与文件和字符串交互的实用函数。
- ucb.py: 用于CS 61A项目的实用函数。
- data/sample_paragraphs.txt: 一个包含要输入的文- 本样本的文件: 这些是搜刮来的关于各种主题的维基百科文章。
- data/common_words.txt: 一个包含常见英语单词的文件，按频率排序。
- data/words.txt: 一个包含更多英语单词的文件，按频率顺序排列。
- gui.py: 基于网络的图形用户界面（GUI）的网络服务器。
- gui_files: 一个包含图形用户界面（GUI）所需文件的目录。
- images: 一个包含图像的目录。
- ok, proj02.ok, tests: 测试文件。

### Problem1

#### Function

- choose

#### Meaning

- 选择符合select条件的第k+1个字符串

#### Attention

- None

### Problem2

#### Function

- about

#### Meaning

- 含有`规定单词`的单词
- 可作为choose的select条件使用

#### Attention

- 全部大写变小写
- 分割开来，避免一串错误的无空格字符被识别
- 去标点

### Problem3

#### Function

- accuracy

#### Meaning

- 返回typed中与reference中匹配单词占reference的比例

#### Attention

- 空格分隔单词
- 标点一并接入单词，即算上标点
- 有空的情况
  - typed和reference均空——100.0
  - 一个空一个非空——0.0
- 百分比保留小数点后1位
- 求比例的时候要一一对应去求，故而用了一下zip

### Problem4

#### Function

- wpm

#### Meaning

- word per minute
- 每分钟打字速度
- 每分钟打字数的公式是打出的字符数（包括空格）除以5（典型的字长）与经过的时间（分钟）的比率。

#### Attention

- None

### Problem5

#### Function

- autocorrect

#### Meaning

- 自动纠正
- 根据valid_words列表中的单词来纠正
  - typed_word在valid_words中，直接返回
  - 若不在，基于diff_function返回
    - 如果typed_word和任何一个valid_words之间的最低差异大于limit，那么就会返回typed_word。


#### Attention

- None

### Problem6

#### Function

- sphinx_switches

#### Meaning

- 接受两个字符串的diff函数。它返回在起始词中必须改变的最小字符数，以便将其转化为目标词。如果两个字符串的长度不相等，长度的差异将被加到总数中。

#### Attention

- 不让用for
  - 题目没提前说，测试的时候才说
- 用递归

### Problem7

#### Function

- pawssible_patches

#### Meaning

- 返回将起始词转化为目标词所需的最小编辑操作数。
- 三种操作
  - 在开头添加一个字母。
  - 从起点删除一个字母。
  - 用开始的一个字母代替另一个字母。


#### Attention

- limit 需注意
  - limit：一个数字，代表编辑次数的上限
  - 每次操作以后，limit需要-1

### Problem8

#### Function

- report_progress

#### Meaning

- 它需要一个输入的单词列表，一个提示词列表，用户的用户ID，以及一个发送函数，用来向多人游戏服务器发送进度报告。
- 你的进度是你正确输入的提示词的比率，直到第一个错误的词为止，除以提示词的数量。

#### Attention

- send要用字典表示
- 返回值为progress

### Problem9

#### Function

- time_per_word

#### Meaning

- 接收times_per_player，即每个玩家的列表，其中的时间戳表明每个玩家完成输入每个单词的时间。它还接收一个单词列表。它返回一个带有给定信息的游戏。

#### Attention

- 要用下面那个`game`函数，而不能直接写[words, time_interval]

  - 不然会报如下错误

  - ```txt
    all_words = lambda u: u.a
    AttributeError: 'list' object has no attribute 'a'
    ```

### Problem10

#### Function

- fastest_words

#### Meaning

- 返回一个单词列表，每个玩家有一个列表，在每个列表中，他们输入的单词是最快的（针对所有其他玩家）。在平局的情况下，认为列表中最早的选手（最小的选手索引）是打得最快的选手。

#### Attention

- 需要用到后面给出的函数`time` 和`word_at`