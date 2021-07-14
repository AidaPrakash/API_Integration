import 'dart:convert';

import 'package:pon/core/models/driverdetails.dart';
import 'package:pon/core/models/login_response.dart';
import 'package:pon/core/models/vehicle.dart';
import 'package:pon/services/api_base.dart';
import 'package:pon/services/api_endpoints.dart';

class API extends ApiBase {
  Future<LoginResponse> submitQry(String name, String qry) async {
    Map<String, dynamic> params = new Map();

    params['name'] = name;
    params['qry'] = qry;

    final response = await sendAsync(
        ApiMethod.POST, ApiEndpoint.enquiry, params,
        authentication: false);
    return response == null
        ? null
        : LoginResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<DriverDetails>> fetchDriver(String customername) async {
    var response = await sendAsync(
      ApiMethod.GET,
      ApiEndpoint.driverdetails + "&operator1=" + customername,
      null,
    );

    try {
      if (response != null) {
        print("RESPONSE" + response.body);
        return (json.decode(response.body) as List)
            .map((i) => DriverDetails.fromJson(i))
            .toList();
      }
    } catch (ex) {
      print(ex.toString());
    }

    return null;
  }

  Future<List<EnquiryDetails>> fetchEnquiry() async {
    var response = await sendAsync(
      ApiMethod.GET,
      ApiEndpoint.getenquiry,
      null,
    );

    try {
      if (response != null) {
        print("RESPONSE" + response.body);
        return (json.decode(response.body) as List)
            .map((i) => EnquiryDetails.fromJson(i))
            .toList();
      }
    } catch (ex) {
      print(ex.toString());
    }

    return null;
  }

  

}
