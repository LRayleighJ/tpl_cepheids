# 大作业选题：OGLE 造父变星光度数据

## 问题背景

**变星**指的是从地球上观察其亮度有起伏变化的恒星。**造父变星**是一种非常明亮的变星, 其亮度会随时间进行周期性变化（如下图）。根据造父变星的周光关系（Period-luminosity relation），可以进一步测量变星所在星云、星团距地球的距离。

OGLE（Optical Gravitational Lensing Experiment，光学引力透镜实验）是由波兰华沙大学主导的大型巡天项目，主要目标是通过引力透镜来寻找暗物质。
目前，OGLE 定期对来自麦哲伦星云、银河系核球和圆盘以及其他区域的约10亿颗恒星进行亮度观测，其最重要的成果之一就是收集了大量变星的光度数据，并形成了包含超过40万个天体的变星目录。这些数据对观测天体物理学的许多领域作出了重大贡献。

![HV 5558 = OGLE-LMC-CEP-0728, R.A.=05:02:11.34 Dec=-70:20:04.8](http://ogle.astrouw.edu.pl/atlas/lcurves/OGLE-LMC-CEP-0728.gif)![HV 974 = OGLE-LMC-CEP-2066, R.A.=05:27:55.00 Dec=-69:48:03.9](http://ogle.astrouw.edu.pl/atlas/lcurves/OGLE-LMC-CEP-2066.gif)![HV 2791 = OGLE-LMC-CEP-2979, R.A.=05:42:16.62 Dec=-70:36:12.1](http://ogle.astrouw.edu.pl/atlas/lcurves/OGLE-LMC-CEP-2979.gif)

本作业的任务是来模拟生成造父变星的光度数据。

### 参考资料

1. [百度百科：造父变星](https://baike.baidu.com/item/%E9%80%A0%E7%88%B6%E5%8F%98%E6%98%9F/101794?fr=aladdin)

2. [OGLE Atlas of Variable Star Light Curves](http://ogle.astrouw.edu.pl/atlas/index.html)

## 作业要求（功能部分）

### Makefile

本次作业提供了 `Makefile`，最终助教也将使用 `Makefile` 进行测试。需要注意，你在编写所有程序文件时，都应该使用 `make` 给程序传入的参数（来自 `sys.argv`），而非硬编码下面提到的文件名；否则，你可能无法通过测试。

在本目录中运行 make -n 即可看到实际运行的命令，这或许能帮助你开发。

### 数据说明

所有的输入数据存放在`data`文件夹下，因此请不要轻易改动这个文件夹下的内容，包括；

+ 观测起始时间个间隔时间（` observation_time.csv`）
+ 造父变星光变曲线的拟合参数（`fit_parameters.csv`），以及用于拟合的 `fourier` 函数（`fourier_func.py`）
+ 造父变星的光变周期和天球坐标（`cepheid_info.csv`）
+ 望远镜背景噪声分布参数（`gauss_std.csv`）

### 基本要求

作业功能部分（占80分）的基础要求分成以下几部分，完成各个任务即可拿到相应分数：

| 任务（程序名）       | 分数 |
| -------------------- | ---- |
| `plot_lightcurve.py` |      |
| `preluminosity.py`   |      |
| `add_noise.py`       |      |
| `plot_data.py`       |      |
| `simu_telescope.py`  |      |



#### `plot_lightcurve.py`

`data` 中的`fourier_func.py`和`fit_parameters.csv`分别给出了拟合造父变星光变曲线所使用的 `fourier`函数及其拟合参数 ，由此可得造父变星在一个光变周期内的光变曲线。按光变周期**从小到大**的顺序，将三个造父变星在各自一个光变周期内的光变曲线**从左到右**依次布置在同一张图上，并给出**坐标轴标签**（横轴单位为day；纵轴为magnitude），子图题分别为三个光变周期$T_i$，格式为"P_1 = $T_i$" ；总图题为“Light Curve”。将图片文件保存为`lightcurve.png`。

> **注意**：
>
> 1. magnitude 越小，亮度越大，因此绘图时需要注意纵轴数据标签（参考“问题背景”中的示例图片）；
>
> 2. 在`plot_lightcurve.py`的实现中，要求导入`data`中提供的`fourier_func`模块，借助`fourier()`和拟合参数完成光变曲线绘制

#### `preluminosity.py`

根据`cepheid_info.csv` 给出的光变周期，并按照`observation_time.csv`里给出的观测间隔时间对拟合曲线间隔采样，得到每个造父变星未加入望远镜噪声的原始光度数据。要求输出的每个造父变星光度变化的**数据点数相同**并至少有**400**个数据点，将输出保存到`idealdata.csv`中，文件的输出格式如下（$t_0$为观测开始时间；$t_i$ 为观测间隔；$j$ 为采样值，第一下标分别对应造父变星编号，即按光变周期从小到大的顺序）：

|   $t_0$    | $j_{10}$ | $j_{20}$ | $j_{30}$ |
| :--------: | :------: | :------: | :------: |
| $t_0+t_i$  | $j_{11}$ | $j_{21}$ | $j_{31}$ |
| $t_0+2t_i$ | $j_{12}$ | $j_{22}$ | $j_{32}$ |
|  $\vdots$  | $\vdots$ | $\vdots$ | $\vdots$ |
| $t_0+nt_i$ | $j_{1n}$ | $j_{2n}$ | $j_{3n}$ |

> **注意**：在`preluminosity.py`的实现中，要求导入`data`中提供的`fourier_func`模块，借助`fourier()`和拟合参数完成初步光度数据生成

#### `add_noise.py`

为了模拟望远镜带来的背景噪声，可选择某一标准差的高斯分布进行抽样，将抽样得到的噪声信息叠加在`preluminosity.py`生成的光度数据文件，最后得到模拟生成的光度数据。分布参数参考`gauss_std.csv`，要求输出格式与`idealdata.csv`相同，输出保存到`realdata.csv`。

#### `plot_data.py`

利用`add_noise.py`生成的模拟光度数据`realdata.csv`，绘制出整个观测时间内（即包括所有的数据点）每个造父变星光度变化的散点图。要求将三个造父变星的光度变化绘制在同一散点图内，使用不同颜色且不同形状的符号对散点进行标识，并附上图例。注意标注坐标轴标签和图题，以及纵轴数据标签。图片保存到`plotdata.png`

#### `simu_telescope.py`

假设巡天望远镜能够同时看到这三个造父变星并正对变星所在平面，尝试生成一个简单动画来模拟望远镜观测造父变星的亮度变化。首先需要读取`cepheid_info.csv` 获得三个造父变星的天球坐标，适当变换后可以得到变星所在平面三个造父变星的相对位置（不对绝对位置和距离做要求），并按照相对位置将变星放入直角坐标系中。可以通过颜色或者图标大小来表征造父变星的亮度。利用`realdata.csv`中 magnitude 随时间变化的数据，得到一系列不同时间下各造父变星的星等图像，顺序显示这些图像便得到动画。将生成的动画存为`simu_telescope.gif`。

> 提示：尝试使用 matplotlib.animation

### 提高要求

“基本要求” 中给出拟合的造父变星光变曲线的类型为“经典造父变星 Fundamental-mode”。事实上由天文观测数据给出的造父变星的类型有很多，除了经典造父变星（Classical Cepheids）外，还有星族Ⅱ造父变星（Type II Cepheids）和反常造父变星（Anomalous Cepheids）等等。而光变曲线变化模式除了 Fundamental-mode 外，还有 First-overtone、Second-overtone等，甚至为多种模式的叠加。

![OGLE-LMC-CEP-0832, R.A.=05:03:58.24 Dec=-69:25:38.2](http://ogle.astrouw.edu.pl/atlas/lcurves/OGLE-LMC-CEP-0832.gif)

1. 自行调研 Classical Cepheids 的 Fundamental-mode、First-overtone 等内容，从 [OGLE Collection of Variable Stars](http://ogledb.astrouw.edu.pl/~ogle/OCVS/index.php) 中选择一个 Classical Cepheids 模式为 First-overtone（1O）的数据，默认 Target 为LMC（Large Magellanic Cloud），要求光变周期（P_1）与 “基本要求” 中给出的三个经典造父变星的光变周期不同，并在报告中注明选择的数据 ID （如 “OGLE-LMC-CEP-xxxx”），注意选择 I-band 的 photometry file。
2. 采用适当的方法处理所选数据，得到一条光滑的光变曲线，并绘制出来（在1~2个光变周期内）。
3. 选择 “基本要求” 中给出的其中一条 Fundamental-mode 的光变曲线（在报告中注明编号），并结合所选 First-overtone 的光变曲线，按照观测间隔采样并加入噪声，最后生成 F/1O multi-mode 的模拟数据。
4. 将生成的模拟数据分别挪到原光变曲线的两个光变周期内，分别绘制出两张散点分布图并进行比较。

## 作业要求（非功能部分）
非功能部分的要求详见大作业公告，此部分占 20 分。
