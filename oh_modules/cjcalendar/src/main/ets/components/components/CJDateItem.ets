import { Solar } from 'lunar'

export interface CJDateItemExtra {
  // [key: string]: any
}

@Observed
export class CJDateItem {
  fullYear: number
  month: number
  date: number
  week: number
  time: number
  // lunarDate?: LunarDate
  // 是否小于开始日期，适用设置开始、截止日期的当月判断
  isSmallThanStart?: boolean
  isBigThanEnd?: boolean
  isPre?: boolean // 是否是上一个月的 / 在startDate 之前
  isNext?: boolean // 是否是下一个月的 / 在endDate 之后
  isToday?: boolean // 是否是今天

  // 农历中文
  // 农历说明文档：https://6tail.cn/calendar/api.html#lunar.festivals.html
  solar?:Solar

  extras: Map<string, number | string | boolean> = new Map()

  constructor(date: Date,
              isPre?: boolean,
              isNext?: boolean) {
    this.fullYear = date.getFullYear()
    this.month = date.getMonth()
    this.date = date.getDate()
    this.week = date.getDay()
    this.time = date.getTime()

    this.isPre = isPre
    this.isNext = isNext
    // this.lunarDate = lunarDate
  }

  equalDay(other: CJDateItem): boolean {
    if (other) {
      if (this.fullYear == other.fullYear
        && this.month == other.month
        && this.date == other.date) {
        return true
      }
      return false
    }
    return false
  }

  /**
   * 日期比较, this - other
   * @param other 另一天
   * @returns == 0 : 等于， > 0：大于，< 0：小于
   */
  compareDay(other: CJDateItem): number {
    if (other) {
      if (this.fullYear < other.fullYear) {
        return -1
      } else if (this.fullYear > other.fullYear) {
        return 1
      } else {
        if (this.month < other.month) {
          return -1
        } else if (this.month > other.month) {
          return 1
        } else {
          return this.date - other.date
        }
      }
    }
    // if (other) {
    //   return this.time - other.time
    // }
    return 0
  }

  /**
   * 大于日期
   * @param other
   * @returns
   */
  bigThan(other: CJDateItem, hasEqual: boolean = false) {
    if (!other) {
      return false
    }

    if (other) {
      if (this.fullYear > other.fullYear) {
        return true
      } else if (this.fullYear < other.fullYear) {
        return false
      } else {
        if (this.month > other.month) {
          return true
        } else if (this.month < other.month) {
          return false
        } else {
          if (hasEqual) {
            return this.date >= other.date
          } else {
            return this.date > other.date
          }
        }
      }
    }
    return false
  }

  /**
   * 小于日期
   * @param other
   * @returns
   */
  smallThan(other: CJDateItem, hasEqual: boolean = false) {
    if (!other) {
      return false
    }
    if (other) {
      if (this.fullYear > other.fullYear) {
        return false
      } else if (this.fullYear < other.fullYear) {
        return true
      } else {
        if (this.month > other.month) {
          return false
        } else if (this.month < other.month) {
          return true
        } else {
          if (hasEqual) {
            return this.date <= other.date
          } else {
            return this.date < other.date
          }
        }
      }
    }
    return false
  }
}