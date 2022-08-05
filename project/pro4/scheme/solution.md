## Scheme

### 内容介绍

- scheme.py：实现 REPL 和 Scheme 表达式的评估
- scheme_reader.py: 实现了Scheme输入的阅读器。Pair类和nil定义可以在这里找到。
- scheme_tokens.py：为Scheme输入实现标记器
- scheme_builtins.py：在Python中实现内置的Scheme程序
- buffer.py：实现Buffer类，在scheme_reader.py中使用。
- ucb.py：在61A项目中使用的实用函数。
- questions.scm：包含第三阶段的骨架代码
- tests.scm：用Scheme编写的测试案例集。
- ok：自动跟踪器
- tests：ok使用的测试目录
- mytests.rst：一个可以添加自己的测试的文件。

### Problem1

#### Function

- scheme_read
- read_tail

#### Meaning

- `scheme_read`从`src`中删除足够多的标记，以形成一个单一的表达式，并以正确的内部表示法返回该表达式
  - `scheme_read`返回缓冲区中下一个完整的表达式
  - 如果当前令牌是字符串` "nil"`，返回`nil`对象。
  - 如果当前令牌是`（`，则表达式是一个对或列表。对`src`的其余部分调用`read_tail`并返回其结果。
  - 如果当前标记是`'`，那么缓冲区的其余部分应作为一个`quote`表达式来处理。在问题6之前你不必担心这个问题。
  - 如果下一个标记不是定界符，那么它必须是一个原始表达式（即数字、布尔值）。返回它。**已提供**
  - 如果上述情况都不适用，则引发一个错误。**已提供**

- `read_tail`期望读取一个列表或对子的其余部分，假设该列表或对子的开放括号已经被`scheme_read`删除。它将读取表达式（并因此移除标记），直到看到匹配的结束括号`）`。这个表达式的列表被作为一个Pair实例的链接列表返回。
  - `read_tail`返回缓冲区中一个列表或对的其余部分。这两个函数都会突变缓冲区，删除已经处理过的标记。
  - 如果没有更多的标记，那么这个列表就缺少一个封闭的小括号，我们应该引发一个错误。**已提供**
  - 如果令牌是`）`，那么我们已经到达了列表或配对的末端。**从缓冲区中删除这个令牌**，并返回`nil`对象。
  - 如果上述情况都不适用，那么下一个标记就是组合中的运算符。例如，src可能包含`+ 2 3）`。要解析这个。
    - `scheme_read`缓冲区中的下一个完整表达式。
    - 调用`read_tail`来读取组合的其余部分，直到匹配的结束括号。
    - 将结果作为一个`Pair`实例返回，其中第一个元素是(1)中的下一个完整表达式，第二个元素是(2)中组合的其余部分。


#### Attention

- None

### Problem2

#### Function

- define
- lookup

#### Meaning

- `bindings` 是一个代表框架中的绑定的字典。它将 Scheme 符号 (用 Python 字符串表示) 映射到 Scheme 值。

- `parent `是父框架`Frame`实例。全局框架的父级是 `None`。

1. `define` 接收一个符号 (用 Python 字符串表示) 和一个值，并将该值绑定到框架中的那个符号。
2. `lookup` 接收一个符号，并在当前环境中找到该名称的第一个 `Frame` 中返回与该名称绑定的值。一个环境被定义为一个框架，它的父框架，以及它所有的祖先框架，包括全局框架。因此。
   - 如果在当前框架中找到该名称，返回其值。
   - 如果在当前框架中没有找到该名称，并且该框架有一个父框架，则继续在父框架中查找。
   - 如果在当前框架中没有找到名字，并且没有父框架，则引发一个`SchemeError`。 **已提供**。


#### Attention

- None

### Problem3

#### Function

- apply

#### Meaning

