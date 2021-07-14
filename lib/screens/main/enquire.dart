import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pon/core/enums/viewstate.dart';
import 'package:pon/core/res/images.dart';
import 'package:pon/core/res/styles.dart';
import 'package:pon/core/viewmodels/main/enquire_view_model.dart';
import 'package:pon/router.dart';
import 'package:pon/screens/base_view.dart';
import 'package:pon/screens/shared/loading.dart';
import 'package:pon/services/secure_storage.dart';
import 'package:pon/widgets/button.dart';
import 'package:pon/core/res/spacing.dart';
import 'package:pon/widgets/drop_down_card.dart';
import 'package:pon/widgets/edit_text.dart';
import 'package:pon/widgets/touch_focus_listener.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../locator.dart';

class Enquire extends StatelessWidget {
  String finalDate = '';

  @override
  Widget build(BuildContext context) {
    return BaseView<EnquireViewModel>(
        onModelReady: (viewModel) async {
          viewModel.init();
          getCurrentDate();
        },
        builder: (context, viewModel, child) => viewModel.state ==
                ViewState.Busy
            ? LoadingWidget("Authenticating...")
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          viewModel.navigationService.pop(returnValue: false);
                        })
                  ],
                ),
                body: WillPopScope(
                  onWillPop: () {
                    return Future.value(true);
                  },
                  child: SafeArea(
                      child: TouchFocusListener(
                          child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                    child: ListView(
                      children: <Widget>[
                        /*  Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "",
                            width: 100,
                            height: 100,
                          ),
                        ),*/
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Text("Enquire Us!",
                            //"${viewModel.user.custmobile}",
                            textScaleFactor: 1,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.appBarTitle
                                .copyWith(fontSize: 30)),

                        Padding(padding: EdgeInsets.only(top: 30)),

                        EditText(
                          "Enter your Name here...",
                          Key("txtName"),
                          viewModel.nameController,
                          TextInputType.text,
                          focusNode: viewModel.nameFocus,
                          validate: viewModel.nameValidate,
                          //marginEdgeInsets: EdgeInsets.only(top: 0),
                          errorText: "Invalid Name",
                          onSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(viewModel.addr1Focus);
                          },
                          onChanged: (value) {
                            viewModel.nameValidate = false;
                          },
                        ),

                        Spacing.small(),

                        EditText(
                          "Queries please!....",
                          Key("txtQuery"),
                          viewModel.qryController,
                          TextInputType.multiline,
                          focusNode: viewModel.qryFocus,
                          validate: viewModel.qryValidate,
                          maxLines: 4,
                          //marginEdgeInsets: EdgeInsets.only(top: 30),
                          errorText: "Invalid Address",
                          onChanged: (value) {
                            viewModel.qryValidate = false;
                          },
                        ),
                        Spacing.xxlarge(),
                        // ignore: missing_required_param
                        Button(
                          "SUBMIT",
                          width: double.infinity,
                          onPressed: () async {
                            viewModel.submitQry(context);
                          },
                        )
                      ],
                    ),
                  ))),
                ),
              ));
  }

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    finalDate = formattedDate.toString();
  }
}
