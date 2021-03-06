import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';

class ShimmerEffect extends StatefulWidget {
  final double height;
  final double width;
  final EdgeInsets margin;

  ShimmerEffect({Key key, this.height = 70, this.width = double.infinity, this.margin = EdgeInsets.zero}) : super(key: key);

  createState() => ShimmerEffectState();
}

class ShimmerEffectState extends State<ShimmerEffect> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      margin: widget.margin,
      child: Container(
        width:  widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(gradientPosition.value, 0),
                end: Alignment(-1, 0),
                colors: [Colors.white12, Color(0xfff4f4f4), Colors.white12]
            )
        ),
      ),
    );
  }
}