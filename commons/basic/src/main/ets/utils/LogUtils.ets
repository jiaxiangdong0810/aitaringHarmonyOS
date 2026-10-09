import { Logger } from '@hzw/logger';

const DOMAIN: number = 0xA17A;

/** 日志等级，与 hilog 对齐。 */
export enum LogLevel {
  DEBUG = 'debug',
  INFO = 'info',
  WARN = 'warn',
  ERROR = 'error',
  FATAL = 'fatal'
}

/**
 * 日志工具。
 * 基础函数 write 交给 @hzw/logger；
 * 二级函数固定等级；
 * 三级函数固定业务 tag，默认走 info。
 */
export class LogUtils {
  private static ready: boolean = false;

  private static ensureReady(): void {
    if (LogUtils.ready) {
      return;
    }
    Logger.initialize((config) => {
      config.domain = DOMAIN;
      config.tag = 'app';
      config.debug = true;
      config.showDivider = true;
      config.showStack = false;
      config.isPrintFullStack = false;
      config.cacheLineNum = 40;
    });
    LogUtils.ready = true;
  }

  /** 基础函数：等级、tag、内容都由调用方给定。 */
  static write(level: LogLevel, tag: string, message: string): void {
    LogUtils.ensureReady();
    const printer = Logger.getLogger(tag);
    switch (level) {
      case LogLevel.DEBUG:
        printer.d(message);
        break;
      case LogLevel.INFO:
        printer.i(message);
        break;
      case LogLevel.WARN:
        printer.w(message);
        break;
      case LogLevel.ERROR:
        printer.e(message);
        break;
      case LogLevel.FATAL:
        printer.f(message);
        break;
      default:
        printer.i(message);
        break;
    }
  }

  /** 二级：固定等级，tag 仍由调用方传入。 */
  static debug(tag: string, message: string): void {
    LogUtils.write(LogLevel.DEBUG, tag, message);
  }

  static info(tag: string, message: string): void {
    LogUtils.write(LogLevel.INFO, tag, message);
  }

  static warn(tag: string, message: string): void {
    LogUtils.write(LogLevel.WARN, tag, message);
  }

  static error(tag: string, message: string): void {
    LogUtils.write(LogLevel.ERROR, tag, message);
  }

  static fatal(tag: string, message: string): void {
    LogUtils.write(LogLevel.FATAL, tag, message);
  }

  /** 三级：固定 tag，只传内容，内部走 info。 */
  static jxd(message: string): void {
    LogUtils.info('jxd', message);
  }

  static net(message: string): void {
    LogUtils.info('network', message);
  }
}

export const logUtils = LogUtils;
