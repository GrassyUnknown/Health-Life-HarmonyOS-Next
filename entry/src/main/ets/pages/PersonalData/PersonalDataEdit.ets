import Context from '@ohos.app.ability.common';

@Component
struct TextFrame{
  @Link content: string;
  private textImage:Resource = $r('app.media.per_name');
  private text:string = '个人信息';
  onTextClick:()=>void = () => {
    console.info('onTextClick')
  };

  build(){
    Row(){
      Image(this.textImage)
        .width(24)
        .height(24)
        .margin({left:12})
      Text(this.text)
        .fontSize(16)
        .margin({ left:12 })
        .height(24)
      Text(this.content)
        .fontSize(16)
        .textAlign(TextAlign.End)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .margin({
          left: 16,
          right: 7
        })
        .layoutWeight(1)
        .width('100%')
      Image($r('app.media.per_name'))
        .width(12)
        .height(24)
        .margin({ right: 14 })
    }
    .margin({ top: 24 })
    .borderRadius(24)
    .backgroundColor(Color.White)
    .width('93.3%')
    .height(64)
    .onClick(this.onTextClick)
  }
}

@Component
struct InputFrame{
  private inputImage: Resource = $r('app.media.per_name');
  private hintText: string = '';

  build(){
    Row() {
      Image(this.inputImage)
        .width(24)
        .height(24)
        .margin({ left: 12 })
      TextInput({ placeholder: this.hintText })
        .fontSize(16)
        .padding({ left: 12 })
        .placeholderColor('#99000000')
        .backgroundColor(Color.White)
        .fontWeight(FontWeight.Normal)
        .fontStyle(FontStyle.Normal)
        .fontColor(Color.Black)
        .margin({ right: 32 })
        .layoutWeight(1)
        .height(48)
    }
    .margin({ top: 24 })
    .borderRadius(24)
    .backgroundColor(Color.White)
    .width('93.3%')
    .height(64)
  }
}

@Entry
@Component
struct PersonalEditIndex {
  @State birthdate: string = '';
  @State sex: string = '';
  @State textValue: string = '';
  @State inputValue: string = '';
  selectedDate: Date = new Date("2010-1-1")
  selectedGender:number = 0
  private sexArray: string[] = ['男', '女'];

  alertDialog(context: Context.UIAbilityContext) {
    AlertDialog.show({
      message: '当前数据未保存，是否确认离开？',
      alignment: DialogAlignment.Bottom,
      offset: {
        dx: 0,
        dy: -20
      },
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('Callback cancel button is clicked');
        }
      },
      secondaryButton: {
        value: '确定',
        action: () => {
          // Exiting the app.
          context.terminateSelf();
          console.info('Callback definite button is clicked');
        }
      }
    });
  }

  datePickerDialog() {
    DatePickerDialog.show({
      start: new Date('1900-1-1'),
      end: new Date('2100-1-1'),
      selected: this.selectedDate,
      lunar: false,
      onAccept: (value: DatePickerResult) => {
        let year = value.year;
        let month = 1;
        if(value.month) {
          let month = value.month + 1;
        }
        let day = value.day;
        let birthdate: string = this.getBirthDateValue(year, month, day);
        this.selectedDate.setFullYear(value.year, value.month, value.day)
        this.birthdate = birthdate;
      }
    });
  }

  textPickerDialog(sexArray: string[], sexCallback:(sexValue: string)=>void) {
    if (this.isEmptyArr(sexArray)) {
      console.error('sex is null');
      return;
    }
    TextPickerDialog.show({
      range: sexArray,
      selected: this.selectedGender,
      onAccept: (result: TextPickerResult) => {
        sexCallback(result.value[0]);
        this.selectedGender = result.index[0]
      },
      onCancel: () => {
        console.info('TextPickerDialog onCancel');
      }
    });
  }

  getBirthDateValue(year: number, month: number, day: number): string {
    let birthdate: string = `${year}${'年'}${month}` +
      `${'月'}${day}${'日'}`;
    return birthdate;
  }

  isEmpty(obj: string[]): boolean {
    return obj === undefined || obj === null;
  }

  isEmptyArr(array: string[]): boolean {
    return this.isEmpty(array) || array.length === 0;
  }

  build() {
    Row() {
      Column() {
        Row(){
          Image($r('app.media.per_back'))
            .width(26)
            .height(26)
            .alignSelf(ItemAlign.Start)
            .margin({
              left: '7.2%',
              top: 19
            })
            .onClick(() => {
              let context = getContext(this) as Context.UIAbilityContext;
              this.alertDialog(context);
            })
          Text('个人信息')
            .fontColor(Color.Black)
            .fontSize(20)
            .margin({ top: 20,left:20 })
            .alignSelf(ItemAlign.Center)
        }
        .width('100%')

        Image($r('app.media.per_name'))
          .width(56)
          .height(56)
          .alignSelf(ItemAlign.Center)
          .margin({ top: '5.5%' })
        Text('头像')
          .fontColor(Color.Black)
          .fontSize(16)
          .margin({ top: '2.1%' })
          .alignSelf(ItemAlign.Center)
        InputFrame({
          inputImage: $r('app.media.per_name'),
          hintText: '昵称'
        })
        TextFrame({
          textImage: $r('app.media.per_birth'),
          text: '出生日期',
          content: $birthdate,
          onTextClick: () => {
            this.datePickerDialog();
          }
        })
        TextFrame({
          textImage: $r('app.media.per_gender'),
          text: '性别',
          content: $sex,
          onTextClick: () => {
            this.textPickerDialog(this.sexArray, (sexValue: string) => {
              this.sex = sexValue;
            });
          }
        })
        InputFrame({
          inputImage: $r('app.media.per_hobby'),
          hintText: '兴趣爱好'
        })
        InputFrame({
          inputImage: $r('app.media.per_sig'),
          hintText: '个性签名'
        })
      }
      .backgroundColor('#F5F5F5')
      .height('100%')
      .width('100%')
    }
    .height('100%')
  }
}