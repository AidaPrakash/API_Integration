import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';

class NumberKeyboard extends StatelessWidget {

  void Function(String data) onChanged;
  BuildContext context;

  NumberKeyboard({this.onChanged, this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: AppColor.scaffoldBackground,
      child: Column(
        children: <Widget>[

          numPadRow("1", "2", "3"),

          numPadRow("4", "5", "6"),

          numPadRow("7", "8", "9"),

          numPadRow(".", "0", "DEL"),

        ],
      )
    );
  }

  Widget numPadRow(String n1, String n2, String n3){
    return Row(
      children: <Widget>[

        Expanded(
          flex: 1,
          child: numPadItem(n1)
        ),

        Expanded(
            flex: 1,
            child: numPadItem(n2)
        ),

        Expanded(
            flex: 1,
            child: numPadItem(n3)
        ),

      ],
    );
  }

  Widget numPadItem(value){
    return InkWell(
      onTap: (){
        onChanged(value);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 15,
        alignment: Alignment.center,
        child: value == "DEL" ? Icon(Icons.arrow_back, color: AppColor.secondaryHeader,) :
        Text(value, textScaleFactor: 1 ,style: TextStyle(color: AppColor.secondaryHeader, fontWeight: FontWeight.bold, fontSize: 20.0),),
      ),
    );
  }

}