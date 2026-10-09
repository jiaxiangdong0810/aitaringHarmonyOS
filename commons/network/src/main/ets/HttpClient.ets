import { BusinessError } from '@kit.BasicServicesKit';
import { http } from '@kit.NetworkKit';
import { HttpError } from './HttpError';
import { LogInterceptor } from './interceptor/LogInterceptor';
import { ResponseParser } from './parser/ResponseParser';

const CONNECT_MS: number = 15000;
const TRANSFER_MS: number = 15000;

interface RequestHeader {
  'Content-Type': string;
  'Accept': string;
}

export class HttpClient {
  private static baseUrl: string = '';
  private static logger: LogInterceptor = new LogInterceptor();

  static init(baseUrl: string): void {
    HttpClient.baseUrl = baseUrl;
  }

  static close(): void {
    HttpClient.baseUrl = '';
  }

  static get<T>(path: string): Promise<T> {
    return HttpClient.execute<T>(http.RequestMethod.GET, path);
  }

  static post<T>(path: string, body: string): Promise<T> {
    return HttpClient.execute<T>(http.RequestMethod.POST, path, body);
  }

  static put<T>(path: string, body: string): Promise<T> {
    return HttpClient.execute<T>(http.RequestMethod.PUT, path, body);
  }

  static delete<T>(path: string): Promise<T> {
    return HttpClient.execute<T>(http.RequestMethod.DELETE, path);
  }

  private static async execute<T>(method: http.RequestMethod, path: string, body?: string): Promise<T> {
    const url = HttpClient.resolve(path);
    const header: RequestHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    const options: http.HttpRequestOptions = {
      method: method,
      header: header,
      connectTimeout: CONNECT_MS,
      readTimeout: TRANSFER_MS,
      expectDataType: http.HttpDataType.STRING,
      usingCache: false
    };
    if (body !== undefined && body.length > 0) {
      options.extraData = body;
    }
    const client = http.createHttp();
    const start = Date.now();
    HttpClient.logger.onStart(HttpClient.methodName(method), url, body);
    try {
      const response = await client.request(url, options);
      const statusCode = response.responseCode as number;
      const result = HttpClient.readBody(response.result);
      HttpClient.logger.onEnd(statusCode, url, Date.now() - start, result);
      return ResponseParser.json<T>(result, statusCode);
    } catch (error) {
      if (error instanceof HttpError) {
        throw error as Error;
      }
      const err = error as BusinessError;
      const message = err.message.length > 0 ? err.message : '网络请求失败';
      HttpClient.logger.onFail(err.code, message, url);
      throw new HttpError(err.code, message);
    } finally {
      client.destroy();
    }
  }

  private static resolve(path: string): string {
    if (HttpClient.baseUrl.length === 0) {
      throw new HttpError(0, '网络模块还没有初始化');
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    const base = HttpClient.baseUrl;
    if (base.endsWith('/') && path.startsWith('/')) {
      return base.substring(0, base.length - 1) + path;
    }
    if (!base.endsWith('/') && !path.startsWith('/')) {
      return `${base}/${path}`;
    }
    return base + path;
  }

  private static readBody(result: string | Object | ArrayBuffer): string {
    if (typeof result === 'string') {
      return result;
    }
    return JSON.stringify(result);
  }

  private static methodName(method: http.RequestMethod): string {
    if (method === http.RequestMethod.POST) {
      return 'POST';
    }
    if (method === http.RequestMethod.PUT) {
      return 'PUT';
    }
    if (method === http.RequestMethod.DELETE) {
      return 'DELETE';
    }
    return 'GET';
  }
}
