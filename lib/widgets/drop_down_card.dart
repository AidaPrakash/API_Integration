
import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/styles.dart';

class DropDownCard extends StatelessWidget {

  String title;
  Widget child;
  EdgeInsets margin;

  DropDownCard(this.title, {this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          title == "" ? Container() : Text(title, textScaleFactor: 1, style: AppTextStyle.label,),

          Padding(padding: EdgeInsets.only(top: title == "" ? 0 :  10),),

          Container(
            decoration: BoxDecoration(
                color: AppColor.secondaryBackground,
                border: Border.all(color: Colors.black12)
            ),

            padding: EdgeInsets.only(left: 10, right: 10),

            child: child,
          )

        ],
      ),
    );
  }
}
