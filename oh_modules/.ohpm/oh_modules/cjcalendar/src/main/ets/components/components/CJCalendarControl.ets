/**
 * 日历控制器
 */
import { CJCalendar } from './CJCalendar'
import { CJDateItem } from './CJDateItem'

export class CJCalendarControl {
  private cjCalendar: CJCalendar | undefined

  bind(cjCalendar: CJCalendar) {
    this.cjCalendar = cjCalendar
  }

  unbind() {
    this.cjCalendar = undefined
  }

  /**
   * 上一个月
   */
  preMonth() {
    this.cjCalendar?.__preMonth()
  }

  /**
   * 下一个月
   */
  nextMonth() {
    this.cjCalendar?.__nextMonth()
  }

  /**
   * 回到今天
   */
  backToday() {
    this.cjCalendar?.__backToday()
  }

  /**
   * 跳转至指定的年月份
   * @param month “2016-08” / new Date(“2016-08”)
   */
  skipToMonth(month: Date | string) {
    this.cjCalendar?.__skipToMonth(month)
  }

  currentMonth() {

  }

  /**
   * 触发选中指定日期项
   * @param items ["2024-06-07"] 、 [new Date()]
   */
  selectItems(items: Array<string | Date> | undefined) {
    this.cjCalendar?.__changeSelectItems(items)
  }

  /**
   * 获取当前items
   * @returns
   */
  getItems():Array<CJDateItem> | undefined{
    return this.cjCalendar?.days[0]
  }
}