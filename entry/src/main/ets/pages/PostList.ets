import { BusinessError } from '@kit.BasicServicesKit';
import { Post } from '../model/Post';
import { PostRouteParam } from '../model/PostRouteParam';
import { PostListViewModel } from '../viewmodel/PostListViewModel';

@Entry
@ComponentV2
struct PostList {
  @Local vm: PostListViewModel = new PostListViewModel();

  aboutToAppear(): void {
    this.vm.load();
  }

  build() {
    Column() {
      Text('文章')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text('http://jsonplaceholder.typicode.com/posts')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .margin({ top: 8 })

      Text(this.vm.hint)
        .fontSize(14)
        .fontColor(this.vm.failed ? '#E84026' : '#666666')
        .width('100%')
        .margin({ top: 8 })

      Button(this.vm.loading ? '加载中' : '刷新')
        .width('100%')
        .height(44)
        .margin({ top: 16 })
        .enabled(!this.vm.loading)
        .onClick(() => {
          this.vm.load();
        })

      List({ space: 12 }) {
        ForEach(this.vm.posts, (item: Post) => {
          ListItem() {
            Column() {
              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .width('100%')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(item.body)
                .fontSize(14)
                .fontColor('#666666')
                .width('100%')
                .margin({ top: 6 })
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Start)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
          }
          .onClick(() => {
            const param = new PostRouteParam();
            param.id = item.id;
            this.getUIContext().getRouter().pushUrl({
              url: 'pages/PostDetail',
              params: param
            }).catch((error: BusinessError) => {
              this.vm.onJumpFailed(error.message);
            });
          })
        }, (item: Post) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .margin({ top: 16 })

      Button('返回')
        .width('100%')
        .height(44)
        .margin({ top: 12 })
        .backgroundColor('#E8F3FF')
        .fontColor('#0A59F7')
        .onClick(() => {
          this.getUIContext().getRouter().back();
        })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#F5F6F8')
  }
}
