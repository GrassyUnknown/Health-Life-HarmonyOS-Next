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

import { CustomDialogCallback } from './CustomDialogView';
import TaskInfo from '../../viewmodel/TaskInfo';
import { TaskMapById } from '../../model/TaskInitList';
import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import { GlobalContext } from '../../common/utils/GlobalContext';
import { CJCalendar, CJDateItem, OptMode, SelectedStyle } from 'cjcalendar'
import { HomeStore } from '../../viewmodel/HomeViewModel';

@Extend(Text)
function textStyle() {
  .fontColor($r('app.color.white'))
  .fontFamily($r('app.string.HarmonyHeiTi'))
}

@Extend(Text)
function taskTextStyle() {
  .fontColor($r('app.color.white'))
  .width('100%')
}

@CustomDialog
export struct TaskDetailDialog {
  @Link homeStore: HomeStore;
  controller: CustomDialogController = new CustomDialogController({ builder: '' });
  @Consume currentTask: TaskInfo;
  @State showButton: boolean = true;
  @Consume dialogCallBack: CustomDialogCallback;

  build() {
    Column() {
      TaskBaseInfo({
        taskName: TaskMapById[this.currentTask?.taskID - 1].taskName
      });

      TaskClock({
        curTaskID:this.currentTask?.taskID,
        myMonthHomeStore:this.homeStore,
        confirm: () => {
          this.dialogCallBack.confirmCallback(this.currentTask);
          this.controller.close();
        },
        cancel: () => {
          this.controller.close();
        },
        showButton: this.showButton
      })
    }
    .height($r('app.float.default_451'))
    .width($r('app.float.default_316'))
    .backgroundImage(TaskMapById[this.currentTask?.taskID - 1].dialogBg, ImageRepeat.NoRepeat)
    .backgroundImageSize({
      width: '100%',
      height: '100%'
    })
    .justifyContent(FlexAlign.End)
    .padding({
      bottom: $r('app.float.default_12'),
      left: $r('app.float.default_20')
    })
  }
}

@Component
struct TaskBaseInfo {
  taskName: string | Resource = '';

  build() {
    Column({ space: Const.DEFAULT_8 }) {
      Text(this.taskName)
        .fontSize($r('app.float.default_22'))
        .fontWeight(FontWeight.Bold)
        .fontFamily($r('app.string.HarmonyHeiTi_Bold'))
        .taskTextStyle()
        .margin({ left: $r('app.float.default_12') })
    }
    .position({ y: $r('app.float.default_267') })
  }
}

@Component
struct TaskClock {
  // curTask:TaskInfo=new TaskInfo(0, '', 0, '', false, '', '', '', false, '');
  curTaskID:number=0;
  myMonthHomeStore:HomeStore=  new HomeStore(new Date());
  // @Builder cellLayout(item: CJDateItem) {
  //   Column() {
  //     Text(item.date + "")
  //       .fontSize(18)
  //       .fontColor(item.isPre || item.isNext ? "#CCCCCC" : "#323232")
  //     Text("你好")
  //       .fontSize(12)
  //   }
  // }
  //item: CJDateItem = new CJDateItem(new Date())
  confirm: Function = () => {
  };
  cancel: Function = () => {
  };
  showButton: boolean = false;


  getAchieveDate() {
    let selectedItems: Array<string | Date> = [];
    for (let dayTaskInfoList of this.myMonthHomeStore.MonthTaskListArr) {
      if(dayTaskInfoList.length!=0){
        let filteredDayTaskInfoList = dayTaskInfoList.filter((taskItem) =>
        (taskItem.taskID === this.curTaskID) && taskItem.isDone
        );
        filteredDayTaskInfoList.forEach(element => {
          selectedItems.push(element.date)
        });
      }
    }
    return selectedItems;
  }

  build() {
    Column({ space: Const.DEFAULT_12 }) {
    //Column() {
      //CJCalendar()//日历
      CJCalendar({
        defSelectedItems: this.getAchieveDate()
      })
      Button() {
        Text($r('app.string.clock_in'))
          .height($r('app.float.default_42'))
          .fontSize($r('app.float.default_20'))
          .fontWeight(FontWeight.Normal)
          .textStyle()
      }
      .width($r('app.float.default_220'))
      .borderRadius($r('app.float.default_24'))
      .backgroundColor('rgba(255,255,255,0.40)')
      .onClick(() => {
        GlobalContext.getContext().setObject('taskListChange', true);
        this.confirm();
      })
      .visibility(!this.showButton ? Visibility.None : Visibility.Visible)
      Text($r('app.string.got_it'))
        .fontSize($r('app.float.default_14'))
        .fontWeight(FontWeight.Regular)
        .textStyle()
        .onClick(() => {
          this.cancel();
        })
    }.alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)
  }
}

