import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/styles.dart';

class Button extends StatelessWidget {

  final Key key;
  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final BorderRadius borderRadius;
  final bool disabled;

  Button(this.text, {@required this.key, this.textStyle = AppTextStyle.button, this.width = 160, this.height = 50, @required this.onPressed,
    this.color = AppColor.primary, this.borderColor = AppColor.primary, this.borderRadius, this.disabled = false});

  Button.outline(this.text, {@required this.key, this.textStyle = AppTextStyle.buttonOutline, this.width = 160, this.height = 50, @required this.onPressed,
    this.color = Colors.transparent, this.borderColor = AppColor.primary, this.borderRadius, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: disabled ? color.withOpacity(0.4) : color,
          borderRadius: borderRadius == null ? BorderRadius.circular(10) : borderRadius,
          border: Border.all(color: borderColor,)
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:  FlatButton(
            key: key,
            onPressed: disabled ? null : onPressed,
            child: Text(text, textScaleFactor: 1, style: textStyle, maxLines: 1, overflow: TextOverflow.fade,),
      ),
        ),
    );
  }

}