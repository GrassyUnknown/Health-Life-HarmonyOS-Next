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

import { relationalStore } from '@kit.ArkData';
import SelfInfo from '../../../viewmodel/SelfInfo';
import { CommonConstants as Const } from '../../constants/CommonConstants'
import RdbUtils from '../rdb/RdbUtils';
import Logger from '../../utils/Logger';
import GlobalInfo from '../../../viewmodel/GlobalInfo';

export class SelfInfoApi {

  /**
   * Insert selfInfo.
   *
   * @param selfInfo
   * @param callback
   */
  insertData(selfInfo: SelfInfo): void {
    const valueBucket = generateBucket(selfInfo);
    RdbUtils.insert('SelfInfo', valueBucket).then(result => {
      Logger.info('SelfInfoTable', 'Insert selfInfo finished with code', result.toString());
      return result;
    });
  }

  /**
   * Update selfInfo.
   *
   * @param selfInfo
   * @param callback
   */
  updateData(selfInfo: SelfInfo): number {
    const valueBucket = generateBucket(selfInfo);
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(Const.SELF_INFO.tableName ? Const.SELF_INFO.tableName : '');
    predicates.equalTo('id', 0);
    RdbUtils.update(valueBucket, predicates).then((result: number) => {
      Logger.info('SelfInfoTable', 'Update selfInfo finished with code', result.toString());
      return result;
    });
    return -1;
  }

  /**
   * Query selfInfo.
   *
   * @param callback
   */
  query(callback: Function): void {
    let predicates = new relationalStore.RdbPredicates(Const.SELF_INFO.tableName ? Const.SELF_INFO.tableName : '');
    console.info("SelfInfoTable type:" + Const.SELF_INFO.tableName ? Const.SELF_INFO.tableName : '')
    predicates.equalTo('id', 0);
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0) {
        Logger.info('SelfInfoTable', 'query no results!');
        let result = new SelfInfo('', 'xzai', '', '', '', '');
        callback(result);
      } else {
        Logger.info('SelfInfoTable:' + count);
        let result = new SelfInfo('', '', '', '', '', '');
        resultSet.goToFirstRow();
        result.img = resultSet.getString(resultSet.getColumnIndex('img'));
        result.name = resultSet.getString(resultSet.getColumnIndex('name'));
        result.birth = resultSet.getString(resultSet.getColumnIndex('birth'));
        result.gender = resultSet.getString(resultSet.getColumnIndex('gender'));
        result.hobby = resultSet.getString(resultSet.getColumnIndex('hobby'));
        result.sig = resultSet.getString(resultSet.getColumnIndex('sig'));
        callback(result);
      }
    });
  }
}

function generateBucket(selfInfo: SelfInfo): relationalStore.ValuesBucket {
  let valueBucket = {} as relationalStore.ValuesBucket;
  Const.SELF_INFO.columns?.forEach((item: string) => {
    if (item === 'id') {
      valueBucket[item] = 0;
    } else {
      switch (item) {
        case 'img':
          valueBucket[item] = selfInfo.img;
          break;
        case 'name':
          valueBucket[item] = selfInfo.name;
          break;
        case 'birth':
          valueBucket[item] = selfInfo.birth;
          break;
        case 'gender':
          valueBucket[item] = selfInfo.gender;
          break;
        case 'hobby':
          valueBucket[item] = selfInfo.hobby;
          break;
        case 'sig':
          valueBucket[item] = selfInfo.sig;
          break;
        default:
          break;
      }
    }
  });
  return valueBucket;
}

let selfInfoApi = new SelfInfoApi();

export default selfInfoApi as SelfInfoApi;
