import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';

class DropDown extends StatefulWidget {

  final String value;
  String title;
  final List<Map<String, dynamic>> items;
  ValueChanged<dynamic> onChanged;

  DropDown({
    @required this.value,
    @required this.items,
    @required this.onChanged,
  });

  DropDown.withTitle(this.title, {
    @required this.value,
    @required this.items,
    @required this.onChanged,
  });

  @override
  _DropDownState createState() => _DropDownState();

}

class _DropDownState extends State<DropDown> {
  List<DropdownMenuItem> dropdownData = new List();

  @override
  void initState() {
    super.initState();

    for(Map<String,dynamic> data in widget.items){
      dropdownData.add(DropdownMenuItem<String>(
        child: Text(data['value']),
        value: data['code'],
      ));
    }
    setState(() {});

    print(dropdownData.length);

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          widget.title == null ? Container() : new Text(
            widget.title, textScaleFactor: 1,
            style: TextStyle(color: AppColor.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.normal),),

          widget.title == null ? Container() : new Padding(
              padding: EdgeInsets.only(top: 0)),

          dropdownData == null ? Container() : Container(
            // decoration: BoxDecoration(
            //     color: whiteColor,
            //     shape: BoxShape.rectangle,
            //     boxShadow: AppStyle.cardShadow,
            // ),
            //padding: EdgeInsets.only(left: 10, right: 10),
            child: DropdownButton(
              style: TextStyle(
                  color: AppColor.text,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
              items: dropdownData,
              onChanged: widget.onChanged,
              isExpanded: true,
              value: widget.value,
            ),
          )

        ],
      ),
    );
  }
}