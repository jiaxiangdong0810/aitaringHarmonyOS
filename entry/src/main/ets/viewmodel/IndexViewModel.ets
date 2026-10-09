import { DetailParam } from '../model/DetailParam';

@ObservedV2
export class IndexViewModel {
  @Trace name: string = '';
  @Trace hint: string = '输入名字后可以生成展示，或跳到详情页';
  @Trace summary: string = '';

  onNameChange(value: string): void {
    this.name = value;
    this.summary = '';
    const trimmed = value.trim();
    this.hint = trimmed.length === 0 ? '名字不能为空' : `已输入 ${trimmed.length} 个字`;
  }

  confirm(): void {
    const name = this.name.trim();
    if (name.length === 0) {
      this.summary = '';
      this.hint = '名字不能为空';
      return;
    }
    this.summary = `你好，${name}。名字共 ${name.length} 个字。`;
    this.hint = '可以跳转到详情页';
  }

  buildDetailParam(): DetailParam | null {
    const name = this.name.trim();
    if (name.length === 0) {
      this.hint = '请先输入名字再跳转';
      return null;
    }
    const param = new DetailParam();
    param.name = name;
    return param;
  }

  onJumpFailed(message: string): void {
    this.hint = `跳转失败：${message}`;
  }
}
