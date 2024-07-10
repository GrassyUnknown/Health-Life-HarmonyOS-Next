/**
 * 单元格样式
 */
export class CJCellStyle {
  lunarFontSize?: number | string | Resource = 12
  lunarFontColor?: ResourceColor = "#252a34"
  lunarFontFontWeight?: FontWeight = FontWeight.Normal
  fontSize?: number | string | Resource = 18
  fontColor?: ResourceColor = "#252a34"
  fontFontWeight?: FontWeight = FontWeight.Normal
  // 今日字体颜色
  todayFontColor?: ResourceColor = "#03A9F4"
  // 不能使用的日期字体颜色
  disabledFontColor?: ResourceColor = "#B1B1B1"
  // 选中日期字体颜色
  selectFontColor?: ResourceColor = "#FFFFFF"
  // 选中字体大小
  selectFontSize?: number | string | Resource = 20
  // 选中日期背景颜色, 默认与todayFontColor一致
  itemBackgroundColor?: ResourceColor = "#00000000"
  selectItemBackgroundColor?: string = "#fff403cc"
  /**
   * RANGE 模式下生效，中间区域颜色变淡比例，范围：0-1
   */
  lightRatio?: number = 0.85
  // 边框样式
  /** 边框颜色 */
  boderColor?: ResourceColor = "#dbe2ef"
  /** 边框宽度 */
  boderWidth?: Length = 0
  /** 边框圆角 */
  boderRadius?: Length = 4
}
