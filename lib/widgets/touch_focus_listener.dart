import 'package:flutter/material.dart';

class TouchFocusListener extends StatelessWidget {

  final Widget child;

  TouchFocusListener({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: child,
    );
  }

}