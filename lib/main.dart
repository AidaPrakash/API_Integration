import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/styles.dart';
import 'package:pon/helper/dialog_manager.dart';
import 'package:pon/locator.dart';
import 'package:pon/router.dart' as start_router;
import 'package:pon/services/dialog_service.dart';
import 'package:pon/services/navigation_service.dart';
import 'package:provider/provider.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();


  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: (Object obj, StackTrace stack) {});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final NavigationService navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryDark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transport',
      theme: AppStyle.appTheme,
      builder: _setupDialogManager,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: (settings) =>
          start_router.Router.generateRoute(settings),
    );
  }

  Widget _setupDialogManager(context, widget) {
    return Navigator(
      key: locator<DialogService>().dialogNavigationKey,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        final MediaQueryData data = MediaQuery.of(context);
        return DialogManager(
          child: MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: widget,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
