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
import promptAction from '@ohos.promptAction';
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
    funct: ()=>{
      AlertDialog.show(
        {
          title: '检查更新', //弹窗标题
          message: '当前已是最新版本', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Bottom, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          primaryButton: { //主要按钮，位于左侧
            value: '确认', //按钮内容
            fontColor: Color.Black, //字体颜色
            action: () => { //点击回调
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
          }
        }
      )
    }
  },
  {
    id: '3',
    title: $r('app.string.mine_about'),
    funct: ()=>{
      AlertDialog.show(
        {
          title: '关于', //弹窗标题
          message: '健康生活 Version 5.0\n点燃星海 Copyright 2024', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Bottom, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          primaryButton: { //主要按钮，位于左侧
            value: '确认', //按钮内容
            fontColor: Color.Black, //字体颜色
            action: () => { //点击回调
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
          }
        }
      )
    }
  },
  {
    id: '4',
    title: $r('app.string.mine_introduce'),
    funct: ()=>{
      AlertDialog.show(
        {
          title: '功能介绍', //弹窗标题
          message: '1. 用户可以创建最多7个健康生活任务（早起，喝水，吃苹果，每日微笑，刷牙，早睡，跑步），并设置任务目标、是否开启提醒、提醒时间、每周任务频率。' +
          '\n2. 用户可以在主页面对设置的健康生活任务进行打卡，其中早起、每日微笑、刷牙和早睡只需打卡一次即可完成任务，喝水、吃苹果需要根据任务目标量多次打卡完成。' +
          '\n3. 主页可显示当天的健康生活任务完成进度，当天所有任务都打卡完成后，进度为100%，并且用户的连续打卡天数加一。' +
          '\n4. 当用户连续打卡天数达到3、7、30、50、73、99天时，可以获得相应的成就。成就在获得时会以动画形式弹出，并可以在“成就”页面查看。' +
          '\n5. 用户可以查看以前的健康生活任务完成情况。' +
          '\n6. 打开应用，显示主页面，点击加号添加任务，添加完任务后，任务列表显示所有添加的任务。' +
          '\n7. 应用退出到后台，长按应用，点击服务卡片，选择2x4卡片，添加到桌面，显示已添加任务。' +
          '\n8. 应用退出到后台，长按应用，点击服务卡片，选择2x2卡片，添加到桌面，显示任务完成进度。' +
          '\n9. 点击2x2或2x4元服务卡片，拉起主页面，看到任务列表。' +
          '\n10. 在卡片配置文件中，设置卡片更新时间，更新时间到后，桌面上2x2或2x4卡片会重置第二天任务，需要重新添加。', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Bottom, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          primaryButton: { //主要按钮，位于左侧
            value: '确认', //按钮内容
            fontColor: Color.Black, //字体颜色
            action: () => { //点击回调
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
          }
        }
      )
    }
  }
];