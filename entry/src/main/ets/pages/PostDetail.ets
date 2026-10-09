import { PostRouteParam } from '../model/PostRouteParam';
import { PostDetailViewModel } from '../viewmodel/PostDetailViewModel';

@Entry
@ComponentV2
struct PostDetail {
  @Local vm: PostDetailViewModel = new PostDetailViewModel();

  aboutToAppear(): void {
    const raw = this.getUIContext().getRouter().getParams();
    if (!raw) {
      this.vm.load(0);
      return;
    }
    const params = raw as PostRouteParam;
    this.vm.load(params.id);
  }

  build() {
    Column() {
      Text('文章详情')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      if (this.vm.hint.length > 0) {
        Text(this.vm.hint)
          .fontSize(14)
          .fontColor(this.vm.failed ? '#E84026' : '#666666')
          .width('100%')
          .margin({ top: 8 })
      }

      if (this.vm.meta.length > 0) {
        Text(this.vm.meta)
          .fontSize(14)
          .fontColor('#0A59F7')
          .width('100%')
          .margin({ top: 12 })
      }

      if (this.vm.title.length > 0) {
        Text(this.vm.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .margin({ top: 16 })
      }

      if (this.vm.content.length > 0) {
        Text(this.vm.content)
          .fontSize(16)
          .fontColor('#333333')
          .width('100%')
          .margin({ top: 12 })
      }

      Blank()

      Button('返回')
        .width('100%')
        .height(44)
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
