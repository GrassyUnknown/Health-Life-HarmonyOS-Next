/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { router } from '@kit.ArkUI';
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import { CJCalendar, OptMode, SelectedStyle } from 'cjcalendar'
import { HomeStore } from '../viewmodel/HomeViewModel';

@Entry
@Component
struct MonthCalendar {
  @Provide @Watch('onParamsChanged') myMonthHomeStore: HomeStore = this.parseRouterParams();
  @State duration: number = Const.AD_DURATION;
  private intervalId: number = -1;
  private isChanged: boolean = false;

  goToHomePage() {
    clearInterval(this.intervalId);
    router.back({
      url: 'pages/MainPage'
  })}
  // 每次改变任务参数时触发
  onParamsChanged() {
    this.isChanged = true;
  }
  parseRouterParams() {
    let params = router.getParams() as Record<string, Object>;
    const routerParams: HomeStore = JSON.parse(params.params as string);
    return routerParams;
  }
  selectedItems: Array<string | Date> = [];
  aboutToAppear() {
    for (let myMonthHomeStoreElement of this.myMonthHomeStore.dateArr) {
      if( myMonthHomeStoreElement.dayInfo.targetTaskNum!=0 && myMonthHomeStoreElement.dayInfo.targetTaskNum == myMonthHomeStoreElement.dayInfo.finTaskNum)
        this.selectedItems.push(myMonthHomeStoreElement.date)

    }
  }


  build() {
    Row(){
    Column() {
      /*Flex({direction: FlexDirection.Row}){

        Text($r('app.string.retHome', this.duration))
          .fontSize($r('app.float.default_14'))
          .fontColor(Color.White)
          .borderRadius($r('app.float.default_16'))
          .letterSpacing(Const.LETTER_1)
          .height($r('app.float.default_42'))
          .backgroundColor('rgba(188, 18, 18, 0.30)')
          .border({ color: $r('app.color.white'), width: $r('app.float.default_1') })
          .margin({ top: $r('app.float.default_36'),left:$r('app.float.default_36') })
          .padding($r('app.float.default_8'))
          .onClick(() => this.goToHomePage())
      }*/
      Row(){
        Image($r('app.media.ic_back_home'))
          .width(26)
          .height(26)
          .alignSelf(ItemAlign.Start)
          .margin({
            left: '7.2%',
            top: 19
          })
          .onClick(() => this.goToHomePage())
        Text('返回首页')
          .fontColor(Color.Black)
          .fontSize(20)
          .margin({ top: 20,left:10 })
          .alignSelf(ItemAlign.Center)
        }
      .width('100%')
      // .justifyContent()
      Row() {
        CJCalendar({
          defSelectedItems: this.selectedItems
        }).height("100%")
      }
    .width('100%')
    .height('100%')
    //.backgroundImagePosition({ x: 0, y: 0 })
    //.backgroundImage($r('app.media.ic_ad_bg'))
    //.backgroundImageSize({ width: '100%', height: '100%' })
    .justifyContent(FlexAlign.SpaceBetween)
      Row() {
        Image($r('app.media.comment'))
          .width($r('app.float.default_100')) // 假设这是你想要的图像宽度
          .height($r('app.float.default_40')) // 假设这是你想要的图像高度)
      }
      .position({ x: '65%', y: '56%'})
      .width($r('app.float.default_316'))
      .height($r('app.float.default_100'))
      .width('100%')
    }
  }
}}
