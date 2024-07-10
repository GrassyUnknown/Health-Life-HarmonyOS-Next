import { ColorUtil } from '../../utils/ColorUtil'
import { CJDateItem } from './CJDateItem'
import { CJCellStyle } from './CJCellStyle'
import { CellStatus } from './CellStatus'
import { SelectedStyle } from './SelectedStyle'
import { CJCalStatusParams } from './CJCalStatusParams'
import { SelectedShape } from './SelectedShape'
import { OptMode } from './OptMode'

@Component
export struct CJDay {
  @State cjCellStatus: CellStatus = new CellStatus()
  @ObjectLink cjDataItem: CJDateItem
  @Prop today: CJDateItem
  @Consume @Watch("__onSelectChange") selectedItems: Array<CJDateItem>
  @Consume cjCalStatus: CJCalStatusParams
  selectedStyle: SelectedStyle = SelectedStyle.ALONE
  /** 默认选中形状 */
  selectedShape: SelectedShape = SelectedShape.RECT
  optMode: OptMode = OptMode.NORMAL
  cjCellStyle: CJCellStyle = new CJCellStyle()
  themeColor: ResourceColor = "#03A9F4"
  @Consume onlyShowCurrMonthDay: boolean
  @Consume showLunar: boolean
  @Consume showJieQi: boolean
  @Consume showJieRi: boolean
  // 点击
  cellClick: (cjDataItem: CJDateItem) => void = () => {
  }
  // ========自定义布局=======
  @BuilderParam buildCellBackground: CustomBuilder = this.BuildCellBackground
  @BuilderParam buildCellBody: CustomBuilder = this.BuildCellBody

  aboutToAppear(): void {
    // if (this.cjDataItem.equalDay(this.today)) {
    //   this.cjCellStatus.fontColor = this.cjCellStyle.todayFontColor
    // } else {
    //   this.cjCellStatus.fontColor = this.cjCellStyle.fontColor
    // }

    this.__onSelectChange()
  }

  build() {
    if (this.onlyShowCurrMonthDay && (this.cjDataItem.isSmallThanStart || this.cjDataItem.isBigThanEnd)) {
      Stack()
    } else {
      Stack() {
        // 背景
        this.CellBackground()

        // 主题内容
        this.CellMain()
      }
      .onClick(() => {

        if ((!this.cjDataItem.isPre && !this.cjDataItem.isNext) ||
          (this.cjDataItem.isPre && this.cjCalStatus.hasPre) ||
          (this.cjDataItem.isNext && this.cjCalStatus.hasNext)) {

          if (this.optMode == OptMode.NORMAL) { // 正常

            this.selectedItems[0] = this.cjDataItem
            // this.cjDataItem.date = 66
          } else if (this.optMode == OptMode.SINGLE) { // 单选

            this.selectedItems[0] = this.cjDataItem

          } else if (this.optMode == OptMode.MULTIPLE) { //多选

            const index = this.containsItem(this.cjDataItem)
            if (index >= 0) {
              this.selectedItems.splice(index, 1)
            } else {
              this.selectedItems.push(this.cjDataItem)
            }

          } else if (this.optMode == OptMode.RANGE) { //范围

            if (this.selectedItems.length == 0) { //一个没选
              this.selectedItems.push(this.cjDataItem)
            } else if (this.selectedItems.length == 1) { // 选了一个
              if (this.cjDataItem.bigThan(this.selectedItems[0])) {
                this.selectedItems.push(this.cjDataItem)
              } else {
                this.selectedItems.splice(0, 0, this.cjDataItem)
              }

            } else if (this.selectedItems.length == 2) { // 选了两个
              this.selectedItems.splice(0, 2)
              this.selectedItems.push(this.cjDataItem)
            }

          }

        }

        // 回调点击
        this.cellClick(this.cjDataItem)
      })
    }
  }

  @Builder
  BuildCellBackground() {

  }

  @Builder
  BuildCellBody() {

  }

  @Builder
  CellBackground() {
    Stack() {
      if (this.buildCellBackground) {
        this.buildCellBackground()
      }
    }
    .width('100%')
    .aspectRatio(1)
    .clip(true)
  }

  @Builder
  CellMain() {
    if (this.buildCellBody) {
      this.buildCellBody()
    }
  }

