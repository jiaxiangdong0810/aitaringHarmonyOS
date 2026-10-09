import { DetailParam } from '../model/DetailParam';
import { DetailViewModel } from '../viewmodel/DetailViewModel';

@Entry
@ComponentV2
struct Detail {
  @Local vm: DetailViewModel = new DetailViewModel();

  aboutToAppear(): void {
    const params = this.getUIContext().getRouter().getParams() as DetailParam;
    this.vm.applyParam(params);
  }

  build() {
    Column() {
      Text('详情')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text(this.vm.received)
        .fontSize(16)
        .fontColor('#0A59F7')
        .width('100%')
        .margin({ top: 12 })

      TextInput({ placeholder: '再写一句备注', text: this.vm.note })
        .width('100%')
        .height(48)
        .margin({ top: 24 })
        .backgroundColor('#FFFFFF')
        .onChange((value: string) => {
          this.vm.onNoteChange(value);
        })

      if (this.vm.result.length > 0) {
        Text(this.vm.result)
          .fontSize(16)
          .width('100%')
          .margin({ top: 16 })
      }

      Button('合成展示')
        .width('100%')
        .height(44)
        .margin({ top: 24 })
        .onClick(() => {
          this.vm.combine();
        })

      Button('打印日志')
        .width('100%')
        .height(44)
        .margin({ top: 12 })
        .backgroundColor('#E8F3FF')
        .fontColor('#0A59F7')
        .onClick(() => {
          this.vm.printLogs();
        })

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
