export class ColorUtil {
  /**
   * 颜色变淡
   * @param colorCode 颜色代码
   * @param percentage 百分比
   * @returns
   */
 static  lightenColor(colorCode: string, percentage: number): string {
    const color = colorCode.replace('#', '');
    const r = parseInt(color.substring(0, 2), 16);
    const g = parseInt(color.substring(2, 4), 16);
    const b = parseInt(color.substring(4, 6), 16);

    const newR = Math.round(r + (255 - r) * percentage);
    const newG = Math.round(g + (255 - g) * percentage);
    const newB = Math.round(b + (255 - b) * percentage);

    return `#${newR.toString(16).padStart(2, '0')}${newG.toString(16).padStart(2, '0')}${newB.toString(16)
      .padStart(2, '0')}`;
  }

}