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
import SelfInfoApi from '../common/database/tables/SelfInfoApi';
import SelfInfo from '../viewmodel/SelfInfo';
import { router } from '@kit.ArkUI';


export interface InfoItem {
  id: string;
  title: Resource;
  funct:()=>void;
  icon?: Resource;
}

/*
getSelfInfo(){return selfInfo;}; 获取数据
updateSelfInfo(selfInfo: SelfInfo);  更新数据
 */
export const MineInfoList: InfoItem[] = [
  {
    id: '1',
    title: $r('app.string.mine_personal_data'),
    funct: ()=>{
      router.pushUrl(
        {
          url: 'pages/PersonalData/PersonalDataEdit',
        }
      )
    }
  },
  {
    id: '2',
    title: $r('app.string.mine_check_updates'),
    funct: ()=>{}
  },
  {
    id: '3',
    title: $r('app.string.mine_about'),
    funct: ()=>{}
  }
];