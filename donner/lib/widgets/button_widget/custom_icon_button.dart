import 'package:donner/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomIconButton extends CustomButton {
  final Icon? icon;

  const CustomIconButton(
    this.icon, {
    Key? key,
    onPressed,
    text,
    color,
    textStyle,
    width,
    height,
    isFill,
  }) : super(
          key: key,
          onPressed: onPressed,
          width: width,
          height: height,
          text: text,
          color: color,
          textStyle: textStyle,
          isFill: isFill,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isFill ? color : null,
        borderRadius: BorderRadius.circular(5),
        border: isFill ? null : Border.all(color: color),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon!,
            Text(
              text,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
