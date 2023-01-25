extension ImagePath on String{

  String  get toSvg=>"assets/images/$this.svg";
  String  get toGif=>"assets/images/$this.gif";
  String  get toPng=>"assets/images/$this.png";
  String  get toJPG=>"assets/images/$this.jpg";

}