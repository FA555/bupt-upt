#import "/globals.typ": *

#show: body-chapter

= 含图表示例

== 含图表示例

=== 图片

[此处键入正文]

图：每个图应有简短确切的图名，图中标注可采用中文或英文。图标题及序号置于图的正下方，居中，图名的英文字体为五号 Times New Roman ，中文字体为五号楷体。图序号一律采用阿拉伯数字分章依序编排，如：图 3-2 为第三章第二图。如果图中含有几个不同部分，应将分图序号标注在分图的左上角，并在图名下列出各分图图名。绘图必须工整、清晰、规范。示意图应能清楚反映图示内容；照片应在右下角标明放大比例；实验结果曲线图应制成方框图。

#figure(
  caption: [明代永宁宣抚司及永宁卫疆域图],
  image("/assets/mock-image.png"),
)

=== 表格

表：表序号一律采用阿拉伯数字分章依序编排，如：表 5-4 为第五章第四表。每张表格应有简短确切的标题，表标题及序号置于表的正上方，居中，英文字体为五号 Times New Roman ，中文字体为五号楷体。表内必须按规定的符号标注单位。
公式：公式序号一律采用阿拉伯数字分章依序编排；如：式（2-13）、式（4-5），其标注应于该公式所在行的最右侧；公式书写方式应在文中相应位置另起一行居中横排，对于较长的公式只可在符号处（$+$、$-$、$*$、$\/$、$<=$、$>=$ 等）转行。

#figure(
  caption: [国际单位制的基本单位],
  table(
    columns: 3,
    stroke: none,
    table.hline(),
    table.header[量的名称][单位名称][单位符号],
    table.hline(),
    [长度], [米], [m],
    [质量], [千克(公斤)], [kg],
    [时间], [秒], [s],
    table.hline(),
  ),
)

=== 公式

第一个公式：

$
  & sum_(n = 1001)^2000 sum_(d divides n) [d >= n - 1000] \
  =& sum_(d = 1)^2000 sum_(n = 1001)^(d + 1000) [d divides n] \
  =& sum_(d = 1)^2000 (floor((d + 1000) / d) - floor((1001 - 1) / d)) \
  =& sum_(d = 1)^2000 (floor(d / d) + [(d + 1000) mod d < 1000 mod d]) \
  =& sum_(d = 1)^2000 (1 + [1000 mod d < 1000 mod d]) \
  =& sum_(d = 1)^2000 1 \
  =& 2000
$

第二个公式：

$
  cal(P)_1: quad max_(bold(alpha), bold(P)) &
  display(
    sum_(m in cal(M)) R_(cal(b), m) + sum_(n in cal(N)) R_n
  ) / display(
    m P_cal(b) + sum_(n in cal(N)) P_n
  ), #<eq:target> \
  "s.t." & alpha_(m, n) in {0, 1}, quad forall n in cal(N), m in cal(M), \
  & alpha_(cal(b), n) in {0, 1}, quad forall n in cal(N), \
  & sum_(m in cal(M)) alpha_(n, m) <= 1, quad forall n in cal(N), \
  & sum_(n in cal(N)) alpha_(m, n) <= Q, quad forall m in cal(M), \
  & d(n, m) <= d_"th", quad forall n in cal(N), m in cal(M), alpha_(n, m) = 1, \
  & P_cal(b) + sum_(n in cal(N)) P_n <= P^max, \
  & 0 <= sum_(n in cal(N)) alpha_(m, n) P_m <= P_m^max, quad forall m in cal(M).
$
