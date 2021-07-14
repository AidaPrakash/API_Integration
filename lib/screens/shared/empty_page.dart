import 'package:flutter/material.dart';

class EmptyPageWidget extends StatelessWidget {

  final String message;
  final String image;

  EmptyPageWidget(this.message, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              image == null ? Container() : new Image.asset(image, width: 100, height: 100,),

              new Padding(padding: EdgeInsets.only(top: 30)),

              Text(message, style: TextStyle(fontSize: 20),)

            ],
          )
      ),
    );
  }

}