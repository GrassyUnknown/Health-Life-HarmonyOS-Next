/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { display, router } from '@kit.ArkUI';
import WeekCalendarMethods, { ScrollTo } from '../../viewmodel/CalendarViewModel';
import { HomeStore } from '../../viewmodel/HomeViewModel';
import HealthText from '../../view/HealthTextComponent';
import { WeekDateModel } from '../../model/WeekCalendarModel';
import { sameDate } from '../../common/utils/Utils';
import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';
import { CJCalendar } from 'cjcalendar'
import { TaskDetailDialog } from '../dialog/TaskDetailDialog';

export const WEEK_DAY_WIDTH: number = 100 / Const.WEEK_DAY_NUM;
const DEFAULT_SCROLL_WIDTH = 336; // default calendar width
const DEFAULT_SCROLL_PERCENT = 0.934; // default calendar width percent

@Component
export struct WeekCalendar {
  @Link homeStore: HomeStore;//@Link装饰的变量与其父组件中的数据源共享相同的值
  currentPage: number = 1;
  private scroller: Scroller = new Scroller();
  scrollWidth: number = DEFAULT_SCROLL_WIDTH;
  private isLoadMore: boolean = false;
  private isPageScroll: boolean = false;

  aboutToAppear() {
    try {
      let displayClass = display.getDefaultDisplaySync();
      this.scrollWidth = displayClass.width / displayClass.densityPixels * DEFAULT_SCROLL_PERCENT;
      Logger.info('HomeIndex', 'get the window scrollWidth: ' + this.scrollWidth);
    } catch (err) {
      Logger.error('HomeIndex->onScrollEnd', JSON.stringify(err));
    }
    // 设置为当天 （周历标题显示相关）
    this.homeStore.setSelectedShowDate(new Date().getTime());
  }
  // 获取该天进度
  getProgressImg(item: WeekDateModel): Resource {
    let finNum = item.dayInfo?.finTaskNum || 0;
    // 0
    if (finNum === 0) {
      return $r('app.media.ic_home_undone');
    }
    // 完成
    if (finNum === (item.dayInfo?.targetTaskNum || 0)) {
      return $r('app.media.ic_home_all_done');
    }
    // other
    return $r('app.media.ic_home_half_done');
  }

  @Builder // 日历的左右箭头
  ArrowIcon(isRight: boolean) {
    Row() {
      Image($r('app.media.ic_right_grey'))
        .width($r('app.float.default_6'))
        .height($r('app.float.default_12'))
    }
    .width($r('app.float.default_20'))
    .height($r('app.float.default_20'))
    .rotate({ z: 1, angle: isRight ? 0 : Const.DEFAULT_180 })
    .justifyContent(FlexAlign.Center)
    .onClick(() => isRight ? // 点击右边 左边箭头的触发事件
    WeekCalendarMethods.goToNextWeek(this.currentPage, this.isPageScroll, this.homeStore, this.scroller) :
    WeekCalendarMethods.gotoPreviousWeek(this.isPageScroll, this.homeStore, this.currentPage, this.scroller))
  }

