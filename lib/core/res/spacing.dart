import 'package:flutter/material.dart';
import 'package:pon/core/res/dimens.dart';

enum SpacingType { Horizontal, Vertical }

class Spacing extends StatelessWidget {

  final double spacing;
  final SpacingType type;

  Spacing._(this.spacing, this.type);

  factory Spacing.thin({SpacingType type = SpacingType.Vertical}){
    return Spacing._(AppDimens.d2px, type);
  }

  factory Spacing.small({SpacingType type = SpacingType.Vertical}){
    return Spacing._(AppDimens.d5px, type);
  }

  factory Spacing.medium({SpacingType type = SpacingType.Vertical}){
    return Spacing._(AppDimens.d10px, type);
  }

  factory Spacing.large({SpacingType type = SpacingType.Vertical}){
    return Spacing._(AppDimens.d15px, type);
  }

  factory Spacing.xlarge({SpacingType type = SpacingType.Vertical}){
    return Spacing._(AppDimens.d20px, type);
  }

  factory Spacing.xxlarge({SpacingType type = SpacingType.Vertical}){
    return Spacing._(AppDimens.d40px, type);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: EdgeInsets.only(top: type == SpacingType.Vertical ? spacing : 0, left: type == SpacingType.Vertical ? 0 : spacing));
  }

}