# textvisualizer

## 原则
类似json结构，简单易懂，且直观
学习代价低，入门门槛低

## 语法结构

* 第一行

  `flowchart|classDiagram|sequenceDiagram|useCase|activity.....[:|=] [块]`
* 全局属性定义

  `([@]保留属性名|@自定义属性名) [:|=] 属性值`
* 节点关系

  `link as 别名 节点引用[#端点] [描述] 箭头 [描述] 节点引用[#端点] : [箭头] 标题 [箭头]`
* 对象定义：

  `关键字 对象标题 [as 对象别名] [<<原型名>>] [#color,#backcolor] [:|=] 块*`
  `[形状] [对象别名] [形状] 对象标题 [<<原型名>>] [:|=] 块*`
* 块

  `{ [属性定义]* [对象定义|节点关系]* }`
  `[ 对象*[, 对象]* ]`
  `[yaml]`
* 对象标题

  `文字和空格|"字符串"|'字符串'|"""[格式类型]..."""|'''[格式类型]...'''`
* 备注

  `note [[方向] of 对象] as 别名 [:|=] 备注标题`
  `note as 别名 [[方向] of 对象] [:|=] 备注标题`

* 关键字含义
```
    @type 图形的类型，layout，布局引擎
    @layout 图形的布局算法，跟随不同的图形类型而定
    @engine 布局的引擎
    @title 图的标题
    @param 块参数
    autonumber自动编号
    header、footer
    if else for alt loop
    group
    class node usecase actor interface () <> object map json package
```
* 线型
```
    -- 实现
    == 粗线
    .. 点线
    .-. 或 -.- 点划线
```
## 示例
### flowchart
#### 单节点
```
flowchart
title : "hello world"
node1
```
#### 双节点
```
flowchart
title two nodes
node1 --> node2
node1 --o node2 : "circle arrow"
node1 -------> node1
node2 "1..1" ====> "0..*" node2 : self pointers
node1 --demo text[#red]--> node2
```
#### 多节点
```
@type : flowchart
@title : "multiple nodes"
node1 "The Node1" <<abstract>> {
node2 "Node2" {
@style "background-color:green"
}
node1#portIn --> node2
}
node3
```


### classDiagram
#### 类图
```
classDiagram
class "ABC" as abc {
#a : Integer required
+b : String[] = "hello"
}
c "ClassC" <<prototype>> {
#Integer a;
== splitter ==
+String b[];
}
abc --|> c
```
### sequence diagram
```
sequenceDiagram
```
