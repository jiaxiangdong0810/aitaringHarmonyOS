import { BusinessError } from '@kit.BasicServicesKit';
import { PostApi } from '../api/PostApi';

@ObservedV2
export class PostDetailViewModel {
  @Trace title: string = '';
  @Trace content: string = '';
  @Trace meta: string = '';
  @Trace hint: string = '正在加载';
  @Trace loading: boolean = false;
  @Trace failed: boolean = false;

  async load(id: number): Promise<void> {
    if (id <= 0) {
      this.failed = true;
      this.hint = '没有文章编号';
      return;
    }
    if (this.loading) {
      return;
    }
    this.loading = true;
    this.failed = false;
    this.hint = '正在加载';
    try {
      const post = await PostApi.detail(id);
      this.title = post.title;
      this.content = post.body;
      this.meta = `文章编号 ${post.id} · 用户 ${post.userId}`;
      this.hint = '';
    } catch (error) {
      this.title = '';
      this.content = '';
      this.meta = '';
      this.failed = true;
      this.hint = PostDetailViewModel.messageOf(error);
    }
    this.loading = false;
  }

  private static messageOf(error: Object): string {
    const err = error as BusinessError;
    if (err.message && err.message.length > 0) {
      return err.message;
    }
    return '加载失败';
  }
}
