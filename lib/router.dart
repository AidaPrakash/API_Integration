import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pon/screens/main/enquire.dart';
import 'package:pon/screens/pdf_creation/enquirydisplay.dart';
import 'package:pon/screens/pdf_creation/paymentreport.dart';
import 'package:pon/screens/splash_page.dart';

const String initialRoute = "login";

class Routes {
  static const String splash = "/";
  static const String enquire = "enquire";
  static const String getenquire = "getenquire";
  static const String custledger = "custledger";

  static const String paymentStatusPage = "cart/payment_status";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return NoTransitionRoute(
          builder: (_) => SplashPage(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.custledger:
        return MaterialPageRoute(
          builder: (_) => PaymentReport(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.enquire:
        return MaterialPageRoute(
          builder: (_) => Enquire(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.getenquire:
        return MaterialPageRoute(
          builder: (_) => EnquiryDisplay(),
          settings: RouteSettings(name: settings.name),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// NoTransitionRoute
/// Custom route which has no transitions
class NoTransitionRoute<T> extends MaterialPageRoute<T> {
  NoTransitionRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

/// NoPushTransitionRoute
/// Custom route which has no transition when pushed, but has a pop animation
class NoPushTransitionRoute<T> extends MaterialPageRoute<T> {
  NoPushTransitionRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // is popping
    if (animation.status == AnimationStatus.reverse) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return child;
  }
}

/// NoPopTransitionRoute
/// Custom route which has no transition when popped, but has a push animation
class NoPopTransitionRoute<T> extends MaterialPageRoute<T> {
  NoPopTransitionRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // is pushing
    if (animation.status == AnimationStatus.forward) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return child;
  }
}

class RouteUtils {
  static RoutePredicate withNameLike(String name) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings.name != null &&
          route.settings.name.contains(name);
    };
  }
}
