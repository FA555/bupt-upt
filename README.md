# BUPT is for Undergraduate Project Thesis

BUPT（或 bupt-upt）是北京邮电大学本科毕业设计（论文）的一份 Typst 模板。

本模板已经通过 2025 年不少于 5 人，以及 2026 年不少于 1 人的实践检验（通过学校提供的格式检测），然而仍然需要一些完善、改进以及与 2026 年校方模板的同步，因而仍然处于 WIP 状态。

## 安装

目前推荐的使用方式是安装到 Typst 的本地 package 目录（`@local`）下，详细方式请参见 [typst/packages#local-packages](https://github.com/typst/packages#local-packages)，您可能需要自行嵌套一层名为当前版本（`0.2.0`）的目录。若您正在使用 Typst 唯一指定 LSP [Tinymist](https://github.com/Myriad-Dreamin/tinymist)，则可在插件面板中找到相关的功能。

> [!NOTE]
> 
> 在本模板稳定后，我们将会将其发布至 Typst Universe，以便于更广泛的使用。欢迎大家的建议与贡献！

## 字体

参见 [src/config.typ](src/config.typ) 中的相关配置。默认使用：

- 中文
  - 宋体：中易宋体（SimSun）
  - 黑体：中易黑体（SimHei）
  - 楷体：中易楷体 GB2312 子集（KaiTi_GB2312）
- 西文
  - 衬线体：Times New Roman
  - 无衬线体：中易黑体
- 数学
  - New Computer Modern Math
- 等宽
  - Fira Code

> [!IMPORTANT]
> 中易系列字体系 Windows / Office 自带，我们使用这些字体是为了与学校模板保持一致，若您的机器缺少这些字体，请您自行安装至系统字体目录。
>
> New Computer Modern Math 随 Typst 分发。
>
> 学校并未规定使用何数学字体与等宽字体，您可以根据个人喜好进行更换。

## 使用例

请参见 [usage](usage) 目录下的示例文档。您需要将 `usage/` 作为项目的根目录。

- 编译入口为 `main.typ`。
- 文档信息、配置在 `globals.typ` 中进行，所有文件都需 `import "/globals.typ": *`，您可将全局 util 也定义在此。可配置项包含：
  - 是否启用材料模式，用于过程性材料中的外文论文翻译
  - 是否启用匿名模式，用于匿名评审
  - 字体
  - 时间
  - 作者信息（姓名、学院、专业、班级、学号、导师、导师签字等）
  - 论文信息（标题、英文标题、摘要、关键词等）

## 许可证 / License

除特别说明外，本仓库中的 Typst 源码、模板文件与示例文档均采用 MIT License 授权，详见 [LICENSE](./LICENSE)。

学校校徽、官方视觉标识、第三方字体等资源如有包含，不属于本许可证授权范围，其权利归原权利方所有。
