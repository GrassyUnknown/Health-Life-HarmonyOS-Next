/**
 * 操作模式
 */
import { CJDateItem } from './CJDateItem'
import { ColorUtil } from '../../utils/ColorUtil'
import { Solar } from 'lunar'
import { CJCellStyle } from './CJCellStyle'
import { OptMode } from './OptMode'
import { SelectedStyle } from './SelectedStyle'
import { CJDay } from './CJDay'
import { CJCalendarControl } from './CJCalendarControl'
import { SelectedShape } from './SelectedShape'
import { CJCalStyle } from './CJCalStyle'
import { CellStatus } from './CellStatus'
import { CJCalStatusParams } from './CJCalStatusParams'
import { CJMonth } from './CJMonth'

function getLunarDesc(cjDataItem: CJDateItem, showJieQi: boolean | undefined, showJieRi: boolean | undefined): string {
  try {
    if (cjDataItem.solar) {
      if (showJieRi && cjDataItem.solar.getLunar().getFestivals().length > 0) {
        return cjDataItem.solar.getLunar().getFestivals().join()
      }
      if (showJieQi && cjDataItem.solar.getLunar().getJieQi()) {
        return cjDataItem.solar.getLunar().getJieQi()
      }
      return cjDataItem.solar.getLunar().getDayInChinese()
    }
  } catch (e) {

  }
  return ""
}


@Component
export struct CJCalendarV2 {
  @Provide @Watch("__onStatusChange") cjCalStatus: CJCalStatusParams = new CJCalStatusParams()
  @Provide @Watch("__onSelectedChanged") selectedItems: Array<CJDateItem> = new Array()
  @State months: Array<CJDateItem> = new Array()
  // 缓存月数
  cacheMaonthCount: number = 1
  // 初始化默认选中日期：["2024-06-07"]
  defSelectedItems: Array<string | Date> | undefined
  /** 默认选中形状 */
  selectedShape: SelectedShape = SelectedShape.RECT
  controller: CJCalendarControl = new CJCalendarControl()
  //================
  today: CJDateItem = new CJDateItem(new Date())
  // 当前显示月份
  currMonth: Date = new Date()
  /** 操作模式 */
  optMode: OptMode = OptMode.NORMAL
  startDate: Date = new Date("1970-01-01")
  endDate: Date = new Date(this.currMonth.getFullYear() + 10, 0, 1)
  selectedStyle: SelectedStyle = SelectedStyle.ALONE
  /** 样式 */
  calStyle: CJCalStyle = new CJCalStyle()
  cjDataItem: CJDateItem = new CJDateItem(new Date())
  weeks: string[] = [
    "日",
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
  ]
  /** 星期标题字体大小 */
  weekTitleFontSize: number | string | Resource = 13
  /** 星期标题字体颜色 */
  weekTitleFontColor: ResourceColor = "#9E9E9E"
  weekTitleBackgroundColor: ResourceColor = "#00000000"
  // 星期标栏高度
  weekTitleHeight: Length = 40
  // =====theme======
  // themeColor: ResourceColor = "#03A9F4"
  itemFontColor: ResourceColor = "#252a34"
  cjCellStatus: CellStatus = new CellStatus()
  cjCellStyle: CJCellStyle = new CJCellStyle()
  // 不能使用的日期字体颜色
  disabledFontColor: ResourceColor = "#9E9E9E"
  // 标题栏高度
  titleHeight: Length = 50
  titleBackgroundColor: ResourceColor | undefined
  titleBackgroundImage: PixelMap | ResourceStr | DrawableDescriptor | undefined
  // 标题年月格式化,默认：yyyy-MM
  titleFormat: string = ""
  // 标题字体大小
  titleFontSize: number | string | Resource = 18
  // 标题字体颜色
  titleFontColor: ResourceColor = "#252a34"
  // 是否显示快捷 今
  showFastToday: boolean = true
  fastTodayFontSize: number | string | Resource = 12
  fastTodayFontColor: ResourceColor = "#FFFFFF"
  fastTodayBackgroundColor: ResourceColor = "#03A9F4"
  // 是否仅显示当月日期
  @Provide onlyShowCurrMonthDay: boolean = false
  // 是否显示农历
  @Provide showLunar: boolean = false
  @Provide showJieQi: boolean | undefined = undefined
  @Provide showJieRi: boolean | undefined = undefined
  /** 状态改变回调 */
  onStatusChange: (cjCalStatus: CJCalStatusParams) => void = () => {
    console.log("状态变化：", JSON.stringify(this.cjCalStatus))
  }
  /** 自定义构建每一项的样式 */
  buildCellStyle: (cjDataItem: CJDateItem) => CJCellStyle = (cjDataItem: CJDateItem) => {
    return new CJCellStyle()
  }
  /**
   * 选择改变监听，
   */
  onSelectedChanged: (items: Array<CJDateItem>) => void = () => {

  }
  /**
   * 点击日期事件响应
   */
  onCellItemClick: (item: CJDateItem) => void = () => {
  }
  /**
   * 不能点击项的点击日期事件响应
   */
  onDisableCellItemClick: (item: CJDateItem) => void = () => {
  }
  /**
   * 月份切换
   */
  onMonthChanged: (month: Date) => void = () => {
  }
  /**
   * 重新构建Item
   */
  reBuildCellItem: (cjDateItem: CJDateItem) => CJDateItem = (cjDateItem: CJDateItem) => {
    return cjDateItem
  }
  // ========自定义布局==========
  /** 构建整体标题栏 */
  @BuilderParam toolbarLayout: CustomBuilder = this.ToolbarLayout
  /** 仅构建标题栏背景 */
  @BuilderParam buildToolbarLayoutBackground: CustomBuilder = this.ToolbarLayoutBackground
  /** 构建单元格背景 */
  @BuilderParam buildCellBackground: CustomBuilder = this.BuildCellBackground
  /** 构建单元格主体内容 */
  @BuilderParam buildCellBody: CustomBuilder = this.BuildCellBody

