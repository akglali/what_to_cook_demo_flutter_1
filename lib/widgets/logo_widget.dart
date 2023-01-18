import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var imagePath = "assets/images/dark_logo.png";
    if (!isDarkMode) {
      imagePath = "assets/images/light_logo.jpeg";
    }
    return Padding(
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
                  image: AssetImage(imagePath), fit: BoxFit.fitHeight)),
        ),
      ),
    );
  }
}
