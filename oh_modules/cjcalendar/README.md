# cjcalendar
_最新版文档还在更新中 [**请点这里查看最新文档**](https://atomgit.com/cj-open/CJOpenNext/blob/master/cjcalendar/README.md)_

_发布审核比较慢，有紧急需求或者BUG要解决者，可加裙讨论：806284521_

#### 先看效果
![各种演示案例](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtybbs/028/132/711/0900086000028132711.20240626150016.10849744792393353474286569995485:50001231000000:2800:63D6ED0F305A355D558A56ECD3680A3DD729B7D3C12D83542175AD969DC3B7D7.gif)


## 简介

_cjcalendar 是一款日常开发常用的日历组件，内部集成常规、单选、时间范围选择、多选、自定义日期每项显示等._

## 下载安装

`ohpm install cjcalendar`

## 本地安装
```
"dependencies": {
  "cjcalendar": "file:path/to/cjcalendar.har" // 此处也可以是以当前oh-package.json5所在目录为起点的相对路径
}
```

## 使用方式

````
import { CJCalendar } from 'cjcalendar'
````

````
CJCalendar()
````

## 一、各项属性

| 参数名 | 类型 | 必填 | 说明 |
|--|--|--|--|
| optMode | OptMode | 否 | 操作模式,常规、单选、一段时间、多选：默认：OptMode.NORMAL |
| startDate | Date | 否 | 开始日期：默认：new Date(1970, 0, 1)   |
| endDate | Date | 否 | 截止日期：默认：当前时间+10年 |
| titleHeight | Length | 否 | 标题栏高度：默认：50vp |
| titleFontSize | number \| string \| Resource| 否 | 标题字体大小，默认：18 |
| titleFontColor| ResourceColor | 否 | 标题字体颜色，默认："#252a34"  |
| titleBackgroundColor| ResourceColor | 否 | 标题背景颜色，默认：undefined  |
| titleBackgroundImage| PixelMap | ResourceStr | DrawableDescriptor | 否 | 标题背景图片，默认：undefined  |
| showFastToday| boolean | 否 | 是否显示快捷 今，默认：true |
| fastTodayFontSize| number \| string \| Resource| 否 | 快捷返回今天，字体大小，默认：12 |
| fastTodayFontColor| Resource| 否 | 快捷返回今天，字体颜色，默认："#FFFFFF"  |
| fastTodayBg| Resource| 否 | 快捷返回今天，背景颜色，默认与todayFontColor一致 |
| weeks| string[] | 否 | 星期标题，默认：["日","一","二","三","四","五","六",]   |
| weekTitleFontSize| number \| string \| Resource | 否 | 星期标题字体大小，默认：12 |
| weekTitleFontColor| ResourceColor | 否 | 星期标题字体颜色，默认："#9E9E9E"  |
| weekTitleBackgroundColor| ResourceColor | 否 | 星期标题背景色颜色，默认未设置  |
| weekTitleHeight| Length | 否 | 星期标栏高度，默认：40 |
| onlyShowCurrMonthDay | boolean | 否 | 是否仅显示当月日期，默认：false |
| showLunar| boolean | 否 | 是否显示农历，默认：false |
| showJieQi| boolean | 否 | 是否显示节气，显示农历下才支持，默认：false |
| showJieRi| boolean | 否 | 是否显示节日，显示农历下才支持，默认：false |
| selectedShape | SelectedShape | 否 |  默认选中样式形状，optMode = OptMode.MULTIPLE、OptMode.SINGLE 或者 optMode = OptMode.RANGE 且 selectedStyle = SelectedStyle.ALONE 、 时 SelectedShape.CIRCLE生效 否则 SelectedShape.RECT 生效 |
| optMode | OptMode | 否 | 操作类型，默认：NORMAL |
| defSelectedItems | Array<string | Date> | 否 | 默认选中日期 |
| rangeStyle | SelectedStyle | 否 | SelectedStyle.ALONE 独立风格，SelectedStyle.CLOSE 封闭风格，默认：SelectedStyle.ALONE 独立圆形选中风格 |
| cjCellStyle | CJCellStyle | 否 | 单元格样式 |
| controller | CJCalendarControl | 否 | 控制器 |

## 二、常用方法

| 方法 | 参数 | 返回|必填 | 说明 |
|--|--|--|--|--|
| cellLayout | item: CJDateItem | - | 否 | 自定义每一项布局 |
| cusCellMainLayout | item: CJDateItem,params: CellFontStyle | - | 否 | 仅自定义日期文字区 |
| selectedBackgroundLayout | item: CJDateItem | - | 否 | 仅自定义选中背景样式区 |
| titleCenterLayout | - | - | 否 | 自定义日期标题中心内容 |
| titleLeftLayout | - | - | 否 | 自定义日期标题左边内容 |
| titleRightLayout | - | - | 否 | 自定义日期标题右边内容 |
| toolbarLayout | item: CJDateItem | - | 否 | 仅自定义 今日 样式，当使用cellLayout时，tadayLayout无效 |
| reBuildCellItem | cjDateItem: CJDateItem | 否 | 重新构建Item，如需添加更多自定义属性时使用 |
| onSelectedChanged | items: Array<CJDateItem> | - | 否 | 选择变化监听，OptMode.NORMAL/OptMode.SINGLE,只返：一项；OptMode.RANGE：返回开始日期与截止日期,items[0]为开始时间，items[1]为结束时间；MULTIPLE：返回Array<CJDateItem>，已选中的日期 |
| buildCellStyle | cjDataItem: CJDateItem | - | 否 | 自定义构建每一项的样式 |
| onCellItemClick | item: CJDateItem | - | 否 | 点击日期事件响应 |
| onDisableCellItemClick | item: CJDateItem | - | 否 | 不能点击项的点击日期事件响应 |


## CJCellStyle属性

| 参数名 | 类型 | 必填 | 说明 |
|--|--|--|--|
| fontSize | number \| string \| Resource | 否 | 日期每一项字体大小，默认：18  |
| fontColor | Resource | 否 | 日期每一项字体颜色，默认："#252a34"  |
| fontFontWeight | Resource | 否 | 日期每一项字体，默认：FontWeight.Normal |
| todayFontColor | ResourceColor | 否 | “今”日字体颜色，默认："#03A9F4"  |
| disabledFontColor | ResourceColor | 否 | 不能使用的日期字体颜色，默认："#9E9E9E"  |
| selectFontColor | ResourceColor | 否 | 选中日期字体颜色，默认："#FFFFFF"  |
| selectItemBackgroundColor | ResourceColor | 否 | 选中日期背景颜色, 默认与todayFontColor一致 |
| itemBackgroundColor | ResourceColor | 否 | 默认日期背景颜色, 默认与todayFontColor一致 |
| lightRatio | number | 否 | RANGE 模式下生效，中间区域颜色变淡比例，范围：0-1, 默认0.85 |
| boderColor | ResourceColor | 否 | 边框颜色, 默认："#dbe2ef" |
| boderWidth | Length | 否 | 边框宽度, 默认：0 |
| boderRadius | Length | 否 | 边框圆角, 默认：0 |

## CJCalendarControl 控制器

| 方法 | 参数                                        | 说明                                                         |
|--|-------------------------------------------|------------------------------------------------------------|
| preMonth | -                                         | 上一个月                                                       |
| nextMonth | -                                         | 下一个月                                                       |
| backToday | -                                         | 回到今天                                                       |
| skipToMonth | Date \| string                            | 跳转到指定年月，“2016-08” / new Date(“2016-08-01”)                 |
| selectItems | items: Array<string \| Date> \| undefined | 触发选中指定日期项，items ["2024-06-07"] / [new Date(“2024-08-01”)]) |
| getItems | -                                         | 获取当前items                                                  |

