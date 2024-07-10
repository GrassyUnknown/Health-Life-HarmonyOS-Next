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
import CardInfo from './CardInfo';
import { ACHIEVEMENT_LEVEL_LIST, AchievementMap, ACHIEVEMENT_LEVEL_LIST_single } from '../model/TaskInitList';

export function getBadgeCardItems_single(successiveDays: number): Array<CardInfo> {
  let badgeMileStones_single = ACHIEVEMENT_LEVEL_LIST_single;
  let cardItems: Array<CardInfo> = [];
  for (let i = 0; i < badgeMileStones_single.length; i++) {
    let onOrOff = successiveDays >= badgeMileStones_single[i] ? 'on' : 'off';
    let titleContent = String(badgeMileStones_single[i]);
    let cardInfo: CardInfo = new CardInfo();
    cardInfo.titleContent = titleContent;
    cardInfo.achievement = getAchievement(`${onOrOff}_${badgeMileStones_single[i]}`);
    cardItems.push(cardInfo);
  }
  return cardItems;
}

function getAchievement(key: string) {
  let result = $r('app.string.empty');
  switch (key) {
        case 'off_100':
      result = AchievementMap.off_100;
      break;
    case 'on_100':
      result = AchievementMap.on_100;
      break;
    case 'off_200':
      result = AchievementMap.off_200;
      break;
    case 'on_200':
      result = AchievementMap.on_200;
      break;
    case 'off_300':
      result = AchievementMap.off_300;
      break;
    case 'on_300':
      result = AchievementMap.on_300;
      break;
    case 'off_400':
      result = AchievementMap.off_400;
      break;
    case 'on_400':
      result = AchievementMap.on_400;
      break;

    default:
      break;
  }
  return result;
}