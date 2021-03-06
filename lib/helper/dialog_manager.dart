import 'package:flutter/material.dart';
import 'package:pon/core/models/alert_request.dart';
import 'package:pon/core/res/styles.dart';
import 'package:pon/services/dialog_service.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showInfoDialog);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Dialog Manager being built");
    return widget.child;
  }

  void _showInfoDialog(AlertRequest request) {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                _dialogService.dialogComplete();
                return false;
              },
              child: AlertDialog(
                title: Text(
                  request.title,
                  style: AppTextStyle.dialogButtonOutline,
                ),
                content: Text(request.description, style: AppTextStyle.body),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: AppTextStyle.dialogButton,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
        });
  }
}
