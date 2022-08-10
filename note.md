---
title: UCB CS61A Lecture Notes
author: xy
date: 2022/8/8
---

# 1 Introduction

本课程基于*Structure and Interpretation of Computer Programs* (SICP)。课程网址: <a href="https://inst.eecs.berkeley.edu/~cs61a/sp21/">[CS 61A Spring 2021 (berkeley.edu)](https://inst.eecs.berkeley.edu/~cs61a/sp21/)</a>

视频地址：<a href="https://www.bilibili.com/video/BV1v64y1Q78o">[b站翻译](https://www.bilibili.com/video/BV1v64y1Q78o)</a>

# 2 Function

## 2.1 expression

> An expression describes a computation and evaluates to a value

> 表达式描述了一种计算过程，并且**最后一定会导出一个值**

> state 和 expression的区别就在后者一定有一个值

## 2.2 call expression

> operator and oprands are also expressions, so they evaluate to values
>
> 操作符和操作数都是表达式，所以他们本身都是一个值

> add          (2               ,                3)
>
> operator (operand1,operand2)

> Evaluate procedure for call expressions:
>
>> 1. Evaluate the operator and then the operand subexpressions
>> 2. Apply the function that is the value of the operator to the arguments that are the values of the operands

## 2.3 Names, Assignment, and UserDefined Functions

- Primitive Expressions 
  - number or numeral
  - name
  - string

> Execution rule for assignment statements:
>
> > 1. Evaluate all expressions to the right of = from left to right
> > 2. Bind all names to the left of = to those resulting values in the current frame


## 2.4 Environment Diagrams

```python
f = min
f = max
g, h = min, max
max = g
max(f(2, g(h(1, 5), 3)), 4)

>>> 3
```

## 2.5 Defindng Functions

```python
def <name>(<formal parameters>):
    return <return expression>
```

> Execution procedure for def statements:
>
> > 1. Create a function with signature <name>(<formal parameters>)
> > 2. Set the body of that function to be everything indented after the first line
> > 3. Bind <name> to the function in the current frame

# 3 Control

## 3.1 Print and None

> None indicates that nothing is returned
>
> The special value **None** represents nothing in Python
>
> A function that does not explicit;y return a value will return **None**
>
> > Careful: **None** is not displayed by the interpreter as the value of an expression
>

## 3.2 Pure Funtions & Non-Pure Functions(纯洁/不纯洁的函数)

- Pure Functions
  - just return values
- Non-Pure Functions
  - have side effects

## 3.3 Multiple Environments(多层的环境)

### 3.3.1 Life Cycle of a User-Defined Function

1.   Def statement

    > What happens?
    >
    > > 1. A new function is created!
    > > 2. Name bound to that function in the current frame

2. Call Expression

    > What happens?
    >
    > > 1. Operator & operands evaluated
    > > 2. Function (value of operator) called on arguments (values of operands)
    
3. Calling/Applying

    > What happens?
    >
    > > 1. A new function is created!
    > > 2. Parameters bound to arguments
    > > 2. Body is executed in that new environment	

### 3.3.2 Multiple Environments in One Diagram

An environment is a sequence of frames

- The global frame alone
- A local, then the global frame

### 3.3.3 Names Have No Meaning Without Environments

## 3.4 Miscellaneous Python Features(Python的特性)

- Division
- Multiple Return Values
- Source Files
  - source file is an ascii file
- Doctests
- Default Arguments

## 3.5 Conditional Statements

### 3.5.1 Statements

> A statement is executed by the interpreter to perform an action

> 1. The first header determines a statement's type
> 2. The header of a clause "controls" the suite that follows
> 3. def statements are compound statements

## 3.6 Iteration(迭代)

While Statements

> Execution Rule for While Statements:
>
> 1. Evaluate the header's expression
> 2. If it is a true value, execute the (whole) suite, then return to step1

# 4 Higher-Order Functions

## 4.1 Designing Functions

### 4.1.1 三要素

- 定义域(domain)

  - > the set of all inputs it might possibly take as arguments

- 值域(range)

  - > the set of output values it might possibly return

- 行为(behavior)

  - > the relationship it creates between input and output


### 4.1.2 A Guide to Designing Function

> 1. Give each function exactly one job, but make it apply to many related situations
> 2. Don't repeat yourself(DRY): Implement a process just once, but execute it many times

## 4.2 Generalization(泛化)

提取共同的结构

## 4.3 Higher-Order Functions

### 4.3.1 Generalizing Over Computational Process

函数

比如求平方和，立方和，都可以变成`求和 + 每个和的形式  `

## 4.4 Funtions as Return Values

>  本地定义函数绑定到本地的frame里面
>
>  >Functions defined within oter function bodies are bound to names in a local frame

## 4.5 Lambda Expression(匿名函数)

## 4.6 Return

> 1. A return statements completes the evaluation of a call expression and provides its value
> 2. Only one return statement is ever executed while executing the body of a function

## 4.7 Control Expression  

```python
def condition():
    print("This is condition.")
    return True

def if_suite():
    print("This is if suite.")

def else_suite():
    print("This is else suite.")

def if_(condition_value, if_value, else_value):
    if condition_value:
        return if_value
    else:
        return else_value

def if_statement():
    if condition():
        if_suite()
    else:
        else_suite()

def if_function():
    if_(condition(), if_suite(), else_suite())
    
>>> if_function()
This is condition.
This is if suite.
This is else suite.
```

```python
如果改成这样
def condition():
    print("This is condition.")
    return True

def if_suite():
    print("This is if suite.")

def else_suite():
    print("This is else suite.")

def if_(condition_value, if_value, else_value):
    if condition_value():
        return if_value()
    else:
        return else_value()

def if_statement():
    if condition():
        if_suite()
    else:
        else_suite()

def if_function():
    if_(condition, if_suite, else_suite)
    
    
>>> if_function()
This is condition.
This is if suite.
```

这就是name和call expression的区别所在

### 4.7.1 Logical Operators

- and(短路原则)
  - \<left> and \<right>
  - 返回left 为 True，返回right的**值**；否则返回本身的**值**
- or
  - \<left> and \<right>
  - 返回left 为False，返回right的**值**；否则返回本身的**值**

### 4.7.2 Condition Expression

> <consequent> if <predicate> else <alternative>

# 5 Environments

## 5.1 Environments for Higher-Order Functions(高阶函数的环境)

> Functions are first-class: Functions are values in our programming language

Higher-order funcion

- A function that takes a function as an argument value 
- A function that returns a function as a return value

## 5.2 Environments for Nested Definitions(嵌套def的环境)

- Every user-defined function has a parent frame(often global)
- The parent of a function is the frame in which it was defined
- Every local frame has a parent frame(often global)
- The parent of a frame is the parent of the function called

## 5.3 Lambda Expression

## 5.4 Function Compostion(复合函数)

## 5.5 Self-Reference(自引用)

## 5.6 Currying(颗粒化)

# 6 Design

## 6.1 Abstraction

把一些细枝末节不需要关心的东西放在一个盒子里面

## 6.1.1 Functional Abstractions

## 6.2 Name Tips

不会影响正确性，但会影响可读性

- Names should convey the meaning or purpose of the values to which they are bound
- The type of value bound to the name is best documented in a function's docstring
- Function names typically convey their effect (**print**),their behavior (**triple**), or the value returned (**abs**).

需要命名的变量

- 避免重复计算
- 有意义的复杂表达式

# 7 Recursion

## 7.1 Recursive Functions

> Definition: A function is called recursive if the body of that funcion calls itself, either directly or indirectly
>
> > 或直接或间接地调用自身的函数

## 7.1.1 The Anatomy of a Recursive Function

- The `def statement header` is similar to other functions
- Conditional statements check for `base cases`
- Base cases are evaluated `without recursive calls`
- Recursive cases are evaluated `with recursive calls`

## 7.2 Recursion in  Environment Diagrams

Iteration VS Recursion

- Iteration
  - Using while
- Recursion
  - Using recursion

## 7.3 Verifying Recusive Functions

数学归纳法思想

## 7.4 Recursion and Iteration

# 8 Tree Recursion

## 8.1 Order of Recursive Calls

## 8.2 Example of Recursion

Cascade & inverse Cascade

## 8.3 Tree Recursion

> Tree-shaped process arise whenever executing the body of a recursive function makes more than one recursive call
>
> > 不止调用一次自身的函数

## 8.4 Example of Tree Recursion

Hanoi Tower & Counting Partitions

# 9 Containers(容器)

## 9.1 List

```python
>>> digits = [1, 8, 2, 8]

# The number of elements
>>> len(digits)
8

# An element selected by its index
>>> digits[3]
4

# Concatenation and repetition
>>> [2, 7] + digits * 2
[2, 7, 1, 8, 2, 8, 1, 8, 2, 8]

# Nested lists
>>> pairs = [[10, 20], [30, 40]]
>>> pairs[1]
[30, 40]
>>> pairs[1][0]
30
```

## 9.2 Containers

> Built -in operators for testing whether an element appears in compound value

```python
>>> digits = [1, 8, 2, 8]
>>> 1 in digits
True
>>> 8 in digits
True
>>> 5 not in digits
True
>>> not(5 in digits)
True
```

## 9.3 For Statements

## 9.4 Range

A range is a sequence of consecutive integers

- ranges can actually represent more general integer sequences

range(a, b) ---> [a, b)

## 9.5 List Comprehensions

> [<map exp> for <name> in <iter exp> if <filter exp>]
>
> short version : [<map exp> for <name> in <iter exp>]

## 9.6 Strings

presenting

- data
- language
- program

## 9.7 Reverse Strings

# 10 Data Abstraction

## 10.1 Data Abstraction

- Compound values combine other values together
- Data abstraction lets us manipulate compound values as units
- Isolate two parts of any program that uses data
  - how data are represented (as parts)
  - how data are manipulated (as units)
- Data abstraction: A methodology by which functions enforce an abstraction barrier between ***representation*** and ***use***

## 10.2 Rational Numbers

## 10.3 Pairs

## 10.4 Abstraction Barriers

高层不用关心底层操作

改变底层实现的时候，更高层不需要改动

## 10.5 Data Representations

## 10.6 Dictionaries

```python
dictionary = {'key1':'value1','key2':'value2'}

# 取值
>>> dictionary['key1']
'value1'

# 修改值
>>> dictionary['key1'] = 'change1'
>>> dictionary['key1']
'change1'

# 增加键值对
>>> dictionary['keyadd'] = 'valueadd'
>>> dictionary
{'key1':'change1','key2':'value2','keyadd':'valueadd'}

# 删除键
>>> del dictionary['keyadd']
>>> dictionary
{'key1':'change1','key2':'value2'}
```

缺点

- unordered
- 每个key唯一

# 11 Tree

## 11.1 Box-and-Pointer Notation

> closure ---> 元素的数据类型也可以是他本身
>
> > - A method for combining data values satisfies the closure property if: The result of combination can itself be combined using the same method
> > - Closure is powerful because it permits us to create hierarchical structures
> > - Hierarchical structures are made up of parts, which themselves are made up of parts, and so on
>
> > 简而言之，就是list可以包含list作为其元素

## 11.2 slicing(切片)

```python
a = [1, 2, 3]
b = a 		# 指向同一个列表
c = a[:] 	# 复制产生了一个新的内容相同的列表
```

## 11.3 Processing Container Values

### 11.3.1 Sequence Aggregation(聚合)

several built-in functions take iterable arguments and aggregate them into a value

- sum(iterable[, start]) -> value
- max(iterable[, key=func]) -> value
- all(iterable) -> bool

## 11.4 Trees

### 11.4.1 Tree Abstraction

- root label
- branch

## 11.5 Tree Processing

Using Recursion

## 11.6 Example: Printing Tree

## 11.7 Example: Summing Paths

# 12 Mutable Values(可修改的值)

## 12.1 Object

> - objects represent information
> - They consist of data and behavior, bundle together to create abstractions
> - Object can represent thing, but also properties, interactions, & process
> - A type of object is called a class; classes are first-class values in Python
>
> > - 呈现信息
> > - 包括数据和行为，将二者绑定来创建抽象
> > - 也可表示某种性质或者互动
> > - 本质还是value

## 12.2 String

## 12.3 Mutation Operations

> - The same object can change in value throughout the course of computation
> - All names that refer to the same object are affected by a mutation
> - Only objects of mutable types can change: lists & dictionaries

## 12.4 Tuple(元组)

> Tuple are Immutable Sequences
>
> - Immutable values are protected from mutation
> - An immutable sequence may still change if it contains a mutable value as an element

## 12.5 Mutation

- equal
- same

## 12.6 Lists

- append
  - 引用盒子
- extend
  - 复制一份到后面，非同一个盒子
- addition & slicing & List function
  - 创建一个新的list，包含已存在的各个元素
- pop
  - 删除并返回最后一个元素
- remove
  - 删除第一个相等的元素
- slice assignment
  - 用空盒子来删除

# 13 Mutable Functions

## 13.1 Local Assignment

> Execution rule for assignment statements:
>
> 1. Evaluate all expressions right of =, from left to right
> 2. Bind the names on the left to the resulting values in the current frame

## 13.2 Non-Local Assignment(非本地赋值)

> 形式：	nonlocal <name>, <name>, ...
>
> > Effect: 
> >
> > Future assignments to that name change its pre-existing binding in the first non-local frame of the current environment in which that name is bound

## 13.3 Multiple Mutable Functions(多重修改性函数)

**Referential Transparency(引用透明性)**

- 功能一样可以视为一个东西

nonlocal让子孙具有能够修改父辈的能力

# 14 Iterators(迭代器)

## 14.1 Iterators

> - A container can provide an iterator that provides access to its elements in order
> - iter(iterable): Return an iterator over the elements of an iterable value
> - next(iterator): Return the next element in an iterator
>
> > - 容器可以提供一个顺序访问的迭代器

## 14.2 Dictonary Iteration

> - An iterable value is any value that can be passed to **iter** to produce an iterator
> - An iterator is returned from **iter** and can be passed to **next**;all iterators are mutable
>
> > - 可迭代就是一个可以放到**iter**函数里面并产生迭代器的值
> > - 所有迭代器都是可修改的

## 14.3 For Statements

## 14.4 Built-In Iterator Functions

- Many built-in Python sequence operations return iterators that compute results lazily
  - map(func, iterable)
    - Iterate over func(x) for x in iterable
  - filter(func, iterable)
    - Iterate over x in iterable if func(x)
  - zip(first_iter,second_iter)
    - Iterate over co-indexed (x, y) pairs
  - reversed(sequence)
    - Iterate over x in a sequence in reverse order
- To view the contents of an iterator, place the resulting elements into a container
  - list(iterable)
    - Create a list containing all x in iterable
  - tuple(iterable)
    - Create a tuple containing all x in iterable
  - sorted(iterable)
    - Create a sorted list containg x in iterable

## 14.5 Generators

使用`yield`关键字来代替`return`的function

- yield
  - 返回值
  - 暂停控制流
- return
  - 返回值
  - 结束控制流

## 14.6 Generators & Iterators

### 14.6.1 Generatots can Yield from Iterators

A yield from statement yields all values from an iterator or iterable

# 15 Objects

## 15.1 Object-Oriented Programming(面向对象编程)

- A method for organizing programs
  - Data abstraction
  - Bundling together information and related behavior
- A metaphor for computation using distributed state(用分布式状态进行计算)
  - Each object has its own local state
  - Each object alse knows how to manage its own local state, based on method calls
  - Method calls are messages passed between objects
  - Several objects may all be instances of a common type
  - Different types may relate to each other

## 15.2 The Class Statement

样式

```python
class <name>:
    <suite>
```

> A class statement creates a new class and binds that class to <name> in the first frame of the current environment

## 15.3 Method

### 15.3.1 Method

- Methods are functions defined in the suite of a class statement

- These def statements create function objects as always, but their names are bound as attributes of the class

### 15.3.2 Invoking Method(调用方法)

- All involked methods have access to the object via the self parameter, and so they can all access and manipulate the object's state
- Dot notation automatically supplies the first argument to a method

### 15.3.3 Dot Expressions

> 格式：	<expression>.<name>
>
> - The <expression> can be any valid Python expression
> - The <name> must be a simple name

## 15.4 Attribute(属性)

- Class attribute
  - class attribute are 'shared' across all instances of a class because they are attributes of the class, not the instance
- instance attribute

## 15.5 Method and Functions

- distinguishes
  - Functions
    - which we have been creating since the beginning of the course
  - Bound methods
    - which couple together a function and the object on which that method will be invoked
  - Object + Function = Bound Method

# 16 Inheritance(继承)

## 16.1 Attributes

### 16.1.1 Terminology: Attributes, Functions, and Methods

- All objects have attributes, which are name-value pairs
- Classes are objects too, so they have attributes
- Instance attribute: attribute of an instance
- Class attribute: attribute of the class of an instance

## 16.2 Attribute Assignment

Assignment statements with a dot expression on their left-hand side affect attributes for the object of tha dot expression

- If the object is an instance, then assignment sets an instance attribute
- If the object is a class, then assignment sets a class attribute

## 16.3 Inheritance

样式

```python
class <Name>(<Base Class>):
    <suite>
```

作用：

- 继承基类的元素
- 只对想要修改的部分进行操作，其余的照用基类就行

## 16.4 Object-Oriented Design

### 16.4.1 Designing for Inheritance

- Don't repeat yourself; use existing implementations
- Attributes that have been overridden are still accessible via class objects
- Look up attributes on instances whenever possible

## 16.5 Inheritance and Composition

- Inheritance
  - is-a relationship(一般和特殊的关系)
- Composition
  - has-a relationship(整体和局部的关系)

## 16.6 Multiple Inheritance(多继承)

# 17 representation(表示)

## 17.1 String Representations

In Python, all objects produce two string representations:

- The **str** is legible to humans
  - 使用Print 函数所打印的就是str的内容
- The **repr** is legible to the Python interpreter
  - The **repr** function returns a Python expression (a string) that evaluates to an equal object

The **str** and **repr** strings are often the same, but not always

## 17.2 Polymorphic Functions(多态函数)

> Polymorphic Functions: A function that applies to many (poly) different forms (morph) of data
>
> >  定义：给不同的输入会返回不同的输出

```python
def repr(x):
    return type(x).__repr__(x)
```

if no `__str__ ` attribute is found, uses `repr` string

## 17.3 Interfaces(接口)

> - Message passing: Objects interacts by looking up attributes on each other (passing messages)
> - The attribute look-up rules allow different data types to respond to the same message
> - A shared message (attribute name) that elicits similiar behavior from different object classes is a powerful method of abstraction
> - An interface is a set of shared messages, along with a specification of what they mean
>
> > - 对象之间的信息传递是通过相互查找各自的方法来实现的
> > - 能够让不同的数据类型对同一个信息做反馈
> > - 不同类可能拥有的共同数据类型的信息
> > - 一个接口是所有对象共有的一些信息，以及共有信息的含义

interface 只是规定了shared message 是什么，具体如何实现的并不在乎

Interface是一种抽象思想，或者说是一个功能，而不是一个具体函数

## 17.4 Special Method Names

- `__init__`
- `__repr__`
- `__add__`
- `__bool__`
- `__float__`

## 17.5 Generic Functions(泛函)

> A polymorphic function might take two or more arguments of different types

# 18 Composition(组合)

## 18.1 Linked Lists(链表)

### 18.1.1 Linked List Structure

> A linked list is either empty or a first value and the rest of the linked list

一个递归的定义

### 18.1.2 Linked List Class

```python
class Link:
    empty = ()
    def __init__(self, first, rest=empty):
        assert rest is Link.empty or isinstance(rest, Link)
        self.first = first
        self.rest = rest
```

## 18.2 Linked List Processing

## 18.3 Linked List Mutation

## 18.4 Tree Class

## 18.5 Tree Mutation

# 19 Efficiency

## 19.1 Memoization(记忆化存储)

用空间换时间

 ```python
 def fib(n):
     """ Return the Nth fibonacci number.
     
     >>> fib(0)
     0
     >>> fib(1)
     1
     >>> fib(2)
     1
     >>> fib(3)
     2
     >>> fib(4)
     3
     >>> fib(5)
     5
     """
     if n == 0:
         return 0
     if n == 1:
         return 1
     return fib(n - 2) + fib(n - 1)
 ```

```python
def memo(f):
    """ Reconstruct a single argument function into a memoized version."""
    cache = {}
    def memoized(n):
        if n not in cache:
            cache[n] = f(n)
        return cache[n]
    return memoized

def make_memo_fib():
    """ Make a memoized fib function that works efficiently.
    >>> memo_fib = make_memo_fib()
    >>> memo_fib(0)
    0
    >>> memo_fib(1)
    1
    >>> memo_fib(2)
    1
    >>> memo_fib(3)
    2
    >>> memo_fib(4)
    3
    >>> memo_fib(5)
    5
    >>> memo_fib(35)
    9227465
    """
    cache = {0: 0, 1: 1}
    def memo_fib(n):
        if n in cache:
            return cache[n]
        res = memo_fib(n - 2) + memo_fib(n - 1)
        cache[n] = res
        return cache[n]
    return memo_fib
```

## 19.2 Exponentiation(指数)

- Linear time(线性时间)
- Logarithemic time(对数时间)

## 19.3 Orders of Growth

## 19.4 Space

# 20 Decomposition(解构)

## 20.1 Modular Design(模块化的思想)

- A design principle: Isolate different parts of a program that address different concerns
- A modular component can be developed and tested independently

## 20.2 Sets

- Set literals are enclosed in braces
- Duplicate elements are removed on construction
- Sets have arbitrary order(随机顺序)



---



# EX1 (Optional) Tail Recursion

## EX1.1 Functional Programming

- 所有的函数都是纯函数，返回一个数值，中间没有任何副作用
- 没有重新赋值和可变数据类型，因此没有`for`或者`while`（过程中会对变量重新赋值）
- 键值绑定是永久的

优点：

- 一个表达式的值和子表达式的执行顺序无关
- 子表达式可以并行求值或者惰性求值
- *Referential transparency*：可以将任意的表达式直接替换为这个表达式的值（因为所有函数都是纯函数）

## EX1.2 Tail calls

在python进行递归调用时，会生成很多函数栈帧，因此空间复杂度为O(n)。这些栈帧可能只是被使用了很短的一段时间，但可能会造成栈溢出，而*properly tail recursive*的语言可以实现进行尾递归调用时空间复杂度为O(1)。

为什么一定需要尾调用这个限制？因为在函数中间的调用如果没有栈帧的话，可能会对当前环境产生影响，从而影响函数中调用之后的代码正确性，因此一定要等到整个函数都执行完毕之后，在最后一个子表达式才能进行栈帧优化。

**尾调用**：在*tail context*中的call expression

tail context: `lambda`表达式body中的最后一个子表达式

如果一个if表达式在tail context中，那么这个if表达式中的和也在tail context中

```scheme
(define (factorial n k)
  (if (= n 0) k
      (factorial (- n 1)
                 (* k n))))
```

上述例子中，`k`和`(factorial (- n 1) (* k n))`都在tail context里

所有的在tail context中的`cond`表达式中的不是predicate的子表达式也都是尾调用

**注意**：如果尾调用表达式中还有一个子表达式，且这个尾调用表达式需要计算，那么这个子表达式不是尾调用（因为得到子表达式的值之后还需要进行计算，因此子表达式并不是最后一步）

```scheme
(define (length s)
  (if (null? s) 0
      (+ 1 (length (cdr s)))))
```

`(+1 (length (cdr s)))`是尾调用，而`(length (cdr s))`不是，为了把它变成尾调用

```scheme
(define (length-tail s)
  (define (length-iter s n)
    (if (null? s) n
        (length-iter (cdr s) (+ 1 n))))
  (length-iter s 0))
```

## EX1.3 Tail Recursion

函数的尾调用是调用这个函数本身，这就是一个尾递归

以下面的scheme函数为例

```scheme
(define (sum n total)
      	(if (zero? n) total
        (sum (- n 1) (+ n total))))

(sum 1001 0)
```

开启了尾递归优化的情况下：在对`(sum 1001 0)`进行求值时，对`sum`进行eval，因为sum在env中已经被定义，因此替换为前面的define的LambdaProcedure对象。然后分别对1001和0进行scheme_eval后将这两个参数scheme_apply到sum这个LambdaProcedure中，此时创建了一个新的env，绑定参数为{n:1001, total:0}，父环境为global，然后对sum函数体中的所有表达式（就只有1个）进行eval_all，而因为这个表达式的rest为nil，因此是在tail context中的，会返回一个Thunk，其环境为{n:1001, total:0}，表达式为sum的body，此时将返回到最开始的`(sum 1001 0)`的eval的循环中，因为返回的是一个Thunk，因此还需要对这个Thunk进行求值

对Thunk调用eval，最先解析的是if表达式，跳转到`do_if_form`，判断`(zero? n)`，发现应当跳转到alternative表达式，注意，此时的alternative表达式处在tail context中，因此不会立即进行求值跳转到新的栈帧，而是会返回一个Thunk，这个Thunk的环境还是父环境为global，表达式为`(sum (- n 1) (+ n total))`，再次返回到global环境中

因为返回的还是Thunk，因此需要继续对这个Thunk进行求值，对上述表达式的所有参数进行eval之后得到对sum进行apply的参数1000和1001，然后创建一个新的子环境。注意：因为此时环境还是global，因此创建的新的环境的父环境是global，而不是之前的{n:1001, total: 0}的环境，这里可以看出**Thunk的作用：将尾调用时的环境和参数保存，然后返回到global环境，再从global环境中对这个Thunk进行求值，这样可以避免直接在子环境中新创建另一个子环境，造成栈帧的递归**

# EX2 Macro

Macro和procedure的区别在于，procedure先对其参数进行求值，然后将这些值apply到这个precedure中，而macro则直接将参数apply，然后对body进行求值，比如

```scheme
(define-macro (twice expr)
              (list 'begin expr expr))
(define (twice2 expr)
  		(list 'begin expr expr))
> (twice (print 2))
2
2
> (twice2 (print 2))
2
(begin undefined undefined)
```

# EX3 SQL

## EX3.1 Declarative Programming Definition

- *declatative languages*：一个程序是对希望得到的结果的描述，怎样得到结果是由解释器负责的。申诉式语言包括SQL、Prolog等
- *imperative languages*：一个程序是对计算过程的描述，解释器负责执行这些计算过程。命令式语言包括Python、C等

```sql
create table cities as
	select 38 as latitude, 122 as longtitude, "Berkeley" as name union
	select 42,             71,                "Cambridge"        union
	select 45,             93,                "Minneapolis";
```

cities:

| Latitude | Longtitude | Name        |
| -------- | ---------- | ----------- |
| 38       | 122        | Berkeley    |
| 42       | 71         | Cambridge   |
| 45       | 93         | Minneapolis |

## EX3.2 SQL Intro

每个SQL语句用`;`结尾

`select`创建一个新的表，`create table`给这个表一个全局名称

列描述：`select [expression] as [name]` 列描述中的`as`和列名称`[name]`都是可选的

`select`创建一个一行的表，但是可以用`union`来将多个行合并为一个表格

除了创建新的表之外，`select`还可以对已有的表进行操作，使用`from`来指定表。可以用`where`来过滤输入的表中的某些行，也可以用`order by`来确定这些行的排序方式

```sql
select [columns] from [table] where [condition] order by [order];
```

**select表达式中的算数**

```sql
create table lift as
  select 101 as chair, 2 as single, 2 as couple union
  select 102         , 0          , 3           union
  select 103         , 4          , 1;

select chair, single + 2 * couple as total from lift;
```

| chair | total |
| ----- | ----- |
| 101   | 6     |
| 102   | 6     |
| 103   | 6     |

## EX3.3 Table

**合并表格**

```sql
-- Parents
CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

-- Fur
CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur UNION
  SELECT "barack"         , "short"       UNION
  SELECT "clinton"        , "long"        UNION
  SELECT "delano"         , "long"        UNION
  SELECT "eisenhower"     , "short"       UNION
  SELECT "fillmore"       , "curly"       UNION
  SELECT "grover"         , "short"       UNION
  SELECT "herbert"        , "curly";
  
-- Parents of curly dogs
SELECT parent FROM parents, dogs WHERE child = name AND fur = "curly";
```

**Alias and Dot Expression**

当2个表格有相同的列名称时，可以用alias和`.`进行区分

筛选parents表格中拥有同一个parent的child

```sql
-- Siblings
SELECT a.child AS first, b.child AS second
  FROM parents AS a, parents AS b
  WHERE a.parent = b.parent AND a.child < b.child;
```

这里的`from parents as a, parents as b`是将2个相同的parents表格进行合并，并且给了不同的别名a和b，`a.child`指代第一个parents表格中的child列，`b.child`指代第二个parents表格中的child列

| first   | second  |
| ------- | ------- |
| barack  | clinton |
| abraham | delano  |
| abraham | grover  |
| delano  | grover  |

**String Expressions**

`||`字符串连接符号

```sql
> select "hello," || " world";
hello, world
```

SQL的index从1开始

`substr(str, start, len)`：从index=start开始长度为len的子字符串

```sql
> create table phrase as select "hello, world" as s;
> select substr(s, 4, 2) || substr(s, instr(s, " ")+1, 1) from phrase;
low
```

