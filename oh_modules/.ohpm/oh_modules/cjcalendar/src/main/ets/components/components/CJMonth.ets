import { Solar } from 'lunar'
import { CJDateItem } from './CJDateItem'
import { SelectedShape } from './SelectedShape'
import { OptMode } from './OptMode'
import { SelectedStyle } from './SelectedStyle'
import { CJCalStyle } from './CJCalStyle'
import { CJCellStyle } from './CJCellStyle'
import { CJDay } from './CJDay'
import { CJCalendarControl } from './CJCalendarControl'
import { CellStatus } from './CellStatus'
import { CJCalStatusParams } from './CJCalStatusParams'

@Component
export struct CJMonth {
  @Consume selectedItems: Array<CJDateItem>
  @State days: Array<CJDateItem> = new Array()
  month: CJDateItem | undefined
  today: CJDateItem = new CJDateItem(new Date())
  startDate: Date = new Date("1970-01-01")
  endDate: Date = new Date(this.today.fullYear + 10, 0, 1)
  //======================

  // 缓存月数
  cacheMaonthCount: number = 1
  // 初始化默认选中日期：["2024-06-07"]
  defSelectedItems: Array<string | Date> | undefined
  /** 默认选中形状 */
  selectedShape: SelectedShape = SelectedShape.RECT
  //================
  /** 操作模式 */
  optMode: OptMode = OptMode.NORMAL
  selectedStyle: SelectedStyle = SelectedStyle.ALONE
  /** 样式 */
  calStyle: CJCalStyle = new CJCalStyle()
  cjDataItem: CJDateItem = new CJDateItem(new Date())
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
  @Consume onlyShowCurrMonthDay: boolean
  // 是否显示农历
  @Consume showLunar: boolean
  @Consume showJieQi: boolean | undefined
  @Consume showJieRi: boolean | undefined
  /** 自定义构建每一项的样式 */
  buildCellStyle: (cjDataItem: CJDateItem) => CJCellStyle = () => {
    return new CJCellStyle()
  }
  cellClick: (cjDataItem: CJDateItem) => void = () => {
  }
  /**
   * 选择改变监听，
   */
  onSelectedChanged: (items: Array<CJDateItem>) => void = () => {

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
  /** 构建单元格背景 */
  @BuilderParam buildCellBackground: CustomBuilder = this.BuildCellBackground
  /** 构建单元格主体内容 */
  @BuilderParam buildCellBody: CustomBuilder = this.BuildCellBody

  aboutToAppear(): void {
    if (this.month) {
      this.__calcMonthDays(new Date(this.month.time))
    }
  }

  @Builder
  BuildCellBackground() {
  }

  @Builder
  BuildCellBody() {
  }

  build() {
    Column() {
      Flex({
        wrap: FlexWrap.Wrap
      }) {
        ForEach(this.days, (item: CJDateItem, index: number) => {
          CJDay({
            cjDataItem: item,
            today: this.today,
            optMode: this.optMode,
            // cjCalStatus: this.cjCalStatus,
            // themeColor: this.themeColor,
            cjCellStyle: this.buildCellStyle(item),
            selectedStyle: this.selectedStyle,
            selectedShape: this.selectedShape,
            // buildCellBackground: (item: CJDateItem, cjCellStyle: CJCellStyle, cjCellStatus: CellStatus) => {
            //   this.buildCellBackground(item, cjCellStyle, cjCellStatus)
            // },
            buildCellBackground: this.buildCellBackground,
            buildCellBody: this.buildCellBody,
            cellClick: (cjDataItem: CJDateItem) => {
              this.cellClick(cjDataItem)
            }
          })
            .width("14.28%")
            .margin({ bottom: this.calStyle.rowSpace })
        })
      }
      .width("100%")
    }
    .width('100%')
  }

  /**
   * 计算指定月份的所有日期
   */
  __calcMonthDays(month: Date) {
    month.setDate(1)
    if (this.days.length > 0) {
      this.days.splice(0, this.days.length)
    }
    // 计算第一个月
    // 获取第一个月总天数
    let endDay: Date = new Date(
      month.getFullYear(),
      month.getMonth() + 1,
      0, 23, 59, 59)

    console.log("endDay：", endDay.getFullYear() + "-" + (endDay.getMonth() + 1) + "-" + endDay.getDate())
    // TimeConversionTool.formatDateTime()

    let tempDate: Date = new Date(month)

    console.log("tempDate：", tempDate.getFullYear() + "-" + (tempDate.getMonth() + 1) + "-" + tempDate.getDate())
    console.log("tempDate 星期：", tempDate.getDay())

    const count = endDay.getDate()
    const preCount = month.getDay()
    const nextCount = 6 - endDay.getDay()
    const finilCount = count + preCount + nextCount

    // 补齐上一个月
    tempDate.setDate(tempDate.getDate() - preCount)
    console.log("补齐上一个月 tempDate：", tempDate.getFullYear() + "-" + (tempDate.getMonth() + 1) + "-" + tempDate.getDate())

    // 添加日期
    for (let index = 0; index < finilCount; index++) {
      let item = new CJDateItem(
        tempDate,
        (index < preCount ? true : false) || this.startDate.getTime() > tempDate.getTime(),
        (index >= preCount + count ? true : false) || this.endDate.getTime() < tempDate.getTime()
      )
      item.isSmallThanStart = index < preCount
      item.isBigThanEnd = index >= preCount + count
      console.log("date:", item.date, ",isSmallThanStart:", item.isSmallThanStart, ",isBigThanEnd:", item.isBigThanEnd)
      item.isToday = tempDate.getFullYear() == this.today.fullYear && tempDate.getMonth() == this.today.month && tempDate.getDate() == this.today.date
      if (this.reBuildCellItem) {
        item = this.reBuildCellItem(item)
      }
      if (this.showLunar) { // 显示农历
        item.solar = Solar.fromYmd(item.fullYear, item.month + 1, item.date)
      }
      // this.reBuildDateItem(item)
      this.days.push(item)
      tempDate.setDate(tempDate.getDate() + 1)
    }

  }
}