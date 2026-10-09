export class HttpError extends Error {
  code: number = 0;

  constructor(code: number, message: string) {
    super(message);
    this.code = code;
    this.name = 'HttpError';
  }
}