## 三、CJDateItem通用属性

| 属性| 类型| 描述 |
|--|--|--|
| fullYear | number | 年 |
| month | number | 月 |
| date | number | 日期 |
| week | number | 星期 |
| time | number | 时间戳 |

## 四、OptMode 操作模式

| 属性 | 描述 |
|--|--|
| NORMAL | 常规 |
| SINGLE | 单选 |
| RANGE | 一段时间 |
| MULTIPLE | 多选 |

## 五、SelectedStyle 选中样式风格

| 属性 | 描述 |
|--|--|
| ALONE | 独立选中风格：默认圆形独立 |
| CLOSE | 封闭选中风格：默认举行封闭 |


## 五、使用案例
### 1、直接使用
```typescript
import { CJCalendar } from 'cjcalendar'
```

```typescript
CJCalendar()
```
![鸿蒙开发交流群二维码.png](https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtybbs/028/132/711/0900086000028132711.20240626150437.67743221377656491907523324351334:20240626150523:2800:DAFFCF5B1E8A7E4828639AFD060802481C082C4EF4EA6F25DE2C21E03BEEFEDC.jpeg)
![综合案例.png](https://atomgit.com/cj-open/CJOpenNext/raw/master/screenshots%2Fcjcalendar%2F00.gif)


## 综合案例
```typescript
    cjCalStatus: CJCalStatusParams = new CJCalStatusParams()
    cjCellStatus: CellStatus = new CellStatus()
    cjDataItem: CJDateItem = new CJDateItem(new Date())
    controller: CJCalendarControl = new CJCalendarControl()


    CJCalendar({
        controller: this.controller,
        // 初始化默认选中项目
        // defSelectedItems: ["2024-06-03", "2024-06-08"],
        selectedStyle: SelectedStyle.ALONE,
        optMode: OptMode.NORMAL,
        startDate: new Date("2024-04-20"),
        endDate: new Date("2024-06-20"),
        // 单元格选中样式
        cjCellStyle: new CJCellStyle(),
        // 默认选中样式形状，optMode = OptMode.MULTIPLE、OptMode.SINGLE
        // 或者 optMode = OptMode.RANGE 且 selectedStyle = SelectedStyle.ALONE 、
        // 时 SelectedShape.CIRCLE生效
        // 否则 SelectedShape.RECT 生效
        selectedShape: SelectedShape.CIRCLE,
        showFastToday: true,
        // titleHeight: 100,
        // 标题栏背景色
        // titleBackgroundColor: Color.Green,
        // 是否显示农历
        showLunar: true,
        // 是否显示节日
        // showJieRi: false,
        // 是否显示节气
        // showJieQi: false,
        // 是否仅显示当月日期
        // onlyShowCurrMonthDay: true,
        // 自定义标题栏
        toolbarLayout: this.ToolbarLayout,
        // 自定义单元格背景
        // buildCellBackground: this.BuildCellBackground,
        onMonthChanged: (month: Date) => {
          console.log("月份切换：", JSON.stringify(month))
        },
        onCellItemClick: (item: CJDateItem) => {
          // 这里修改数据后会同步更新到界面
          // item.date = item.date + 1
          // item.extras.set("test", "-" + (item.date + 1) + "-")
          console.log("点击了：", JSON.stringify(item))
        },
        onDisableCellItemClick: (item: CJDateItem) => {
          console.log("越界点击了：", JSON.stringify(item))
        },
        onSelectedChanged: (items: Array<CJDateItem>) => {
          console.log("选择变化：", JSON.stringify(items))
        },
        // 自定义主体部分
        // buildCellBody: this.BuildCellBody,
        // 向CellItem中添加自定义属性
        // reBuildCellItem: (cjDateItem: CJDateItem) => {
        //   // 需要向 CJDateItem 中添加附加数据时，可是使用如下方式
        //   cjDateItem.extras.set("test", "-" + cjDateItem.date + "-")
        //   return cjDateItem
        // },
    
        // 自定义Cell样式风格
        // buildCellStyle: (item: CJDateItem) => {
        //   let cjCellStyle: CJCellStyle = new CJCellStyle()
        //   if (item.date < 7) {
        //     cjCellStyle.itemBackgroundColor = "#abedd8"
        //     cjCellStyle.fontColor = "#3f72af"
        //   } else if (item.date >= 10 && item.date < 16) {
        //     cjCellStyle.itemBackgroundColor = "#e4f9f5"
        //     cjCellStyle.fontColor = "#3d84a8"
        //   } else if (item.date >= 20 && item.date <= 28) {
        //     cjCellStyle.itemBackgroundColor = "#88304e"
        //     cjCellStyle.fontColor = "#fae3d9"
        //   }
        //   return cjCellStyle
        // }
      })

    @Builder
    ToolbarLayout() {
      Column() {
        Row() {
          Button("上一月")
            .onClick(() => {
              this.controller.preMonth()
            })
          Blank()
          Text(this.cjCalStatus.title)
            .fontColor(Color.White)
          Text("2024-03")
            .onClick(() => {
              this.controller.skipToMonth(new Date("2022-03-01"))
            })
          Blank()
          Button("下一月")
            .onClick(() => {
              this.controller.nextMonth()
            })
        }
        .width("100%")
    
        Text("此处可添加广告位")
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .width("100%")
          .height(100)
          .backgroundColor(Color.Pink)
      }
      .backgroundColor(Color.Orange)
        .width("100%")
    
    }
    
    @Builder
    TestTitle() {
    
      // 这里的 this 指向子组件，
      // 想要在这里同时使用父组件的数据该怎样操作
    
    
      Text(this.cjCalStatus.title)
    }
    
    @Builder
    BuildCellBackground() {
      if (this.cjDataItem.isToday) { // 今天
        Column()
          .backgroundColor(Color.Yellow)
          .width('85%')
          .aspectRatio(1)
          .border({
            width: this.cjCellStyle.boderWidth,
            color: this.cjCellStyle.boderColor
          })
          .borderRadius(this.cjCellStyle.boderRadius)
      } else {
        Column()
          .backgroundColor(this.cjCellStatus.backgroundColor)
          .width('85%')
          .aspectRatio(1)
          .border({
            width: this.cjCellStyle.boderWidth,
            color: this.cjCellStyle.boderColor
          })
          .borderRadius(this.cjCellStyle.boderRadius)
      }
    
    }
    
    @Builder
    BuildCellBody() {
      Column() {
        Text(this.cjDataItem.date + '')
          .fontColor(this.cjCellStatus.fontColor)
          .fontSize(this.cjCellStyle.fontSize)
          .fontWeight(this.cjCellStyle.fontFontWeight)
        Text(this.cjDataItem.extras.get("test") as string)
          .fontSize(10)
          .fontColor(Color.Gray)
          .fontColor(this.cjCellStatus.fontColor)
      }
      .alignItems(HorizontalAlign.Center)
    
    }

```


### 移驾学习交流群
![鸿蒙开发交流群二维码.png](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtybbs/028/132/711/0900086000028132711.20240626150437.67743221377656491907523324351334:50001231000000:2800:018E153B1410499CC6E1CA52D13D590D824CE468FCDAD6F1FBA705E318C32509.jpeg)


这只是冰山一脚，

还有很多功能可自行探索
。。。。。。


