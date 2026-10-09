import { BusinessError } from '@kit.BasicServicesKit';
import { IndexViewModel } from '../viewmodel/IndexViewModel';

@Entry
@ComponentV2
struct Index {
  @Local vm: IndexViewModel = new IndexViewModel();

  build() {
    Column() {
      Text('填写信息')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text(this.vm.hint)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .margin({ top: 8 })

      TextInput({ placeholder: '请输入名字', text: this.vm.name })
        .width('100%')
        .height(48)
        .margin({ top: 24 })
        .backgroundColor('#FFFFFF')
        .onChange((value: string) => {
          this.vm.onNameChange(value);
        })

      if (this.vm.summary.length > 0) {
        Text(this.vm.summary)
          .fontSize(16)
          .fontColor('#0A59F7')
          .width('100%')
          .margin({ top: 16 })
      }

      Button('生成展示')
        .width('100%')
        .height(44)
        .margin({ top: 24 })
        .onClick(() => {
          this.vm.confirm();
        })

      Button('去详情')
        .width('100%')
        .height(44)
        .margin({ top: 12 })
        .backgroundColor('#E8F3FF')
        .fontColor('#0A59F7')
        .onClick(() => {
          const param = this.vm.buildDetailParam();
          if (!param) {
            return;
          }
          this.getUIContext().getRouter().pushUrl({
            url: 'pages/Detail',
            params: param
          }).catch((error: BusinessError) => {
            this.vm.onJumpFailed(error.message);
          });
        })

      Button('文章列表')
        .width('100%')
        .height(44)
        .margin({ top: 12 })
        .backgroundColor('#E8F3FF')
        .fontColor('#0A59F7')
        .onClick(() => {
          this.getUIContext().getRouter().pushUrl({
            url: 'pages/PostList'
          }).catch((error: BusinessError) => {
            this.vm.onJumpFailed(error.message);
          });
        })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#F5F6F8')
  }
}
