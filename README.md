### 简介
这是一个FPGA的多功能时钟项目，来自北航集成电路学院数字系统设计与验证课程的设计项目<br>
`original_code`中的代码经过了上板验证；`new_code`中的代码尝试使其代码更加简洁、美观，可以优先采用和阅读。整体功能并非十分完善，**仅供交流、学习**！<br>

### 仓库结构
```
BUAA_FPGA_CourseDesign_MutifuctionalClock
│  DE2_115_pin_assignments.csv
│  LICENSE.txt
│  README.md
│  
├─new_code
│      alarm.v
│      alarm_clock.v
│      bin2bcd.v
│      clk_div.v
│      clk_div.v.bak
│      clock_tb.v
│      comparer.v
│      complex_clock.v
│      complex_clock_debounce.v
│      counter.v
│      counter_add_sub.v
│      counter_set.v
│      counter_set_reset.v
│      debounce.v
│      mod_display.v
│      mod_shift3.v
│      mod_shift4.v
│      segment.v
│      simple_clock.v
│      stopwatch.v
│      
└─original_code
        alarm.v
        alarm_clock.v
        bin2bcd.v
        clk_div.v
        clock_tb.v
        comparer.v
        complex_clock.v
        complex_clock_debounce.v
        counter.v
        counter_add_sub.v
        counter_reset.v
        counter_set.v
        counter_set_reset.v
        debounce.v
        mod_display.v
        mod_shift3.v
        mod_shift4.v
        segment.v
        simple_clock.v
        stopwatch.v
```  

### 开发环境
开发板：**Altera DE2-115**
EDA工具：**Quartus Prime Lite**

### 功能介绍
- 总复位时，时钟为 01:02:03 ，闹钟为 02:04:00
- 模式1为时钟显示
- 模式2为时钟设置，可通过`KEY[3:1]`来改变数字，通过`SW[15]`一开一关确认设置
- 模式3为秒表，可通过`SW[15]`实现开始/暂停
- 模式4为闹钟设置，设置方法与模式2相同
- 闹钟触发时`LEDR[0]`会亮，关闭`SW[14]`后才会熄灭

### 硬件面板介绍
![kit.jpg](https://github.com/Lumen507/BUAA_FPGA_CourseDesign_MutifuctionalClock/blob/main/photos/kit.jpg)
见图中的绿色方框
| 引脚 | 功能 |
| --- | --- |
|SW[17]|总复位|
|SW[16]|每个模式的归零|
|SW[15]|置数/秒表开关|
|SW[14]|闹钟开关|
|KEY[3]|数字减1|
|KEY[2]|数字加1|
|KEY[1]|切换数字设置位|
|KEY[0]|切换模式|
|HEX7-2|时钟/秒表显示|
|HEX1|模式显示|
|HEX0|闹钟开关显示|
|LEDR[0]|闹钟触发显示|

> SW均是高电平有效

### 实现框图
![framework.png](https://github.com/Lumen507/BUAA_FPGA_CourseDesign_MutifuctionalClock/blob/main/photos/framework.png)
这也是编程和例化的思路（左边的消抖模块图片未包含）

### 如何运行
> 熟悉Quartus的用户可以跳过本节
1. 开发板插上电源和USB，安装并打开Quartus Prime
2. 新建工程
    1. File > New Project Wizard
    2. working directory要选择可以正常打开的文件夹
    3. device要**选择如图所示板子**
    4. 其他点next即可

    <img src="https://github.com/Lumen507/BUAA_FPGA_CourseDesign_MutifuctionalClock/blob/main/photos/device.png" width="300">

3. **导入verilog代码**
    1. Project > Add Files in Project
    2. 选择所有.v文件并打开
4. **设置顶层模块**
    1. 打开 `clock_tb.v` 文件
    2. Project > Set as Top-level Entity
5. **配置端口**
    1. Assignments > Import Assignments
    2. 打开 `DE2_115_pin_assignments.csv`
6. 综合和烧录

    <img src="https://github.com/Lumen507/BUAA_FPGA_CourseDesign_MutifuctionalClock/blob/main/photos/compile.png" width="300">

    1. 在如图所示处点击Compile design
    2. 没有报错的话点击Program Device
    3. 在Hardware Setup中选择USB端口（注意提前装好驱动）
    4. 点击Start直到烧录成功

### 常用模块简介
- bin2bcd
    将十进制数的二进制编码按位拆分成4bit BCD码输出
- clk_div
    它能实现任意整数N倍的分频，且占空比为50%
- counter
    M进制计数器，具有置数和进位功能
- debounce
    对按键进行消抖，20ms的消抖时间是比较有效的
- segment
    共阳7段数码管的显示

具体端口请见源代码
### 改进方向
1. 每次置数应从当前时钟数字获取，并且置数完成后可以跳回模式1
2. 闹钟的触发形式可以扩展为闪烁灯或呼吸灯