- `BuiltinProcedure`的`apply`方法接收一个参数值的列表和当前环境。` args`是一个Scheme列表，以`Pair`对象或`nil`表示。你的实现应该做以下工作: 
  - 将 Scheme 列表转换成 Python 的参数列表。
    - 提示：`args` 是一个 Pair，它有一个` .first` 和` .rest`，类似于一个 Linked List。想一想，你将如何把 Linked List 的值放到一个列表中。

  - 如果 `self.use_env` 是` True`，那么就把当前环境 `env `作为最后一个参数加入这个 Python 列表。
  - 使用 `*args` 符号对所有这些参数调用 `self.fn` (`f(1, 2, 3)` 相当于 `f(*[1, 2, 3]) `。**已提供**
  - 如果调用函数的结果是引发`TypeError`异常，那么就是传错了参数的数量。使用`try`/`except`块拦截异常，并在其位置上引发一个适当的`SchemeError`。**已提供**



#### Attention

- “如果 `self.use_env` 是` True`，那么就把当前环境 `env `作为最后一个参数加入这个 Python 列表。”这句话中的最后一个参数，要在while循环之外再加入

### Problem4

#### Function

- scheme_eval

#### Meaning

- 实现 `scheme_eval `中缺少的部分，即评估调用表达式。为了评估一个调用表达式，我们要做以下工作。
  - 评估运算符（它应该评估为`Procedure`的一个实例）
  - 评估所有的操作数
  - 在已评估的操作数上应用程序，并返回结果。

- 下面是一些你应该使用的其他函数/方法。
  - `validate_procedure`函数如果提供的参数不是Scheme存储过程，则会引发错误。你可以用它来验证你的操作符是否真的被评估为一个存储过程。
  - `Pair`的`map`方法返回一个新的Scheme列表，该列表是通过对Scheme列表中的每个项目应用一个单参数函数而构建的
  - `scheme_apply `函数将一个Scheme存储过程应用于一个Scheme列表的参数。**请确保使用这个函数而不是特定存储过程的`apply`方法**，因为不是所有的存储过程都有自己的apply方法。



#### Attention

- 其实要完成的只有“在已评估的操作数上应用程序，并返回结果”这一步，并且调用的apply方法是`scheme_apply`，而不是其他的apply方法。

### Problem5

#### Function

- define

#### Meaning

- 第一个操作数的类型告诉我们什么是被定义的。
  - 如果它是一个符号，例如`a`，那么这个表达式就定义了一个名字。
  - 如果它是一个列表，例如`（foo x）`，那么该表达式就定义了一个过程。

- 在`do_define_form`函数中缺少两个部分，它处理`（define ...）`特殊形式。对于这个问题，**只需实现第一部分**，即对第二个操作数进行评估以获得一个值，并将第一个操作数（一个符号）与这个值绑定。


#### Attention

- 看最下面有个`create_global_frame`函数，找到env有个define的用法，实现题示绑定要求

### Problem6

#### Function

- do_quote_form

#### Meaning

- 在 `scheme_reader.py `中完成` scheme_read` 的实现，处理`'`的情况。首先，注意`'<expr>`翻译为`（quote <expr>）`。这意味着我们需要将`'`后面的表达式（你可以通过递归调用 `scheme_read `得到）包装成 quote 的特殊形式，就像所有的特殊形式一样，它实际上只是一个列表。



#### Attention

- None

### Problem7

#### Function

- eval_all

#### Meaning

- 完成 begin 特殊形式的实现。一个`begin`表达式是通过依次评估所有子表达式来进行评估的。`begin`表达式的值就是最后一个子表达式的值。
- 如果 `eval_all` 被传递给一个空的表达式列表 (`nil`)，那么它应该返回 Python 值 `None`，它代表了 Scheme 值 `undefined`。


#### Attention

- ```python
  if not expressions :
          return None
  elif not expressions.rest :
  	return scheme_eval(expressions.first, env)
  evalate_but_not_display = scheme_eval(expressions.first,env)
  return eval_all(expressions.rest,env)
  ```
  
- ```python
  if not expressions :
          return None
  ans = nil
  while expressions:
  	ans = scheme_eval(expressions.first,env)
  	expressions = expressions.rest
  return ans
  ```

- > evalate_but_not_display = scheme_eval(expressions.first,env)
  >
  > 这句加上去以后，实现了题目要求的evaluate所有的要求

### Problem8

#### Function

- do_lambda_form

#### Meaning

- 它创建并返回一个`LambdaProcedure`实例。虽然还不能调用用户定义的存储过程，但可以通过在解释器提示符中输入λ表达式来验证是否正确创建了存储过程。
- 在Scheme中，在一个过程的主体中放置一个以上的表达式是合法的（必须至少有一个表达式）。`LambdaProcedure`实例的`body`属性是一个主体表达式的Scheme列表。这个表达式列表的语义与单个`begin`特殊形式的主体相同。


#### Attention

- None

### Problem9

#### Function

- do_define_form

#### Meaning

- 使用给定的变量`target`和`expressions`，找到定义函数的名称、formals和body。
- 使用`formals`和`body`创建一个`LambdaProcedure`实例。提示：你可以使用你在问题8中所做的，在适当的参数上调用`do_lambda_form`。
- 将名字绑定到`LambdaProcedure`实例上。


#### Attention

- None

### Problem10

#### Function

- make_child_frame

#### Meaning

- 这个方法接收两个参数：`formals`，这是一个符号的Scheme列表，和`vals`，这是一个值的Scheme列表。它应该返回一个新的子框架，将形式参数与数值绑定。
  - 如果参数值的数量与形式参数的数量不一致，则引发`SchemeError`。**已提供**
  - 创建一个新的`Frame`实例，它的父类是`self`。
    在新创建的框架中，将每个形式参数绑定到其相应的参数值
  - `formals`中的第一个符号应该被绑定到`vals`中的第一个值，以此类推。
  - 返回新的框架。



#### Attention

- None

### Problem11

#### Function

- make_call_frame

#### Meaning

- 它应该使用适当的父框架的`make_child_frame`方法创建并返回一个新的`Frame`实例，将正式参数与参数值绑定。
- 由于lambdas是词义范围的，你的新框架应该是定义lambda的框架的一个子框架。作为参数提供给`make_call_frame`的`env`是存储过程被调用的框架


#### Attention

- None

### Problem12

#### Function

- do_and_form
- do_or_form

#### Meaning

- 逻辑形式`and`和`or`是短路的。对于`and`，你的解释器应该从左到右评估每个子表达式，如果其中任何一个子表达式评估为一个假值，那么就返回`#f`。否则，它应该返回最后一个子表达式的值。如果在一个`and`表达式中没有子表达式，那么它的值是`#`t。
- 对于`or`，从左到右评估每个子表达式。如果任何子表达式评估为真值，则返回该值。否则，返回`#f`。如果在`or`表达式中没有子表达式，那么它就会被评估为`#f`。
- 记住，你可以使用提供的Python函数`is_true_primitive`和`is_false_primitive`来测试布尔值。


#### Attention

- None

### Problem13

#### Function

- do_cond_form

#### Meaning

- 使其返回对应于true谓词的第一个结果子表达式的值，或者对应于`else`的结果子表达式。一些特殊情况。
- 当true谓词没有对应的结果子表达式时，返回谓词值。
- 当 `cond` case 的结果子表达式有多个表达式时，评估它们并返回最后一个表达式的值。(提示：使用 `eval_all`。)
- 如果没有真谓语，也没有`else`，`cond`的值是`undefined`的。在这种情况下，`do_cond_form`应该返回`None`。如果只有一个`else`，返回其子表达式。如果它没有，则返回`#t`。


#### Attention

- clause---->条件+该条件成立时的操作
- test---->操作，即可能的返回结果
- 实际要完成的步骤
  - 当true谓词没有对应的结果子表达式时，返回谓词值。
  - 返回对应于true谓词的第一个结果子表达式的值

### Problem14

#### Function

- make_let_frame

#### Meaning

- 它返回`env`的一个子框架，该框架将`bindings`的每个元素中的符号绑定到其对应的表达式的值上。绑定方案列表包含的对，每一个都包含一个符号和一个相应的表达式。
- `validate_form`：这个函数可以用来验证每个绑定的结构。它接收一个表达式的列表`expr`和一个`min`和`max`长度。如果`expr`不是一个合适的列表，或者没有包括`min`和`max`在内的项目，它就会引发一个错误。如果没有传入`max`，默认为无穷大。
- `validate_formals`：这个函数验证形式参数是一个符号的Scheme列表，每个符号都是不同的。


#### Attention

- validate_form格式抄之前的

### Problem15

#### Function

- enumerate (**questions.scm**)

#### Meaning

- 它接收一个值的列表，并返回一个两元素的列表
  - 其中第一个元素是值的索引
  - 第二个元素是值本身。



#### Attention

- None

### Problem16

#### Function

- merge (**questions.scm**)

#### Meaning

- 接收一个比较器和两个排序的列表，并将两个列表合并成一个排序的列表。
- 比较器通过比较两个值来定义排序，如果这两个值是有序的，则返回一个真值。


#### Attention

- None

### Problem17

#### Function

- let-to-lambda (**questions.scm**)

#### Meaning

- 如果我们引用一个`let`表达式并将其传入这个过程，应该会返回一个等价的`lambda`表达式。
- 为了处理所有程序，`let-to-lambda`必须了解Scheme语法。由于Scheme表达式是递归嵌套的，`let-to-lambda`也必须是递归的。


#### Attention

- None
