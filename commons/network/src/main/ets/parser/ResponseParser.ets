import { HttpError } from '../HttpError';

export class ResponseParser {
  static json<T>(body: string, statusCode: number): T {
    if (statusCode < 200 || statusCode >= 300) {
      throw new HttpError(statusCode, `请求失败（${statusCode}）`);
    }
    if (body.length === 0) {
      throw new HttpError(statusCode, '响应解析失败');
    }
    try {
      return JSON.parse(body) as T;
    } catch (error) {
      throw new HttpError(statusCode, '响应解析失败');
    }
  }
}
