import { HttpClient } from 'network';
import { Post } from '../model/Post';

export class PostApi {
  static list(): Promise<Post[]> {
    return HttpClient.get<Post[]>('/posts');
  }

  static detail(id: number): Promise<Post> {
    return HttpClient.get<Post>(`/posts/${id}`);
  }
}
