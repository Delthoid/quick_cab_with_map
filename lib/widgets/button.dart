import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_cab/configs/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.maximize = true,
    this.buttonColor,
    this.height = 60,
    this.textColor = Colors.white,
    this.wrap = false,
    this.fontSize = 18,
    this.showLoading = false,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final bool? maximize;
  final Color? buttonColor;
  final double? height;
  final Color? textColor;
  final bool? wrap;
  final double? fontSize;
  final bool? showLoading;

  factory CustomButton.small(
    String text,
    Function() onPressed,
    Color textColor,
    Color buttonColor,
    bool wrap,
    double fontSize,
  ) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      textColor: textColor,
      buttonColor: buttonColor,
      wrap: wrap,
      fontSize: fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      child: wrap!
          ? Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            )
          : Container(
              alignment: Alignment.center,
              height: height,
              child: showLoading!
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          textColor ?? Colors.white,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor ?? Theme.of(context).primaryColor,
        ),
        elevation: MaterialStateProperty.all<double>(0),
      ),
    );
  }
}
