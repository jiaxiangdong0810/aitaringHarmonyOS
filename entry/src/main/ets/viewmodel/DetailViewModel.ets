import { LogLevel, logUtils } from 'basic';
import { DetailParam } from '../model/DetailParam';

@ObservedV2
export class DetailViewModel {
  @Trace name: string = '';
  @Trace note: string = '';
  @Trace received: string = '没有收到名字';
  @Trace result: string = '';

  applyParam(params: DetailParam | undefined): void {
    if (params && params.name && params.name.length > 0) {
      this.name = params.name;
      this.received = `收到名字：${params.name}`;
      return;
    }
    this.name = '';
    this.received = '没有收到名字';
  }

  onNoteChange(value: string): void {
    this.note = value;
    this.result = '';
  }

  combine(): void {
    const note = this.note.trim();
    if (this.name.length === 0) {
      this.result = '没有名字，请返回上一页填写';
      return;
    }
    if (note.length === 0) {
      this.result = '请先写一句备注';
      return;
    }
    this.result = `${this.name}：${note}`;
  }

  printLogs(): void {
    logUtils.write(LogLevel.INFO, 'detail', '基础函数 write');
    logUtils.info('detail', '二级函数 info');
    logUtils.error('detail', '二级函数 error');
    logUtils.jxd('三级函数 jxd');
    logUtils.net('三级函数 net');
  }
}
