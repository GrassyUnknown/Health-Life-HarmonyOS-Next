/**
 * GlobalInfo
 *
 * @param img
 * @param name
 * @param birth
 * @param gender
 * @param hobby
 * @param sig
 */
export default class SelfInfo {
  img: string;
  name: string;
  birth: string;
  gender: string;
  hobby: string;
  sig: string;

  constructor(
    img: string = '',
    name: string = '',
    birth: string = '',
    gender: string = '',
    hobby: string = '',
    sig: string = ''
  ) {
    this.img = img;
    this.name = name;
    this.birth = birth;
    this.gender = gender;
    this.hobby = hobby;
    this.sig = sig;
  }

  toString(): string {
    return this.img + ' ' + this.name + ' ' + this.birth + ' ' + this.hobby + ' ' + this.sig;
  }
}