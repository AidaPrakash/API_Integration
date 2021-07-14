import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pon/core/enums/viewstate.dart';
import 'package:pon/core/models/customer.dart';
import 'package:pon/core/models/driverdetails.dart';
import 'package:pon/core/viewmodels/base_view_model.dart';
import 'package:pon/router.dart';
import 'package:pon/services/api.dart';

import '../../locator.dart'; // add the http plugin in pubspec.yaml file.

class EnquiryDisplayView extends BaseViewModel {
  final API _api = locator<API>();

  List<Customer> _customerList = [];
  Customer _selectedCustomer;

  Customer get selectedCustomer => _selectedCustomer;
  set selectedCustomer(Customer value) {
    _selectedCustomer = value;
    notifyListeners();
  }

  List<Customer> get customerList => _customerList;
  set customerList(List<Customer> value) {
    _customerList = value;
    notifyListeners();
  }



  bool isUpdating = true;

  String formattedCurrentDate = DateTime.now().toString().substring(0, 10);
  DateTime currentDateBirth = DateTime.now();
  //String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDateBirth);

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDateBirth,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDateBirth) {
      currentDateBirth = pickedDate;
    }
    String formattedChangedDate = pickedDate.toString().substring(0, 10);
    //getCustPayBill();
    notifyListeners();
  }

  List<EnquiryDetails> _driverList;
  List<EnquiryDetails> get transportDriver =>
      _driverList == null ? new List() : _driverList;

  getCustPayBill() async {
    setState(ViewState.Busy);

    var result = await _api.fetchEnquiry();
    List<String> prodids = [];
    if (result.length > 0) {
      _driverList = [];
      isUpdating = true;
      for (EnquiryDetails products in result) {
        if (prodids.indexOf(products.name) == -1) {
          prodids.add(products.name);
          _driverList.add(products);
        }
      }
    } else {
      isUpdating = false;
      Fluttertoast.showToast(
          msg: 'No Record available...',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.white,
          textColor: Colors.blue[800]);
    }

    setState(ViewState.Idle);
    notifyListeners();
  }

  clearValues() async {
    setState(ViewState.Busy);

    _driverList = [];
    isUpdating = true;

    notifyListeners();
  }

  

  
}
