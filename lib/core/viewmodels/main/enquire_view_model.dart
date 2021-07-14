import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pon/core/enums/viewstate.dart';
import 'package:pon/core/models/login_response.dart';
import 'package:pon/services/api.dart';
import 'package:pon/core/viewmodels/base_view_model.dart';
import 'package:pon/locator.dart';

import '../../../router.dart';

class EnquireViewModel extends BaseViewModel {
  final API _api = locator<API>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addr1Controller = new TextEditingController();
  TextEditingController qryController = new TextEditingController();
  TextEditingController pinController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  FocusNode nameFocus = new FocusNode();
  FocusNode phoneFocus = new FocusNode();
  FocusNode addr1Focus = new FocusNode();
  FocusNode qryFocus = new FocusNode();
  FocusNode pinFocus = new FocusNode();
  FocusNode dateFocus = new FocusNode();

  bool _nameValidate = false;
  bool _phoneValidate = false;
  bool _addr1Validate = false;
  bool _qryValidate = false;
  bool _pinValidate = false;

  bool get nameValidate => _nameValidate;
  bool get phoneValidate => _phoneValidate;
  bool get addr1Validate => _addr1Validate;
  bool get qryValidate => _qryValidate;
  bool get pinValidate => _pinValidate;

  set nameValidate(bool value) {
    _nameValidate = value;
    notifyListeners();
  }

  set phoneValidate(bool value) {
    _phoneValidate = value;
    notifyListeners();
  }

  set addr1Validate(bool value) {
    _addr1Validate = value;
    notifyListeners();
  }

  set qryValidate(bool value) {
    _qryValidate = value;
    notifyListeners();
  }

  set pinValidate(bool value) {
    _pinValidate = value;
    notifyListeners();
  }

  init() async {
    setState(ViewState.Busy);
    //locationList = await locator<LocationService>().getLocations();
    //_user = await api.getCustomerDetails();
    // _user = await locator<PreferenceService>().init();
    setState(ViewState.Idle);
  }

  submitQry(BuildContext context) async {
    if (nameController.text == "") {
      //nameController.text = _user.custname;
      nameValidate = true;
      FocusScope.of(context).requestFocus(nameFocus);
      return;
    }

    setState(ViewState.Busy);
    LoginResponse result =
        await _api.submitQry(nameController.text, qryController.text);
    if (result.success) {
      Fluttertoast.showToast(
          msg: result.message, toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: result.message, toastLength: Toast.LENGTH_LONG);
    }
    setState(ViewState.Idle);
    return result;
  }
}
