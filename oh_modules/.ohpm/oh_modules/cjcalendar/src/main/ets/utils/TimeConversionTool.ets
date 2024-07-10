class TimeConversionTool {
  // static formatTime(time: string | number, format: string): string {
  //   // 将时间转换为日期对象
  //   const date = new Date(time);
  //
  //   // 使用内置的日期格式化方法进行格式化
  //   // const formattedTime = date.toLocaleDateString(undefined, format);
  //
  //   // const date = new Date();
  //   const formattedDate = date.toLocaleString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' });
  //   console.log(formattedDate);
  //
  //   return formattedDate;
  // }

  //下面是一个通用较高的自定义日期时间格式化函数的示例：
  static formatDateTime(date: Date, format: string): string {
    // const o = {
    //   'M+': date.getMonth() + 1, // 月份
    //   'd+': date.getDate(), // 日
    //   'h+': date.getHours() % 12 === 0 ? 12 : date.getHours() % 12, // 小时
    //   'H+': date.getHours(), // 小时
    //   'm+': date.getMinutes(), // 分
    //   's+': date.getSeconds(), // 秒
    //   'q+': Math.floor((date.getMonth() + 3) / 3), // 季度
    //   S: date.getMilliseconds(), // 毫秒
    //   a: date.getHours() < 12 ? '上午' : '下午', // 上午/下午
    //   A: date.getHours() < 12 ? 'AM' : 'PM', // AM/PM
    // };
    // if (/(y+)/.test(format)) {
    //   format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
    // }
    // for (let k in o) {
    //   if (new RegExp('(' + k + ')').test(format)) {
    //     format = format.replace(
    //       RegExp.$1,
    //       RegExp.$1.length === 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length)
    //     );
    //   }
    // }
    return format;
  }

  static convertToUnixTimestamp(time: string | number): number {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 获取 Unix 时间戳
    const unixTimestamp = date.getTime();

    return unixTimestamp;
  }

  static convertToDateObject(time: string | number): Date {
    // 将时间转换为日期对象
    return new Date(time);
  }

  static addSeconds(time: string | number, secondsToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加秒数
    date.setSeconds(date.getSeconds() + secondsToAdd);

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }

  static addMinutes(time: string | number, minutesToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加分钟数
    date.setMinutes(date.getMinutes() + minutesToAdd);

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }

  static addHours(time: string | number, hoursToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加小时数
    date.setHours(date.getHours() + hoursToAdd);

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }

  static addDays(time: string | number, daysToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加天数
    date.setDate(date.getDate() + daysToAdd);

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }

  static addWeeks(time: string | number, weeksToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加周数
    date.setDate(date.getDate() + (weeksToAdd * 7));

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }

  static addMonths(time: string | number, monthsToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加月数
    date.setMonth(date.getMonth() + monthsToAdd);

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }

  static addYears(time: string | number, yearsToAdd: number): string {
    // 将时间转换为日期对象
    const date = new Date(time);

    // 增加年数
    date.setFullYear(date.getFullYear() + yearsToAdd);

    // 将日期对象转换回字符串
    const newTime = date.toISOString().substr(0, 19);

    return newTime;
  }
}

export default TimeConversionTool;