  aboutToAppear() {
    this.__initAttrs()
    // this.buildCellBackground.bind(this)
    // 初始化其他参数
    // this.fastTodayBackgroundColor = this.themeColor
    this.cjCalStatus.showFastToday = this.showFastToday

    // 初始化日期项
    this.__initDays()
  }

  /**
   * 初始化属性
   */
  __initAttrs() {
    // 初始化农历相关属性
    if (this.showLunar) {
      if (this.showJieQi == undefined) {
        this.showJieQi = true
      }
      if (this.showJieRi == undefined) {
        this.showJieRi = true
      }
    }

    // 初始化defSelectedItems
    if (this.defSelectedItems && this.defSelectedItems.length > 0) {
      if (this.optMode == OptMode.SINGLE) {
        if (typeof this.defSelectedItems[0] == "string") {
          this.selectedItems.push(new CJDateItem(new Date(this.defSelectedItems[0])))
        } else {
          this.selectedItems.push(new CJDateItem(this.defSelectedItems[0]))
        }
      } else if (this.optMode == OptMode.MULTIPLE) {
        this.defSelectedItems.forEach((item: string | Date) => {
          if (typeof item == "string") {
            this.selectedItems.push(new CJDateItem(new Date(item)))
          } else {
            this.selectedItems.push(new CJDateItem(item))
          }
        })
      } else if (this.optMode == OptMode.RANGE) {
        if (typeof this.defSelectedItems[0] == "string") {
          this.selectedItems.push(new CJDateItem(new Date(this.defSelectedItems[0])))
        } else {
          this.selectedItems.push(new CJDateItem(this.defSelectedItems[0]))
        }
        if (typeof this.defSelectedItems[1] == "string") {
          this.selectedItems.push(new CJDateItem(new Date(this.defSelectedItems[1])))
        } else {
          this.selectedItems.push(new CJDateItem(this.defSelectedItems[1]))
        }
      }
    }

    // 操作模式初始化
    if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) {
      if (this.selectedItems && this.selectedItems.length > 0) {
        this.selectedItems.splice(0, this.selectedItems.length)
      }
      this.selectedItems.push(new CJDateItem(new Date()))
    }

