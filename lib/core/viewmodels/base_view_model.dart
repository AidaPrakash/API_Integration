import 'package:flutter/widgets.dart';
import 'package:pon/core/enums/viewstate.dart';
import 'package:pon/locator.dart';
import 'package:pon/services/api.dart';
import 'package:pon/services/dialog_service.dart';
import 'package:pon/services/navigation_service.dart';
import 'package:pon/services/secure_storage.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  final API _api = locator<API>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SecureStorage _secureStorage = locator<SecureStorage>();

  API get api => _api;

  NavigationService get navigationService => _navigationService;

  SecureStorage get secureStorage => _secureStorage;

  DialogService get dialogService => _dialogService;
}
