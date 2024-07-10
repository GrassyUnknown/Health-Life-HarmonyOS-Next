// import MeasureText from '@ohos.measure';
// import font from '@ohos.font';
// import CustomTextPicker from './CustomTextPicker';
// import { CellFontStyle } from './CellFontStyle';
//
// const TAG = "CJCalendar"
//
// /**
//  * 操作模式
//  */
// export enum OptMode {
//   /** 普通模式 */
//   NORMAL = "normal",
//   /** 单选模式 */
//   SINGLE = "single",
//   /** 范围选择模式 */
//   RANGE = "range", //一段区域
//   /** 多选选择模式 */
//   MULTIPLE = "multiple", // 多选
// }
//
// /**
//  * 选中风格
//  */
// export enum SelectedStyle {
//   /** 独立风格 */
//   ALONE = 1,
//   /** 封闭风格 */
//   CLOSE = 2,
// }
//
// @Observed
// class LunarDate {
//   // 阴历日期的属性
//   public year: number;
//   public month: number;
//   public day: number;
//   // 是否是闰年
//   public isLeapMonth: boolean;
// }
//
// @Observed
// export class CJDateItem {
//   fullYear?: number
//   month?: number
//   date?: number
//   week?: number
//   time?: number
//   lunarDate?: LunarDate
//   isPre?: boolean // 是否是上一个月的 / 在startDate 之前
//   isNext?: boolean // 是否是下一个月的 / 在endDate 之后
//   isToday?: boolean // 是否是今天
//   [key: string]: any
//
//   constructor(date: Date,
//               isPre?: boolean,
//               isNext?: boolean) {
//     if (date) {
//       this.fullYear = date.getFullYear()
//       this.month = date.getMonth()
//       this.date = date.getDate()
//       this.week = date.getDay()
//       this.time = date.getTime()
//     }
//
//     this.isPre = isPre
//     this.isNext = isNext
//     // this.lunarDate = lunarDate
//   }
//
//   equalDay(other: CJDateItem | number): boolean {
//     if (typeof other == "number") {
//       other = new CJDateItem(new Date(other))
//     }
//     if (other) {
//       if (this.fullYear == other.fullYear
//       && this.month == other.month
//       && this.date == other.date) {
//         return true
//       }
//       return false
//     }
//     return false
//   }
//
//   /**
//    * 日期比较, this - other
//    * @param other 另一天
//    * @returns == 0 : 等于， > 0：大于，< 0：小于
//    */
//   compareDay(other: CJDateItem | number): number {
//     if (typeof other == "number") {
//       let temp = new Date(other)
//       other = new CJDateItem(new Date(temp.getFullYear(), temp.getMonth(), temp.getDate()))
//     }
//     if (other) {
//       if (this.fullYear < other.fullYear) {
//         return -1
//       } else if (this.fullYear > other.fullYear) {
//         return 1
//       } else {
//         if (this.month < other.month) {
//           return -1
//         } else if (this.month > other.month) {
//           return 1
//         } else {
//           return this.date - other.date
//         }
//       }
//     }
//     // if (other) {
//     //   return this.time - other.time
//     // }
//     return 0
//   }
//
//   /**
//    * 大于日期
//    * @param other
//    * @returns
//    */
//   bigThan(other: CJDateItem | number, hasEqual: boolean = false) {
//     if (!other) {
//       return false
//     }
//     if (typeof other == "number") {
//       other = new CJDateItem(new Date(other))
//     }
//     if (other) {
//       if (this.fullYear > other.fullYear) {
//         return true
//       } else if (this.fullYear < other.fullYear) {
//         return false
//       } else {
//         if (this.month > other.month) {
//           return true
//         } else if (this.month < other.month) {
//           return false
//         } else {
//           if (hasEqual) {
//             return this.date >= other.date
//           } else {
//             return this.date > other.date
//           }
//         }
//       }
//     }
//     return false
//   }
//
//   /**
//    * 小于日期
//    * @param other
//    * @returns
//    */
//   smallThan(other: CJDateItem | number, hasEqual: boolean = false) {
//     if (!other) {
//       return false
//     }
//     if (typeof other == "number") {
//       other = new CJDateItem(new Date(other))
//     }
//     if (other) {
//       if (this.fullYear > other.fullYear) {
//         return false
//       } else if (this.fullYear < other.fullYear) {
//         return true
//       } else {
//         if (this.month > other.month) {
//           return false
//         } else if (this.month < other.month) {
//           return true
//         } else {
//           if (hasEqual) {
//             return this.date <= other.date
//           } else {
//             return this.date < other.date
//           }
//         }
//       }
//     }
//     return false
//   }
// }
//
// export class CJTimeItem {
//   hour: number = 0
//   minute: number = 0
//   second: number = 0
//   timeStr: string = "00:00:00"
//
//   setHour(hour: number) {
//     this.hour = hour
//     this.resetTimeStr()
//   }
//
//   setMinute(minute: number) {
//     this.minute = minute
//     this.resetTimeStr()
//   }
//
//   setSecond(second: number) {
//     this.second = second
//     this.resetTimeStr()
//   }
//
//   resetTimeStr() {
//     this.timeStr = this.hour.toString().padStart(2, '0')
//     + ":"
//     + this.minute.toString().padStart(2, '0')
//     + ":"
//     + this.second.toString().padStart(2, '0')
//   }
// }
//
// @Component
// struct CalenderCell {
//   selectMiddleOpacity: number = 0.15
//   extremityRadius: number = 0
//   itemFontSize: number | string | Resource = 18
//   itemFontColor: ResourceColor = "#252a34"
//   itemFontWeight: FontWeight = FontWeight.Normal
//   todayFontColor: ResourceColor = "#03A9F4"
//   selectFontColor: ResourceColor = "#FFFFFF"
//   selectItemBgColor: ResourceColor = this.todayFontColor
//   disabledFontColor: ResourceColor = "#9E9E9E"
//   optMode: OptMode = OptMode.NORMAL
//   rangeStyle: number = SelectedStyle.ALONE
//   // 今日时间戳
//   today: number = -1
//   @Link selectItem: CJDateItem
//   @Link selectItem2: CJDateItem
//   @Link selectedDates: Array<CJDateItem>
//   @Prop hasPre: boolean
//   @Prop hasNext: boolean
//   @ObjectLink item: CJDateItem
//   // 自定义每一项布局
//   @BuilderParam public cellLayout?: (item: CJDateItem) => void = () => {
//     this.CellLayout()
//   }
//   @BuilderParam public todayLayout?: (item: CJDateItem) => void = () => {
//     this.TodayLayout()
//   }
//   /**
//    * 自定义选中背景层
//    */
//   @BuilderParam public selectedBackgroundLayout?: (item: CJDateItem, isStart?: boolean, isLast?: boolean) => void = () => {
//     this.SelectedBackgroundLayout()
//   }
//
//   /**
//    * 主题部分
//    */
//   @BuilderParam public cusCellMainLayout?: (item: CJDateItem, params: CellFontStyle) => void = () => {
//     this.CusCellMainLayout()
//   }
//   //
//   cellClick: (item: CJDateItem) => void = undefined
//   disableClick: (item: CJDateItem) => void = undefined
//
//   /**
//    * 检测是否包含在数组中
//    */
//   checkInArrays(): number {
//     for (let index = 0; index < this.selectedDates.length; index++) {
//       if (this.item.equalDay(this.selectedDates[index])) {
//         return index
//       }
//     }
//     return -1
//   }
//
//   getItemColor(): ResourceColor {
//
//     if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) {
//       if (this.item.isPre) {
//         return this.disabledFontColor
//       } else if (this.item.isNext) {
//         return this.disabledFontColor
//       } else if (this.item.equalDay(this.selectItem)) {
//         return this.selectFontColor
//       } else if (this.item.time == this.today) {
//         return this.todayFontColor
//       }
//       return this.itemFontColor
//     } else if (this.optMode == OptMode.RANGE) { // 一段时间选择
//       if (this.item.equalDay(this.selectItem)
//       || this.item.equalDay(this.selectItem2)) {
//         if (this.item.isPre) {
//           if (this.rangeStyle == SelectedStyle.CLOSE) { // 条状
//             return this.selectFontColor
//           }
//           return this.disabledFontColor
//         } else if (this.item.isNext) {
//           if (this.rangeStyle == SelectedStyle.CLOSE) { // 条状
//             return this.selectFontColor
//           }
//           return this.disabledFontColor
//         }
//         return this.selectFontColor
//       } else if (this.item.isPre) {
//         return this.disabledFontColor
//       } else if (this.item.isNext) {
//         return this.disabledFontColor
//       } else if (this.item.time == this.today) {
//         return this.todayFontColor
//       }
//       return this.itemFontColor
//     } else if (this.optMode == OptMode.MULTIPLE) { // 多选
//       if (!this.item.isPre && !this.item.isNext && this.checkInArrays() > -1) { //包含
//         return this.selectFontColor
//       } else if (this.item.isPre) {
//         return this.disabledFontColor
//       } else if (this.item.isNext) {
//         return this.disabledFontColor
//       } else if (this.item.time == this.today) {
//         return this.todayFontColor
//       }
//       return this.itemFontColor
//     } else {
//       if (this.item.isPre) {
//         return this.disabledFontColor
//       } else if (this.item.isNext) {
//         return this.disabledFontColor
//       }
//     }
//
//     return this.itemFontColor
//   }
//
//   getBorder(): {
//     width: number,
//     color?: ResourceColor
//   } {
//     if (this.item.equalDay(this.selectItem)) {
//       return {
//         width: 1,
//         color: this.getItemColor()
//       }
//     } else {
//       return {
//         width: 0,
//       }
//     }
//   }
//
//   /**
//    * 获取选中项背景颜色
//    */
//   getSelectItemBg(): ResourceColor {
//     return this.selectItemBgColor
//   }
//
//   /**
//    * 获取选中项背景透明度
//    * @returns
//    */
//   getSelectItemBgOpa(): number {
//     if (this.optMode == OptMode.RANGE) {
//       if (this.rangeStyle == SelectedStyle.CLOSE) { // 条状
//         return 1
//       } else { // 圆形
//         return this.item.isPre || this.item.isNext ? this.selectMiddleOpacity : 1
//       }
//     }
//     return this.item.isPre || this.item.isNext ? this.selectMiddleOpacity : 1
//   }
//
//   /**
//    * 是否需要显示选项背景
//    */
//   isShowSelectBg(): boolean {
//     if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) { // 单选
//       return this.item.equalDay(this.selectItem)
//     } else if (this.optMode == OptMode.RANGE) { // 范围选择
//       return this.item.equalDay(this.selectItem)
//       || this.item.equalDay(this.selectItem2)
//     } else if (this.optMode == OptMode.MULTIPLE) { // 多选
//       return this.checkInArrays() > -1
//     }
//     return false
//   }
//
//   @Builder
//   TodayLayout() {
//     this.cusCellMainLayout(this.item, {
//       fontSize: this.itemFontSize,
//       fontColor: this.getItemColor(),
//       fontWeight: this.itemFontWeight
//     })
//   }
//
//   /**
//    * 独立选中风格样式
//    */
//   @Builder
//   SelectedBackgroundLayout() {
//     if (this.rangeStyle == SelectedStyle.ALONE) {
//       Column()
//         .height("100%")
//         .aspectRatio(1)
//         .borderRadius(999)
//         .backgroundColor(this.getSelectItemBg())
//
//     } else {
//       Column()
//         .height("100%")
//         .width("100%")
//         .backgroundColor(this.getSelectItemBg())
//     }
//   }
//
//   /**
//    * 封闭选中风格样式
//    */
//   @Builder
//   CloseSelectedLayout() {
//     Column()
//       .height("100%")
//       .aspectRatio(1)
//       .borderRadius(999)
//       .backgroundColor(this.getSelectItemBg())
//   }
//
//   @Builder
//   SelectedLayout() {
//     // 区间内部
//     if (this.optMode == OptMode.RANGE
//     && this.item.bigThan(this.selectItem)
//     && this.item.smallThan(this.selectItem2)) {
//       // 区间内状态
//       if (this.rangeStyle == SelectedStyle.ALONE) { // 独立样式风格
//         Column() {
//           this.selectedBackgroundLayout(this.item)
//         }
//         .position({ x: "10%", y: "10%" })
//         .height("80%")
//         .aspectRatio(1)
//         .clip(true)
//         .opacity(this.item.equalDay(this.selectItem) || this.item.equalDay(this.selectItem2) ? 1 : this.selectMiddleOpacity)
//         .transition({ type: TransitionType.Insert, opacity: 1 })
//         .transition({ type: TransitionType.Delete, opacity: 0 })
//
//       } else if (this.rangeStyle == SelectedStyle.CLOSE) { // 封闭样式
//
//         Column() {
//           this.selectedBackgroundLayout(this.item)
//         }
//         .opacity(this.selectMiddleOpacity)
//         .position({
//           x: 0,
//           y: "10%"
//         })
//         .clip(true)
//         .width("100%")
//         .height("80%")
//       }
//     }
//
//     // CLOSE 情况下才考虑 端点
//     if (this.optMode == OptMode.RANGE && this.rangeStyle == SelectedStyle.CLOSE
//     && this.selectItem && this.selectItem2
//     && (this.item.equalDay(this.selectItem) || this.item.equalDay(this.selectItem2))) {
//       Column() {
//         this.selectedBackgroundLayout(this.item, false, false)
//       }
//       .opacity(this.selectMiddleOpacity)
//       .position({
//         x: this.item.equalDay(this.selectItem) ? "50%" : 0,
//         y: "10%"
//       })
//       .width(this.item.equalDay(this.selectItem) ||
//              this.item.equalDay(this.selectItem2) ? "50%" : "100%")
//       .height("80%")
//     }
//
//     if (this.isShowSelectBg()) {
//
//       if (this.optMode == OptMode.RANGE && this.rangeStyle == SelectedStyle.CLOSE) {
//         Column() {
//           this.selectedBackgroundLayout(this.item, this.item.equalDay(this.selectItem), this.item.equalDay(this.selectItem2))
//         }
//         .position({ x: "10%", y: "10%" })
//         .height("80%")
//         .aspectRatio(1)
//         .clip(true)
//         .opacity(this.getSelectItemBgOpa())
//         .transition({ type: TransitionType.Insert, opacity: 1 })
//         .transition({ type: TransitionType.Delete, opacity: 0 })
//         .borderRadius({
//           topLeft: this.selectItem && this.selectItem2 && this.item.equalDay(this.selectItem) ? this.extremityRadius : 0,
//           bottomLeft: this.selectItem && this.selectItem2 && this.item.equalDay(this.selectItem) ? this.extremityRadius : 0,
//           topRight: this.selectItem && this.selectItem2 && this.item.equalDay(this.selectItem2) ? this.extremityRadius : 0,
//           bottomRight: this.selectItem && this.selectItem2 && this.item.equalDay(this.selectItem2) ? this.extremityRadius : 0
//         })
//
//       } else {
//         Column() {
//           this.selectedBackgroundLayout(this.item)
//         }
//         .position({ x: "10%", y: "10%" })
//         // .borderRadius(999)
//         .height("80%")
//         .aspectRatio(1)
//         .clip(true)
//         .opacity(this.getSelectItemBgOpa())
//         .transition({ type: TransitionType.Insert, opacity: 1 })
//         .transition({ type: TransitionType.Delete, opacity: 0 })
//       }
//     }
//
//   }
//
//   @Builder
//   CusCellMainLayout() {
//     Text(this.item.date + '')
//       .fontSize(this.itemFontSize)
//       .fontColor(this.getItemColor())
//       .fontWeight(this.itemFontWeight)
//   }
//
//   /**
//    * 默认布局
//    */
//   @Builder
//   CellLayout() {
//
//     Stack() {
//       // this.cusCellSelectedLayout(this.item)
//       this.SelectedLayout()
//
//       if (this.item.equalDay(this.today)) {
//         this.todayLayout(this.item)
//       } else {
//         this.cusCellMainLayout(this.item, {
//           fontSize: this.itemFontSize,
//           fontColor: this.getItemColor(),
//           fontWeight: this.itemFontWeight
//         })
//       }
//
//     }
//     .aspectRatio(1)
//     .width("100%")
//
//   }
//
//   build() {
//     Column() {
//       this.cellLayout(this.item)
//     }
//     .justifyContent(FlexAlign.Center)
//     .width("100%")
//     .aspectRatio(1)
//     .onClick(() => {
//       // animateTo({ duration: 200 }, () => {
//       //
//       // })
//
//       if (this.item.isNext) {
//         if (!this.hasNext) {
//           if (this.disableClick) {
//             this.disableClick(this.item)
//           }
//           return
//         }
//       }
//
//       if (this.item.isPre) {
//         if (!this.hasPre) {
//           if (this.disableClick) {
//             this.disableClick(this.item)
//           }
//           return
//         }
//       }
//
//       // if (!this.item.isPre && !this.item.isNext) {
//       if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) {
//         this.selectItem = this.item
//       } else if (this.optMode == OptMode.RANGE) { // 一段时间
//         if (!this.selectItem || this.selectItem && this.selectItem2) {
//           this.selectItem = this.item
//           this.selectItem2 = null
//         } else {
//           this.selectItem2 = this.item
//           if (this.selectItem2.time < this.selectItem.time) {
//             [this.selectItem, this.selectItem2] = [this.selectItem2, this.selectItem];
//           }
//         }
//       } else if (this.optMode == OptMode.MULTIPLE) { // 多选
//         let index = this.checkInArrays()
//         if (index < 0) { //不包含
//           this.selectedDates.push(this.item)
//         } else { // 包含
//           this.selectedDates.splice(index, 1)
//         }
//       }
//       // }
//       if (this.cellClick) {
//         this.cellClick(this.item)
//       }
//     })
//   }
// }
//
// @Component
// export struct CJCalendar {
//   @State selectItem: CJDateItem = undefined
//   @State selectItem2: CJDateItem = undefined // OptMode.RANGE 生效
//   /** 操作模式 */
//   optMode: OptMode = OptMode.NORMAL
//   /** 选中样式 */
//   rangeStyle: number = SelectedStyle.ALONE // ALONE：独立风格，CLOSE：封闭风格
//   /** RANGE、CLOSE 时，两头的圆角 */
//   extremityRadius: number = 0
//   /** RANGE、CLOSE 时，两头的圆角 */
//   selectMiddleOpacity: number = 0.15
//   private today: Date = new Date() // 当天
//   showTime: boolean = false // 是否显示时间选择
//   timeFontSize: number | string | Resource = 18 // 时间字体大小
//   timeFontColor: ResourceColor // 时间字体大小
//   private hours: string[] // 小时
//   private minutes: string[] // 分钟
//   private seconds: string[] // 秒
//   private timeItem1: CJTimeItem
//   private timeItem2: CJTimeItem
//   private timeCellWidth: number // 时间选择宽度
//   // 开始日期
//   startDate: Date
//   // 截止日期
//   endDate: Date
//   //
//   @State private currMonth: number = this.today.getMonth()
//   @State private currYear: number = this.today.getFullYear()
//   private startDay: Date = new Date(
//     this.today.getFullYear(),
//     this.today.getMonth(),
//     1
//   ) // 当前显示的月份的第一天
//   // 是否有上一个月
//   @State @Watch("onTitleChange")
//   private hasPre: boolean = true
//   // 是否有下一个月
//   @State @Watch("onTitleChange")
//   private hasNext: boolean = true
//   // 标题栏高度
//   titleHeight: Length = '50vp'
//   // 星期标题
//   weeks: string[] = [
//     "日",
//     "一",
//     "二",
//     "三",
//     "四",
//     "五",
//     "六",
//   ]
//   // 星期标题字体大小
//   weekTitleFontSize: number | string | Resource = 13
//   // 星期标题字体颜色
//   weekTitleFontColor: ResourceColor = "#9E9E9E"
//   weekTitleBackgroundColor: ResourceColor = undefined
//   // 星期标栏高度
//   weekTitleHeight: Length = 40
//   // 标题字体大小
//   titleFontSize: number | string | Resource = 18
//   // 标题字体颜色
//   titleFontColor: ResourceColor = "#252a34"
//   // 是否显示快捷 今
//   showFastToday: boolean = true
//   fastTodayFontSize: number | string | Resource = 12
//   fastTodayFontColor: ResourceColor = "#FFFFFF"
//   fastTodayBg: ResourceColor = undefined
//   // 快捷回到今天自定义布局
//   @BuilderParam public fastTodayLayout?: () => void = () => {
//     this.FastTodayLayout()
//   }
//   // 日期每一项字体大小
//   itemFontSize: number | string | Resource = 18
//   itemFontColor: ResourceColor = "#252a34"
//   itemFontWeight: FontWeight = FontWeight.Normal
//   // 今日字体颜色
//   todayFontColor: ResourceColor = "#03A9F4"
//   // 不能使用的日期字体颜色
//   disabledFontColor: ResourceColor = "#9E9E9E"
//   // 选中日期字体颜色
//   selectFontColor: ResourceColor = "#FFFFFF"
//   // 选中日期背景颜色, 默认与todayFontColor一致
//   selectItemBgColor: ResourceColor = undefined
//   @State @Watch("onTitleChange")
//   private title: string = undefined
//   // 计算的总加载
//   @State dates: Array<CJDateItem> = new Array()
//   /** 初始化已选日期 */
//   @State
//   selectedDates: Array<CJDateItem | string> = new Array()
//   /** 自定义每一项布局 */
//   @BuilderParam public cellLayout?: (item: CJDateItem) => void = undefined
//   /** 自定义日期标题每项内容 */
//   @BuilderParam public titleCenterLayout?: (backToday?: () => void) => void = () => {
//     this.TitleCenterLayout()
//   }
//   /** 自定义标题左边布局 */
//   @BuilderParam public titleLeftLayout?: () => void = () => {
//     this.TitleLeftLayout()
//   }
//   /** 自定义标题栏右边布局 */
//   @BuilderParam public titleRightLayout?: () => void = () => {
//     this.TitleRightLayout()
//   }
//   /** 仅自定义 今日 样式，当使用cellLayout时，tadayLayout无效 */
//   @BuilderParam public todayLayout?: (item: CJDateItem) => void = undefined
//   /** 自定义顶部，可结合cusTopStateListener使用 */
//   @BuilderParam public cusTopLayout?: (preMonth?: () => void,
//                                        nextMonth?: () => void,
//                                        backToday?: () => void) => void = () => {
//     this.CusTopLayout()
//   }
//   // 自定义Cell主体部分
//   @BuilderParam public cusCellMainLayout?: (item: CJDateItem, params: CellFontStyle) => void = undefined
//   // 自定义选中样式
//   @BuilderParam public selectedBackgroundLayout?: (item: CJDateItem, isStart?: boolean, isEnd?: boolean) => void = undefined
//   // 顶部状态变量更新回调
//   cusTopStateListener: (title?: string,
//                         hasPre?: boolean,
//                         hasNext?: boolean,
//                         showFastToday?: boolean) => void = undefined
//   // 计算item时，如需添加更多自定义属性时使用
//   reBuildDateItem: (item: CJDateItem) => CJDateItem = undefined
//   /**
//    * 选择变化监听，OptMode.NORMAL/OptMode.NORMAL,只返：date1，OptMode.MULTIPLE：两个都返
//    */
//   onDateChange: (date1: CJDateItem | Array<CJDateItem | string>, date2?: CJDateItem) => void = undefined
//   /**
//    * 选中时间变化监听
//    */
//   onTimeChange: (time1: CJTimeItem, time2?: CJTimeItem) => void = undefined
//   /**
//    * 月份变化监听
//    */
//   onMonthChange: (after: Date, befor?: Date) => void = undefined
//   /**
//    * 不可选中项的点击事件
//    */
//   disableCellClick: (item: CJDateItem) => void = undefined
//
//   /**
//    * 自定义顶部
//    */
//   @Builder
//   CusTopLayout() {
//     Row() {
//       Column() {
//         this.titleLeftLayout()
//       }
//       .justifyContent(FlexAlign.Center)
//       .height("100%")
//       .aspectRatio(1)
//       .onClick(() => {
//         if (this.hasPre) {
//           this.preMonth()
//         }
//       })
//
//       Blank()
//
//       this.titleCenterLayout(() => {
//         this.backToday()
//       })
//
//       Blank()
//       Column() {
//         this.titleRightLayout()
//       }
//       .justifyContent(FlexAlign.Center)
//       .height("100%")
//       .aspectRatio(1)
//       .onClick(() => {
//         if (this.hasNext) {
//           this.nextMonth()
//         }
//       })
//     }
//     .alignItems(VerticalAlign.Center)
//     .width("100%")
//     .height(this.titleHeight)
//   }
//
//   /**
//    * 标题栏左边默认布局
//    */
//   @Builder
//   TitleLeftLayout() {
//     Image($r("app.media.ic_public_arrow_left"))
//       .width(28)
//       .fillColor(this.hasPre ? this.itemFontColor : this.disabledFontColor)
//       .aspectRatio(1)
//   }
//
//   /**
//    * 标题栏右边默认布局
//    */
//   @Builder
//   TitleRightLayout() {
//     Image($r("app.media.ic_public_arrow_right_filled"))
//       .fillColor(this.hasNext ? this.itemFontColor : this.disabledFontColor)
//       .width(28)
//       .aspectRatio(1)
//   }
//
//   /**
//    * 自定义顶部中间排版
//    */
//   @Builder
//   TitleCenterLayout() {
//     Row() {
//       Text(this.title)
//         .fontSize(this.titleFontSize)
//         .fontColor(this.titleFontColor)
//       if ((this.currYear == this.today.getFullYear() && this.currMonth != this.today.getMonth()
//       || this.currYear != this.today.getFullYear()) && this.showFastToday) {
//         Row() {
//           this.fastTodayLayout()
//         }
//         .onClick(() => {
//           this.backToday()
//         })
//       }
//
//     }
//   }
//
//   /**
//    * 回到今天默认布局
//    */
//   @Builder
//   FastTodayLayout() {
//     Text("今")
//       .fontSize(this.fastTodayFontSize)
//       .fontColor(this.fastTodayFontColor)
//       .backgroundColor(this.fastTodayBg)
//       .borderRadius(50)
//       .padding(4)
//       .margin({ left: 4 })
//   }
//
//   /**
//    * 星期标题栏
//    * @param item
//    */
//   @Builder
//   WeekTitle(item) {
//     Text(item)
//       .textAlign(TextAlign.Center)
//       .fontColor(this.weekTitleFontColor)
//       .fontSize(this.weekTitleFontSize)
//       .layoutWeight(1)
//   }
//
//   @Builder
//   ItemCell() {
//     ForEach(this.dates, (item: CJDateItem, index: number) => {
//       CalenderCell({
//         item: item,
//         cellLayout: this.cellLayout,
//         itemFontSize: this.itemFontSize,
//         itemFontColor: this.itemFontColor,
//         optMode: this.optMode,
//         today: this.today.getTime(),
//         itemFontWeight: this.itemFontWeight,
//         todayFontColor: this.todayFontColor,
//         todayLayout: this.todayLayout,
//         selectItem: $selectItem,
//         selectItem2: $selectItem2,
//         selectFontColor: this.selectFontColor,
//         selectItemBgColor: this.selectItemBgColor,
//         rangeStyle: this.rangeStyle,
//         selectedDates: $selectedDates,
//         disabledFontColor: this.disabledFontColor,
//         hasPre: this.hasPre,
//         hasNext: this.hasNext,
//         cusCellMainLayout: this.cusCellMainLayout,
//         selectedBackgroundLayout: this.selectedBackgroundLayout,
//         extremityRadius: this.extremityRadius,
//         selectMiddleOpacity: this.selectMiddleOpacity,
//         disableClick: (item: CJDateItem) => {
//           if (this.disableCellClick) {
//             this.disableCellClick(item)
//           }
//         },
//         cellClick: (item: CJDateItem) => {
//           if (item.isPre) {
//             this.preMonth()
//           } else if (item.isNext) {
//             this.nextMonth()
//           }
//           if (this.onDateChange) {
//             if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) {
//               this.onDateChange(item)
//             } else if (this.optMode == OptMode.RANGE) {
//               this.onDateChange(this.selectItem, this.selectItem2)
//             } else if (this.optMode == OptMode.MULTIPLE) {
//               this.onDateChange(this.selectedDates)
//             }
//           }
//         }
//       })
//         .width(`14.28%`)
//     }, (item: CJDateItem) => JSON.stringify(item))
//   }
//
//   private changeTopState() {
//     if (this.cusTopStateListener) {
//       this.cusTopStateListener(this.title,
//         this.hasPre,
//         this.hasNext,
//         (this.currYear == this.today.getFullYear() && this.currMonth != this.today.getMonth()
//         || this.currYear != this.today.getFullYear()) && this.showFastToday)
//     }
//   }
//
//   /**
//    * 标题改变时
//    */
//   onTitleChange() {
//     this.changeTopState()
//   }
//
//   /**
//    * 属性初始化
//    */
//   initAttr() {
//     if (!this.selectItemBgColor) {
//       this.selectItemBgColor = this.todayFontColor
//     }
//     if (!this.fastTodayBg) {
//       this.fastTodayBg = this.todayFontColor
//     }
//
//     this.today = new Date(
//       this.today.getFullYear(),
//       this.today.getMonth(),
//       this.today.getDate(),
//     )
//
//     // 开始日期
//     if (!this.startDate) {
//       this.startDate = new Date(1970, 0, 1)
//     } else {
//       this.startDate = new Date(this.startDate.getFullYear(), this.startDate.getMonth(), this.startDate.getDate())
//     }
//     // 截止日期
//     if (!this.endDate) {
//       this.endDate = new Date(this.today.getFullYear() + 10, 11, 31)
//     } else {
//       this.endDate = new Date(this.endDate.getFullYear(), this.endDate.getMonth(), this.endDate.getDate())
//     }
//
//     if (this.today.getTime() < this.startDate.getTime()) {
//       this.startDay.setTime(this.startDate.getTime())
//       this.showFastToday = false
//     } else if (this.today.getTime() > this.endDate.getTime()) {
//       this.startDay.setTime(this.endDate.getTime())
//       this.showFastToday = false
//     } else {
//       this.startDay.setTime(this.today.getTime())
//     }
//
//     // 初始化默认选项
//     if (this.selectedDates && this.selectedDates.length > 0) {
//       if (this.optMode == OptMode.MULTIPLE) { // 多选
//         for (let index = 0; index < this.selectedDates.length; index++) {
//           const element = this.selectedDates[index];
//           if (typeof element == "string") {
//             this.selectedDates[index] = new CJDateItem(new Date(element))
//           }
//         }
//       } else if (this.optMode == OptMode.RANGE) { // 范围选择
//         if (typeof this.selectedDates[0] == "string") {
//           this.selectItem = new CJDateItem(new Date(this.selectedDates[0]))
//         } else {
//           this.selectItem = this.selectedDates[0]
//         }
//
//         if (typeof this.selectedDates[this.selectedDates.length - 1] == "string") {
//           // @ts-ignore
//           this.selectItem2 = new CJDateItem(new Date(this.selectedDates[this.selectedDates.length - 1]))
//         } else {
//           // @ts-ignore
//           this.selectItem2 = this.selectedDates[this.selectedDates.length - 1]
//         }
//
//       } else if (this.optMode == OptMode.SINGLE) { // 单选
//         if (typeof this.selectedDates[0] == "string") {
//           this.selectItem = new CJDateItem(new Date(this.selectedDates[0]))
//         } else {
//           this.selectItem = this.selectedDates[0]
//         }
//         console.log("选中项目：", JSON.stringify(this.selectItem))
//       }
//
//       // console.log("测试：", JSON.stringify(this.selectedDates))
//     }
//
//     if (this.showTime) { // 显示时间
//       this.hours = []
//       this.minutes = []
//       this.seconds = []
//       for (let index = 0; index < 24; index++) {
//         this.hours.push(index.toString().padStart(2, '0'))
//       }
//       for (let index = 0; index < 59; index++) {
//         this.minutes.push(index.toString().padStart(2, '0'))
//       }
//       for (let index = 0; index < 59; index++) {
//         this.seconds.push(index.toString().padStart(2, '0'))
//       }
//
//       // 计算time cell 宽度
//       const fontWidth = MeasureText.measureText({
//         textContent: "23",
//         fontSize: this.timeFontSize
//       })
//
//       this.timeCellWidth = px2vp(fontWidth) + 4
//       if (!this.timeFontColor) {
//         this.timeFontColor = this.itemFontColor
//       }
//       // console.log(TAG, "字体宽度：", fontWidth, px2vp(fontWidth))
//
//       if (this.optMode == OptMode.NORMAL
//       || this.optMode == OptMode.SINGLE
//       || this.optMode == OptMode.MULTIPLE) {
//         this.timeItem1 = new CJTimeItem()
//       } else if (this.optMode == OptMode.RANGE) {
//         this.timeItem1 = new CJTimeItem()
//         this.timeItem2 = new CJTimeItem()
//       }
//     }
//   }
//
//   aboutToAppear() {
//     this.initAttr()
//
//     if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) {
//       if (!this.selectItem) {
//         let temp = new CJDateItem(this.today)
//         this.selectItem = temp
//       }
//     }
//     this.calcDatas()
//   }
//
//   /**
//    * 下一个月
//    */
//   private nextMonth() {
//     // this.dates.slice(0, this.dates.length)
//     this.dates = []
//     const beforDate = new Date(this.startDay.getFullYear(), this.startDay.getMonth())
//     this.startDay.setMonth(this.startDay.getMonth() + 1)
//     if (this.onMonthChange) {
//       this.onMonthChange(new Date(this.startDay.getFullYear(), this.startDay.getMonth()), beforDate)
//     }
//     this.calcDatas()
//   }
//
//   /**
//    * 上一个月
//    */
//   private preMonth() {
//     // this.dates.slice(0, this.dates.length)
//     this.dates = []
//     const beforDate = new Date(this.startDay.getFullYear(), this.startDay.getMonth())
//     this.startDay.setMonth(this.startDay.getMonth() - 1)
//     if (this.onMonthChange) {
//       this.onMonthChange(new Date(this.startDay.getFullYear(), this.startDay.getMonth()), beforDate)
//     }
//     this.calcDatas()
//   }
//
//   /**
//    * 回到今天
//    */
//   private backToday() {
//     this.dates = []
//     const beforDate = new Date(this.startDay.getFullYear(), this.startDay.getMonth())
//     this.startDay.setFullYear(this.today.getFullYear(), this.today.getMonth())
//
//     if (this.optMode == OptMode.NORMAL) {
//       let temp = new CJDateItem(this.today)
//       this.selectItem = temp
//
//       // if (this.onSelectChange) {
//       //   this.onSelectChange()
//       // }
//     }
//     if (this.onMonthChange) {
//       this.onMonthChange(new Date(this.startDay.getFullYear(), this.startDay.getMonth()), beforDate)
//     }
//     this.calcDatas()
//   }
//
//   /**
//    * 具体计算
//    */
//   private calcDatas() {
//     const startDay = this.startDay
//     this.currMonth = startDay.getMonth()
//     this.currYear = startDay.getFullYear()
//     this.title = `${startDay.getFullYear()}年${startDay.getMonth() + 1}月`
//     startDay.setDate(1)
//
//     if (startDay.getFullYear() < this.startDate.getFullYear()
//     || (startDay.getFullYear() == this.startDate.getFullYear() && startDay.getMonth() <= this.startDate.getMonth())) {
//       this.hasPre = false
//     } else {
//       this.hasPre = true
//     }
//
//     if (startDay.getFullYear() > this.endDate.getFullYear()
//     || (startDay.getFullYear() == this.endDate.getFullYear() && startDay.getMonth() >= this.endDate.getMonth())) {
//       this.hasNext = false
//     } else {
//       this.hasNext = true
//     }
//
//     // 计算第一个月
//     // 获取第一个月总天数
//     let endDay: Date = new Date(
//       startDay.getFullYear(),
//       startDay.getMonth() + 1,
//       0, 23, 59, 59)
//
//     let tempDate: Date = new Date(
//       startDay.getFullYear(),
//       startDay.getMonth(),
//       startDay.getDate()
//     )
//
//     const count = endDay.getDate()
//     const preCount = startDay.getDay()
//     const nextCount = 6 - endDay.getDay()
//     const finilCount = count + preCount + nextCount
//
//     // 补齐上一个月
//     tempDate.setDate(tempDate.getDate() - preCount)
//
//     // 添加日期
//     for (let index = 0; index < finilCount; index++) {
//       let item = new CJDateItem(
//         tempDate,
//         (index < preCount ? true : false) || this.startDate.getTime() > tempDate.getTime(),
//         (index >= preCount + count ? true : false) || this.endDate.getTime() < tempDate.getTime()
//       )
//       if (this.reBuildDateItem) {
//         this.reBuildDateItem(item)
//       }
//       this.dates.push(item)
//       tempDate.setDate(tempDate.getDate() + 1)
//     }
//   }
//
//   @Styles
//   timePicker() {
//     .width(30)
//     .height(40)
//   }
//
//   build() {
//     Column() {
//
//       this.cusTopLayout(
//         () => {
//           this.preMonth()
//         },
//         () => {
//           this.nextMonth()
//         },
//         () => {
//           this.backToday()
//         },
//       )
//
//       // 星期title
//       Row() {
//         ForEach(this.weeks, (item, index) => {
//           this.WeekTitle(item)
//         })
//       }
//       .backgroundColor(this.weekTitleBackgroundColor)
//       .alignItems(VerticalAlign.Center)
//       .height(this.weekTitleHeight)
//
//       Flex({ wrap: FlexWrap.Wrap }) {
//         this.ItemCell()
//       }
//       .width("100%")
//
//       if (this.showTime) {
//         Row() {
//           Row() {
//             CustomTextPicker({
//               cellHeight: 50,
//               datas: this.hours,
//               initIndex: 0,
//               normal: {
//                 fgColor: this.timeFontColor,
//                 fontSize: this.timeFontSize
//               },
//               onchange: (index: number) => {
//                 // this.hourSelectIdx = index
//                 this.timeItem1.setHour(index)
//                 if (this.onTimeChange) {
//                   this.onTimeChange(this.timeItem1, this.timeItem2)
//                 }
//               }
//             }) // .height(40)
//               .width(this.timeCellWidth)
//
//             Text(":")
//               .margin({ left: 2, right: 2 })
//
//             CustomTextPicker({
//               cellHeight: 50,
//               datas: this.minutes,
//               initIndex: 0,
//               onchange: (index: number) => {
//                 this.timeItem1.setMinute(index)
//                 if (this.onTimeChange) {
//                   this.onTimeChange(this.timeItem1, this.timeItem2)
//                 }
//               }
//             }) // .height(40)？
//               .width(this.timeCellWidth)
//
//             Text(":")
//               .margin({ left: 2, right: 2 })
//
//             CustomTextPicker({
//               cellHeight: 50,
//               datas: this.seconds,
//               initIndex: 0,
//               normal: {
//                 fgColor: this.timeFontColor,
//                 fontSize: this.timeFontSize
//               },
//               onchange: (index: number) => {
//                 this.timeItem1.setSecond(index)
//                 if (this.onTimeChange) {
//                   this.onTimeChange(this.timeItem1, this.timeItem2)
//                 }
//               }
//             }) // .height(40)
//               .width(this.timeCellWidth)
//           }
//
//
//           // Blank()
//
//           if (this.optMode == OptMode.RANGE) {
//             Row() {
//               CustomTextPicker({
//                 cellHeight: 50,
//                 datas: this.hours,
//                 initIndex: 0,
//                 normal: {
//                   fgColor: this.timeFontColor,
//                   fontSize: this.timeFontSize
//                 },
//                 onchange: (index: number) => {
//                   // this.hourSelectIdx = index
//                   this.timeItem2.setHour(index)
//                   if (this.onTimeChange) {
//                     this.onTimeChange(this.timeItem1, this.timeItem2)
//                   }
//                 }
//               }) // .height(40)
//                 .width(this.timeCellWidth)
//
//               Text(":")
//                 .margin({ left: 2, right: 2 })
//
//               CustomTextPicker({
//                 cellHeight: 50,
//                 datas: this.minutes,
//                 initIndex: 0,
//                 normal: {
//                   fgColor: this.timeFontColor,
//                   fontSize: this.timeFontSize
//                 },
//                 onchange: (index: number) => {
//                   this.timeItem2.setMinute(index)
//                   if (this.onTimeChange) {
//                     this.onTimeChange(this.timeItem1, this.timeItem2)
//                   }
//                 }
//               }) // .height(40)？
//                 .width(this.timeCellWidth)
//
//               Text(":")
//                 .margin({ left: 2, right: 2 })
//
//               CustomTextPicker({
//                 cellHeight: 50,
//                 datas: this.seconds,
//                 initIndex: 0,
//                 normal: {
//                   fgColor: this.timeFontColor,
//                   fontSize: this.timeFontSize
//                 },
//                 onchange: (index: number) => {
//                   this.timeItem2.setSecond(index)
//                   if (this.onTimeChange) {
//                     this.onTimeChange(this.timeItem1, this.timeItem2)
//                   }
//                 }
//               }) // .height(40)
//                 .width(this.timeCellWidth)
//             }
//           }
//         }
//         .height(40)
//         .width("100%")
//         .padding({ left: 12, right: 12 })
//         .justifyContent(FlexAlign.SpaceBetween)
//       }
//
//     }
//     .width("100%")
//
//     // .height("100%")
//   }
// }