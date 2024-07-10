
import { ratio2percent } from '../common/utils/Utils'
import { CommonConstants as Const } from '../common/constants/CommonConstants';

@Component
export struct BadgeCard_morning_single {
  @Prop content: string = '';
  imgSrc: Resource = $r('app.string.empty');

  build() {
    Column({ space: Const.DEFAULT_18 }) {
      Image(this.imgSrc)
        .width(Const.FULL_WIDTH)
        .height(Const.ACHIEVE_CARD_IMG_HEIGHT)
        .objectFit(ImageFit.Contain)
      Text($r('app.string.task_achievement_single_morning_task', Number(this.content)))
        .lineHeight($r('app.float.default_16'))
        .fontSize($r('app.float.default_12'))
        .fontColor($r('app.color.white'))
    }
    .width(ratio2percent(Const.ACHIEVE_SPLIT_RATIO))
    .padding({ top: Const.ACHIEVE_CARD_TOP, bottom: Const.ACHIEVE_CARD_BOTTOM })
  }
}
