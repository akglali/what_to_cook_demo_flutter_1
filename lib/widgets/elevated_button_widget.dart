import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    Key? key,
    required this.screenWidth,
    required this.onPressed,
    required this.text,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.icon,
  }) : super(key: key);

  final double screenWidth;
  final VoidCallback onPressed;
  final String text;
  final MaterialStateProperty<Color?>? foregroundColor;
  final MaterialStateProperty<Color?>? backgroundColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: icon,
                ),
              ),
              TextSpan(
                  text: text,
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.05)),
            ],
          ),
        ));
  }
}
