import { SelectedShape } from '../components/SelectedShape'
import { OptMode } from '../components/OptMode'
import { SelectedStyle } from '../components/SelectedStyle'
import { CJCalStyle } from '../components/CJCalStyle'
import { CJCellStyle } from '../components/CJCellStyle'
import { CJDay } from '../components/CJDay'
import { CJCalendarControl } from '../components/CJCalendarControl'
import { CellStatus } from '../components/CellStatus'
import { CJCalStatusParams } from '../components/CJCalStatusParams'

// import { CJCalendar as CJCalendarV2 } from '../components/CJCalendarV2';
import { CJCalendar } from '../components/CJCalendar';
import { CJDateItem } from '../components/CJDateItem';
import { Solar } from 'lunar';
import { CJCalendarV2 } from '../components/CJCalendarV2'

@Component
@Entry
export struct MainPage {
  @State message: string = 'Hello World';
  today11 = new Date()
  cjCellStyle: CJCellStyle = new CJCellStyle()
  cjCalStatus: CJCalStatusParams = new CJCalStatusParams()
  cjCellStatus: CellStatus = new CellStatus()
  cjDataItem: CJDateItem = new CJDateItem(new Date())
  controller: CJCalendarControl = new CJCalendarControl()
  @State defSelectedItems: Array<string> = ["2024-06-03", "2024-06-08"]

  build() {
    Column() {
      Text("日历Demo")
        .height(50)
        .textAlign(TextAlign.Center)
      Scroll() {
        Column() {
          // CJCalendar({
          //   controller: this.controller,
          //   // extras:
          //   // 初始化默认选中项目
          //   defSelectedItems: this.defSelectedItems,
          //   selectedStyle: SelectedStyle.ALONE,
          //   // optMode: OptMode.RANGE,
          //   startDate: new Date("2024-05-20"),
          //   endDate: new Date("2024-07-20"),
          //   // 单元格选中样式
          //   cjCellStyle: this.cjCellStyle,
          //   // 默认选中样式形状，optMode = OptMode.MULTIPLE、OptMode.SINGLE
          //   // 或者 optMode = OptMode.RANGE 且 selectedStyle = SelectedStyle.ALONE 、
          //   // 时 SelectedShape.CIRCLE生效
          //   // 否则 SelectedShape.RECT 生效
          //   selectedShape: SelectedShape.RECT,
          //   showFastToday: true,
          //   // titleHeight: 100,
          //   // 标题栏背景色
          //   // titleBackgroundColor: Color.Green,
          //   // 是否显示农历
          //   showLunar: true,
          //   // 是否显示节日
          //   // showJieRi: false,
          //   // 是否显示节气
          //   // showJieQi: false,
          //   // 是否仅显示当月日期
          //   // onlyShowCurrMonthDay: true,
          //   // 自定义标题栏
          //   toolbarLayout: this.ToolbarLayout,
          //   // 自定义单元格背景
          //   // buildCellBackground: this.BuildCellBackground,
          //   onMonthChanged: (month: Date) => {
          //     console.log("月份切换：", JSON.stringify(month))
          //   },
          //   onCellItemClick: (item: CJDateItem) => {
          //     // 这里修改数据后会同步更新到界面
          //     // item.date = item.date + 1
          //     // item.extras.set("test", "-" + (item.date + 1) + "-")
          //     console.log("点击了：", JSON.stringify(item))
          //   },
          //   onDisableCellItemClick: (item: CJDateItem) => {
          //     console.log("越界点击了：", JSON.stringify(item))
          //   },
          //   onSelectedChanged: (items: Array<CJDateItem>) => {
          //     console.log("选择变化：", JSON.stringify(items))
          //   },
          //   // 自定义主体部分
          //   buildCellBody: this.BuildCellBody,
          //   // 向CellItem中添加自定义属性
          //   reBuildCellItem: (cjDateItem: CJDateItem) => {
          //     // 需要向 CJDateItem 中添加附加数据时，可是使用如下方式
          //     cjDateItem.extras.set("test", "自定义" + cjDateItem.date)
          //     return cjDateItem
          //   },
          //
          //   // 自定义Cell样式风格
          //   buildCellStyle: (item: CJDateItem) => {
          //     let cjCellStyle: CJCellStyle = new CJCellStyle()
          //     // cjCellStyle.boderRadius = 100
          //     // item.
          //     if (item.date < 7) {
          //       cjCellStyle.itemBackgroundColor = "#abedd8"
          //       cjCellStyle.fontColor = "#3f72af"
          //     } else if (item.date >= 10 && item.date < 16) {
          //       cjCellStyle.itemBackgroundColor = "#e4f9f5"
          //       cjCellStyle.fontColor = "#3d84a8"
          //     } else if (item.date >= 20 && item.date <= 28) {
          //       cjCellStyle.itemBackgroundColor = "#88304e"
          //       cjCellStyle.fontColor = "#fae3d9"
          //     }
          //     return cjCellStyle
          //   }
          // })

          CJCalendarV2({
            controller: this.controller,
            // extras:
            // 初始化默认选中项目
            defSelectedItems: this.defSelectedItems,
            selectedStyle: SelectedStyle.ALONE,
            optMode: OptMode.RANGE,
            startDate: new Date("2024-05-20"),
            endDate: new Date("2024-07-20"),
            // 单元格选中样式
            cjCellStyle: this.cjCellStyle,
            // 默认选中样式形状，optMode = OptMode.MULTIPLE、OptMode.SINGLE
            // 或者 optMode = OptMode.RANGE 且 selectedStyle = SelectedStyle.ALONE 、
            // 时 SelectedShape.CIRCLE生效
            // 否则 SelectedShape.RECT 生效
            selectedShape: SelectedShape.RECT,
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
            buildCellBody: this.BuildCellBody,
            // 向CellItem中添加自定义属性
            reBuildCellItem: (cjDateItem: CJDateItem) => {
              // 需要向 CJDateItem 中添加附加数据时，可是使用如下方式
              cjDateItem.extras.set("test", "自定义" + cjDateItem.date)
              return cjDateItem
            },

            // 自定义Cell样式风格
            buildCellStyle: (item: CJDateItem) => {
              let cjCellStyle: CJCellStyle = new CJCellStyle()
              // cjCellStyle.boderRadius = 100
              // item.
              if (item.date < 7) {
                cjCellStyle.itemBackgroundColor = "#abedd8"
                cjCellStyle.fontColor = "#3f72af"
              } else if (item.date >= 10 && item.date < 16) {
                cjCellStyle.itemBackgroundColor = "#e4f9f5"
                cjCellStyle.fontColor = "#3d84a8"
              } else if (item.date >= 20 && item.date <= 28) {
                cjCellStyle.itemBackgroundColor = "#88304e"
                cjCellStyle.fontColor = "#fae3d9"
              }
              return cjCellStyle
            }
          })

        }
        .justifyContent(FlexAlign.Start)
      }
      .align(Alignment.Top)
      .layoutWeight(1)
    }
    .height("100%")
  }

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
          .onClick(() => {
            console.log("测试", "点击率")
            let datas = this.controller.getItems()
            if (datas) {
              console.log("测试", "点击11")
              datas[0].date = 29
              datas[0].extras.set("test", "测试")
            }
          })
        Blank()
        Button("下一月")
          .onClick(() => {
            // this.controller.nextMonth()

            console.log("===========")
            this.defSelectedItems = ["2024-06-05", "2024-06-13"]
            this.controller.skipToMonth("2024-06-01")

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
}
