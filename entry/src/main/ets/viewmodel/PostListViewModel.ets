import { BusinessError } from '@kit.BasicServicesKit';
import { Post } from '../model/Post';
import { PostApi } from '../api/PostApi';

@ObservedV2
export class PostListViewModel {
  @Trace posts: Post[] = [];
  @Trace hint: string = '正在加载文章';
  @Trace loading: boolean = false;
  @Trace failed: boolean = false;

  async load(): Promise<void> {
    if (this.loading) {
      return;
    }
    this.loading = true;
    this.failed = false;
    this.hint = '正在加载文章';
    try {
      const posts = await PostApi.list();
      this.posts = posts;
      this.hint = `已加载 ${posts.length} 篇文章`;
    } catch (error) {
      this.posts = [];
      this.failed = true;
      this.hint = PostListViewModel.messageOf(error);
    }
    this.loading = false;
  }

  onJumpFailed(message: string): void {
    this.failed = true;
    this.hint = `跳转失败：${message}`;
  }

  private static messageOf(error: Object): string {
    const err = error as BusinessError;
    if (err.message && err.message.length > 0) {
      return err.message;
    }
    return '加载失败';
  }
}