    // 初始化ctroller
    if (!this.controller) {
      this.controller = new CJCalendarControl()
    }
    // this.controller.bind(this)
  }

  aboutToDisappear() {
    this.controller.unbind()
  }

  build() {
    Column() {
      // this.testTitle()
      // 顶部导航
      if (this.toolbarLayout) {
        this.toolbarLayout()
      }
      // 星期
      this.WeekLayout()
      // 日期
      this.BodyLayout()
    }
    .width('100%')

  }

  @Builder
  BuildCellBackground() {
    if (this.optMode == OptMode.NORMAL ||
      this.optMode == OptMode.MULTIPLE ||
      this.optMode == OptMode.SINGLE) {
      if (this.selectedShape == SelectedShape.CIRCLE) { // 圆形
        Column()
          .backgroundColor(this.cjCellStatus.backgroundColor)
          .width('90%')
          .aspectRatio(1)
          .border({
            width: this.cjCellStyle.boderWidth,
            color: this.cjCellStyle.boderColor,
            radius: 200
          })
        // .borderRadius(this.cjCellStyle.boderRadius)
      } else if (this.selectedShape == SelectedShape.RECT) { // 矩形
        Column()
          .backgroundColor(this.cjCellStatus.backgroundColor)
          .width('90%')
          .aspectRatio(1)
          .border({
            width: this.cjCellStyle.boderWidth,
            color: this.cjCellStyle.boderColor
          })
          .borderRadius(this.cjCellStyle.boderRadius)
      }
    } else if (this.optMode == OptMode.RANGE) {
      if (this.selectedStyle == SelectedStyle.ALONE) { // 独立
        if (this.selectedShape == SelectedShape.CIRCLE) {
          Column()
            .backgroundColor(this.cjCellStatus.backgroundColor)
            .width('90%')
            .aspectRatio(1)
            .border({
              width: this.cjCellStyle.boderWidth,
              color: this.cjCellStyle.boderColor,
              radius: 200
            })
          // .borderRadius(this.cjCellStyle.boderRadius)
        } else if (this.selectedShape == SelectedShape.RECT) {
          Column()
            .backgroundColor(this.cjCellStatus.backgroundColor)
            .width('90%')
            .aspectRatio(1)
            .border({
              width: this.cjCellStyle.boderWidth,
              color: this.cjCellStyle.boderColor
            })
            .borderRadius(this.cjCellStyle.boderRadius)
        }
      } else {
        Column()
          .backgroundColor(this.cjCellStatus.backgroundColor)
          .width('100%')
          .height("90%")// .aspectRatio(1)
          .border({
            width: this.cjCellStyle.boderWidth,
            color: this.cjCellStyle.boderColor
          })
          .borderRadius({
            topLeft: this.cjCellStatus.isStart ? this.cjCellStyle.boderRadius : 0,
            topRight: this.cjCellStatus.isEnd ? this.cjCellStyle.boderRadius : 0,
            bottomLeft: this.cjCellStatus.isStart ? this.cjCellStyle.boderRadius : 0,
            bottomRight: this.cjCellStatus.isEnd ? this.cjCellStyle.boderRadius : 0
          })
        // .borderRadius(this.cjCellStyle.boderRadius)
      }

    }

    // Text(this.selectedStyle + "")
  }

  @Builder
  BuildCellBody() {
    Column() {
      Text(this.cjDataItem.date + '')
        .fontColor(this.cjCellStatus.fontColor)
        .fontSize(this.cjCellStatus.fontSize)
        .fontWeight(this.cjCellStyle.fontFontWeight)
      if (this.showLunar && this.cjDataItem.solar) {
        Text(getLunarDesc(this.cjDataItem, this.showJieQi, this.showJieRi))
          .fontSize(this.cjCellStyle.lunarFontSize)
          .fontColor(this.cjCellStatus.fontColor)
          .fontWeight(this.cjCellStyle.lunarFontFontWeight)
          .margin({
            top: 2
          })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ToolbarLayoutBackground() {
    if (this.titleBackgroundImage) {
      Image(this.titleBackgroundImage)
        .width("100%")
        .height("100%")
        .objectFit(ImageFit.Fill)
    }
    if (this.titleBackgroundColor) {
      Row()
        .width("100%")
        .height("100%")
        .backgroundColor(this.titleBackgroundColor)
    }

  }

  @Builder
  ToolbarLayout() {
    Stack() {
      if (this.buildToolbarLayoutBackground) {
        this.buildToolbarLayoutBackground()
      }
      Row() {
        Image($r("app.media.ic_public_arrow_left"))
          .width(28)
          .fillColor(this.cjCalStatus.hasPre ? this.itemFontColor : this.disabledFontColor)
          .aspectRatio(1)
          .onClick(() => {
            // this.cjCalStatus.title = "2024-04"
            this.controller.preMonth()
          })

        Blank()

        Row() {
          Text(this.cjCalStatus.title)
            .fontSize(this.titleFontSize)
            .fontColor(this.titleFontColor)

          if (this.showFastToday && !this.cjCalStatus.showFastToday) {
            Text("今")
              .fontSize(this.fastTodayFontSize)
              .fontColor(this.fastTodayFontColor)
              .backgroundColor(this.fastTodayBackgroundColor)
              .borderRadius(50)
              .padding(4)
              .margin({ left: 4 })
              .onClick(() => {
                this.controller.backToday()
              })
          }
        }

        Blank()

        Image($r("app.media.ic_public_arrow_right_filled"))
          .width(28)
          .fillColor(this.cjCalStatus.hasNext ? this.itemFontColor : this.disabledFontColor)
          .aspectRatio(1)
          .onClick(() => {
            // this.cjCalStatus.title = "2024-06"
            this.controller.nextMonth()
          })
      }
      .width('100%')
      .height("100%")
      .backgroundColor("#00000000")
      .alignItems(VerticalAlign.Center)
    }
    .width("100%")
    .height(this.titleHeight)
  }

  @Builder
  WeekLayout() {
    Row() {
      ForEach(this.weeks, (item: string, index) => {
        this.WeekCell(item)
      })
    }
    .backgroundColor(this.weekTitleBackgroundColor)
    .alignItems(VerticalAlign.Center)
    .height(this.weekTitleHeight)

  }

  @Builder
  WeekCell(week: string) {
    Text(week)
      .textAlign(TextAlign.Center)
      .fontColor(this.weekTitleFontColor)
      .fontSize(this.weekTitleFontSize)
      .layoutWeight(1)
  }

  @Builder
  MonthLayout(item: CJDateItem) {
    Column() {
      CJMonth({
        // cjDataItem: item,
        startDate: this.startDate,
        endDate: this.endDate,
        month: item,
        today: this.today,
        optMode: this.optMode,
        // cjCalStatus: this.cjCalStatus,
        // themeColor: this.themeColor,
        cjCellStyle: this.cjCellStyle,
        selectedStyle: this.selectedStyle,
        selectedShape: this.selectedShape,
        // buildCellBackground: (item: CJDateItem, cjCellStyle: CJCellStyle, cjCellStatus: CellStatus) => {
        //   this.buildCellBackground(item, cjCellStyle, cjCellStatus)
        // },
        buildCellBackground: this.buildCellBackground,
        buildCellBody: this.buildCellBody,
        cellClick: (cellItem: CJDateItem) => {
          if (cellItem.isPre) {
            if (this.controller) {
              this.controller.preMonth()
            }
          } else if (cellItem.isNext) {
            if (this.controller) {
              this.controller.nextMonth()
            }
          }
          if (cellItem.smallThan(new CJDateItem(this.startDate)) ||
          cellItem.bigThan(new CJDateItem(this.endDate))) {
            if (this.onDisableCellItemClick) {
              this.onDisableCellItemClick(cellItem)
            } else {
              if (this.onCellItemClick) {
                this.onCellItemClick(cellItem)
              }
            }
          } else {
            if (this.onCellItemClick) {
              this.onCellItemClick(cellItem)
            }
          }
          this.onSelectedChanged(this.selectedItems)
        },
      })

    }
    .width('100%')
  }

  @Builder
  BodyLayout() {
    Stack() {
      ForEach(this.months, (item: CJDateItem, index: number) => {
        this.MonthLayout(item)
      }, (item: CJDateItem) => item.time.toString())
    }
    .clip(true)
    .width('100%')
  }

  __onStatusChange() {
    this.onStatusChange(this.cjCalStatus)
  }

  __onSelectedChanged() {
    this.onSelectedChanged(this.selectedItems)
  }

  /**
   * 上一月
   */
  __preMonth() {
    if (!this.cjCalStatus.hasPre) {
      return
    }
    this.currMonth.setMonth(this.currMonth.getMonth() - 1)
    this.__calcMonthDays(this.currMonth)
    if (this.onMonthChanged) {
      this.onMonthChanged(this.currMonth)
    }
  }

  /**
   * 下一月
   */
  __nextMonth() {
    if (!this.cjCalStatus.hasNext) {
      return
    }
    this.currMonth.setMonth(this.currMonth.getMonth() + 1)
    this.__calcMonthDays(this.currMonth)
    if (this.onMonthChanged) {
      this.onMonthChanged(this.currMonth)
    }
  }

  /**
   * 回到今天
   */
  __backToday() {
    this.currMonth.setMonth(new Date().getMonth())
    this.__calcMonthDays(this.currMonth)
    if (this.onMonthChanged) {
      this.onMonthChanged(this.currMonth)
    }
  }

  /**
   * 跳转至指定的年月份
   * @param month “2016-08” / new Date(“2016-08”)
   */
  __skipToMonth(month: Date | string) {
    if (typeof month == "string") {
      this.currMonth.setFullYear(Number.parseInt(month.substring(0, 4)))
      this.currMonth.setMonth(Number.parseInt(month.substring(5, 7)) - 1)
    } else {
      this.currMonth.setTime(month.getTime())
    }

    this.__calcMonthDays(this.currMonth)
    if (this.onMonthChanged) {
      this.onMonthChanged(this.currMonth)
    }
  }

  /**
   * 初始化日期项
   */
  __initDays() {
    this.__calcMonthDays(this.currMonth)
  }

  /**
   * 计算指定月份的所有日期
   */
  __calcMonthDays(month: Date) {
    month.setDate(1)
    this.cjCalStatus.title = month.getFullYear() + "-" + (month.getMonth() + 1).toString().padStart(2, "0")

    // 是否有上一月
    if (month.getFullYear() < this.startDate.getFullYear()
      || (month.getFullYear() == this.startDate.getFullYear() && month.getMonth() <= this.startDate.getMonth())) {
      this.cjCalStatus.hasPre = false
    } else {
      this.cjCalStatus.hasPre = true
    }

    // 是否有下一月
    if (month.getFullYear() > this.endDate.getFullYear()
      || (month.getFullYear() == this.endDate.getFullYear() && month.getMonth() >= this.endDate.getMonth())) {
      this.cjCalStatus.hasNext = false
    } else {
      this.cjCalStatus.hasNext = true
    }

    // 是否是当前月
    if (this.today.fullYear == month.getFullYear() && this.today.month == month.getMonth()) {
      this.cjCalStatus.showFastToday = true
    } else {
      this.cjCalStatus.showFastToday = false
    }

    this.months.splice(0, 1)
    this.months.push(new CJDateItem(month))
  }
}