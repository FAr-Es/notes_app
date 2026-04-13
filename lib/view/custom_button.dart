import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.textStyle,
    required this.onTap,
    this.buttonColor,
    this.height,
    this.textButtonColor,
    this.border,
    this.radius,
    this.widget,
  });

  final String text;
  final TextStyle? textStyle;
  final void Function() onTap;
  final Color? buttonColor;
  final Color? textButtonColor;
  final double? height;
  final BoxBorder? border;
  final double? radius;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height ?? 48,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: buttonColor ?? Color.fromARGB(255, 11, 217, 217),
        ),
        child: Center(
          child: Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ?widget,
              Text(
                text,
                style:
                    (textStyle ??
                            TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFFFFFFF),
                            ))
                        .copyWith(color: textButtonColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
