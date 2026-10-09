/**
 * 字符串工具。
 * isEmpty 只看有没有字符；isBlank 把纯空格也当成空。
 */
export class StringUtil {
  static isEmpty(value: string | undefined): boolean {
    if (value === undefined) {
      return true;
    }
    return value.length === 0;
  }

  static isBlank(value: string | undefined): boolean {
    if (value === undefined) {
      return true;
    }
    return value.trim().length === 0;
  }
}

export const stringUtil = StringUtil;
