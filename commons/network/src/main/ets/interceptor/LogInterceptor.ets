import { logUtils } from 'basic';

export class LogInterceptor {
  onStart(method: string, url: string, body?: string): void {
    logUtils.net(LogInterceptor.requestText(method, url, body));
  }

  onEnd(statusCode: number, url: string, cost: number, body: string): void {
    let text = `<-- ${statusCode} ${cost}ms ${url}`;
    if (body.length > 0) {
      text += `\n${LogInterceptor.toPrettyJson(body)}`;
    }
    logUtils.net(text);
  }

  onFail(code: number, message: string, url: string): void {
    logUtils.error('network', `<-- fail ${code} ${message} ${url}`);
  }

  private static requestText(method: string, url: string, body?: string): string {
    let text = `--> ${method} ${url}`;
    if (body !== undefined && body.length > 0) {
      text += `\n${LogInterceptor.toPrettyJson(body)}`;
    }
    return text;
  }

  private static toPrettyJson(body: string): string {
    try {
      return JSON.stringify(JSON.parse(body) as Object, undefined, 2);
    } catch (error) {
      return body;
    }
  }
}
