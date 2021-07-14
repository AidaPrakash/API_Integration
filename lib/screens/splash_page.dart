import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/images.dart';
import 'package:pon/core/res/styles.dart';
import 'package:pon/core/viewmodels/splash_view_model.dart';
import 'package:pon/locator.dart';
import 'package:pon/router.dart';
import 'package:pon/screens/base_view.dart';
import 'package:pon/widgets/splash_screen.dart';

class SplashPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        onModelReady: (viewModel) async {},
        builder: (context, viewModel, child) => _buildSplashScreen());
  }

  Widget _buildSplashScreen() {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.white,
      title: new Text(
        'VINAYAGA TRANSPORT',
        textScaleFactor: 2,
      ),
      image: Image.asset("assets/images/login.png"),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.red,
      navigateAfterSeconds: Routes.custledger,
    );
  }
}
