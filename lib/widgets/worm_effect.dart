import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';

class WormEffect extends IndicatorEffect {
  const WormEffect({
    double offset,
    double dotWidth = 8.0,
    double dotHeight = 8.0,
    double spacing = 8.0,
    double radius = 8,
    Color dotColor = AppColor.secondaryBackground,
    Color activeDotColor = AppColor.secondaryText,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotColor != null),
        super(
        dotWidth: dotWidth,
        dotHeight: dotHeight,
        spacing: spacing,
        radius: radius,
        strokeWidth: strokeWidth,
        paintStyle: paintStyle,
        dotColor: dotColor,
        activeDotColor: activeDotColor,
      );

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return WormPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}


abstract class IndicatorEffect {
  // Singe dot width
  final double dotWidth;

  // Singe dot height
  final double dotHeight;

  // The horizontal space between dots
  final double spacing;

  // Single dot radius
  final double radius;

  // Inactive dots color or all dots in some effects
  final Color dotColor;

  // The active dot color
  final Color activeDotColor;

  // Inactive dots paint style (fill|stroke) defaults to fill.
  final PaintingStyle paintStyle;

  /// This is ignored if [paintStyle] is PaintStyle.fill
  final double strokeWidth;

  const IndicatorEffect({
    @required this.strokeWidth,
    @required this.dotWidth,
    @required this.dotHeight,
    @required this.spacing,
    @required this.radius,
    @required this.dotColor,
    @required this.paintStyle,
    @required this.activeDotColor,
  })  : assert(radius != null),
        assert(dotColor != null || paintStyle != null || strokeWidth != null),
        assert(activeDotColor != null),
        assert(dotWidth != null),
        assert(dotHeight != null),
        assert(spacing != null),
        assert(dotWidth >= 0 &&
            dotHeight >= 0 &&
            spacing >= 0 &&
            strokeWidth >= 0);

  // Builds a new painter every time the page offset changes
  IndicatorPainter buildPainter(int count, double offset, bool isRTL);

  // Calculates the size of canvas based on
  // dots count, size and spacing
  //
  // Other effects can override this function
  // to calculate their own size
  Size calculateSize(int count) {
    return Size(dotWidth * count + (spacing * (count - 1)), dotHeight);
  }
}
abstract class IndicatorPainter extends CustomPainter {
  /// The raw offset from the [PageController].page
  ///
  /// This is called raw because it's used to resolve
  /// the final [offset] based on [isRTL] property
  final double _rawOffset;

  /// This holds the directional offset
  final double offset;

  // The count of pages
  final int count;

  // The provided effect is passed to this super class
  // to make some calculations and paint still dots
  final IndicatorEffect _effect;

  // Inactive dot paint or base paint in one-color effects.
  final Paint dotPaint;

  // The Radius of all dots
  final Radius dotRadius;

  IndicatorPainter(
      this._rawOffset,
      this.count,
      this._effect,
      bool _isRTL,
      )   : assert(_isRTL != null),
        dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth,
        offset = _isRTL ? (count - 1) - _rawOffset : _rawOffset;

  // The distance between dot lefts
  double get distance => _effect.dotWidth + _effect.spacing;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint still dots if the sub class calls super
    for (int i = 0; i < count; i++) {
      final xPos = (i * distance);
      final yPos = size.height / 2;
      final bounds = Rect.fromLTRB(xPos, yPos - _effect.dotHeight / 2,
          xPos + _effect.dotWidth, yPos + _effect.dotHeight / 2);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    // only repaint if the raw offset changes
    return oldDelegate._rawOffset != _rawOffset;
  }
}
class WormPainter extends IndicatorPainter {
  final WormEffect effect;

  WormPainter({
    @required this.effect,
    @required int count,
    @required double offset,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    super.paint(canvas, size);
    final activeDotPaint = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    final worm = _calcBounds(offset.floor(), dotOffset * 2);
    canvas.drawRRect(worm, activeDotPaint);
  }

  RRect _calcBounds(num i, double dotOffset) {
    final xPos = (i * distance);
    final yPos = (effect.dotHeight) / 2;
    double left = xPos;
    double right = xPos +
        effect.dotWidth +
        (dotOffset * (effect.dotWidth + effect.spacing));
    if (dotOffset > 1) {
      right = xPos + effect.dotWidth + (1 * (effect.dotWidth + effect.spacing));
      left = xPos + ((effect.spacing + effect.dotWidth) * (dotOffset - 1));
    }
    return RRect.fromLTRBR(
      left,
      yPos - effect.dotHeight / 2,
      right,
      yPos + effect.dotHeight / 2,
      dotRadius,
    );
  }
}
class SmoothPageIndicator extends AnimatedWidget {
  // a PageView controller to listen for page offset updates
  final PageController controller;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page offset will be reversed
  final TextDirection textDirection;

  SmoothPageIndicator({
    @required this.controller,
    @required this.count,
    this.textDirection,
    this.effect = const WormEffect(),
    Key key,
  })  : assert(controller != null),
        assert(effect != null),
        assert(count != null),
        super(listenable: controller, key: key);

  @override
  Widget build(BuildContext context) {
    // if textDirection is not provided use the nearest directionality up the widgets tree;
    final isRTL =
        (textDirection ?? Directionality.of(context)) == TextDirection.rtl;
    return CustomPaint(
      // different effects have different sizes
      // so we calculate size based on the provided effect
      size: effect.calculateSize(count),
      // rebuild the painter with the new offset every time it updates
      painter: effect.buildPainter(
        count,
        _currentPage,
        isRTL,
      ),
    );
  }

  double get _currentPage {
    try {
      return controller.page ?? controller.initialPage.toDouble();
    } catch (Exception) {
      return controller.initialPage.toDouble();
    }
  }
}