  __onSelectChange() {
    // 初始化颜色
    if (this.cjDataItem.isPre || this.cjDataItem.isNext) {
      this.cjCellStatus.fontColor = this.cjCellStyle.disabledFontColor
    } else if (this.cjDataItem.equalDay(this.today)) {
      this.cjCellStatus.fontColor = this.cjCellStyle.todayFontColor
    }

    if (this.optMode == OptMode.NORMAL || this.optMode == OptMode.SINGLE) { // 正常

      if (this.cjDataItem.equalDay(this.selectedItems[0])) {
        // this.cjCellStatus.selected = true
        this.cjCellStatus.fontColor = this.cjCellStyle.selectFontColor
        this.cjCellStatus.fontSize = this.cjCellStyle.selectFontSize
        this.cjCellStatus.backgroundColor = this.cjCellStyle.selectItemBackgroundColor
      } else {
        // this.cjCellStatus.selected = false
        if (this.cjDataItem.equalDay(this.today)) {
          this.cjCellStatus.fontColor = this.cjCellStyle.todayFontColor
        } else {
          if (!this.cjDataItem.isPre && !this.cjDataItem.isNext) {
            this.cjCellStatus.fontColor = this.cjCellStyle.fontColor
          }
        }
        this.cjCellStatus.fontSize = this.cjCellStyle.fontSize
        this.cjCellStatus.backgroundColor = this.cjCellStyle.itemBackgroundColor
      }

    } else if (this.optMode == OptMode.MULTIPLE) { //多选

      if (this.containsItem(this.cjDataItem) >= 0) {
        if (!this.cjDataItem.isPre && !this.cjDataItem.isNext) {
          this.cjCellStatus.fontColor = this.cjCellStyle.selectFontColor
          this.cjCellStatus.fontSize = this.cjCellStyle.selectFontSize
          this.cjCellStatus.backgroundColor = this.cjCellStyle.selectItemBackgroundColor
        } else {
          this.cjCellStatus.backgroundColor = ColorUtil.lightenColor(
            this.cjCellStyle.selectItemBackgroundColor as string,
            this.cjCellStyle.lightRatio as number)
        }
      } else {
        // this.cjCellStatus.selected = false
        if (this.cjDataItem.equalDay(this.today)) {
          this.cjCellStatus.fontColor = this.cjCellStyle.todayFontColor
        } else {
          if (!this.cjDataItem.isPre && !this.cjDataItem.isNext) {
            this.cjCellStatus.fontColor = this.cjCellStyle.fontColor
          }
        }
        this.cjCellStatus.fontSize = this.cjCellStyle.fontSize
        this.cjCellStatus.backgroundColor = this.cjCellStyle.itemBackgroundColor
      }

    } else if (this.optMode == OptMode.RANGE) { //范围

      let isStart = this.cjDataItem.equalDay(this.selectedItems[0])
      let isEnd = this.cjDataItem.equalDay(this.selectedItems[1])
      if (isStart && !this.selectedItems[1]) {
        isEnd = true
      }

      this.cjCellStatus.isStart = isStart
      this.cjCellStatus.isEnd = isEnd

      if (isStart || isEnd) { // 两端状态

        this.cjCellStatus.fontColor = this.cjCellStyle.selectFontColor
        this.cjCellStatus.backgroundColor = this.cjCellStyle.selectItemBackgroundColor
        this.cjDataItem.equalDay(this.selectedItems[0])
        this.cjCellStatus.fontSize = this.cjCellStyle.selectFontSize

      } else if (this.selectedItems.length == 2 &&
        (this.cjDataItem.bigThan(this.selectedItems[0]) && this.cjDataItem.smallThan(this.selectedItems[1]))) { //中间状态

        if (this.cjDataItem.equalDay(this.today)) {
          this.cjCellStatus.fontColor = this.cjCellStyle.todayFontColor
        } else {
          if (!this.cjDataItem.isPre && !this.cjDataItem.isNext) {
            this.cjCellStatus.fontColor = this.cjCellStyle.fontColor
          }
        }
        this.cjCellStatus.backgroundColor = ColorUtil.lightenColor(
          this.cjCellStyle.selectItemBackgroundColor as string,
          this.cjCellStyle.lightRatio as number);
      } else {
        // this.cjCellStatus.selected = false
        if (this.cjDataItem.equalDay(this.today)) {
          this.cjCellStatus.fontColor = this.cjCellStyle.todayFontColor
        } else {
          if (!this.cjDataItem.isPre && !this.cjDataItem.isNext) {
            this.cjCellStatus.fontColor = this.cjCellStyle.fontColor
          }
        }
        this.cjCellStatus.fontSize = this.cjCellStyle.fontSize
        this.cjCellStatus.backgroundColor = this.cjCellStyle.itemBackgroundColor
      }
    }
  }

  containsItem(cellItem: CJDateItem): number {
    return this.selectedItems.findIndex(item => item.equalDay(cellItem))
  }
}