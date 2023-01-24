import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  LogoWidget({
    Key? key,
    required this.height,
    required this.width,

  }) : super(key: key);

  final double height;
  final double width;


  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var imagePath = "assets/images/sign_up_logo_dark.png";
    if (!isDarkMode) {
      imagePath = "assets/images/sign_up_logo_light.jpeg";
    }
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.02),
      child: Hero(
        tag: "Logo",
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

/*Padding(
padding: EdgeInsets.only(
top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
child: Hero(
tag: "Logo",
child: Container(
height: 300,
width: 300,
decoration: BoxDecoration(
shape: BoxShape.circle,
image: DecorationImage(
image: AssetImage(imagePath), fit: BoxFit.cover)),
),
),
);*/
