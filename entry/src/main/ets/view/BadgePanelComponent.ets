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

import { BadgeCard } from './BadgeCardComponent'
import { getAchievementLevel } from '../model/AchieveModel'
import { getBadgeCardItems } from '../viewmodel/AchievementViewModel'
import Logger from '../common/utils/Logger'
import { ACHIEVEMENT_LEVEL_KEY } from '../model/AchieveModel'
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import CardInfo from '../viewmodel/CardInfo'
import { BadgeCard_morning_single } from './morning_single_task'
import { BadgeCard_drink_single } from './drink_single_task'
import { BadgeCard_apple_single } from './apple_single_rask'
import { BadgeCard_smile_single } from './smile_single_task'
import { BadgeCard_brush_single } from './brush_single_task'
import { BadgeCard_sleep_single } from './sleep_single_task'
import { getBadgeCardItems_single } from '../viewmodel/AchievementViewModel_single'


@Component
export struct BadgePanel {
  @StorageProp(ACHIEVEMENT_LEVEL_KEY) successiveDays: number = 0;
  scroller: Scroller = new Scroller();

  aboutToAppear() {
    Logger.debug('BadgePanel', 'aboutToAppear');
    getAchievementLevel();
  }
  build() {
    Scroll(this.scroller){
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap })
      {
        ForEach(getBadgeCardItems(this.successiveDays), (item: CardInfo) =>
        {
          BadgeCard({ content: item.titleContent, imgSrc: item.achievement })
        })
        ForEach(getBadgeCardItems_single(this.successiveDays), (item: CardInfo) =>
        {
          BadgeCard_morning_single({ content: item.titleContent, imgSrc: item.achievement })
          BadgeCard_drink_single({ content: item.titleContent, imgSrc: item.achievement })
          BadgeCard_apple_single({ content: item.titleContent, imgSrc: item.achievement })
          BadgeCard_smile_single({ content: item.titleContent, imgSrc: item.achievement })
          BadgeCard_brush_single({ content: item.titleContent, imgSrc: item.achievement })
          BadgeCard_sleep_single({ content: item.titleContent, imgSrc: item.achievement })
        })
      }
      .width(Const.FULL_WIDTH)
    }
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    .scrollBar(BarState.Auto)  // 滚动条自动显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(4) // 滚动条宽度
    .edgeEffect(EdgeEffect.None)
    .onScroll((xOffset: number, yOffset: number) => {
      console.info(xOffset + ' ' + yOffset)
    })
    .onScrollEdge((side: Edge) => {
      console.info('To the edge')
    })
    .onScrollStop(() => {
      console.info('Scroll Stop')
    })
    .height('91%')
  }

  onScrollAction() {
    throw new Error('Method not implemented.')
  }
}