  build() {
    Row() {
      Column() {
        Row() {
          this.ArrowIcon(false) // 箭头
          HealthText({ title: this.homeStore.dateTitle, fontSize: $r('app.float.default_14') })
            .margin($r('app.float.default_12'))
          this.ArrowIcon(true)
          // Button({ type: ButtonType.Circle, stateEffect: true }) {
          //   LoadingProgress().width(30).height(20).color(0xFFFFFF)
          // }.width(55).height(55).margin({ left: 20 }).backgroundColor(0xF55A42)
          // .onClick(()=>{
          //
          //   // router.pushUrl({
          //   //   url: 'pages/MonthCalendar',
          //   //   params: {
          //   //     data1: 'message',
          //   //     data2: {
          //   //       data3: [123, 456, 789]
          //   //     }
          //   //   }
          //   // })
          // })
        }
        .justifyContent(FlexAlign.Center)

        Scroll(this.scroller) {
          Row() {// 周历
            ForEach(this.homeStore.dateArr, (item: WeekDateModel, index?: number) => {
              // 一周的每个天
              Column() {
                // ‘一’ ‘二’ ... 选中是蓝
                Text(item.weekTitle)
                  .fontSize($r('app.float.default_12'))
                  .fontWeight(Const.FONT_WEIGHT_500)
                  // 如果是选中的天，就blue sameDate
                  .fontColor(sameDate(item.date, this.homeStore.showDate) ?
                  $r('app.color.blueColor') : $r('app.color.titleColor'))
                  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
                  .opacity(Const.OPACITY_6)
                // 分隔符 也是选中是blue 不选背景色
                Divider()
                  .margin({ top: Const.DEFAULT_2, bottom: $r('app.float.default_4') })
                  .width($r('app.float.default_12'))
                  .color(sameDate(item.date, this.homeStore.showDate) ? $r('app.color.blueColor') : $r('app.color.white'))
                //渲染每个天的成就进度图片
                Image(this.getProgressImg(item))
                  .height($r('app.float.default_28'))
                  .objectFit(ImageFit.Contain)
                  .margin({ top: Const.THOUSANDTH_80 })
              }
              .width(`${WEEK_DAY_WIDTH}%`)
              .justifyContent(FlexAlign.SpaceBetween)
              // 点击事件 set下date 方法具体实现都在CalendarViewModel.ets
              .onClick(() => WeekCalendarMethods.calenderItemClickAction(item, index, this.homeStore))
            })
          }
        }
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Horizontal)
        .width(Const.THOUSANDTH_1000)
        .onScrollStop(() => this.onScrollEndAction())
        .onScrollEdge((event) => this.onScrollEdgeAction(event))
      }
      .borderRadius($r('app.float.default_24'))
      .backgroundColor($r('app.color.white'))
      .width(Const.THOUSANDTH_1000)
      .height(Const.THOUSANDTH_1000)
      .padding({ top: Const.THOUSANDTH_50, bottom: Const.THOUSANDTH_120 })

    }
    .width(Const.THOUSANDTH_1000)
    .height(Const.THOUSANDTH_420)
    .padding(Const.THOUSANDTH_33)
  }

  onScrollEndAction() {
    if (this.isPageScroll === false) {
      let page = Math.round(this.scroller.currentOffset().xOffset / this.scrollWidth);
      page = (this.isLoadMore === true) ? page + 1 : page;
      if (this.scroller.currentOffset().xOffset % this.scrollWidth != 0 || this.isLoadMore === true) {
        let xOffset = page * this.scrollWidth;
        this.scroller.scrollTo({ xOffset, yOffset: 0 } as ScrollTo);
        this.isLoadMore = false;
      }
      this.currentPage = this.homeStore.dateArr.length / Const.WEEK_DAY_NUM - page - 1;
      Logger.info('HomeIndex', 'onScrollEnd: page ' + page + ', listLength ' + this.homeStore.dateArr.length);
      let dayModel: WeekDateModel = this.homeStore.dateArr[Const.WEEK_DAY_NUM * page+this.homeStore.selectedDay];
      Logger.info('HomeIndex', 'currentItem: ' + JSON.stringify(dayModel) + ', selectedDay  ' + this.homeStore.selectedDay);
      this.homeStore!.setSelectedShowDate(dayModel!.date!.getTime());
    }
    this.isPageScroll = false;
  }

  onScrollEdgeAction(side: Edge) {
    if (side === Edge.Top && this.isPageScroll === false) {
      Logger.info('HomeIndex', 'onScrollEdge: currentPage ' + this.currentPage);
      if ((this.currentPage + 2) * Const.WEEK_DAY_NUM >= this.homeStore.dateArr.length) {
        Logger.info('HomeIndex', 'onScrollEdge: load more data');
        let date: Date = new Date(this.homeStore.showDate);
        date.setDate(date.getDate() - Const.WEEK_DAY_NUM);
        this.homeStore.getPreWeekData(date, () => {
        });
        this.isLoadMore = true;
      }
    }
  }
}