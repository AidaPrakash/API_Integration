
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pon/core/models/alert_request.dart';

class DialogService {
  final _dialogNavigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;
  Function(AlertRequest) _showDialogListener;
  Completer _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<void> showDialog({String title = 'Message', String description, String buttonTitle = 'OK'}) {
    _dialogCompleter = Completer();
    _showDialogListener(AlertRequest(
        description: description,
        buttonTitle: buttonTitle,
        title: title
    ));

    return _dialogCompleter.future;
  }

  void dialogComplete() {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter = null;
  }
}