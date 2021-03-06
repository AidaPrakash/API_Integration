import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pon/core/res/images.dart';

class NetworkImageLoader extends StatelessWidget {

  String image;
  double height;
  double width;
  BoxFit fit;

  NetworkImageLoader({
    this.image,
    this.height,
    this.width,
    this.fit
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => Center(
        child: Container(
            width: 35.0,
            height: 35.0,
            child: new Image.asset("", width: 60.0, height: 60.0,)),
      ),
      errorWidget: (context, url, error) => Center(child: new Image.asset("", width: 60.0, height: 60.0,)),
      alignment: Alignment.center,
    );
  }

}
