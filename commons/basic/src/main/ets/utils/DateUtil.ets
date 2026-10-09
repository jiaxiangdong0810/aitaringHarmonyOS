/**
 * 时间工具。
 * now 取当前毫秒时间戳；format 把时间戳格式化成 yyyy-MM-dd HH:mm:ss。
 */
export class DateUtil {
  static now(): number {
    return Date.now();
  }

  static format(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = DateUtil.pad(date.getMonth() + 1);
    const day = DateUtil.pad(date.getDate());
    const hour = DateUtil.pad(date.getHours());
    const minute = DateUtil.pad(date.getMinutes());
    const second = DateUtil.pad(date.getSeconds());
    return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
  }

  private static pad(value: number): string {
    if (value < 10) {
      return `0${value}`;
    }
    return `${value}`;
  }
}

export const dateUtil = DateUtil;
